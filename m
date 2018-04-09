Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104BE1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 03:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeDID5r (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 23:57:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752211AbeDID5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 23:57:46 -0400
Received: (qmail 21928 invoked by uid 109); 9 Apr 2018 03:57:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Apr 2018 03:57:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12126 invoked by uid 111); 9 Apr 2018 03:57:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 08 Apr 2018 23:57:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2018 23:57:43 -0400
Date:   Sun, 8 Apr 2018 23:57:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] ref-filter: factor ref_array pushing into its own
 function
Message-ID: <20180409035743.GA30063@sigill.intra.peff.net>
References: <20180406185801.GA921@sigill.intra.peff.net>
 <20180406185945.GC11108@sigill.intra.peff.net>
 <xmqqy3hx70dw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3hx70dw.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 09, 2018 at 08:18:35AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In preparation for callers constructing their own ref_array
> > structs, let's move our own internal push operation into its
> > own function.
> >
> > While we're at it, we can replace REALLOC_ARRAY() with
> > ALLOC_GROW(), which should give the growth operation
> > amortized linear complexity (as opposed to growing by one,
> > which is potentially quadratic, though in-place realloc
> > growth often makes this faster in practice).
> 
> Sorry, but I do not quite get the last part this paragraph.  Up to
> but not including ", though in-place..." I would understand as:
> 
>      - With ALLOC_GROW(), we are explicit in that we are amortizing
>        the allocation cost by growing in exponential batches.
> 
>      - With REALLOC_ARRAY(), we are telling the underlying
>        realloc(3) that it is OK to pretend that we grow by one, but
>        if that permission is literally followed, it could end up
>        quadratic.
> 
>     So if you have really a bad realloc(3) implementation, switching
>     to use ALLOC_GROW() is an improvement.

Yes, that's the gist of what I was saying. Though it is not even
necessarily "a bad realloc". At some point you may hit heap segmentation
and need to copy (though I guess if that happens repeatedly then maybe
your realloc really _is_ bad ;) ).

> But after that I am not sure what you are getting at.  Do you mean
> "In practice, a well-done realloc(3) does the amortizing internally
> anyway, which makes it faster than the grow-by-one quadratic, so
> this change may not make that much of a difference"?  Or do you mean
> "In practice, a well-done realloc(3) internally amortizes better
> than we do manually, so this change may hurt performance"?

The first. I couldn't measure any speedup on glibc, which makes me think
it's mostly doing in-place expansion.

> In either case, I think this splitting into a helper is obviously a
> good move, and using ALLOC_GROW() is conceptually cleaner, as we use
> it everywhere and tend to avoid realloc(3) just to add one item.
> 
> Other than that small confusion (not even a nit), three patches were
> pleasant read.  Thanks.

Thanks. Please feel free to expand or clarify the commit message if that
helps.

-Peff
