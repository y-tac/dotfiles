umask 022
limit coredumpsize 0
bindkey -d

# Return if zsh is called from Vim
if [[ -n $VIMRUNTIME ]]; then
    return 0
fi

# tmux_automatically_attach attachs tmux session
# automatically when your are in zsh
if [[ -x ~/bin/tmuxx ]]; then
    ~/bin/tmuxx
fi

if [[ -f ~/.zplug/init.zsh ]]; then
    export ZPLUG_LOADFILE=~/.zsh/zplug.zsh
    source ~/.zplug/init.zsh

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
        echo
    fi
    zplug load
fi

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
 
# User specific aliases and functions
#
# Prompt
#
autoload colors
colors

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
source ~/.git-prompt.sh
setopt prompt_subst
PROMPT='%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m:%{$reset_color%}%~%{$fg[red]%}$(__git_ps1 " (%s)") %{$reset_color%}
\$ '
