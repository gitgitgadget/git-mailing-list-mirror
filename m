Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF11C3B1B5
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18572168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393294AbgBNSWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:43702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390584AbgBNSWV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:21 -0500
Received: (qmail 22959 invoked by uid 109); 14 Feb 2020 18:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23657 invoked by uid 111); 14 Feb 2020 18:31:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:16 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:18 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/15] rev-list: factor out bitmap-optimized routines
Message-ID: <20200214182218.GE150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few operations in rev-list that are optimized for bitmaps.
Rather than having the code inline in cmd_rev_list(), let's move them
into helpers. This not only makes the flow of the main function simpler,
but it lets us replace the complex "can we do the optimization?"
conditionals with a series of early returns from the functions. That
also makes it easy to add comments explaining those conditions.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c | 88 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4cb5a52dee..38c5ca5603 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -364,6 +364,69 @@ static inline int parse_missing_action_value(const char *value)
 	return 0;
 }
 
+static int try_bitmap_count(struct rev_info *revs)
+{
+	uint32_t commit_count;
+	int max_count;
+	struct bitmap_index *bitmap_git;
+
+	/* This function only handles counting, not general traversal. */
+	if (!revs->count)
+		return -1;
+
+	/*
+	 * A bitmap result can't know left/right, etc, because we don't
+	 * actually traverse.
+	 */
+	if (revs->left_right || revs->cherry_mark)
+		return -1;
+
+	/*
+	 * This must be saved before doing any walking, since the revision
+	 * machinery will count it down to zero while traversing.
+	 */
+	max_count = revs->max_count;
+
+	bitmap_git = prepare_bitmap_walk(revs);
+	if (!bitmap_git)
+		return -1;
+
+	count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
+	if (max_count >= 0 && max_count < commit_count)
+		commit_count = max_count;
+
+	printf("%d\n", commit_count);
+	free_bitmap_index(bitmap_git);
+	return 0;
+}
+
+static int try_bitmap_traversal(struct rev_info *revs)
+{
+	struct bitmap_index *bitmap_git;
+
+	/*
+	 * We can't use a bitmap result with a traversal limit, since the set
+	 * of commits we'd get would be essentially random.
+	 */
+	if (revs->max_count >= 0)
+		return -1;
+
+	/*
+	 * Our bitmap result will return all objects, and we're not
+	 * yet prepared to show only particular types.
+	 */
+	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
+		return -1;
+
+	bitmap_git = prepare_bitmap_walk(revs);
+	if (!bitmap_git)
+		return -1;
+
+	traverse_bitmap_commit_list(bitmap_git, &show_object_fast);
+	free_bitmap_index(bitmap_git);
+	return 0;
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -534,27 +597,10 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		progress = start_delayed_progress(show_progress, 0);
 
 	if (use_bitmap_index) {
-		if (revs.count && !revs.left_right && !revs.cherry_mark) {
-			uint32_t commit_count;
-			int max_count = revs.max_count;
-			struct bitmap_index *bitmap_git;
-			if ((bitmap_git = prepare_bitmap_walk(&revs))) {
-				count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
-				if (max_count >= 0 && max_count < commit_count)
-					commit_count = max_count;
-				printf("%d\n", commit_count);
-				free_bitmap_index(bitmap_git);
-				return 0;
-			}
-		} else if (revs.max_count < 0 &&
-			   revs.tag_objects && revs.tree_objects && revs.blob_objects) {
-			struct bitmap_index *bitmap_git;
-			if ((bitmap_git = prepare_bitmap_walk(&revs))) {
-				traverse_bitmap_commit_list(bitmap_git, &show_object_fast);
-				free_bitmap_index(bitmap_git);
-				return 0;
-			}
-		}
+		if (!try_bitmap_count(&revs))
+			return 0;
+		if (!try_bitmap_traversal(&revs))
+			return 0;
 	}
 
 	if (prepare_revision_walk(&revs))
-- 
2.25.0.796.gcc29325708

