Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8BAC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7041960EE6
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352172AbhIHPsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:48:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61002 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349646AbhIHPsk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:48:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1F00ECC0F;
        Wed,  8 Sep 2021 11:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lR8rJ3ociOUJ
        iH61EP86JdHr32ZBoXvO64JDI0G+t3c=; b=KyvL/+oB1iFf1EUwmugLBoKoGxKp
        30F3oLQtzDPWmubJejgeHDEke67xweIbq6tJR0hgvCC/j/BCEymYGO3qcK9q8eoc
        wdH0Cac/kYWmbm/KtEB4MfpFHNpYNIO289r6/ELG67vNlKmybb6h6t3L/NISt5/X
        TgadrJy/3ZtgYJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9765BECC0E;
        Wed,  8 Sep 2021 11:47:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F5D2ECC0D;
        Wed,  8 Sep 2021 11:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] pack-write: skip *.rev work when not writing *.rev
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
        <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
        <CAPUEspgh0kbm-ro13Xt2-g-hPoBMK2-34iP2GvK_gaa2bGC+GQ@mail.gmail.com>
        <YTgjA/mwH7wY4oyZ@nand.local>
Date:   Wed, 08 Sep 2021 08:47:30 -0700
In-Reply-To: <YTgjA/mwH7wY4oyZ@nand.local> (Taylor Blau's message of "Tue, 7
        Sep 2021 22:42:11 -0400")
Message-ID: <xmqqo8935ast.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1357D528-10BC-11EC-B1B2-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Sep 07, 2021 at 06:35:10PM -0700, Carlo Arenas wrote:
>> On Tue, Sep 7, 2021 at 6:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> > +       if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
>> > +               return NULL;
>>
>> I see this expression matches exactly the logic from 8ef50d9958 which
>> is why I presume
>> you used it, but the simpler (and logically equivalent[1]) :
>>
>>   if !((flags & WRITE_REV) || (flags & WRITE_REV_VERIFY))
>
> Even simpler would be:
>
>     if (!(flags & (WRITE_REV | WRITE_REV_VERIFY)))
>
> although with optimization flags other than -O0, it seems that each of
> these three produce the same result [1], so I don't think that it
> matters much either way ;-).

If all result in the same binary, the only deciding factor would be
how readable the code is to human readers.

I too find that your version, "we care about these two bits---if
flags does not have either of them, then...", the easiest to follow.
But the original is not unreadable and is good enough once it has
already been written.

Thanks.
