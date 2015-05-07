From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Thu, 07 May 2015 11:33:01 -0700
Message-ID: <xmqqmw1gp7aa.fsf@gitster.dls.corp.google.com>
References: <CAMbsUu66AJ1hC-nDrHSojMibYp-rh=zSpEwC3hCaG-1yU71GZw@mail.gmail.com>
	<CAMbsUu7vkS4D2z_gNFsujVsyHjRiXseTLGCaic=841V=HZyb_g@mail.gmail.com>
	<CAMbsUu6XT4hB0L0PjgJKniyBJ9svkQoJqnxiYaRWo9EZUXnNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	git develop <git@vger.kernel.org>
To: Danny Lin <danny0838@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:33:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQbe-0008KT-Jh
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbEGSdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:33:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967AbbEGSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:33:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 583A04D164;
	Thu,  7 May 2015 14:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=872YCPsUlcjFD/vrUr6+uY/uDLs=; b=mGzbty
	hmxA6jyc8ToF98zYekc9h/oF15YIl1kaUS3azQsHpf7G5sPm7K222qsUtXgAjQKK
	ZBzsLflc77xEMIj7TCTreGb4qY5ZOl/wv1GjVMlFAeD6SHJhSCcUBDBL9yM2Nxq2
	SpKiwNZ5ZjXWjXDqDEkWTmOgTiLubmVEs8nF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YiF7/BL5Big7HBjO3TKawDh7aJXqdRv6
	CKCe7k2/Q23cC26XCSGqpKRimM0vZqgnvu8eIU7haZ+j6SavGxfkP3MkA2zKBwn9
	S0fYow5+8UQAUNXTDzMdZ+GE2A5HTG8cRnveFDDuBgu8+HHBALZkF+4B3G11tOU7
	QNV9JaC78kg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E0734D163;
	Thu,  7 May 2015 14:33:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD23C4D160;
	Thu,  7 May 2015 14:33:02 -0400 (EDT)
In-Reply-To: <CAMbsUu6XT4hB0L0PjgJKniyBJ9svkQoJqnxiYaRWo9EZUXnNhg@mail.gmail.com>
	(Danny Lin's message of "Thu, 7 May 2015 13:10:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EAD918E-F4E7-11E4-A039-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268572>

Danny Lin <danny0838@gmail.com> writes:

> Replace all echo using printf for better portability.

I doubt this change is sensible.

It is not like "echo is bad, don't use it".  It is more about "some
features of 'echo', like 'echo -n $msg' vs 'echo $msg\c' are not
portable".

>  "
> -eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
> +eval "$(printf %s "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || printf %s "exit $?")"

I do not think we want this.

>  PATH=$PATH:$(git --exec-path)
>  . git-sh-setup
> @@ -51,17 +51,29 @@ prefix=
>  debug()
>  {
>  	if [ -n "$debug" ]; then
> -		echo "$@" >&2
> +		printf "%s\n" "$*" >&2
>  	fi
>  }
>  
>  say()
>  {
>  	if [ -z "$quiet" ]; then
> -		echo "$@" >&2
> +		printf "%s\n" "$*" >&2
>  	fi
>  }

These are OK.

> +state()
> +{
> +	if [ -z "$quiet" ]; then
> +		printf "%s\r" "$*" >&2
> +	fi
> +}

This is good, but I think it is misnamed.  "progress" might be more
appropriate.

> +
> +log()
> +{
> +	printf "%s\n" "$*"
> +}

I do not think we need this.

> @@ -72,7 +84,7 @@ assert()
>  }
>  
>  
> -#echo "Options: $*"
> +#log "Options: $*"

Definitely not.

>  while [ $# -gt 0 ]; do
>  	opt="$1"
> @@ -149,7 +161,7 @@ cache_get()
>  	for oldrev in $*; do
>  		if [ -r "$cachedir/$oldrev" ]; then
>  			read newrev <"$cachedir/$oldrev"
> -			echo $newrev
> +			log $newrev

We know this is 40-hex, and there is no magic, don't we?

> @@ -158,7 +170,7 @@ cache_miss()
>  {
>  	for oldrev in $*; do
>  		if [ ! -r "$cachedir/$oldrev" ]; then
> -			echo $oldrev
> +			log $oldrev

Likewise.

And I'll stop saying "Likewise" at this point.

> @@ -599,7 +611,7 @@ cmd_split()
>  	eval "$grl" |
>  	while read rev parents; do
>  		revcount=$(($revcount + 1))
> -		say -n "$revcount/$revmax ($createcount)"
> +		state "$revcount/$revmax ($createcount)"
>  		debug "Processing commit: $rev"
>  		exists=$(cache_get $rev)
>  		if [ -n "$exists" ]; then

Good.

If we wanted to make "state" (or "progress") to be usable in a wider
context, we may want to change its implementation a little bit, but
that is a separate topic.  It only has a single caller, and it only
feeds ever growing string, so the "print and then carriage-return"
is sufficient for now.

Thanks.
