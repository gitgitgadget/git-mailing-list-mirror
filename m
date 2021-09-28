Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DCFC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DE161374
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbhI1Uwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:52:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59278 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbhI1Uwh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:52:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5742914AF38;
        Tue, 28 Sep 2021 16:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O01mj48b2Ots
        Jgz7qVRX4+SksEmQav8dXfMjtmznGjI=; b=QrnSCbfbEb30YQKIvGuvvmYjR3/A
        AhPSgIWCICllII2xl0Tg3Bk6JHxGHL92rUU090EmdDOAcxYTXKwsoJQU3oNSGXwC
        R63cfUlqEki/QNi20ADPiQ1mFjALey1MixUeStQGLgGTKJPC17KAhbLJFi6px/cu
        ugoaEjA8inBc5g8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50AD214AF37;
        Tue, 28 Sep 2021 16:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5B1814AF34;
        Tue, 28 Sep 2021 16:50:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
        <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
        <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
        <87czou1dmp.fsf@evledraar.gmail.com>
        <YVJZrOYucywgoi+v@coredump.intra.peff.net>
        <xmqqpmssk0v1.fsf@gitster.g> <877df0wknp.fsf@evledraar.gmail.com>
Date:   Tue, 28 Sep 2021 13:50:53 -0700
In-Reply-To: <877df0wknp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 28 Sep 2021 21:42:45 +0200")
Message-ID: <xmqqlf3gjufm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C6205680-209D-11EC-A905-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 28 2021, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>>> >> +	memcpy(t, &blank, sizeof(*t));
>>>> >
>>>> > Is
>>>> > 	*t =3D blank;
>>>> >
>>>> > not a thing in C?
>>>
>>> It would be fine to use struct assignment here, and should be equival=
ent
>>> in most compilers. They know about memcpy() and will inline it as
>>> appropriate.
>>
>> FWIW, I'd be fine with structure assignment, but we already have too
>> many such memcpy(<ptr>, &<struct>, sizeof(struct)), adding one more
>> is not giving us too much incremental burden for later clean-up.
>>
>>> I think some C programmers tend to prefer memcpy() just because that'=
s
>>> how they think. It also wasn't legal in old K&R compilers, but as far=
 as
>>> I know was in C89.
>>
>> I think so, too.
>
> Getting back to the topic of this v2 in general, my reading of the
> discussion since then is that nothing in it necessitated a v3 re-roll t=
o
> address outstanding issues. If I've got that wrong please shout...

I was hoping that these can hit 'next' soonish.
