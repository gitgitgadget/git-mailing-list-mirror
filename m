Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146DC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7D7610A0
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhEKU74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:59:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57659 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKU74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:59:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81DA5C629D;
        Tue, 11 May 2021 16:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GoEjsgBMo+Oj2Ej53qywap7sHi/Qb6ZQ/rlCkV
        w/6VU=; b=lqaj2Wjreo1S0gJPiOxTgJk8sbpthnGh1iIiOd3EjNATLD6qpHNnJu
        F+HzFSPvWJ8uw0DdUlpbfV0GPzyPCcwY4kQ6FCpcneoBKBNZJXLD3JVEIR+xH1b0
        Lz86nx0UHt0Zo7x2MGOLIHXvIqCEi5UrnWFCLUa5mN6GoG2P+DISs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77ECCC629B;
        Tue, 11 May 2021 16:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA725C6297;
        Tue, 11 May 2021 16:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
References: <20200404142131.GA679473@coredump.intra.peff.net>
        <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet>
        <xmqqv97w1wl1.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105062229270.50@tvgsbejvaqbjf.bet>
        <xmqqh7jfy3du.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105111632380.57@tvgsbejvaqbjf.bet>
        <YJrGOqjS10Z/WkE8@coredump.intra.peff.net>
Date:   Wed, 12 May 2021 05:58:47 +0900
In-Reply-To: <YJrGOqjS10Z/WkE8@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 14:00:26 -0400")
Message-ID: <xmqqlf8lkmwo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE5098F0-B29B-11EB-AF72-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 11, 2021 at 04:34:49PM +0200, Johannes Schindelin wrote:
>
>> On Fri, 7 May 2021, Junio C Hamano wrote:
>> 
>> > 		/* GCC thinks socket()/connect() might fail to set errno */
>> > 		return errno ? errno : EIO;
>> >
>> > If a compiler thinks errno may *not* be set, can 'errno' be reliably
>> > used to decide if it can be returned as-is or a fallback value EIO
>> > should be used, without triggering the same (incorrect) working in
>> > the first place?
>> 
>> Oh, I guess I mistook the problem for something else, then.
>> 
>> If the problem is that `errno` is not set in case of failure, the
>> resolution is easy (and even recommended in the manual page of `errno`):
>> simply set it to 0 before the syscall (or in the function that relies on
>> `errno == 0` means success).
>
> I don't think that is the problem. According to the standard, errno is
> always set to a non-zero value after a syscall failure.
>
> The problem is only that the compiler does not incorporate that special
> knowledge of the variable, so it generates a warning even though we can
> reason that the situation it describes is impossible.

Yes, that is what I tried to say (i.e. if the compiler does not know
errno has a defined value at certain places in our code and
complain, then "return errno ? errno : EIO" would get the same
warning because bases its outcome on the value of errno the compiler
thinks is possibly undefined at that point), but apparently I failed
to convey that clearly enough.

Thanks.


