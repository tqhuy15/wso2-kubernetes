#!/bin/bash

### Cai dat Docker lastest
#echo "123" | sudo -S apt update
sudo apt-get update
sudo apt install openssh-server openssh-client
sudo apt-get install apt-transport-https ca-certificates unzip git curl gnupg-agent software-properties-common -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo usermod -a -G docker $(whoami)

### Restart Docker
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

### Disbale ufw
sudo service ufw stop
sudo systemctl disable ufw

# Tat swap
sudo sed -i '/swap/d' /etc/fstab
sudo swapoff -a

### Cai dat Kubernetes

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

sudo systemctl enable kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

sudo apt-get install openjdk-8-jdk -y

sudo apt install nfs-common -y
