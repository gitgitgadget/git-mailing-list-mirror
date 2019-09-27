Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42A21F463
	for <e@80x24.org>; Fri, 27 Sep 2019 22:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfI0WOW (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 18:14:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:34150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725990AbfI0WOW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 18:14:22 -0400
Received: (qmail 12325 invoked by uid 109); 27 Sep 2019 22:14:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Sep 2019 22:14:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14537 invoked by uid 111); 27 Sep 2019 22:16:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Sep 2019 18:16:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Sep 2019 18:14:21 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Common thread pool API in Git?
Message-ID: <20190927221420.GA31237@sigill.intra.peff.net>
References: <20190926003300.195781-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926003300.195781-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 05:33:00PM -0700, Jonathan Tan wrote:

> Does anyone have ideas or plans for this? I know that (at least) "grep"
> and "index-pack" have their own implementations, and it would be great
> to just have one that all code can use.
> [..]
> Searching reveals [2], but I don't think it ever made it into Git.

I think that's correct. I had a recollection of this being discussed in
the past, but I'm pretty sure I was thinking of the patches you already
linked to. We didn't take it because the proposed callers actually were
starting sub-processes anyway, so we ended up instead with
run_processes_parallel():

  https://public-inbox.org/git/1442012994-20374-1-git-send-email-sbeller@google.com/

In case it's useful, here's the latest version of the threaded version
that was posted to the list (I think):

  https://public-inbox.org/git/1440724495-708-5-git-send-email-sbeller@google.com/

> For those who want to know, this question was motivated by a big delta
> tree occurring in [1]. index-pack does parallelize delta resolution, but
> it cannot split up trees into threads: each delta base root can go into
> its own thread, but when a delta base root is processed, all deltas on
> that root (direct or indirect) is processed in the same thread. I took a
> look to see if this could be parallelized, but thought that it might be
> better to standardize on a thread pool implementation first.

This seems like a reasonable thing to want to do. It does mean that
threads have more potential to interact with each other. E.g., two might
use the same base now, so we'd have to make sure we don't throw away the
bytes of that base until both are done. As you pointed out to me
off-list, the bases are currently placed in a cache, but I think that
cache is currently per-thread. I guess we could "split" it and copy the
new base into a thread's cache when we give it work to do.

While thinking about this, an unrelated optimization occurred to me
(that I don't see us doing). Right now we put every base we resolve into
the cache. But if it only has one child delta, after we resolve that
delta, we can definitely remove the base (even if we're still resolving
deltas against that child). Or more generally, once we've resolved the
_final_ child that uses that base, we no longer need it. Here's an
illustration (where "<-" means "has delta child"):

  A <- B <- C
         <- D <- E <- F ...
	      <- G <- H ...

We'd visit each column in a depth-first way, looking for children of
each base we find. Once we've resolved C and D, we don't need to care
about the cache of B anymore. So freeing it puts more room in the cache
while processing E, F, etc.

And likewise, we can throw away D after finishing G. The strategy might
help more if we did a breadth-first traversal, but then you have the
opposite problem (instead of a deep tree busting your cache, a wide one
would).

Anyway, that's all pretty far off your original point. But it might be
worth thinking about it you have to touch this part of the code as part
of your threading work.

-Peff
