Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0534A1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 11:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfKKLMv (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 06:12:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:44420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726768AbfKKLMv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 06:12:51 -0500
Received: (qmail 19400 invoked by uid 109); 11 Nov 2019 11:12:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 11:12:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5496 invoked by uid 111); 11 Nov 2019 11:16:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 06:16:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 06:12:49 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] pack-objects: avoid pointless oe_map_new_pack() calls
Message-ID: <20191111111249.GA31169@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes an extreme slowdown in pack-objects when you have more
than 1023 packs. See below for numbers.

Since 43fa44fa3b (pack-objects: move in_pack out of struct object_entry,
2018-04-14), we use a complicated system to save some per-object memory.

Each object_entry structs gets a 10-bit field to store the index of the
pack it's in. We map those indices into pointers using
packing_data->in_pack_by_idx, which we initialize at the start of the
program. If we have 2^10 or more packs, then we instead create an array
of pack pointers, one per object. This is packing_data->in_pack.

So far so good. But there's one other tricky case: if a new pack arrives
after we've initialized in_pack_by_idx, it won't have an index yet. We
solve that by calling oe_map_new_pack(), which just switches on the fly
to the less-optimal in_pack mechanism, allocating the array and
back-filling it for already-seen objects.

But that logic kicks in even when we've switched to it already (whether
because we really did see a new pack, or because we had too many packs
in the first place). The result doesn't produce a wrong outcome, but
it's very slow. What happens is this:

  - imagine you have a repo with 500k objects and 2000 packs that you
    want to repack.

  - before looking at any objects, we call prepare_in_pack_by_idx(). It
    starts allocating an index for each pack. On the 1024th pack, it
    sees there are too many, so it bails, leaving in_pack_by_idx as
    NULL.

  - while actually adding objects to the packing list, we call
    oe_set_in_pack(), which checks whether the pack already has an
    index. If it's one of the packs after the first 1023, then it
    doesn't have one, and we'll call oe_map_new_pack().

    But there's no useful work for that function to do. We're already
    using in_pack, so it just uselessly walks over the complete list of
    objects, trying to backfill in_pack.

    And we end up doing this for almost 1000 packs (each of which may be
    triggered by more than one object). And each time it triggers, we
    may iterate over up to 500k objects. So in the absolute worst case,
    this is quadratic in the number of objects.

The solution is simple: we don't need to bother checking whether the
pack has an index if we've already converted to using in_pack, since by
definition we're not going to use it. So we can just push the "does the
pack have a valid index" check down into that half of the conditional,
where we know we're going to use it.

The current test in p5303 sadly doesn't notice this problem, since it
maxes out at 1000 packs. If we add a new test to it at 2000 packs, it
does show the improvement:

  Test                      HEAD^               HEAD
  ----------------------------------------------------------------------
  5303.12: repack (2000)    26.72(39.68+0.67)   15.70(28.70+0.66) -41.2%

However, these many-pack test cases are rather expensive to run, so
adding larger and larger numbers isn't appealing. Instead, we can show
it off more easily by using GIT_TEST_FULL_IN_PACK_ARRAY, which forces us
into the absolute worst case: no pack has an index, so we'll trigger
oe_map_new_pack() pointlessly for every single object, making it truly
quadratic.

Here are the numbers (on git.git) with the included change to p5303:

  Test                      HEAD^               HEAD
  ----------------------------------------------------------------------
  5303.3: rev-list (1)      2.05(1.98+0.06)     2.06(1.99+0.06) +0.5%
  5303.4: repack (1)        33.45(33.46+0.19)   2.75(2.73+0.22) -91.8%
  5303.6: rev-list (50)     2.07(2.01+0.06)     2.06(2.01+0.05) -0.5%
  5303.7: repack (50)       34.21(35.18+0.16)   3.49(4.50+0.12) -89.8%
  5303.9: rev-list (1000)   2.87(2.78+0.08)     2.88(2.80+0.07) +0.3%
  5303.10: repack (1000)    41.26(51.30+0.47)   10.75(20.75+0.44) -73.9%

Again, those improvements aren't realistic for the 1-pack case (because
in the real world, the full-array solution doesn't kick in), but it's
more useful to be testing the more-complicated code path.

While we're looking at this issue, we'll tweak one more thing: in
oe_map_new_pack(), we call REALLOC_ARRAY(pack->in_pack). But we'd never
expect to get here unless we're back-filling it for the first time, in
which case it would be NULL. So let's switch that to ALLOC_ARRAY() for
clarity, and add a BUG() to document the expectation. Unfortunately this
code isn't well-covered in the test suite because it's inherently racy
(it only kicks in if somebody else adds a new pack while we're in the
middle of repacking).

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-objects.c             |  5 ++++-
 pack-objects.h             | 19 ++++++++++++++-----
 t/perf/p5303-many-packs.sh |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index c6250d77f4..5e5a3c62d9 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -119,7 +119,10 @@ void oe_map_new_pack(struct packing_data *pack)
 {
 	uint32_t i;
 
-	REALLOC_ARRAY(pack->in_pack, pack->nr_alloc);
+	if (pack->in_pack)
+		BUG("packing_data has already been converted to pack array");
+
+	ALLOC_ARRAY(pack->in_pack, pack->nr_alloc);
 
 	for (i = 0; i < pack->nr_objects; i++)
 		pack->in_pack[i] = oe_in_pack(pack, pack->objects + i);
diff --git a/pack-objects.h b/pack-objects.h
index 6fe6ae5ee8..d3975e079b 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -251,12 +251,21 @@ static inline void oe_set_in_pack(struct packing_data *pack,
 				  struct object_entry *e,
 				  struct packed_git *p)
 {
-	if (!p->index)
+	if (pack->in_pack_by_idx) {
+		if (p->index) {
+			e->in_pack_idx = p->index;
+			return;
+		}
+		/*
+		 * We're accessing packs by index, but this pack doesn't have
+		 * an index (e.g., because it was added since we created the
+		 * in_pack_by_idx array). Bail to oe_map_new_pack(), which
+		 * will convert us to using the full in_pack array, and then
+		 * fall through to our in_pack handling.
+		 */
 		oe_map_new_pack(pack);
-	if (pack->in_pack_by_idx)
-		e->in_pack_idx = p->index;
-	else
-		pack->in_pack[e - pack->objects] = p;
+	}
+	pack->in_pack[e - pack->objects] = p;
 }
 
 static inline struct object_entry *oe_delta(
diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index 3779851941..a369152c47 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -77,6 +77,7 @@ do
 	# actual pack generation, without smudging the on-disk setup
 	# between trials.
 	test_perf "repack ($nr_packs)" '
+		GIT_TEST_FULL_IN_PACK_ARRAY=1 \
 		git pack-objects --keep-true-parents \
 		  --honor-pack-keep --non-empty --all \
 		  --reflog --indexed-objects --delta-base-offset \
-- 
2.24.0.739.gb5632e4929
