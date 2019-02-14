Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CEE71F453
	for <e@80x24.org>; Thu, 14 Feb 2019 04:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbfBNEhp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 23:37:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:43622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727763AbfBNEhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 23:37:45 -0500
Received: (qmail 30267 invoked by uid 109); 14 Feb 2019 04:37:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 04:37:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6340 invoked by uid 111); 14 Feb 2019 04:37:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 23:37:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 23:37:43 -0500
Date:   Wed, 13 Feb 2019 23:37:43 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] prune: use bitmaps for reachability traversal
Message-ID: <20190214043743.GB19183@sigill.intra.peff.net>
References: <20190214043127.GA19019@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214043127.GA19019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pruning generally has to traverse the whole commit graph in order to
see which objects are reachable. This is the exact problem that
reachability bitmaps were meant to solve, so let's use them (if they're
available, of course).

Here are timings on git.git:

  Test                            HEAD^             HEAD
  ------------------------------------------------------------------------
  5304.6: prune with bitmaps      3.65(3.56+0.09)   1.01(0.92+0.08) -72.3%

And on linux.git:

  Test                            HEAD^               HEAD
  --------------------------------------------------------------------------
  5304.6: prune with bitmaps      35.05(34.79+0.23)   3.00(2.78+0.21) -91.4%

The tests show a pretty optimal case, as we'll have just repacked and
should have pretty good coverage of all refs with our bitmaps. But
that's actually pretty realistic: normally prune is run via "gc" right
after repacking.

A few notes on the implementation:

  - the change is actually in reachable.c, so it would improve
    reachability traversals by "reflog expire --stale-fix", as well.
    Those aren't performed regularly, though (a normal "git gc" doesn't
    use --stale-fix), so they're not really worth measuring. There's a
    low chance of regressing that caller, since the use of bitmaps is
    totally transparent from the caller's perspective.

  - The bitmap case could actually get away without creating a "struct
    object", and instead the caller could just look up each object id in
    the bitmap result. However, this would be a marginal improvement in
    runtime, and it would make the callers much more complicated. They'd
    have to handle both the bitmap and non-bitmap cases separately, and
    in the case of git-prune, we'd also have to tweak prune_shallow(),
    which relies on our SEEN flags.

  - Because we do create real object structs, we go through a few
    contortions to create ones of the right type. This isn't strictly
    necessary (lookup_unknown_object() would suffice), but it's more
    memory efficient to use the correct types, since we already know
    them.

Signed-off-by: Jeff King <peff@peff.net>
---
 reachable.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
 t/perf/p5304-prune.sh | 11 +++++++++++
 2 files changed, 53 insertions(+)

diff --git a/reachable.c b/reachable.c
index 6e9b810d2a..0d00a91de4 100644
--- a/reachable.c
+++ b/reachable.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "object-store.h"
+#include "pack-bitmap.h"
 
 struct connectivity_progress {
 	struct progress *progress;
@@ -158,10 +159,44 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 				      FOR_EACH_OBJECT_LOCAL_ONLY);
 }
 
+static void *lookup_object_by_type(struct repository *r,
+				   const struct object_id *oid,
+				   enum object_type type)
+{
+	switch (type) {
+	case OBJ_COMMIT:
+		return lookup_commit(r, oid);
+	case OBJ_TREE:
+		return lookup_tree(r, oid);
+	case OBJ_TAG:
+		return lookup_tag(r, oid);
+	case OBJ_BLOB:
+		return lookup_blob(r, oid);
+	default:
+		die("BUG: unknown object type %d", type);
+	}
+}
+
+static int mark_object_seen(const struct object_id *oid,
+			     enum object_type type,
+			     int exclude,
+			     uint32_t name_hash,
+			     struct packed_git *found_pack,
+			     off_t found_offset)
+{
+	struct object *obj = lookup_object_by_type(the_repository, oid, type);
+	if (!obj)
+		die("unable to create object '%s'", oid_to_hex(oid));
+
+	obj->flags |= SEEN;
+	return 0;
+}
+
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 			    timestamp_t mark_recent, struct progress *progress)
 {
 	struct connectivity_progress cp;
+	struct bitmap_index *bitmap_git;
 
 	/*
 	 * Set up revision parsing, and mark us as being interested
@@ -188,6 +223,13 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	cp.progress = progress;
 	cp.count = 0;
 
+	bitmap_git = prepare_bitmap_walk(revs);
+	if (bitmap_git) {
+		traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
+		free_bitmap_index(bitmap_git);
+		return;
+	}
+
 	/*
 	 * Set up the revision walk - this will move all commits
 	 * from the pending list to the commit walking list.
diff --git a/t/perf/p5304-prune.sh b/t/perf/p5304-prune.sh
index 3c852084eb..83baedb8a4 100755
--- a/t/perf/p5304-prune.sh
+++ b/t/perf/p5304-prune.sh
@@ -21,4 +21,15 @@ test_perf 'prune with no objects' '
 	git prune
 '
 
+test_expect_success 'repack with bitmaps' '
+	git repack -adb
+'
+
+# We have to create the object in each trial run, since otherwise
+# runs after the first see no object and just skip the traversal entirely!
+test_perf 'prune with bitmaps' '
+	echo "probably not present in repo" | git hash-object -w --stdin &&
+	git prune
+'
+
 test_done
-- 
2.21.0.rc0.586.gffba1126a0

