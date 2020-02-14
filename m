Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8CCC3B1BA
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDAE2168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394912AbgBNSWb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:43716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394916AbgBNSW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:29 -0500
Received: (qmail 22981 invoked by uid 109); 14 Feb 2020 18:22:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23673 invoked by uid 111); 14 Feb 2020 18:31:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/15] rev-list: allow commit-only bitmap traversals
Message-ID: <20200214182227.GI150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since we added reachability bitmap support, we've been able to use
it with rev-list to get the full list of objects, like:

  git rev-list --objects --use-bitmap-index --all

But you can't do so without --objects, since we weren't ready to just
show the commits. However, the internals of the bitmap code are mostly
ready for this: they avoid opening up trees when walking to fill in the
bitmaps. We just need to actually pass in the rev_info to
traverse_bitmap_commit_list() so it knows which types to bother
triggering our callback for.

For completeness, the perf test now covers both the existing --objects
case, as well as the new commits-only behavior (the objects one got way
faster when we introduced bitmaps, but obviously isn't improved now).

Here are numbers for linux.git:

  Test                         HEAD^               HEAD
  ------------------------------------------------------------------------
  5310.7: rev-list (commits)   8.29(8.10+0.19)       1.76(1.72+0.04) -78.8%
  5310.8: rev-list (objects)   8.06(7.94+0.12)       8.14(7.94+0.13) +1.0%

That run was cheating a little, as I didn't have any commit-graph in the
repository, and we'd built it by default these days when running git-gc.
Here are numbers with a commit-graph:

  Test                         HEAD^               HEAD
  ------------------------------------------------------------------------
  5310.7: rev-list (commits)   0.70(0.58+0.12)     0.51(0.46+0.04) -27.1%
  5310.8: rev-list (objects)   6.20(6.09+0.10)     6.27(6.16+0.11) +1.1%

Still an improvement, but a lot less impressive.

We could have the perf script remove any commit-graph to show the
out-sized effect, but it probably makes sense to leave it in what would
be a more typical setup.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c       |  3 ++-
 builtin/rev-list.c           |  9 +--------
 pack-bitmap.c                | 20 +++++++++++++++-----
 pack-bitmap.h                |  1 +
 reachable.c                  |  2 +-
 t/perf/p5310-pack-bitmaps.sh |  8 ++++++++
 t/t5310-pack-bitmaps.sh      |  6 ++++++
 7 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 393c20a2d7..06915ebe7f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3054,7 +3054,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
 		display_progress(progress_state, nr_result);
 	}
 
-	traverse_bitmap_commit_list(bitmap_git, &add_object_entry_from_bitmap);
+	traverse_bitmap_commit_list(bitmap_git, revs,
+				    &add_object_entry_from_bitmap);
 	return 0;
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 70f3207ecc..937324cef0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -434,18 +434,11 @@ static int try_bitmap_traversal(struct rev_info *revs)
 	if (revs->max_count >= 0)
 		return -1;
 
-	/*
-	 * Our bitmap result will return all objects, and we're not
-	 * yet prepared to show only particular types.
-	 */
-	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
-		return -1;
-
 	bitmap_git = prepare_bitmap_walk(revs);
 	if (!bitmap_git)
 		return -1;
 
-	traverse_bitmap_commit_list(bitmap_git, &show_object_fast);
+	traverse_bitmap_commit_list(bitmap_git, revs, &show_object_fast);
 	free_bitmap_index(bitmap_git);
 	return 0;
 }
diff --git a/pack-bitmap.c b/pack-bitmap.c
index a97b717e55..2fbc748b19 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -599,6 +599,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 }
 
 static void show_extended_objects(struct bitmap_index *bitmap_git,
+				  struct rev_info *revs,
 				  show_reachable_fn show_reach)
 {
 	struct bitmap *objects = bitmap_git->result;
@@ -612,6 +613,11 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 			continue;
 
 		obj = eindex->objects[i];
+		if ((obj->type == OBJ_BLOB && !revs->blob_objects) ||
+		    (obj->type == OBJ_TREE && !revs->tree_objects) ||
+		    (obj->type == OBJ_TAG && !revs->tag_objects))
+			continue;
+
 		show_reach(&obj->oid, obj->type, 0, eindex->hashes[i], NULL, 0);
 	}
 }
@@ -872,16 +878,20 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 }
 
 void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
+				 struct rev_info *revs,
 				 show_reachable_fn show_reachable)
 {
 	assert(bitmap_git->result);
 
 	show_objects_for_type(bitmap_git, OBJ_COMMIT, show_reachable);
-	show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
-	show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
-	show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
-
-	show_extended_objects(bitmap_git, show_reachable);
+	if (revs->tree_objects)
+		show_objects_for_type(bitmap_git, OBJ_TREE, show_reachable);
+	if (revs->blob_objects)
+		show_objects_for_type(bitmap_git, OBJ_BLOB, show_reachable);
+	if (revs->tag_objects)
+		show_objects_for_type(bitmap_git, OBJ_TAG, show_reachable);
+
+	show_extended_objects(bitmap_git, revs, show_reachable);
 }
 
 static uint32_t count_object_type(struct bitmap_index *bitmap_git,
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 466c5afa09..b0c06a212e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -44,6 +44,7 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r);
 void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
 			      uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(struct bitmap_index *,
+				 struct rev_info *revs,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
 struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs);
diff --git a/reachable.c b/reachable.c
index 8f50235b28..0919f025c4 100644
--- a/reachable.c
+++ b/reachable.c
@@ -225,7 +225,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 
 	bitmap_git = prepare_bitmap_walk(revs);
 	if (bitmap_git) {
-		traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
+		traverse_bitmap_commit_list(bitmap_git, revs, mark_object_seen);
 		free_bitmap_index(bitmap_git);
 		return;
 	}
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 6a3a42531b..e52f66ec9e 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -39,6 +39,14 @@ test_perf 'pack to file (bitmap)' '
 	git pack-objects --use-bitmap-index --all pack1b </dev/null >/dev/null
 '
 
+test_perf 'rev-list (commits)' '
+	git rev-list --all --use-bitmap-index >/dev/null
+'
+
+test_perf 'rev-list (objects)' '
+	git rev-list --all --use-bitmap-index --objects >/dev/null
+'
+
 test_expect_success 'create partial bitmap state' '
 	# pick a commit to represent the repo tip in the past
 	cutoff=$(git rev-list HEAD~100 -1) &&
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index b8645ae070..2c64d0c441 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -80,6 +80,12 @@ rev_list_tests() {
 		test_cmp expect actual
 	'
 
+	test_expect_success "enumerate commits ($state)" '
+		git rev-list --use-bitmap-index HEAD >actual &&
+		git rev-list HEAD >expect &&
+		test_bitmap_traversal --no-confirm-bitmaps expect actual
+	'
+
 	test_expect_success "enumerate --objects ($state)" '
 		git rev-list --objects --use-bitmap-index HEAD >actual &&
 		git rev-list --objects HEAD >expect &&
-- 
2.25.0.796.gcc29325708

