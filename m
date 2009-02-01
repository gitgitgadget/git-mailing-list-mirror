From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] bash: offer to show (un)staged changes
Date: Sun, 1 Feb 2009 14:29:37 -0800
Message-ID: <20090201222937.GP26880@spearce.org>
References: <1232401089-27512-1-git-send-email-trast@student.ethz.ch> <1233526423-30694-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTkqG-0005C6-MW
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZBAW3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZBAW3j
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:29:39 -0500
Received: from george.spearce.org ([209.20.77.23]:41594 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbZBAW3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:29:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DBA0938210; Sun,  1 Feb 2009 22:29:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233526423-30694-1-git-send-email-trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108014>

Thomas Rast <trast@student.ethz.ch> wrote:
> Add a bit of code to __git_ps1 that lets it append '*' to the branch
> name if there are any unstaged changes, and '+' if there are any
> staged changes.
> 
> Since this is a rather expensive operation and will force a lot of
> data into the cache whenever you first enter a repository, you have to
> enable it manually by setting bash.showDirtyState to a true value.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
> This got no replies... was there anything wrong with v2?

Dropped on the floor by me.  Sorry.

But I'm a bit worried about the config --bool test in the prompt.
Its a new fork+exec we weren't doing before.  I wonder if we should
use a shell variable to consider whether or not this should even
be executed and try to shortcut out if not.  E.g.:

  if test -n "$GIT_PS1_SHOWDIRTYSTATE"; then
    ... your new code block ...
  fi

and ask that users at some point set GIT_PS1_SHOWDIRTYSTATE=1 in
their shell startup scripts, and also set bash.showDirtyState true
in any of the repositories they care about it in.


 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index f8b845a..7864ca7 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -34,6 +34,10 @@
>  #       are currently in a git repository.  The %s token will be
>  #       the name of the current branch.
>  #
> +#	In addition, if you set bash.showDirtyState to a true value,
> +#	unstaged (*) and staged (+) changes will be shown next to the
> +#	branch name.
> +#
>  # To submit patches:
>  #
>  #    *) Read Documentation/SubmittingPatches
> @@ -116,10 +120,24 @@ __git_ps1 ()
>  			fi
>  		fi
>  
> +		local w
> +		local i
> +
> +		if test "$(git config --bool bash.showDirtyState)" = "true"; then
> +			git diff --no-ext-diff --ignore-submodules \
> +				--quiet --exit-code || w="*"
> +			if git rev-parse --quiet --verify HEAD >/dev/null; then
> +				git diff-index --cached --quiet \
> +					--ignore-submodules HEAD -- || i="+"
> +			else
> +				i="#"
> +			fi
> +		fi
> +
>  		if [ -n "${1-}" ]; then
> -			printf "$1" "${b##refs/heads/}$r"
> +			printf "$1" "${b##refs/heads/}$w$i$r"
>  		else
> -			printf " (%s)" "${b##refs/heads/}$r"
> +			printf " (%s)" "${b##refs/heads/}$w$i$r"
>  		fi
>  	fi
>  }

-- 
Shawn.
