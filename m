Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C392042F
	for <e@80x24.org>; Thu, 17 Nov 2016 01:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbcKQBnL (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 20:43:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:44226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753265AbcKQBnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 20:43:11 -0500
Received: (qmail 11003 invoked by uid 109); 17 Nov 2016 01:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Nov 2016 01:43:10 +0000
Received: (qmail 23641 invoked by uid 111); 17 Nov 2016 01:43:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Nov 2016 20:43:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Nov 2016 17:43:07 -0800
Date:   Wed, 16 Nov 2016 17:43:07 -0800
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: Re* Protecting old temporary objects being reused from
 concurrent "git gc"?
Message-ID: <20161117014306.2ptqd56gur7dlb4c@sigill.intra.peff.net>
References: <1479219194.2406.73.camel@mattmccutchen.net>
 <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
 <1479231184.2406.88.camel@mattmccutchen.net>
 <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
 <xmqq1sybqmjt.fsf@gitster.mtv.corp.google.com>
 <20161117010449.6k3cwo3njvrid4jy@sigill.intra.peff.net>
 <xmqqvavmopl8.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvavmopl8.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 05:35:47PM -0800, Junio C Hamano wrote:

> OK, here is what I have queued.
> 
> -- >8 --
> Subject: cache-tree: make sure to "touch" tree objects the cache-tree records
> 
> The cache_tree_fully_valid() function is called by callers that want
> to know if they need to call cache_tree_update(), i.e. as an attempt
> to optimize. They all want to have a fully valid cache-tree in the
> end so that they can write a tree object out.

That makes sense. I was focusing on cache_tree_update() call, but we do
not even get there in the fully-valid case.

So I think this approach is nice as long as there is not a caller who
asks "are we fully valid? I do not need to write, but was just
wondering". That should be a read-only operation, but the freshen calls
may fail with EPERM, for example.

I do not see any such callers, nor do I really expect any. Just trying
to think through the possible consequences.

> Strictly speaking, freshing these tree objects at each and every
> level is probably unnecessary, given that anything reachable from a
> young object inherits the youth from the referring object to be
> protected from pruning.  It should be sufficient to freshen only the
> very top-level tree instead.  Benchmarking and optimization is left
> as an exercise for later days.

Good observation, and nicely explained all around.

-Peff
