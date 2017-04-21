Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBEC207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 06:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035281AbdDUGFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 02:05:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60526 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1033573AbdDUGFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 02:05:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D05DB81829;
        Fri, 21 Apr 2017 02:05:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ub77nEh82jIsqm0vpaOp/rg9Lcc=; b=ePmn7C
        Bj2FRUTLhFkbsMeYrUmDH42kWk8B4Mvltd5dFXDhuoqDZAXEFCUd++06wgVE4mH/
        sEKosfFKyYuF6D6yP+Q/9FFL1Le/eJPP+Nff1osXEALEmEKkNdx8F3Qg/0nl1tgC
        U9s4mkSoJ+sSAWFAFIpLFaSwo5ChWJTl+tqmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tnI6FwdKFyqN10ITjWXDMPYO+wcQz/cq
        +fTl5SpwNmOiyAY6M+MaZoYwYCIGGyIp6JS1YpmmmlLkMOmzVdQzvkAE1wJnggdZ
        eWhPcEBB6t8NX/yA4/uUzc1eb0lf4K6a9Gcf55YA61PD87UDMNvtg2aF9XYkTXs3
        8p/1CrrlvKQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7F2F81828;
        Fri, 21 Apr 2017 02:05:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38BBB81827;
        Fri, 21 Apr 2017 02:05:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/8] Introduce timestamp_t for timestamps
References: <cover.1491159939.git.johannes.schindelin@gmx.de>
        <cover.1492721487.git.johannes.schindelin@gmx.de>
Date:   Thu, 20 Apr 2017 23:05:20 -0700
In-Reply-To: <cover.1492721487.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 20 Apr 2017 22:52:05 +0200 (CEST)")
Message-ID: <xmqqpog647of.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8078B724-2658-11E7-89CB-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Note: while the `time_t` data type exists and is meant to be used for
> timestamps, on 32-bit Linux it is *still* 32-bit. An earlier iteration
> used `time_t` for that reason, but it came with a few serious downsides:
> as `time_t` can be signed (and indeed, on Windows it is an int64_t),
> Git's expectation that 0 is the minimal value does no longer hold true,
> introducing its own set of interesting challenges. Besides, if we *can*
> handle far in the future timestamps (except for formatting them using
> the system libraries), it is more consistent to do so.

I somehow had an impression that the list consensus during the
discussion on an earlier round of this series was that time_t is
more appropriate, as platforms with time_t with inadequent range
will be updated before it gets too late at around 2038 (or they will
die off).  After all, at some point we need to interact with the
platform functions that expect time_t as their interface and they do
not take our own timestamp_t without casting.

But that is provided if not introducing timestamp_t and using time_t
results in a simpler code.  I do not know if that is the case.

For timestamps in the distant past, even though time_t could be
unsigned, I do not think anybody came up with a concrete example of
a platform with such a problem during the previous discussions,
while I do recall people wanting to use Git to store historical
documents with timestamps before 1970.  We do expect 0 can be used
as a sentinel, which needs to be updated once we seriously start
supporting such use cases.  I think that (i.e. should the timestamp
be signed?) is more or less unrelated to the focus of the discussion
that stemed from this topic, which was "ulong that is often 32-bit
does not necessarily fit the notion of time on a platform, which is
time_t, and we need to widen it", which all involved in the discussion
agreed.

In any case, when merged to 'pu', this had a slight conflict with
topics in flight in builtin/name-rev.c and I think I resolved it
correctly, but please double check.  I will have to revamp the
resolution rerere remembered when the next version of this series
starts using time_t instead of timestamp_t anyway, but it is better
to always get conflict resolution right.  That is what maintainers
do and what they are for ;-)

Thanks.

