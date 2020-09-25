Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B984C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 04:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045382176B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 04:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgIYE4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 00:56:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:40314 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgIYE4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 00:56:21 -0400
Received: (qmail 12511 invoked by uid 109); 25 Sep 2020 04:56:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 04:56:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15114 invoked by uid 111); 25 Sep 2020 04:56:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 00:56:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 00:56:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 1/2] bswap.h: drop unaligned loads
Message-ID: <20200925045620.GA3110076@coredump.intra.peff.net>
References: <20200924191638.GA2528003@coredump.intra.peff.net>
 <20200924192111.GA2528225@coredump.intra.peff.net>
 <b4b9475f-9c84-1889-835d-9f6e81198e5b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4b9475f-9c84-1889-835d-9f6e81198e5b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 12:02:38AM +0200, René Scharfe wrote:

> Older versions of gcc and clang didn't see through the shifting
> put_be32() implementation.  If you go back further there are also
> versions that didn't optimize the shifting get_be32().  And the latest
> icc still can't do that.
> 
> gcc 10.2 just optimizes all functions to a bswap and a mov.  Can't do
> any better than that, can you?
> 
> But why do we then see a difference in our benchmark results?  Not sure,
> but https://www.godbolt.org/z/7xh8ao shows that gcc is shuffling some
> instructions around depending on the implementation.  Switch to clang if
> you want to see more vigorous shuffling.

We do redefine ntohl(), etc in compat/bswap.h. Looking at them, I'd
think the result would end up as a bswap instruction, though. And
indeed, trying to feed that to godbolt results in the same output you
got.

It does sound like older compilers were benefiting from the unaligned
versions. Building with gcc-4.8 (from debian jessie in a docker
container on the same machine), I get ~6.25s with the unaligned load
versus ~6.6s with the bit-shifting code. So that's the opposite of how
the newer compiler behaves.

Benchmarking clang-8 (which your results showed doesn't handle the
shifting version well). It likewise is just _slightly_ slower after my
patch (11.47s versus 11.57s).

Given that newer compilers behave the opposite way, and the overall
small magnitude of the impact, I'm still comfortable with the change.
It's nice to have a better understanding of how the compiler is
impacting it (even if I am still confused how anything at all changes on
the newer compilers). Thanks for digging.

-Peff
