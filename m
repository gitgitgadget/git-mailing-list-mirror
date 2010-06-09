From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [RFC/PATCHv2] bash completion: Support "divergence from
 upstream" warnings in __git_ps1
Date: Wed, 9 Jun 2010 10:21:29 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC744839BF3EB@xmail3.se.axis.com>
References: <4C0AE640.3040503@pileofstuff.org>
 <201006062014.59386.trast@student.ethz.ch>
 <4C0C09BF.4070503@pileofstuff.org>
 <201006070942.34753.trast@student.ethz.ch> <4C0EB7F1.1030707@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 09 10:22:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMGY2-0002U6-Ha
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 10:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831Ab0FIIV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 04:21:59 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:33496 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab0FIIV4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 04:21:56 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o598LUqI023036;
	Wed, 9 Jun 2010 10:21:30 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Wed, 9 Jun 2010 10:21:30 +0200
Thread-Topic: [RFC/PATCHv2] bash completion: Support "divergence from
 upstream" warnings in __git_ps1
Thread-Index: AcsHUvAmeFnzUkXeSlOeRTOxd12iZQAWPigg
In-Reply-To: <4C0EB7F1.1030707@pileofstuff.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148752>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Andrew Sayers
> Sent: den 8 juni 2010 23:37
> To: Thomas Rast
> Cc: Shawn O. Pearce; Git Mailing List
> Subject: [RFC/PATCHv2] bash completion: Support "divergence from
> upstream" warnings in __git_ps1
> 
> Add a notification in the command prompt specifying whether you're ahead of
> (>), behind (<), diverged from (<>) or at (=) your upstream.  This is
> especially helpful in small teams that (forget to) push to each other very
> frequently.
> 
> Support git-svn upstream detection as a special case, as migraters from
> centralised version control systems are especially likely to forget to push.
> 
> Support for other types of upstream than SVN should be easy to add if anyone is
> so inclined.
> 
> Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
> ---
> 
> This patch includes Thomas Rast's feedback - thanks Thomas for the education :)
> 
> This patch makes unashamed use of shell arrays and substring expansion that
> would normally not be allowed.  As Jakub Narebski mentioned, this is probably ok
> in a bash-specific script.
> 
> Unlike other prompt options, I've put the divergence characters on the left of the
> branch name.  I'm really not sure about this, and I'd like to hear people's
> opinions.
> 
> This patch produces output like this when I have unpushed commits:
> 
> [andrew@pc myrepo >master] # my master is ahead of upstream
> 
> Intuitively, I like having a ">" when I'm ahead, although it would be more
> logical to have something like this:
> 
> [andrew@pc myrepo <master] # upstream less-than master
> 
> Putting the symbol on the right makes this problem go away, but looks ridiculous
> if you use a prompt like PS1='\W:$(__git_ps1 "(%s)")> '
> 
> myrepo:master>> # master greater-than upstream
> myrepo:master<> # master less-than upstream
> myrepo:master<>> # master and upstream have diverged
> 
> I'd rather not rely on colour prompts to clear this up - using colour as the
> only way to convey important information to the user rarely ends well.
> 
> Adding a "u" to the symbol could also clear this up:
> 
> [andrew@pc myrepo u<master] # upstream less-than master
> 
> Using "u<", "u=", "u>" and "<>" would mean that the prompt always used either
> two or zero characters, which would keep prompts lined up over time. But it
> would also eat horizontal space for an issue you'd stop seeing after a few
> minutes.
> 
> Finally, my apologies to anyone that tried to apply my previous patch - to make
> a long story short, it turns out I need this feature more than I realised :)
> 
>  contrib/completion/git-completion.bash |   58 +++++++++++++++++++++++++++++++-
>  1 files changed, 57 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 57245a8..1dc80fd 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -42,6 +42,14 @@
>  #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
>  #       untracked files, then a '%' will be shown next to the branch name.
>  #
> +#       If you would like to see the difference bitween HEAD and its

Typo: bitween -> between

> +#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.
> +#       Unpushed commits (>), unmerged commits (<), both (<>) and
> +#       neither (=) will be shown on the left of the branch name.  You
> +#       can enable git-svn mode by setting GIT_PS1_SHOWUPSTREAM=svn
> +#       and set the value per-repository with the bash.showUpstream
> +#       variable.
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
> @@ -159,10 +168,57 @@ __git_ps1 ()
>  			      u="%"
>  			   fi
>  			fi
> +
> +			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
> +
> +				# Note: 'p' is used as a temporary throughout this block,
> +				# before finally being assigned its correct value
> +
> +				if p="$(git config --get bash.showUpstream)"
> +				then
> +					GIT_PS1_SHOWUPSTREAM="$p"
> +				fi
> +
> +				local upstream
> +
> +				if [ "${GIT_PS1_SHOWUPSTREAM-}" = "svn" ]; then
> +
> +					# git-svn upstream checking
> +					p="$( git config --get svn-remote.svn.url )"
> +					upstream=( $( git log --first-parent -1 \
> +						--grep="^git-svn-id: $p" ) )
> +					upstream=${upstream[ ${#upstream[@]} - 2 ]}
> +					upstream=${upstream%@*}
> +					upstream=${upstream#*$p/}
> +
> +				else # git upstream checking
> +				  upstream="@{upstream}"
> +				fi
> +
> +				if p="$( git rev-list \
> +						--left-right "$upstream"...HEAD 2>/dev/null )"
> +				then
> +					case "$p" in
> +						\<*\>*|\>*\<* ) p="<>" ;;
> +						*\<*          ) p="<"  ;;
> +						*\>*          ) p=">"  ;;
> +						""            ) p="="  ;;
> +
> +						# the following case shouldn't be possible
> +						# if you see this, please report it as a bug
> +						* ) p="?ERROR($p)?" ;;
> +
> +					esac
> +				else
> +					p=""
> +				fi
> +
> +			fi
> +
>  		fi
> 
>  		local f="$w$i$s$u"
> -		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r"
> +		printf "${1:- (%s)}" "$c$p${b##refs/heads/}${f:+ $f}$r"
>  	fi
>  }
> 
> --
> 1.7.0.4

//Peter
