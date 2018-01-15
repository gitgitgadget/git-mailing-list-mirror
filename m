Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9A31FAE2
	for <e@80x24.org>; Mon, 15 Jan 2018 23:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeAOXwy (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 18:52:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:44524 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750752AbeAOXwy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 18:52:54 -0500
Received: (qmail 23877 invoked by uid 109); 15 Jan 2018 23:52:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jan 2018 23:52:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20806 invoked by uid 111); 15 Jan 2018 23:53:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jan 2018 18:53:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2018 18:52:52 -0500
Date:   Mon, 15 Jan 2018 18:52:52 -0500
From:   Jeff King <peff@peff.net>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] packed_ref_cache: don't use mmap() for small files
Message-ID: <20180115235251.GA21900@sigill.intra.peff.net>
References: <20180113161149.9564-1-kgybels@infogroep.be>
 <20180115211505.GA4778@sigill.intra.peff.net>
 <20180115233751.GA1781@infogroep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180115233751.GA1781@infogroep.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 16, 2018 at 12:37:51AM +0100, Kim Gybels wrote:

> > This looks good to me, and since it's a recent-ish regression, I think
> > we should take the minimal fix here.
> 
> The minimal fix being a simple NULL check before munmap()?

Sorry to be unclear. I just meant that your patch is probably fine
as-is. I didn't want to hold up a regression fix with a bunch of
nit-picking or possible future work, when we could build that on top
later.

> > But it does make me wonder whether xmmap() ought to be doing this "small
> > mmap" optimization for us. Obviously that only works when we do
> > MAP_PRIVATE and never write to the result. But that's how we always use
> > it anyway, and we're restricted to that to work with the NO_MMAP wrapper
> > in compat/mmap.c.
> 
> Maybe I should have left the optimization for small files out of the patch for
> the zero length regression. After all, read() vs mmap() performance might
> depend on other factors than just size.

I'd be OK including it here, since there's prior art in the commit you
referenced. Though of course actual numbers are always good when
claiming an optimization. :)

> > If the "!size" case is just lumped in with "size <= SMALL_FILE_SIZE",
> > then we'd try to xmalloc(0), which is guaranteed to work (we fallback to
> > a 1-byte allocation if necessary). Would that make things simpler and
> > more consistent for the rest of the code to always have snapshot->buf be
> > a valid pointer (just based on seeing Michael's follow-up patches)?
> 
> Indeed, all those patches are to avoid using the NULL pointers in ways that are
> undefined. We could also copy index_core's way of handling the zero length
> case:
> ret = index_mem(sha1, "", size, type, path, flags);
> 
> Point to some static memory instead of NULL, then all the pointer arithmetic is defined.

Yep, that would work, too. I don't think the overhead of a
once-per-process xmalloc(0) is a big deal, though, if it keeps the code
simpler (though I admit it is not that complex either way).

-Peff
