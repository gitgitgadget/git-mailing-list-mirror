From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add completion for 'git help'
Date: Fri, 25 Jul 2008 15:40:51 -0500
Message-ID: <20080725204051.GB23202@spearce.org>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 22:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMU6q-0006fx-W0
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 22:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYGYUkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 16:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbYGYUkx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 16:40:53 -0400
Received: from george.spearce.org ([209.20.77.23]:58523 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYGYUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 16:40:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 058EB383A5; Fri, 25 Jul 2008 20:40:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1216858043-53646-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90112>

Lee Marlow <lee.marlow@gmail.com> wrote:
> Renamed cached __git_commandlist to __git_porcelain_commandlist
> and added __git_all_commandlist that only filters out *--* helpers.
> Completions for 'git help' will use the __git_all_commandlist, while
> __git_porcelain_commandlist is used for git command completion.
> Users who actually read man pages may want to see help for plumbing
> commands.
> 
> Options added: --all --info --man --web
> 
> Signed-off-by: Lee Marlow <lee.marlow@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> This version fixes a small error in the __git_all_commands
...
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2edb341..f3bdea4 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -349,10 +349,10 @@ __git_complete_revlist ()
>  	esac
>  }
>  
> -__git_commands ()
> +__git_all_commands ()
>  {
> -	if [ -n "$__git_commandlist" ]; then
> -		echo "$__git_commandlist"
> +	if [ -n "$__git_all_commandlist" ]; then
> +		echo "$__git_all_commandlist"
>  		return
>  	fi
>  	local i IFS=" "$'\n'
> @@ -360,6 +360,24 @@ __git_commands ()
>  	do
>  		case $i in
>  		*--*)             : helper pattern;;
> +		*) echo $i;;
> +		esac
> +	done
> +}
> +__git_all_commandlist=
> +__git_all_commandlist="$(__git_all_commands 2>/dev/null)"
> +
> +__git_porcelain_commands ()
> +{
> +	if [ -n "$__git_porcelain_commandlist" ]; then
> +		echo "$__git_porcelain_commandlist"
> +		return
> +	fi
> +	local i IFS=" "$'\n'
> +	for i in "help" $(__git_all_commands)
> +	do
> +		case $i in
> +		*--*)             : helper pattern;;
>  		applymbox)        : ask gittus;;
>  		applypatch)       : ask gittus;;
>  		archimport)       : import;;
> @@ -427,8 +445,8 @@ __git_commands ()
>  		esac
>  	done
>  }
> -__git_commandlist=
> -__git_commandlist="$(__git_commands 2>/dev/null)"
> +__git_porcelain_commandlist=
> +__git_porcelain_commandlist="$(__git_porcelain_commands 2>/dev/null)"
>  
>  __git_aliases ()
>  {
> @@ -767,6 +785,18 @@ _git_gc ()
>  	COMPREPLY=()
>  }
>  
> +_git_help ()
> +{
> +	local cur="${COMP_WORDS[COMP_CWORD]}"
> +	case "$cur" in
> +	--*)
> +		__gitcomp "--all --info --man --web"
> +		return
> +		;;
> +	esac
> +	__gitcomp "$(__git_all_commands)"
> +}
> +
>  _git_ls_remote ()
>  {
>  	__gitcomp "$(__git_remotes)"
> @@ -1369,7 +1399,8 @@ _git ()
>  		case "$i" in
>  		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
>  		--bare)      __git_dir="." ;;
> -		--version|--help|-p|--paginate) ;;
> +		--version|-p|--paginate) ;;
> +		--help) command="help"; break ;;
>  		*) command="$i"; break ;;
>  		esac
>  		c=$((++c))
> @@ -1389,7 +1420,7 @@ _git ()
>  			--help
>  			"
>  			;;
> -		*)     __gitcomp "$(__git_commands) $(__git_aliases)" ;;
> +		*)     __gitcomp "$(__git_porcelain_commands) $(__git_aliases)" ;;
>  		esac
>  		return
>  	fi
> @@ -1414,6 +1445,7 @@ _git ()
>  	fetch)       _git_fetch ;;
>  	format-patch) _git_format_patch ;;
>  	gc)          _git_gc ;;
> +	help)        _git_help ;;
>  	log)         _git_log ;;
>  	ls-remote)   _git_ls_remote ;;
>  	ls-tree)     _git_ls_tree ;;

-- 
Shawn.
