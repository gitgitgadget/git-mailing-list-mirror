Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DE21F463
	for <e@80x24.org>; Mon, 23 Sep 2019 19:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfIWTPL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 15:15:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57464 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726033AbfIWTPL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 15:15:11 -0400
Received: (qmail 29418 invoked by uid 109); 23 Sep 2019 19:15:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 19:15:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3799 invoked by uid 111); 23 Sep 2019 19:17:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 15:17:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 15:15:10 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923191509.GC21344@sigill.intra.peff.net>
References: <20190913205148.GA8799@sigill.intra.peff.net>
 <20190920170448.226942-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920170448.226942-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 10:04:48AM -0700, Jonathan Tan wrote:

> > I'm happy to discuss possible projects if anybody has an idea but isn't
> > sure how to develop it into a proposal.
> 
> I'm new to Outreachy and programs like this, so does anyone have an
> opinion on my draft proposal below? It does not have any immediate
> user-facing benefit, but it does have a definite end point.
> 
> Also let me know if an Outreachy proposal should have more detail, etc.
> 
>     Refactor "git index-pack" logic into library code
> 
>     Currently, whenever any Git code needs a pack to be indexed, it
>     needs to spawn a new "git index-pack" process, passing command-line
>     arguments and communicating with it using file descriptors (standard
>     input and output), much like an end-user would if invoking "git
>     index-pack" directly. Refactor the pack indexing logic into library
>     code callable from other Git code, make "git index-pack" a thin
>     wrapper around that library code, and (to demonstrate that the
>     refactoring works) change fetch-pack.c to use the library code
>     instead of spawning the "git index-pack" process.
> 
>     This allows the pack indexing code to communicate with its callers
>     with the full power of C (structs, callbacks, etc.) instead of being
>     restricted to command-line arguments and file descriptors. It also
>     simplifies debugging in that there will no longer be 2
>     inter-communicating processes to deal with, only 1.

I think this is an OK level of detail. I'm not sure quite sure about the
goal of the project, though. In particular:

  - I'm not clear what we'd hope to gain. I.e., what richer information
    would we want to pass back and forth between index-pack and the
    other processes? It might also be more efficient, but I'm not sure
    it's measurably so (we save a single process, and we save some pipe
    traffic, but the sideband demuxer would probably end up passing it
    over a self-pipe anyway).

  - index-pack is prone to dying on bad input, and we wouldn't want it
    to take down the outer fetch-pack or receive-pack, which are what
    produce useful messages to the user. That's something that could be
    fixed as part of the libification, but I suspect the control flow
    might be a little tricky.

  - we don't always call index-pack, but sometimes call unpack-objects.
    I suppose we could continue to call an external unpack-objects in
    that path, but that eliminates the utility of having richer
    communication if we sometimes have to take the "dumb" path. A while
    ago I took a stab at teaching index-pack to unpack. It works, but
    there are a few ugly bits, as discussed in:

      https://github.com/peff/git/commit/7df82454a855281e9c147f3023225f8a6f72e303

    Maybe that would be worth making part of the project?

-Peff
