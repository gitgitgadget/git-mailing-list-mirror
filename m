From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] completion: introduce __gitcomp_nl_append ()
Date: Fri, 03 Jan 2014 12:41:22 -0800
Message-ID: <xmqq38l4n6h9.fsf@gitster.dls.corp.google.com>
References: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
	<1388779022-14536-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 21:41:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzBYj-0002Bd-9L
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 21:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbaACUl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 15:41:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbaACUl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 15:41:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA3435F680;
	Fri,  3 Jan 2014 15:41:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nOZqdX4GyMyggUnOzNeVvtoGu20=; b=H3i+IQ
	6jIkJ9VoCfajeso4pFWF8f6HFIuFAHsxyMLygYymHDI++THmeDJyGQB0ynmAZi87
	lTmUNecx35DCBUZIdoteTB+8gBk4cOyFUEWCXhkikFLMjyOvGwethzjY0Qh8a2pY
	gq2YJxopyF2cz/+EONIPwf6CVQJv9xWNdaUK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oWdAjHIXlmW19ZJF/wyL8eY19H65WZgK
	XvOdBD0fkJXbEkr5cdiORbhDxA57HAush3wkz6qWr+1JEw5gARQNVq7YjOZHWOg1
	i0Z1/CgwhWMLjwCL8pyot7bueYZopyEClimGmQ45OGQxEXiUrt8lHY6MjSWxrriQ
	rYSoLSEWCGc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6D4F5F67E;
	Fri,  3 Jan 2014 15:41:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D78775F677;
	Fri,  3 Jan 2014 15:41:24 -0500 (EST)
In-Reply-To: <1388779022-14536-3-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 4 Jan 2014 01:27:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 697D3136-74B7-11E3-A917-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239937>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 51c2dd4..bf358d6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -233,6 +233,19 @@ __gitcomp_nl ()
>  	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
>  }
>  
> +# Variation of __gitcomp_nl () that appends to the existing list of
> +# completion candidates, COMPREPLY.
> +__gitcomp_nl_append ()
> +{
> +	local IFS=$'\n'
> +	local i=${#COMPREPLY[@]}
> +	for x in $1; do
> +		if [[ "$x" == "$3"* ]]; then
> +			COMPREPLY[i++]="$2$x$4"
> +		fi
> +	done
> +}

Hmph. Why so much duplication with __gitcompadd, though.

I would have expected that this "append" behaviour to be done at the
lower level by introducing __gitcompappend that does not forcibly
truncate by starting from a hard-coded i=0, i.e. a collection of
small helper functions plus a single implementation of the logic to
push elements into COMPREPLY[] in __gitcompappend, perhaps like
these:

	__gitcompappend () {
		local i=${#COMPREPLY[@]}
		for x in $1; do
                        if [[ "$x" == "$3"* ]]; then
                                COMPREPLY[i++]="$2$x$4"
                        fi
		done
        }

	__gitcompadd () {
		COMPREPLY=()
		__gitcompappend "$@"
	}

	__gitcomp_nl_append () {
		local IFS=$'\n'
                __gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
        }

	__gitcomp_nl () {
		COMPREPLY=()
                __gitcomp_nl_append "$@"		
        }
        
Is it because going this route and doing it at such a low level
would make zsh completion (which I have no clue about ;-)
unnecessarily complex?

> +
>  # Generates completion reply with compgen from newline-separated possible
>  # completion filenames.
>  # It accepts 1 to 3 arguments:
> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index 6fca145..6b77968 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -76,6 +76,14 @@ __gitcomp_nl ()
>  	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
>  }
>  
> +__gitcomp_nl_append ()
> +{
> +	emulate -L zsh
> +
> +	local IFS=$'\n'
> +	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
> +}
> +
>  __gitcomp_file ()
>  {
>  	emulate -L zsh
