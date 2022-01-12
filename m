Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA772C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 17:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbiALRuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:50:18 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56064 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344489AbiALRuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 12:50:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B8F315949E;
        Wed, 12 Jan 2022 12:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+jl2kPSL0O0B
        w980iNm5tpvEI6GcjTQkSie06tpaGUQ=; b=BH4PhZytpaCQu2ZyA5TTD/XPbt+t
        3jwbtS0Q0Uc/CRVH3L/xBk6iFmM8/2dXS09jHAa2JrurwYiCJMc7kbanpj6yT+Lz
        P48OXy99ltXXgp29h4Z1+JVnYGL7VeXsZ0SXsUIock4mCPXSs5zvBLOjno3oFXyz
        vM740m6xtwsEJfY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D1C415949C;
        Wed, 12 Jan 2022 12:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D764215949B;
        Wed, 12 Jan 2022 12:50:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: git bisect bad @
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
        <xmqqilus3ctf.fsf@gitster.g>
        <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
        <xmqq4k6b34h8.fsf@gitster.g>
        <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
        <3dade45b-494f-663b-264b-06a51ea1cf56@web.de>
Date:   Wed, 12 Jan 2022 09:50:12 -0800
In-Reply-To: <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 12 Jan 2022 10:04:28 +0100")
Message-ID: <xmqq35lsyhbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18417E46-73D0-11EC-943C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> It would be nice if we could determine if the command was not found by
> the shell and halt the bisection.  This is actually indicated by the
> shell using error code 127.  However, the script itself could also exit
> with that code (e.g. if one of its commands was not found).  Currently
> this is interpreted as a bad revision and bisection continues, as
> documented in the man page of git bisect.
>
> If we'd make error code 127 (and 126) special by stopping the bisection
> (like we do for 128 and higher) then scripts that relied on that code
> indicating a bad revision would require a manual "git bisect bad" at
> each affected step.  Annoying, but not dangerous.  Such a script would
> have to be modified to convert codes 126 and 127 to e.g. 1.
>
> Seems like a reasonable trade-off to me.  Thoughts?

Probably.  It is safer than the current "all revisions including the
bottom one and the top one are bad" which leads to the "merge-base
says your good and bad are nonsense" error for the "command not
found" case, but what if the one that reports an error with 127 (or
126) is coming from something other than shell (i.e. the 'bisect
run' command was fed is not a script at all)?  Is it a no-no for a
random binary that is not an implementation of shell to exit with
these error status?

>> This presents another possible opportunity for enhancement: in an
>> overwhelmingly large majority of the use cases (or so I assume), './'
>> is really redundant.
> Adding the current directory to $PATH would be inconsistent and might
> even be dangerous.
>
> Prepending "./" to a given command that contains no directory separator
> is speculative -- what if that command is actually found in $PATH?

Bad idea.

> Additionally we could check for the command in the current directory
> and suggest something like "'bisect.sh' not found; did you mean
> './bisect.sh'?".

It may not hurt but I do not think it is necessary at all, as long
as the "halt the 'bisect run' session upon 126 and 127"=20
