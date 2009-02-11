From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] completion: Better __git_ps1 support when not in
	working directory
Date: Wed, 11 Feb 2009 10:09:02 -0800
Message-ID: <20090211180902.GM30949@spearce.org>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com> <1234375406-27099-2-git-send-email-ted@tedpavlic.com> <1234375406-27099-3-git-send-email-ted@tedpavlic.com> <1234375406-27099-4-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:10:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJXt-0001ZY-IU
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbZBKSJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbZBKSJE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:09:04 -0500
Received: from george.spearce.org ([209.20.77.23]:56353 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbZBKSJD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:09:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9CCF638210; Wed, 11 Feb 2009 18:09:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234375406-27099-4-git-send-email-ted@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109467>

Ted Pavlic <ted@tedpavlic.com> wrote:
> If .git/HEAD is not readable, __git_ps1 does nothing.
> 
> If --is-in-git-dir, __git_ps1 returns " (GIT_DIR!)" as a cautionary
> note. The previous behavior would show the branch name (and would
> optionally attempt to determine the dirtyState of the directory, which
> was impossible because a "git diff" was used).
> 
> If --is-in-work-tree, __git_ps1 returns the branch name. Additionally,
> if showDirtyState is on, the dirty state is displayed.
> 
> Signed-off-by: Ted Pavlic <ted@tedpavlic.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  contrib/completion/git-completion.bash |   36 +++++++++++++++++++------------
>  1 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 7706170..c28d6be 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -108,7 +108,9 @@ __git_ps1 ()
>  			fi
>  			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"; then
>  				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"; then
> -					b="$(cut -c1-7 "$g/HEAD")..."
> +					if [ -r "$g/HEAD" ]; then
> +						b="$(cut -c1-7 "$g/HEAD")..."
> +					fi
>  				fi
>  			fi
>  		fi
> @@ -116,23 +118,29 @@ __git_ps1 ()
>  		local w
>  		local i
>  
> -		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
> -			if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
> -				git diff --no-ext-diff --ignore-submodules \
> -					--quiet --exit-code || w="*"
> -				if git rev-parse --quiet --verify HEAD >/dev/null; then
> -					git diff-index --cached --quiet \
> -						--ignore-submodules HEAD -- || i="+"
> -				else
> -					i="#"
> +		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
> +			b="GIT_DIR!"
> +		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
> +			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
> +				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
> +					git diff --no-ext-diff --ignore-submodules \
> +						--quiet --exit-code || w="*"
> +					if git rev-parse --quiet --verify HEAD >/dev/null; then
> +						git diff-index --cached --quiet \
> +							--ignore-submodules HEAD -- || i="+"
> +					else
> +						i="#"
> +					fi
>  				fi
>  			fi
>  		fi
>  
> -		if [ -n "${1-}" ]; then
> -			printf "$1" "${b##refs/heads/}$w$i$r"
> -		else
> -			printf " (%s)" "${b##refs/heads/}$w$i$r"
> +		if [ -n "$b" ]; then
> +			if [ -n "${1-}" ]; then
> +				printf "$1" "${b##refs/heads/}$w$i$r"
> +			else
> +				printf " (%s)" "${b##refs/heads/}$w$i$r"
> +			fi
>  		fi
>  	fi
>  }
> -- 
> 1.6.1.2.390.gba743
> 

-- 
Shawn.
