From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prompt: fix missing file errors in zsh
Date: Mon, 14 Apr 2014 13:30:33 -0700
Message-ID: <xmqqa9bnodqu.fsf@gitster.dls.corp.google.com>
References: <1397259145-18514-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 22:30:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZnWd-0005wf-P7
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 22:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbaDNUai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 16:30:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467AbaDNUah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 16:30:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 984467D9E0;
	Mon, 14 Apr 2014 16:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=92rEDICKRlCxC5oD+VczgIlPBwE=; b=T7eswm
	110Wh4Byf7uz4lgzzddu7GhfWKdcB/nH664rV35KeihZLraLoBoAQvYrL6Yp6kPX
	wXhbl7TWscAou7xdW3IsgNt/mFCUxLZZ2AfiasxoYeI3/N+laJWXiuectm8XVL0l
	YhTFQ9AE47nBimM2OhHPc0qYUDCWCvIkUyOkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=azTnDj41np56F19WxiJjCpLS6BZ36djS
	T/VzdYIY7cmCwwajjWzQH3SYCcHIgJ1ab4uegM33zCaPaov4xbtIvhoag7daiz8E
	BmJ38VOQZY90pBPdKURc3TydMuT7Tod+qJXislGXAPdkxRQnisNbf3VUa/CdNiWn
	0UQ4MRt7jsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7978A7D9DF;
	Mon, 14 Apr 2014 16:30:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B77857D9DC;
	Mon, 14 Apr 2014 16:30:34 -0400 (EDT)
In-Reply-To: <1397259145-18514-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 11 Apr 2014 18:32:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A1B5DCE6-C413-11E3-B904-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246263>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> zsh seems to have a bug while redirecting the stderr of the 'read'
> command:
>
>  % read foo 2> /dev/null < foo
>  zsh: no such file or directory: foo
>
> Which causes errors to be displayed when certain files are missing.
> Let's add a convenience function to manually check if the file is
> readable before calling "read".

OK.  I wondered if this can become conditional to zsh (with the
common code still using eread, just the implementation of shell
function being different from zsh and bash), but I doubt it would be
worth it (other people can contradict me, of course).

Will queue.  Thanks.

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-prompt.sh | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 7b732d2..1526086 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -259,6 +259,13 @@ __git_ps1_colorize_gitstring ()
>  	r="$c_clear$r"
>  }
>  
> +eread ()
> +{
> +	f="$1"
> +	shift
> +	test -r "$f" && read "$@" < "$f"
> +}
> +
>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
>  # when called from PS1 using command substitution
>  # in this mode it prints text to add to bash PS1 prompt (includes branch name)
> @@ -321,9 +328,9 @@ __git_ps1 ()
>  	local step=""
>  	local total=""
>  	if [ -d "$g/rebase-merge" ]; then
> -		read b 2>/dev/null <"$g/rebase-merge/head-name"
> -		read step 2>/dev/null <"$g/rebase-merge/msgnum"
> -		read total 2>/dev/null <"$g/rebase-merge/end"
> +		eread "$g/rebase-merge/head-name" b
> +		eread "$g/rebase-merge/msgnum" step
> +		eread "$g/rebase-merge/end" total
>  		if [ -f "$g/rebase-merge/interactive" ]; then
>  			r="|REBASE-i"
>  		else
> @@ -331,10 +338,10 @@ __git_ps1 ()
>  		fi
>  	else
>  		if [ -d "$g/rebase-apply" ]; then
> -			read step 2>/dev/null <"$g/rebase-apply/next"
> -			read total 2>/dev/null <"$g/rebase-apply/last"
> +			eread "$g/rebase-apply/next" step
> +			eread "$g/rebase-apply/last" total
>  			if [ -f "$g/rebase-apply/rebasing" ]; then
> -				read b 2>/dev/null <"$g/rebase-apply/head-name"
> +				eread "$g/rebase-apply/head-name" b
>  				r="|REBASE"
>  			elif [ -f "$g/rebase-apply/applying" ]; then
>  				r="|AM"
> @@ -358,7 +365,7 @@ __git_ps1 ()
>  			b="$(git symbolic-ref HEAD 2>/dev/null)"
>  		else
>  			local head=""
> -			if ! read head 2>/dev/null <"$g/HEAD"; then
> +			if ! eread "$g/HEAD" head; then
>  				if [ $pcmode = yes ]; then
>  					PS1="$ps1pc_start$ps1pc_end"
>  				fi
