Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0817C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2D520838
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tZHcjQFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIFVwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:52:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51173 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFVwf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:52:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D622B6F395;
        Sun,  6 Sep 2020 17:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MLDcgU0g1lLfzkNfwdnThz1rwi4=; b=tZHcjQFcYYyu8gRSM9qQ
        wPqPt/mMZM0Q71iU8FMhmMb5uUWoB+01rG1X64TwNRSJ7dUniFeqckNLb6GLMH3T
        T1aOoWNx5I+EqZqfOAX9t2kpt9WDd/os1XA0Cw/XPmT9EjL0LE9j5VrFflLifZde
        K9EEAMSxzjPZ9kTFynj/ApY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=GxvuaezWWPv/3G1uBJE9ccLW2oXe3mOhwSKkdpj8Fo4zCU
        r0OcZxtGuA3xSHP1/71wqKpU6wwzPLFOmD5XaPauukM+1t2Qn9VSrmut66/lZuln
        m75TprKG9eHHrvKpPACzTalJzTv0gItyhW/KAlveI6Zf08Z4aPCOxMicGhtFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD1DD6F394;
        Sun,  6 Sep 2020 17:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 593B46F391;
        Sun,  6 Sep 2020 17:52:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 07/14] bloom: split 'get_bloom_filter()' in two
References: <cover.1599172907.git.me@ttaylorr.com>
        <ba89a0cb837abc5fadbaa9514169636d85ee50cf.1599172908.git.me@ttaylorr.com>
        <85h7sc9m0v.fsf@gmail.com> <20200905173825.GA6820@nand.local>
        <CANQwDwcWveN03h=Ex0GFo-Mm89UT8_HXFMQcZWdDx9MPZYYodQ@mail.gmail.com>
        <20200905180120.GB6820@nand.local>
        <CANQwDwcD5XD3e7ar=8HPupobOZGDN4bgQJBS1Ad1m2NDx8eurw@mail.gmail.com>
        <20200905183854.GC6820@nand.local> <20200905185534.GA7416@nand.local>
        <20200905190449.GB6209@szeder.dev> <20200905194926.GA7964@nand.local>
Date:   Sun, 06 Sep 2020 14:52:33 -0700
Message-ID: <xmqq8sdm4lpa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45687E0C-F08B-11EA-AC0E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> And this is exactly what I proposed earlier.
>
> Fair enough, I bet that would work.
>
> Junio, let's eject this series while I try to see if SZEDER's idea is
> workable.

Thanks, I'll mark the topic as such for now.
