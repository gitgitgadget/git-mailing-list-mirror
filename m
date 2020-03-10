Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2E9C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5063B208C3
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WFz20hgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCJS0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:26:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50557 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJS0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 14:26:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DDAC5AE30;
        Tue, 10 Mar 2020 14:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+vJ/Sy/4/y+Bs0GPQNlfvZWeFNA=; b=WFz20h
        gIjlffmtS0Knp6FbnTVVsXePXg183SyDEDZGKVMiXHJTguldfzLaPi6A5gFXNdnC
        t1VT4r6LpJcTdRaPV5dvVMc0VtoQIFddJRYQ2QM+OEy3vMXIRi++mileCwJ7vH7s
        OYRn+XdxmnAb9znCpeBJTBONLiJVclrsORwns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aHIPrecOeyPhKP/2bKIGXpAkIy/QPT8z
        puPXy8qzAdjAmgAo9DeUfpHBWQXIuCwDDUXTMaOGlwn87LqsGkz90rCYMxvicsXz
        QXZqa8V28BqtVsLTdfy3tgEw4Zfw7lRrdtEIT6IVPZJ2c/DXTC4zCaOMEzmTyeVL
        c8njclqvzCs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 149EF5AE2F;
        Tue, 10 Mar 2020 14:26:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FEB35AE2E;
        Tue, 10 Mar 2020 14:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] commit-slab: clarify slabname##_peek()'s return value
References: <20200310153049.3482-1-szeder.dev@gmail.com>
        <20200310175446.GB549010@coredump.intra.peff.net>
        <xmqqftegjcne.fsf@gitster.c.googlers.com>
Date:   Tue, 10 Mar 2020 11:26:21 -0700
In-Reply-To: <xmqqftegjcne.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 10 Mar 2020 11:19:33 -0700")
Message-ID: <xmqqblp4jcc2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4E69DF4-62FC-11EA-B8C9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> But that would get a bit awkward, because peek() returns a pointer, not
>> a value (as it should, because the type we're storing may be a compound
>> type, which we generally avoid passing or returning by value).  So we'd
>> actually need to return a pointer to a zero-initialized dummy value. Not
>> impossible, but getting a bit odd.
>
> Do we have a guarantee that callers of the peek only look at, never
> touch, the location?  As long as we make it return a "const *", it
> might be OK, but a quick look at commit-slab.h tells me that we do
> not say "const".

Ah, should have read the other message ;-)
