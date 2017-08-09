Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8050D1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 15:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbdHIPGs (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 11:06:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:33440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751560AbdHIPGr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 11:06:47 -0400
Received: (qmail 11324 invoked by uid 109); 9 Aug 2017 15:06:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 15:06:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28593 invoked by uid 111); 9 Aug 2017 15:07:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 11:07:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 11:06:45 -0400
Date:   Wed, 9 Aug 2017 11:06:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] hashcmp: use memcmp instead of open-coded loop
Message-ID: <20170809150644.ny565zdhki5zgdzr@sigill.intra.peff.net>
References: <20170809101106.p45y34uk6wcruqxv@sigill.intra.peff.net>
 <20170809101645.7wv4mcsmnejxzhvs@sigill.intra.peff.net>
 <2b111a78-dea4-85ff-3d8f-94d2eee0ca26@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b111a78-dea4-85ff-3d8f-94d2eee0ca26@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 09, 2017 at 04:55:43PM +0200, René Scharfe wrote:

> > I also wondered if using memcmp() could be a hint to the compiler to use
> > an intrinsic or some other trick, especially because the "len" here is a
> > constant. But in a toy function compiled with "gcc -S", it looks like we
> > do keep the call to memcmp (so the speedup really is glibc, and not some
> > compiler magic).
> 
> GCC 7 inlines memcmp() if we only need a binary result:
> 
> 	https://godbolt.org/g/iZ11Ne

Cute.  It turns it into a series of 8-byte xors. The original open-coded
loop doesn't end up nearly as optimized with gcc-7.

I suspect many calls in practice are of the binary-result type. So some
of the speedup I saw may have been from compiler improvements and not
libc improvements. Still, I think the general argument is the same,
replacing "if your libc memcmp is fast" with "if your libc/compiler
makes memcmp fast".

-Peff
