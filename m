Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841671FAFB
	for <e@80x24.org>; Fri,  7 Apr 2017 05:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbdDGFTn (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 01:19:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:57895 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbdDGFTl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 01:19:41 -0400
Received: (qmail 24650 invoked by uid 109); 7 Apr 2017 05:19:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 05:19:38 +0000
Received: (qmail 32024 invoked by uid 111); 7 Apr 2017 05:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Apr 2017 01:19:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Apr 2017 01:19:35 -0400
Date:   Fri, 7 Apr 2017 01:19:35 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] unpack-trees: avoid duplicate ODB lookups during
 checkout
Message-ID: <20170407051935.4usaxtmco7lqm4ew@sigill.intra.peff.net>
References: <20170406203732.47714-1-git@jeffhostetler.com>
 <20170406203732.47714-2-git@jeffhostetler.com>
 <CAGZ79kafbRQo2Of0H162ue5YzL7uA2PDu=sTy0=cEOejGTJhyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kafbRQo2Of0H162ue5YzL7uA2PDu=sTy0=cEOejGTJhyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2017 at 03:48:07PM -0700, Stefan Beller wrote:

> On Thu, Apr 6, 2017 at 1:37 PM,  <git@jeffhostetler.com> wrote:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Teach traverse_trees_recursive() to not do redundant ODB
> > lookups when both directories refer to the same OID.
> 
> And the reason for this is that omitting the second lookup
> saves time, i.e. a lookup in the ODB of a sufficiently large
> repo is slow.
> 
> My kneejerk line of thinking:
> * yes, it sounds good to reduce the number of ODB accesses.
> * But if we consider ODB lookups to be slow and we perform
>   a structured access, how about a cache in front of the ODB?
> * We already have that! (sort of..) 9a414486d9 (lookup_object:
>   prioritize recently found objects, 2013-05-01)
> * Instead of improving the caching, maybe change the
>   size of the problem: We could keep the objects of different types
>   in different hash-tables.

I don't think this is using lookup_object() at all, though. It goes
straight to fill_tree_descriptor(), which will read the object contents
from disk. So our time is going to:

  1. Finding the object in the odb (ideally a binary search in a single
     pack index, but less optimal when there are many packs).

  2. Reconstructing the object. This means zlib-inflating from disk, but
     it may also mean delta reconstruction.

I think there _are_ some caches at play here, though, when you look up
the same tree back to back. The pack-mru means that we'll always look in
the correct pack first. And in theory the delta base cache means that
we'll already have the whole thing reconstructed in memory (though I
have often been confused by exactly when we put items into that cache,
so I might be wrong).

So in theory, this is not all that different than the "just allocate and
copy the bytes" optimization that's happening here (though I'm not
surprised that doing it at a higher level can produce some speedup).

I think the more interesting optimization is "just use the same buffer
without bothering to copy", which is hard for the low-level code to do
(since it doesn't know what lifetime the caller is expecting). 

> object.c has its own hash table, I presume for historical and
> performance reasons, this would be split up to multiple hash
> tables.

So I don't think lookup_object() is really relevant here. But I'm also
not sure that multiple hash tables would really buy us much. In theory
hash tables are O(1), so multiple smaller tables doesn't help (and might
hurt, since now we have four O(1) lookups to do). Of course that's a
minor fiction because of collisions, but we keep the load factor on the
object.c table pretty low (and that's why things like quadratic probing
and cuckoo hashing never showed great improvement).

-Peff
