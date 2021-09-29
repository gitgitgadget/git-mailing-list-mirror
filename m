Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072FC433FE
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 15:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2434361381
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 15:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbhI2PKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:10:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65252 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbhI2PKv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 11:10:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53093E7EEF;
        Wed, 29 Sep 2021 11:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fw2RA67Hd99s
        x1z1xV4pOGFEc+uQFeB76kT6m4mZ91g=; b=RnCNiV6CzkRhEc7pI2rB4r7N9CJB
        f3QRN+LpqV4AGbi40b1BzyY5+diFGzINCe8VAQhRYD/ukQRb2qqyNT7WeqSJbLfW
        0r8AJtM9IZyeghmhwcdWSwjqRIWn36Hko679O0oyDkd3AGF7Y5e6Ai/eTD1YwEkg
        1BTRZp9/uqxIUds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4834BE7EEE;
        Wed, 29 Sep 2021 11:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A79B0E7EED;
        Wed, 29 Sep 2021 11:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 02/10] parse-options.[ch]: consistently use "enum
 parse_opt_flags"
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <patch-02.10-289bb437eb5-20210928T130905Z-avarab@gmail.com>
        <xmqqilykgs2k.fsf@gitster.g> <87mtnvvj3c.fsf@evledraar.gmail.com>
Date:   Wed, 29 Sep 2021 08:09:08 -0700
In-Reply-To: <87mtnvvj3c.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 29 Sep 2021 10:53:18 +0200")
Message-ID: <xmqqbl4bfmgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32932876-2137-11EC-9E74-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 28 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Use the "enum parse_opt_flags" instead of an "int flags" as arguments
>>> to the various functions in parse-options.c. This will help to catch
>>> cases where we're not handling cases in switch statements, and

 ...

> But I think this is perfectly good use of enums, we use this
> enums-as-bitfields pattern in various other places,
> e.g. builtin/rebase.c's "flags", the "commit_graph_write_flags",
> "expire_reflog_flags" & "todo_item_flags", just to name a few from some
> quick grepping.

Many codepaths already misusing is not an excuse to add another ;-)

But ...

> One advantage is that integrates nicely with some wider C
> tooling. E.g. before this series, starting "git stash show" under gdb
> and inspecting flags:
>
>     (gdb) p flags
>     $1 =3D 9
>
> And after:
>
>     (gdb) p flags
>     $1 =3D (PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN)

... this is a pleasant surprise---the last time I checked, debuggers
were that clever to notice that the distinct values are names for
individual bits.  I can buy this as an argument for using enums for
names for individual bits.  For this to work, obviously, variable
and struct members need to be given the appropriate type.

So I agree with the change in 2/10.

Except that one place there was a change related to a different enum
that is a true enumeration in this step.  It belongs to 3/10, I
think.  Also, the sales pitch for this step in the proposed commit
log message needs rewriting---this will "not" help to catch cases
where we're not handling cases in switch statements; if you are
selling it because you think it will help debuggers and other
tooling, let's describe it as such.

Even though I think debuggers are overrated ;-)

Thanks.
