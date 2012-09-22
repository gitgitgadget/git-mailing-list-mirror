From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule: if $command was not matched, don't parse other args
Date: Sat, 22 Sep 2012 13:31:27 -0700
Message-ID: <7v8vc13ilc.fsf@alter.siamese.dyndns.org>
References: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 22:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFWMX-0000Jr-Ju
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 22:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab2IVUbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 16:31:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab2IVUba (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 16:31:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13C06862C;
	Sat, 22 Sep 2012 16:31:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lBnnnXOmsdOB/eAp+n1NKAgWwK8=; b=t3ZKC3
	7lqz9wUo+EOHel0rcruZfNXOVBeGeLIfLz/nqd/yvFS8mV5fX6h9FEnUdaCFtxeu
	oo4wsT+yfUlQrcpeAUtNfTEA86NFfi2W5HqMpbbQSM+tSyRoGofBkUqorwShdyXf
	b9lyco3gePLZSzI02DU9nPHNS2rsEjK8NKN5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yNQrHz1zVa3Dluug5Ue9Jhqz4kPgSGFF
	3sBNlr/NxFPfOWjYkDzkrCdXPciImLrNAt0h3lxvoBXiLvAxtfYXGD+/lCbI35FJ
	0tNfW6zYBoFyerY88VvDj35ZAY4H41leA02WEHrbtX4nO3q0WdnURSKcm73ehyfr
	BxNGWUj56tI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00115862B;
	Sat, 22 Sep 2012 16:31:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50EEF862A; Sat, 22 Sep 2012
 16:31:29 -0400 (EDT)
In-Reply-To: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 22 Sep 2012 16:57:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D30B844-04F4-11E2-B6B0-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206214>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When we try to execute 'git submodule' with an invalid subcommand, we
> get an error like the following:
>
>     $ git submodule show
>     error: pathspec 'show' did not match any file(s) known to git.
>     Did you forget to 'git add'?
>
> The cause of the problem: since $command is not matched, it is set to
> "status", and "show" is treated as an argument to "status".  Change
> this so that usage information is printed when an invalid subcommand
> is tried.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  This breaks test 41 in t7400-submodule-bash -- does the test cover a
>  real-world usecase?

You know how to ask "shortlog --since=18.months --no-merges" to find
people to list on "Cc:" line to ask that question, no?

> diff --git a/git-submodule.sh b/git-submodule.sh
> index a7e933e..dfec45d 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1108,7 +1108,15 @@ do
>  done
>
>  # No command word defaults to "status"
> -test -n "$command" || command=status
> +if test -z "$command"
> +then
> +    if test $# = 0
> +    then
> +	command=status
> +    else
> +	usage
> +    fi
> +fi

I personally feel "no command means this default" is a mistake for
"git submodule", even if there is no pathspec or other arguments,
but I am not a heavy user of submodules, so others should discuss
this.
