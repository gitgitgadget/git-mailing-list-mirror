Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B3BC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB57611AD
	for <git@archiver.kernel.org>; Thu,  6 May 2021 01:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhEFB1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 21:27:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60748 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFB1g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 21:27:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AF33124055;
        Wed,  5 May 2021 21:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NycDhQWID39S
        kWDzLI9PDMBHfFfDhQYCx3lx5jNjl5w=; b=shiIKhan1GlfAH3EZre3P7kUDR0l
        csacoQkW1W1i8Gp/yT3JmjwH/kyeEEbcLehsKW3LSo3ebhIYuPsek0FRIFhrbpdk
        gVxBlf6luTDWgT1FKBbxVI6OTrfajX6OMkLEpoCcWpedWpKztT7BhljhJrsv0rWm
        NpLqaj/I0CTbhT8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34676124053;
        Wed,  5 May 2021 21:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 71E67124052;
        Wed,  5 May 2021 21:26:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
References: <20200404142131.GA679473@coredump.intra.peff.net>
        <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet>
Date:   Thu, 06 May 2021 10:26:34 +0900
In-Reply-To: <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 5 May 2021 16:38:42 +0200 (CEST)")
Message-ID: <xmqqv97w1wl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 197330A2-AE0A-11EB-9BE8-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi =C3=86var,
>
> On Wed, 5 May 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
>> appears under -O3 (but not -O2). This makes the build pass under
>> DEVELOPER=3D1 without needing a DEVOPTS=3Dno-error.
>>
>> This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
>> clang 7.0.1-8+deb10u2. We've had this warning since
>> ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).
>>
>> As noted in [2] this warning happens because the compiler doesn't
>> assume that errno must be non-zero after a failed syscall. Let's work
>> around it as suggested in that analysis. We now return -1 ourselves on
>> error, and save away the value of errno in a variable the caller
>> passes in.
>
> It would probably be a lot nicer if you lead with this insight. I could
> imagine, for example, that a oneline like this would be much more helpf=
ul
> to any reader:
>
> 	trace2: do not assume errno !=3D 0 after a failed syscall

But that is misleading. =20

My understanding is that this patch is about working around
compilers that do not know that a failed syscall means errno would
be set to non-zero.  Am I mistaken?

Otherwise I'd strongly prefer to see a word that hints that this is
an otherwise unneeded workaround for comiplers.  Your suggested
title instead hints that it is wrong to assume that errno will be
set to non-zero after a syscall.  I do not think that is the message
we want to send to our readers.


