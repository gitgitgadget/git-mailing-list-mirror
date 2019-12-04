Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83056C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3610B20862
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fKu41hd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbfLDSP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:15:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54306 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfLDSP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 13:15:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE52F39B9F;
        Wed,  4 Dec 2019 13:15:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bUeu4bfAyqQHAPYYtmJcg0Z5h30=; b=fKu41h
        d+oP7WMQjZ2yBlP1BRm8Pg0SerTI6p9vtQ8RbvKl/mdtDxOpFnSVMQ2nPOsH9m9m
        Lr1Y8/qeaZ/S8YDa4IKhMGepBE6sa4MIqnaq0mpKoCS9gW0u7U4aRyadsxWHVei4
        aY0vr3vCXTFxjRzgH6zWJpZ+MF5mBRn3SnSwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B/KK2sDkd8wWrqvEZK2fSxdd6cK+vXl/
        2ZR0JXNgZs/KzijecqieXO/V2aVbrB45Ak9kR1s+qUmksPn4P6jkqUAtGHH0lCif
        5uXJS0JSn3a20tNPAd20IyiDg7VjzHQixsGu+Ejjhrs3hU1x2Mj2u/S1T6ArprF2
        cZSgPK385ww=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C306339B9E;
        Wed,  4 Dec 2019 13:15:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2FEFE39B9D;
        Wed,  4 Dec 2019 13:15:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Colin Stolley <cstolley@runbox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
References: <20191127222453.GA3765@owl.colinstolley.com>
        <20191202174035.GJ23183@szeder.dev>
        <20191202194231.GA10707@sigill.intra.peff.net>
        <xmqq7e3d75vk.fsf@gitster-ct.c.googlers.com>
        <20191203173334.GA20027@owl.colinstolley.com>
        <20191203221819.GB28419@sigill.intra.peff.net>
Date:   Wed, 04 Dec 2019 10:15:23 -0800
In-Reply-To: <20191203221819.GB28419@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 3 Dec 2019 17:18:19 -0500")
Message-ID: <xmqqsgm03qkk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A65936A-16C2-11EA-AA2F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 03, 2019 at 11:33:34AM -0600, Colin Stolley wrote:
>
>> Junio C Hamano wrote:
>> 
>> > Let me locally squash your fix in and credit you with helped-by
>> > footer in the amended log message.  Strictly speaking, this may
>> 
>> I'm also happy to provide a khash version if that is still desired,
>> perhaps as a separate patch.
>
> Personally I'd be OK with it as-is, or with a conversion to khash (as I
> said earlier, I prefer khash myself, but it's not like there aren't tons
> of other hashmap.c users in the code).

Exactly me feeling.  Thanks.
