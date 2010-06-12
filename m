From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] bash completion: Support "divergence from
	upstream" warnings in __git_ps1
Date: Sat, 12 Jun 2010 02:00:02 +0200
Message-ID: <20100612000002.GA30196@neumann>
References: <cover.1276169807.git.trast@student.ethz.ch>
	<a798e1b7f5ce3872a794829555c7295e588e2c61.1276169807.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Thomas Rast <trast@student.ethz.ch>,
	Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 02:00:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONE92-0000Av-1a
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 02:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760709Ab0FLAAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 20:00:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:58683 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760679Ab0FLAAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 20:00:08 -0400
Received: from [127.0.1.1] (p5B130766.dip0.t-ipconnect.de [91.19.7.102])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MYcHS-1Oiemn2drG-00VlVZ; Sat, 12 Jun 2010 02:00:04 +0200
Content-Disposition: inline
In-Reply-To: <a798e1b7f5ce3872a794829555c7295e588e2c61.1276169807.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/EfBltEKt08NQyi8LEUTpB0OXZ+PnDWlx3Wet
 OzZHcVfAruvLjB9b165O0TEFPf+HrUseMFriyGMkGdQLvgCSdB
 SKcUEMf8+GmyGfHOXDuOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148979>

Hi,


On Thu, Jun 10, 2010 at 01:47:24PM +0200, Thomas Rast wrote:
> From: Andrew Sayers <andrew-git@pileofstuff.org>

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index de5e6c1..49253a1 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -42,6 +42,14 @@
>  #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
>  #       untracked files, then a '%' will be shown next to the branch name.
>  #
> +#       If you would like to see the difference bitween HEAD and its
> +#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.  The
> +#       difference will be shown as, e.g., "u+7-5" meaning that you
> +#       are 7 commits ahead of and 5 commits behind the upstream.  You
> +#       can enable git-svn mode by setting GIT_PS1_SHOWUPSTREAM=svn
> +#       and set the value per-repository with the bash.showUpstream
> +#       variable.

I find the last sentence of this description ambiguous.  What value
should bash.showUpstream be set to?  Do I really need to set both
GIT_PS1_SHOWUPSTREAM and bash.showUpstream?  What if
GIT_PS1_SHOWUPSTREAM=foo and bash.showUpstream=svn?

Furthermore, I think it would be good to provide means to disable this
feature for some repositories while keeping it enabled for others.  In
the current version I could either disable or enable it globally.
Perhaps we could disable it when bash.showUpstream is set to an empty
value.

> +#
>  # To submit patches:
>  #
>  #    *) Read Documentation/SubmittingPatches
> @@ -132,6 +140,7 @@ __git_ps1 ()
>  		local s
>  		local u
>  		local c
> +		local p
>  
>  		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
>  			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
> @@ -159,10 +168,56 @@ __git_ps1 ()
>  			      u="%"
>  			   fi
>  			fi
> +
> +			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
> +
> +				# Note: 'p' is used as a temporary throughout this block,
> +				# before finally being assigned its correct value
> +

Back in the old days when I was just learning programming, I got my
ass kicked when I dared to reuse the same variable for different
purposes.  C'mon, just how much shorter it is to create one more
variable than this two lines long comment?! ;)  It could even be
squashed together with the "local upstream" line.

> +				if p="$(git config --get bash.showUpstream)"
> +				then
> +					GIT_PS1_SHOWUPSTREAM="$p"
> +				fi
> +
> +				local upstream
> +
> +				if [ "${GIT_PS1_SHOWUPSTREAM-}" = "svn" ]; then

No need to use default value here, because GIT_PS1_SHOWUPSTREAM has
already been set above.

> +
> +					# git-svn upstream checking
> +					p="$( git config --get svn-remote.svn.url )"
> +					upstream=( $( git log --first-parent -1 \
> +						--grep="^git-svn-id: $p" ) )
> +					upstream=${upstream[ ${#upstream[@]} - 2 ]}
> +					upstream=${upstream%@*}
> +					upstream=${upstream#*$p/}
> +

Unnecessary empty lines before and after this block of code.

> +				else # git upstream checking
> +					upstream="@{upstream}"
> +				fi
> +
> +				p=$(git rev-list --count --left-right "$upstream"...HEAD 2>/dev/null)
> +				debug_p="$p"

The leftover debugging mentioned by Michael.

> +				case "$p" in
> +				"0	0"|"") # empty means no --count support or no upstream
> +					p=
> +					;;
> +				"0	"*)
> +					p="+${p#0	}"
> +					;;
> +				*"	0")
> +					p="-${p%	0}"
> +					;;
> +				*)
> +					p="+${p#*	}-${p%	*}"
> +					;;
> +				esac
> +
> +			fi
> +
>  		fi

Unnecessary empty lines before both fi.

>  
>  		local f="$w$i$s$u"
> -		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
> +		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r${p:+ u$p}"
>  	fi
>  }
>  
> -- 
> 1.7.1.553.ge4d5c.dirty
> 
> 
