#!/bin/bash

## default setting
target_profile_name=".bash_profile"

echo ${target_profile_name}

function init_bash_profile()
{
    if [ ! -f $HOME/.bash_profile ]; then
         cat << EOF > $HOME/.bash_profile
if [ -f $HOME/.profile ]; then
   . $HOME/.profile
fi

EOF
    fi
}

function install() 
{
    sudo apt-get update
    sudo apt-get install git python-pip make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl
    sudo apt-get install libffi-dev
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    init_bash_profile
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/${target_profile_name}
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/${target_profile_name}
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/${target_profile_name}
    echo -e 'export PYTHON_CONFIGURE_OPTS="--enable-shared ${PYTHON_CONFIGURE_OPTS}"' >> ~/${target_profile_name}
}

function update()
{
    cd $(pyenv root)
    git pull
}

function uninstall()
{    
    echo $(pyenv root)
    # rm -rf $(pyenv root)
}

install
