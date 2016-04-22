From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Fri, 22 Apr 2016 11:14:06 -0700
Message-ID: <xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	<vpq37qeovu4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:14:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atfay-0001dz-US
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbcDVSOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 14:14:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754638AbcDVSOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:14:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0114A14577;
	Fri, 22 Apr 2016 14:14:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6EfkanvtYXKotP+W9PyB7bRYz6w=; b=K+T34o
	7yk080jVtCiChBd8O6vQGu753CvgE7jwXVlrlhV4oMrsMVkgMJf06qvaLn9iarwE
	4IDGveTxPgDtTEAvNQDdWpbOFsk3xUaX0j0MaWlzBvv5CPdsMJeWPq9CoITRa51U
	jrnyPKcyQZvKXZUEFV87vMogMB79I4O7dWzcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g43jEOW6F9hWC8vdew4Aji3IrEag3mSJ
	XlzrmLjvdZXoeDTPxyiYIFqV7Y7jb+aszTjiLfSoTf/XUQVlF9/9YbIVg0WFMrrh
	NSMIG00PJhmIAPgTLMjz0nUUWcZtHmkBEsE+zHFDafyiuMAvGllrRIZFw5rNmYCb
	jo9zf6RQ/68=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED4DB14576;
	Fri, 22 Apr 2016 14:14:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5801214575;
	Fri, 22 Apr 2016 14:14:07 -0400 (EDT)
In-Reply-To: <vpq37qeovu4.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	22 Apr 2016 11:07:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00E91992-08B6-11E6-A1DA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292238>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> larsxschneider@gmail.com writes:
>
>> +      if [[ "$TRAVIS_OS_NAME" = linux ]] && [[ "$CC" = gcc ]];
>
> [[ is a bashism, and doesn't bring anything here compared to the POSIX
> [ ... ], or "test" which is prefered in Git's source code.
>
> The ; or the newline is not needed either.

Honestly, I didn't know that we were even trying to be pure POSIX,
avoid bashism or GNUism, or in general to follow our shell scripting
style in the scriptlet in the .travis.yml file.

While I feel fairly strongly about keeping the generic part generic,
I am actually OK with things that are known to be used in a specific
environment to be specific to that environment.

Having said all that, if we are not benefiting from using features
beyond POSIX, then by all means we should strive to be writing our
stuff in a portable way, as we do not have firm control over from
where and to where people cut and paste code snippets.

And I do think bashism [[ ... ]] is *NOT* buying anything in this
particular case, so I do agree with you that

	if test "$TRAVIS_OS_NAME" = linux && test "$CC" = gcc
        then
        	...

or even

	case "$TRAVIS_OS_NAME,$CC" in
        linux,gcc)
        	...

is what I would have written instead if I were writing this
conditional.

If we were to shoot for "be POSIX unless we can clearly benefit from
being bash/gnu/linux specific in bash/gnu/linux specific parts", the
existing scriptlets in .travis.yml file has a few things that may
need to be cleaned up already.  There are "mkdir --parents" (POSIX
spells it "-p"), "pushd/popd" and invocation of "tar" is very GNU
specific in the part that appears in the case arm for "linux".

There also are existing instances of "useless ;" that would want to
be cleaned up regardless of portability issues.

>> +          then
>> +          echo ""
>> +          echo "------------------------------------------------------------------------" &&
>
> I usualy avoid "echo <something-starting-with-dash>" as I'm not sure how
> portable it is across variants of "echo". Maybe this one is portable
> enough, I don't know. Perhaps printf, or cat << EOF ...?

Do you even need a long divider there?

> I think it makes sense to do some lightweight checks after "make doc",
> rather than just check the return code. For example, check that a few
> generated files exist and are non-empty, like
>
> test -s Documentation/git.html &&
> test -s Documentation/git.1

Yup, or the formatter does not give new/unknown warnings.

Thanks.
