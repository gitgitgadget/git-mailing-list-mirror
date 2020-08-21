Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB7AC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABA820748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 18:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHUSpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:45:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:37370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHUSpA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 14:45:00 -0400
Received: (qmail 19486 invoked by uid 109); 21 Aug 2020 18:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 18:45:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30707 invoked by uid 111); 21 Aug 2020 18:44:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 14:44:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 14:44:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] index-pack threading defaults
Message-ID: <20200821184459.GB3263614@coredump.intra.peff.net>
References: <20200821175153.GA3263018@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200821175153.GA3263018@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 01:51:53PM -0400, Jeff King wrote:

> That value was determined experimentally in 2012. I'm not sure of the
> exact reason it's different now (modern processors are better at
> parallelism, or modern git is better at parallelism, or the original
> experiment was just a fluke). But regardless, I can get on the order of
> a two-to-one speedup by bumping the thread count. See the final patch
> for timings and more specific discussion.

After writing a response elsewhere in the thread, it occurred to me that
a good candidate for explaining this may be that our modern sha1dc
implementation is way slower than what we were using in 2012 (which
would have been either block-sha1, or the even-faster openssl
implementation). And since a good chunk of index-pack's time is going to
computing sha1 hashes on the resulting objects, that means that since
2012, we're spending relatively more time in the hash computation (which
parallelizes per-object) and less time in the other parts that happen
under a lock.

-Peff
