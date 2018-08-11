Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1301A1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 20:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeHKWpt (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 18:45:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:51286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727316AbeHKWps (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 18:45:48 -0400
Received: (qmail 2391 invoked by uid 109); 11 Aug 2018 17:23:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 17:23:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28680 invoked by uid 111); 11 Aug 2018 17:23:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 13:23:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 13:23:50 -0400
Date:   Sat, 11 Aug 2018 13:23:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
Message-ID: <20180811172350.GA2689@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180811170248.GC27393@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 01:02:48PM -0400, Jeff King wrote:

>   - we could probably improve the speed of oidset. Two things I notice
>     about its implementation:
> 
>       - it has to malloc for each entry, which I suspect is the main
> 	bottleneck. We could probably pool-allocate blocks, and when
> 	entries get removed just leave the allocations in place until we
> 	clear(). Most callers tend to build up a set and then query it a
> 	lot, or possibly remove items from the set until it's empty. But
> 	my guess is that few or none want a long-lived set that they add
> 	and remove from randomly.
> 
>       - insertion lets you do check-and-insert as a single operation
> 	(something I failed to notice in [1]). But it's not implemented
> 	as efficiently as it could be, since the "contains" and "put"
> 	operations do separate lookups. This doesn't matter for a set
> 	that's queried a lot more, but for something like de-duping
> 	(like I was doing in [1]) most operations are check-and-insert.
> [...]
> [1] https://public-inbox.org/git/20180810232457.GG19875@sigill.intra.peff.net/
>     but note that it's buried pretty deep.

Some notes on this, based on the cat-file patch that I linked to.

Before any optimizations, my best-of-five timing for:

  git cat-file --batch-all-objects --unordered --buffer \
               --batch-check='%(objectname)' >/dev/null

in git.git was:

  real	0m0.434s
  user	0m0.414s
  sys	0m0.020s

That's enumerating every object in the repo but not doing much more than
de-duping the names and printing them.

Applying this patch:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 45992c9be9..04b5cda191 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -443,9 +443,8 @@ static int batch_unordered_object(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
 
-	if (oidset_contains(data->seen, oid))
+	if (oidset_insert(data->seen, oid))
 		return 0;
-	oidset_insert(data->seen, oid);
 
 	return batch_object_cb(oid, data);
 }

to use the single-call set-and-replace doesn't seem to help (any
improvement is within the run-to-run noise). So a single hash lookup per
object does not seem to be measurable. And thus teaching oidset_insert()
to do a single hash lookup for check-and-insert is unlikely to help us.

On top of that, I tried using a pool to store the set entries:

diff --git a/oidset.c b/oidset.c
index 454c54f933..504929f177 100644
--- a/oidset.c
+++ b/oidset.c
@@ -17,7 +17,10 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
 	else if (oidset_contains(set, oid))
 		return 1;
 
-	entry = xmalloc(sizeof(*entry));
+	if (!set->pool)
+		mem_pool_init(&set->pool, 0);
+
+	entry = mem_pool_alloc(set->pool, sizeof(*entry));
 	oidcpy(&entry->oid, oid);
 
 	oidmap_put(&set->map, entry);
@@ -29,12 +32,13 @@ int oidset_remove(struct oidset *set, const struct object_id *oid)
 	struct oidmap_entry *entry;
 
 	entry = oidmap_remove(&set->map, oid);
-	free(entry);
+	/* abandon pool memory for "entry" */
 
 	return (entry != NULL);
 }
 
 void oidset_clear(struct oidset *set)
 {
-	oidmap_free(&set->map, 1);
+	oidmap_free(&set->map, 0);
+	mem_pool_discard(set->pool, 0);
 }
diff --git a/oidset.h b/oidset.h
index 40ec5f87fe..6b8b802987 100644
--- a/oidset.h
+++ b/oidset.h
@@ -20,6 +20,7 @@
  */
 struct oidset {
 	struct oidmap map;
+	struct mem_pool *pool;
 };
 
 #define OIDSET_INIT { OIDMAP_INIT }

That drops my best-of-five to:

  real	0m0.300s
  user	0m0.288s
  sys	0m0.012s

which is over a 25% speedup. So that does seem worth pursuing.

For reference, the oid_array code path for cat-file is still:

  real	0m0.161s
  user	0m0.157s
  sys	0m0.004s

but that's not completely apples to apples. The oidset code is also
iterating the packfiles in a different order and generating a revidx
(which I know is about 25ms in this repo). So a better test would
actually swap one data structure out for the other with no other changes
(I just happened to have this test handy, and really wanted to know
whether the mem_pool stuff would help).

-Peff
