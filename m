Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8D851FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 05:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbcLCFQY (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 00:16:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:51067 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbcLCFQX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 00:16:23 -0500
Received: (qmail 5033 invoked by uid 109); 3 Dec 2016 05:14:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 05:14:57 +0000
Received: (qmail 19643 invoked by uid 111); 3 Dec 2016 05:15:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Dec 2016 00:15:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Dec 2016 00:14:54 -0500
Date:   Sat, 3 Dec 2016 00:14:54 -0500
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] shallow.c: make paint_alloc slightly more robust
Message-ID: <20161203051454.vp772xtto5ddxe7g@sigill.intra.peff.net>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 02, 2016 at 09:31:01PM +0100, Rasmus Villemoes wrote:

> I have no idea if this is a real issue, but it's not obvious to me that
> paint_alloc cannot be called with info->nr_bits greater than about
> 4M (\approx 8*COMMIT_SLAB_SIZE). In that case the new slab would be too
> small. So just round up the allocation to the maximum of
> COMMIT_SLAB_SIZE and size.

I had trouble understanding what the problem is from this description,
but I think i figured it out from the code.

Let me try to restate it to make sure I understand.

The paint_alloc() may be asked to allocate a certain number of bits,
which it does across a series of independently allocated slabs. Each
slab holds a fixed size, but we only allocate a single slab. If the
number we need to allocate is larger than fits in a single slab, then at
the end we'll have under-allocated.

Your solution is to make the slab we allocate bigger. But that seems
odd to me. Usually when we are using COMMIT_SLAB_SIZE, we are allocating
a series of slabs that make up a virtual array, and we know that each
slab has the same size. So if you need to find the k-th item, and each
slab has length n, then you'd look at slab (k / n), and then at item (k
% n) within that slab.

In other words, I think the solution isn't to make the one slab bigger,
but to allocate slabs until we have enough of them to meet the request.

But I don't really know how this code is used, or why it is using
COMMIT_SLAB_SIZE in the first place. That's generally supposed to be an
internal detail of the commit-slab.h infrastructure. Why is it being
used directly, instead of just using the functions that commit-slab
defines?

-Peff
