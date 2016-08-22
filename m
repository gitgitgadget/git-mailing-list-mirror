Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2D51F859
	for <e@80x24.org>; Mon, 22 Aug 2016 22:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756499AbcHVWAG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 18:00:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756483AbcHVWAE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 18:00:04 -0400
Received: (qmail 29647 invoked by uid 109); 22 Aug 2016 21:59:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 21:59:59 +0000
Received: (qmail 17580 invoked by uid 111); 22 Aug 2016 22:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Aug 2016 18:00:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Aug 2016 17:59:56 -0400
Date:   Mon, 22 Aug 2016 17:59:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/7] delta_base_cache: drop special treatment of blobs
Message-ID: <20160822215956.kuqnucvfodxjrawn@sigill.intra.peff.net>
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the delta base cache runs out of allowed memory, it has
to drop entries. It does so by walking an LRU list, dropping
objects until we are under the memory limit. But we actually
walk the list twice: once to drop blobs, and then again to
drop other objects (which are generally trees). This comes
from 18bdec1 (Limit the size of the new delta_base_cache,
2007-03-19).

This performs poorly as the number of entries grows, because
any time dropping blobs does not satisfy the limit, we have
to walk the _entire_ list, trees included, looking for blobs
to drop, before starting to drop any trees.

It's not generally a problem now, as the cache is limited to
only 256 entries. But as we could benefit from increasing
that in a future patch, it's worth looking at how it
performs as the cache size grows. And the answer is "not
well".

The table below shows times for various operations with
different values of MAX_DELTA_CACHE (which is not a run-time
knob; I recompiled with -DMAX_DELTA_CACHE=$n for each).

I chose "git log --raw" ("log-raw" in the table) because it
will access all of the trees, but no blobs at all (so in a
sense it is a worst case for this problem, because we will
always walk over the entire list of trees once before
realizing there are no blobs to drop). This is also
representative of other tree-only operations like "rev-list
--objects" and "git log -- <path>".

I also timed "git log -Sfoo --raw" ("log-S" in the table).
It similarly accesses all of the trees, but also the blobs
for each commit. It's representative of "git log -p", though
it emphasizes the cost of blob access more, as "-S" is
cheaper than computing an actual blob diff.

All timings are best-of-3 wall-clock times (though they all
were CPU bound, so the user CPU times are similar). The
repositories were fully packed with --depth=50, and the
default core.deltaBaseCacheLimit of 96M was in effect.  The
current value of MAX_DELTA_CACHE is 256, so I started there
and worked up by factors of 2.

First, here are values for git.git (the asterisk signals the
fastest run for each operation):

    MAX_DELTA_CACHE    log-raw       log-S
    ---------------   ---------    ---------
                256   0m02.212s    0m12.634s
                512   0m02.136s*   0m10.614s
               1024   0m02.156s    0m08.614s
               2048   0m02.208s    0m07.062s
               4096   0m02.190s    0m06.484s*
               8192   0m02.176s    0m07.635s
              16384   0m02.913s    0m19.845s
              32768   0m03.617s    1m05.507s
              65536   0m04.031s    1m18.488s

You can see that for the tree-only log-raw case, we don't
actually benefit that much as the cache grows (all the
differences up through 8192 are basically just noise; this
is probably because we don't actually have that many
distinct trees in git.git). But for log-S, we get a definite
speed improvement as the cache grows, but the improvements
are lost as cache size grows and the linear LRU management
starts to dominate.

Here's the same thing run against linux.git:

    MAX_DELTA_CACHE    log-raw       log-S
    ---------------   ---------    ----------
                256   0m40.987s     5m13.216s
                512   0m37.949s     5m03.243s
               1024   0m35.977s     4m50.580s
               2048   0m33.855s     4m39.818s
               4096   0m32.913s     4m47.299s*
               8192   0m32.176s*    5m14.650s
              16384   0m32.185s     6m31.625s
              32768   0m38.056s     9m31.136s
              65536   1m30.518s    17m38.549s

The pattern is similar, though the effect in log-raw is more
pronounced here. The times dip down in the middle, and then
go back up as we keep growing.

So we know there's a problem. What's the solution?

The obvious one is to improve the data structure to avoid
walking over tree entries during the looking-for-blobs
traversal. We can do this by keeping _two_ LRU lists: one
for blobs, and one for other objects. We drop items from the
blob LRU first, and then from the tree LRU (if necessary).

Here's git.git using that strategy:

    MAX_DELTA_CACHE    log-raw      log-S
    ---------------   ---------   ----------
                256   0m02.264s   0m12.830s
                512   0m02.201s   0m10.771s
               1024   0m02.181s   0m08.593s
               2048   0m02.205s   0m07.116s
               4096   0m02.158s   0m06.537s*
               8192   0m02.213s   0m07.246s
              16384   0m02.155s*  0m10.975s
              32768   0m02.159s   0m16.047s
              65536   0m02.181s   0m16.992s

The upswing on log-raw is gone completely. But log-S still
has it (albeit much better than without this strategy).
Let's see what linux.git shows:

    MAX_DELTA_CACHE    log-raw       log-S
    ---------------   ---------    ---------
                256   0m42.519s    5m14.654s
                512   0m39.106s    5m04.708s
               1024   0m36.802s    4m51.454s
               2048   0m34.685s    4m39.378s*
               4096   0m33.663s    4m44.047s
               8192   0m33.157s    4m50.644s
              16384   0m33.090s*   4m49.648s
              32768   0m33.458s    4m53.371s
              65536   0m33.563s    5m04.580s

The results are similar. The tree-only case again performs
well (not surprising; we're literally just dropping the one
useless walk, and not otherwise changing the cache eviction
strategy at all). But the log-S case again does a bit worse
as the cache grows (though possibly that's within the noise,
which is much larger for this case).

Perhaps this is an indication that the "remove blobs first"
strategy is not actually optimal. The intent of it is to
avoid blowing out the tree cache when we see large blobs,
but it also means we'll throw away useful, recent blobs in
favor of older trees.

Let's run the same numbers without caring about object type
at all (i.e., one LRU list, and always evicting whatever is
at the head, regardless of type).

Here's git.git:

    MAX_DELTA_CACHE    log-raw      log-S
    ---------------   ---------   ---------
                256   0m02.227s   0m12.821s
                512   0m02.143s   0m10.602s
               1024   0m02.127s   0m08.642s
               2048   0m02.148s   0m07.123s
               4096   0m02.194s   0m06.448s*
               8192   0m02.239s   0m06.504s
              16384   0m02.144s*  0m06.502s
              32768   0m02.202s   0m06.622s
              65536   0m02.230s   0m06.677s

Much smoother; there's no dramatic upswing as we increase
the cache size (some remains, though it's small enough that
it's mostly run-to-run noise. E.g., in the log-raw case,
note how 8192 is 50-100ms higher than its neighbors). Note
also that we stop getting any real benefit for log-S after
about 4096 entries; that number will depend on the size of
the repository, the size of the blob entries, and the memory
limit of the cache.

Let's see what linux.git shows for the same strategy:

    MAX_DELTA_CACHE    log-raw      log-S
    ---------------   ---------   ---------
                256   0m41.661s   5m12.410s
                512   0m39.547s   5m07.920s
               1024   0m37.054s   4m54.666s
               2048   0m35.871s   4m41.194s*
               4096   0m34.646s   4m51.648s
               8192   0m33.881s   4m55.342s
              16384   0m35.190s   5m00.122s
              32768   0m35.060s   4m58.851s
              65536   0m33.311s*  4m51.420s

It's similarly good. As with the "separate blob LRU"
strategy, there's a lot of noise on the log-S run here. But
it's certainly not any worse, is possibly a bit better, and
the improvement over "separate blob LRU" on the git.git case
is dramatic.

So it seems like a clear winner, and that's what this patch
implements.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index c02e785..33564d6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2175,14 +2175,6 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 			list_entry(lru, struct delta_base_cache_entry, lru);
 		if (delta_base_cached <= delta_base_cache_limit)
 			break;
-		if (f->type == OBJ_BLOB)
-			release_delta_base_cache(f);
-	}
-	list_for_each(lru, &delta_base_cache_lru) {
-		struct delta_base_cache_entry *f =
-			list_entry(lru, struct delta_base_cache_entry, lru);
-		if (delta_base_cached <= delta_base_cache_limit)
-			break;
 		release_delta_base_cache(f);
 	}
 
-- 
2.10.0.rc1.118.ge2299eb

