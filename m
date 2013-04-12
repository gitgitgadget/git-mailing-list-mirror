From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/7] completion: add new __gitcompadd helper
Date: Fri, 12 Apr 2013 10:55:49 -0700
Message-ID: <7vli8neiqi.fsf@alter.siamese.dyndns.org>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
 <1365577077-12648-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 19:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQiCc-0004kI-Fp
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 19:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab3DLRzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 13:55:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752632Ab3DLRzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 13:55:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D4113D63;
	Fri, 12 Apr 2013 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h/q2UBrG0maXMCxYYEg9EXpAWUc=; b=wqNfkg
	fv9CneTFE8ni8GXH09g9hyX1veQW25La27vb9x3pKHXJde8xUUByovfqjR+Fzi14
	NPn3APXAOz3vBZlzSrSjtbH44tazp3Yi6OjW8+Zi+aIqPjpQbblve3KdCBEZGB6r
	6AK9pZdzGpSUEqiepw9p26HDZ5oobNol7n+ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x3O0PU92konxLbFcvikpttWxjeRommio
	XD6To3fhSFp6yHep5rWuoCnnOz/EMWf6NisISrqtYHoj9Tcrbe5bL6TUhwM0mOVK
	WIBuuuvEnZ83jRfJxuiMtb2RhQQyB0t1xlDYHuWwUhqSQ2R53brA3CR9DysQBtNb
	t7AOH11zxSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB2F13D61;
	Fri, 12 Apr 2013 17:55:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C4E513D60; Fri, 12 Apr
 2013 17:55:51 +0000 (UTC)
In-Reply-To: <1365577077-12648-4-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Wed, 10 Apr 2013 01:57:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36A9C830-A39A-11E2-8F3D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221007>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The idea is to never touch the COMPREPLY variable directly.
>
> This allows other completion systems (i.e. zsh) to override
> __gitcompadd, and do something different instead.
>
> Also, this allows further optimizations down the line.
>
> There should be no functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2c87fd8..90b54ab 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -195,6 +195,11 @@ _get_comp_words_by_ref ()
>  }
>  fi
>  
> +__gitcompadd ()
> +{
> +	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))

Making a mental note that this takes prefix ($2), suffix ($4) and
the actual word ($3) are given in addition to the list of expansions
($1)...

> +}
> +
>  # Generates completion reply with compgen, appending a space to possible
>  # completion words, if necessary.
>  # It accepts 1 to 4 arguments:
> @@ -211,9 +216,7 @@ __gitcomp ()
>  		;;
>  	*)
>  		local IFS=$'\n'
> -		COMPREPLY=($(compgen -P "${2-}" \
> -			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
> -			-- "$cur_"))
> +		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""

This did not use to use suffix, but we pass an empty string as $4,
so it is an equivalent rewrite.

>  		;;
>  	esac
>  }
> @@ -230,7 +233,7 @@ __gitcomp ()
>  __gitcomp_nl ()
>  {
>  	local IFS=$'\n'
> -	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
> +	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"

This also is a straight-forward rewrite.

>  }
>  
>  # Generates completion reply with compgen from newline-separated possible
> @@ -1820,7 +1823,7 @@ _git_config ()
>  		local remote="${prev#remote.}"
>  		remote="${remote%.fetch}"
>  		if [ -z "$cur" ]; then
> -			COMPREPLY=("refs/heads/")
> +			__gitcompadd "refs/heads/"

I am not sure about this one, though.

Other callers took pains to protet against triggering unset variable
references by using ${1-} instead of ${1}.  Shouldn't this caller be
passing three empty strings?

>  			return
>  		fi
>  		__gitcomp_nl "$(__git_refs_remotes "$remote")"
