Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920BC1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 13:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbeDCNGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 09:06:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:51752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932168AbeDCNGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 09:06:17 -0400
Received: (qmail 30472 invoked by uid 109); 3 Apr 2018 13:06:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 13:06:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25155 invoked by uid 111); 3 Apr 2018 13:07:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 09:07:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 09:06:15 -0400
Date:   Tue, 3 Apr 2018 09:06:15 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH 0/3] Lazy-load trees when reading commit-graph
Message-ID: <20180403130615.GA18824@sigill.intra.peff.net>
References: <20180403120057.173849-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403120057.173849-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 08:00:54AM -0400, Derrick Stolee wrote:

> There are several commit-graph walks that require loading many commits
> but never walk the trees reachable from those commits. However, the
> current logic in parse_commit() requires the root tree to be loaded.
> This only uses lookup_tree(), but when reading commits from the commit-
> graph file, the hashcpy() to load the root tree hash and the time spent
> checking the object cache take more time than parsing the rest of the
> commit.
> 
> In this patch series, all direct references to accessing the 'tree'
> member of struct commit are replaced instead by one of the following
> methods:
> 
> 	struct tree *get_commit_tree(struct commit *)
> 	struct object_id *get_commit_tree_oid(struct commit *)

This seems like a pretty sane thing to do. There may still be a few
parts of the code, notably fsck, that are reliant on a "struct object"
having been instantiated to determine whether an object is "used".  I
tried to clean that up around the time of c2d17b3b6e (fsck: check
HAS_OBJ more consistently, 2017-01-16), but I won't be surprised if
there's still some hidden assumptions.

I peeked at the fsck.c parts of patch 2, and it looks like we may be OK,
since you use get_commit_tree() during the walk.

> This replacement was assisted by a Coccinelle script, but the 'tree'
> member is overloaded in other types, so the script gave false-positives
> that were removed from the diff.

That catches any existing in-tree callers, but not any topics in flight.
We could add the Coccinelle script and re-run it to catch any future
ones. But perhaps simpler still: can we rename the "tree" member to
"maybe_tree" or something, since nobody should be accessing it directly?
That will give us a compile error if an older topic is merged.

> On the Linux repository, performance tests were run for the following
> command:
> 
>     git log --graph --oneline -1000
> 
> Before: 0.83s
> After:  0.65s
> Rel %: -21.6%

Neat.

Not strictly related, but I happened across another thing today that
might be worth investigating here. We allocate "struct commit" in these
nice big allocation blocks. But then for every commit we allocate at
least one "struct commit_list" to store the parent pointer.

I was looking at this from a memory consumption angle (I found a
pathological repository full of single-parent commits, and this wastes
an extra 16 bytes plus malloc overhead for every 64-byte "struct
commit").

But I wonder if it could also have non-negligible overhead in calling
malloc() for your case, since you've optimized out so much of the rest
of the work.

I'm not sure what the exact solution would be, but I imagine something
like variable-sized "struct commit"s with the parent pointers embedded,
with some kind of flag to indicate the number of parents (and probably
some fallback to break out to a linked list for extreme cases of more
than 2 parents).  It may end up pretty invasive, though, as there's a
lot of open-coded traversals of that parent list.

Anyway, not anything to do with this patch, but food for thought as you
micro-optimize these traversals.

-Peff
