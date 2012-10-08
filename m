From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow __git_ps1 to be used in PROMPT_COMMAND
Date: Mon, 08 Oct 2012 11:12:26 -0700
Message-ID: <7vr4p8lto5.fsf@alter.siamese.dyndns.org>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
 <20121005210945.GA4961@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:12:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLHom-0001Cr-5a
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab2JHSMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 14:12:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542Ab2JHSM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 14:12:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E70A9306;
	Mon,  8 Oct 2012 14:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MhbmFbyuVA+5pDPb5w9z8tulpYY=; b=rwt5kx
	xvGkGcDsovJ2DbFI+1VS4TG4P4F2Q9G2HJ4Og6HVvqNIgHW9UxvDslAGyxdDQ1bE
	HYR+FATZrwNiB/Zb6iU4AZLXszBDn7/ToybIPi8sWM6/BIsM3k3LxkIWYkF0Z3Ef
	Kpy5JPqFFk1SAEx1NSzeqEDMSadE3UeKafRE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e+0M+ci528Wyoum5aXwJW5NKhuGMi3kF
	nlRkkTgcJvYkwFXcbU97CZXI10EakHUg1KwSOAS5dFqzh+K5vqYjmlM9pclkv7eQ
	LzmCJF3vHkQgmkDAfh9sGDiuPSVbmP6A6UQoJ8G0Y7Y/DaMJE35b1hHaETKoTrm3
	b0EqR22AY2M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C17F9305;
	Mon,  8 Oct 2012 14:12:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3A2D9303; Mon,  8 Oct 2012
 14:12:27 -0400 (EDT)
In-Reply-To: <20121005210945.GA4961@simaj.xs4all.nl> (Simon Oosthoek's
 message of "Fri, 5 Oct 2012 23:09:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7D5F3F2-1173-11E2-B9FD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207253>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> changes __git_ps1 to not just allow use in setting PS1
> with __git_ps1 in a command substitution, but also allows
> __git_ps1 to be used as PROMPT_COMMAND in bash.
> This has advantages for using color and I think it is more
> elegant

Is "and I think" necessary?  I do not think it matters what _you_
think when judging it is worth including in the future releases ;-)

A lot more important thing to say is why it has advantages for using
color (remember, it took a few rounds of back and forth with me).
Unless you are going to explain the same to all the people who are
reading the "git log" output 6 months down the road, that is a more
appropriate thing to write here.

>  contrib/completion/git-prompt.sh |   51 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 29b1ec9..c50c94a 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -10,9 +10,14 @@
>  #    1) Copy this file to somewhere (e.g. ~/.git-prompt.sh).
>  #    2) Add the following line to your .bashrc/.zshrc:
>  #        source ~/.git-prompt.sh
> -#    3) Change your PS1 to also show the current branch:
> -#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> -#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
> +#    3a) In ~/.bashrc set PROMPT_COMMAND=__git_ps1
> +#        To customize the prompt, provide start/end arguments
> +#        PROMPT_COMMAND="__git_ps1 '\u@\h:\w (' ')\$ '"
> +#    3b) Alternatively change your PS1 to call __git_ps1 as
> +#        command-substitution:
> +#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
> +#        ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
> +#        the optional argument will be used as format string
>  #
>  # The argument to __git_ps1 will be displayed only if you are currently
>  # in a git repository.  The %s token will be the name of the current
> @@ -194,11 +199,41 @@ __git_ps1_show_upstream ()
>  
>  
>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
> +# when called from PS1 using command substitution
> +# in this mode it returns text to add to bash PS1 prompt (includes branch name) or
> +# __git_ps1 accepts 0 or 2 arguments when called from PROMPT_COMMAND
> +# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
> +# when both arguments are given, the first is prepended and the second appended
> +# to the state string when assigned to PS1, otherwise default start/end strings
> +# are used.

Sorry, but I cannot parse this.  Is this meant to be a two-item list,
one describing the command substitution mode (zero or 1 arguments) and
the other describing the prompt command mode?  If so, perhaps replacing
the " or" at the end of the first item with ".\n#\n" would make it readable.

>  __git_ps1 ()
>  {
> +	local pcmode=yes
> +	local ps1pc_start='\u@\h:\w '
> +	local ps1pc_end='\$ '
> +
> +	case "$PROMPT_COMMAND" in
> +		__git_ps1*)
> +			if [ $# = 2 ]; then
> +				ps1pc_start="$1"
> +				ps1pc_end="$2"
> +			fi
> +			case "$PS1" in
> +			*__git_ps1*)
> +				echo '__git_ps1: overwriting PS1 due to PROMPT_COMMAND'

Is this supposed to be an error and/or warning message?  Why is it
worth warning only when you are overwriting __git_ps1 style of PS1
and not other user customization?

> +			;;
> +			esac
> +		;;
> +		*)  pcmode=no ;; #no output
> +	esac

Please align outer "case" "its arms)" and "esac" at the same column,
like you did for the inner "case/esac".

Auto-detetction based on PROMPT_COMMAND is a flaky approach.  In
practice, nobody will call PROMPT_COMMAND with the __git_ps1 without
any parameter (100% people want their prompt to end with some sort
of whitespace so they want the "what comes after what is computed",
aka $2), and even more importantly, nobody has been relying on use
of 0 argument form of __git_ps1 in PROMPT_COMMAND.  So why not
always require 2 args and take that as a cue to go into the pc mode?

> +
>  	local g="$(__gitdir)"
> -	if [ -n "$g" ]; then
> +	if [ -z "$g" ]; then
> +		if [ $pcmode = yes ]; then
> +			#In PC mode PS1 always needs to be set
> +			PS1="$ps1pc_start$ps1pc_end"
> +		fi
> +	else
>  		local r=""
>  		local b=""
>  		if [ -f "$g/rebase-merge/interactive" ]; then
> @@ -284,6 +319,10 @@ __git_ps1 ()
>  		fi
>  
>  		local f="$w$i$s$u"
> -		printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
> +		if [ $pcmode = yes ]; then
> +			PS1="$ps1pc_start($c${b##refs/heads/}${f:+ $f}$r$p)$ps1pc_end"
> +		elif [ $pcmode = no ]; then
> +			printf -- "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
> +		fi

Are there $pcmode other than yes or no?  Why not just "else",
instead of performing the test twice?

>  	fi
>  }
