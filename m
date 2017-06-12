Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA45120C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdFLVNu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:13:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:38471 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdFLVNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:13:50 -0400
Received: (qmail 1248 invoked by uid 109); 12 Jun 2017 21:13:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:13:50 +0000
Received: (qmail 16276 invoked by uid 111); 12 Jun 2017 21:13:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:13:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:13:48 -0400
Date:   Mon, 12 Jun 2017 17:13:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] sha1_file: extract type and size from object_info
Message-ID: <20170612211348.xqawraeqacgw6iyx@sigill.intra.peff.net>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <b090fef9ff8593a6d77c3d3363b4af7e73ac12dc.1497035376.git.jonathantanmy@google.com>
 <20170610070133.boicdvkudifz7b4c@sigill.intra.peff.net>
 <20170612125254.33ba633a@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170612125254.33ba633a@twelve2.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 12:52:54PM -0700, Jonathan Tan wrote:

> > I like the idea of consolidating the logic. But I can't help but feel
> > that pulling these fields out of object_info is a step backwards. The
> > point of that struct is to let the caller specify which aspects of the
> > object they're interested in
> 
> My issue was that there are some parts that cannot be turned off (in
> particular, the object_info.u.packed part). Having said that, reading
> the packed object itself should give us enough information to populate
> that, so I'll take a look and see if this is possible.

I think in general that the parts of object_info which aren't optional
should be largely "free" to set (or at least O(1)).

> > Another approach to this whole mess is to have a single function for
> > acquiring a "handle" to an object, along with functions to query aspects
> [...]
> 
> There are a few safeguards that, I think, only work with the current
> get-everything-then-forget-about-it approach (the packed-loose-packed
> retry mechanism, and the desperate retry-if-corrupt-packed-object one).
> If we have a handle with a cache, then, for example, we would lose the
> ability to retry packed after loose if the handle has already declared
> that the object is loose.

Yes, the handle would have to make some guarantee that it could access
the object. Which would generally involve holding open a descriptor or
mmap. That would probably take some surgery to make it work with the way
pack mmap windows work.

So the whole "handle" thing is how it probably _ought_ to work, but I
agree we may be too far down the other path to make it worth switching.

-Peff
