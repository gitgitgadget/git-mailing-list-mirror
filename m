Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C370C352A4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75197218AC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgBMCU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:20:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:42106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729333AbgBMCU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:20:59 -0500
Received: (qmail 9862 invoked by uid 109); 13 Feb 2020 02:19:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:19:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8722 invoked by uid 111); 13 Feb 2020 02:29:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:29:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:20:58 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/13] pack-bitmap: basic noop bitmap filter infrastructure
Message-ID: <20200213022058.GH1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently you can't use object filters with bitmaps, but we plan to
support at least some filters with bitmaps. Let's introduce some
infrastructure that will help us do that:

  - prepare_bitmap_walk() now accepts a list_objects_filter_options
    parameter (which can be NULL for no filtering; all the current
    callers pass this)

  - we'll bail early if the filter is incompatible with bitmaps (just as
    we would if there were no bitmaps at all). Currently all filters are
    incompatible.

  - we'll filter the resulting bitmap; since there are no supported
    filters yet, this is always a noop.

There should be no behavior change yet, but we'll support some actual
filters in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  4 ++--
 pack-bitmap.c          | 30 ++++++++++++++++++++++++++++--
 pack-bitmap.h          |  4 +++-
 reachable.c            |  2 +-
 5 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 393c20a2d7..60c943e42b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3040,7 +3040,7 @@ static int pack_options_allow_reuse(void)
 
 static int get_object_list_from_bitmap(struct rev_info *revs)
 {
-	if (!(bitmap_git = prepare_bitmap_walk(revs)))
+	if (!(bitmap_git = prepare_bitmap_walk(revs, NULL)))
 		return -1;
 
 	if (pack_options_allow_reuse() &&
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ce1cfc7da0..1ef180469f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -407,7 +407,7 @@ static int try_bitmap_count(struct rev_info *revs)
 	 */
 	max_count = revs->max_count;
 
-	bitmap_git = prepare_bitmap_walk(revs);
+	bitmap_git = prepare_bitmap_walk(revs, NULL);
 	if (!bitmap_git)
 		return -1;
 
@@ -441,7 +441,7 @@ static int try_bitmap_traversal(struct rev_info *revs)
 	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs);
+	bitmap_git = prepare_bitmap_walk(revs, NULL);
 	if (!bitmap_git)
 		return -1;
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6c06099dc7..eb8888bb5e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "repository.h"
 #include "object-store.h"
+#include "list-objects-filter-options.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -705,7 +706,25 @@ static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
 	return 0;
 }
 
-struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
+static int filter_bitmap(struct bitmap_index *bitmap_git,
+			 struct object_list *tip_objects,
+			 struct bitmap *to_filter,
+			 struct list_objects_filter_options *filter)
+{
+	if (!filter || filter->choice == LOFC_DISABLED)
+		return 0;
+
+	/* filter choice not handled */
+	return -1;
+}
+
+static int can_filter_bitmap(struct list_objects_filter_options *filter)
+{
+	return !filter_bitmap(NULL, NULL, NULL, filter);
+}
+
+struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
+					 struct list_objects_filter_options *filter)
 {
 	unsigned int i;
 
@@ -715,9 +734,14 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	struct bitmap *wants_bitmap = NULL;
 	struct bitmap *haves_bitmap = NULL;
 
-	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
+	struct bitmap_index *bitmap_git;
+
+	if (!can_filter_bitmap(filter))
+		return NULL;
+
 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
+	bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;
 
@@ -784,6 +808,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs)
 	if (haves_bitmap)
 		bitmap_and_not(wants_bitmap, haves_bitmap);
 
+	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
+
 	bitmap_git->result = wants_bitmap;
 	bitmap_git->haves = haves_bitmap;
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 466c5afa09..04bdb20c3c 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -8,6 +8,7 @@
 struct commit;
 struct repository;
 struct rev_info;
+struct list_objects_filter_options;
 
 static const char BITMAP_IDX_SIGNATURE[] = {'B', 'I', 'T', 'M'};
 
@@ -46,7 +47,8 @@ void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
 void traverse_bitmap_commit_list(struct bitmap_index *,
 				 show_reachable_fn show_reachable);
 void test_bitmap_walk(struct rev_info *revs);
-struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs);
+struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
+					 struct list_objects_filter_options *filter);
 int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
 				       struct packed_git **packfile,
 				       uint32_t *entries, off_t *up_to);
diff --git a/reachable.c b/reachable.c
index 8f50235b28..45cde57cab 100644
--- a/reachable.c
+++ b/reachable.c
@@ -223,7 +223,7 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 	cp.progress = progress;
 	cp.count = 0;
 
-	bitmap_git = prepare_bitmap_walk(revs);
+	bitmap_git = prepare_bitmap_walk(revs, NULL);
 	if (bitmap_git) {
 		traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
 		free_bitmap_index(bitmap_git);
-- 
2.25.0.785.g49bcbe7794

