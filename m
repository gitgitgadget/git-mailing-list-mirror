Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0FC352A4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3703206D7
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 02:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgBMCV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:21:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:42112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729440AbgBMCV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 21:21:26 -0500
Received: (qmail 9868 invoked by uid 109); 13 Feb 2020 02:20:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Feb 2020 02:20:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8738 invoked by uid 111); 13 Feb 2020 02:30:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Feb 2020 21:30:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Feb 2020 21:21:25 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/13] rev-list: use bitmap filters for traversal
Message-ID: <20200213022125.GI1126038@coredump.intra.peff.net>
References: <20200213021506.GA1124607@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213021506.GA1124607@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just passes the filter-options struct to prepare_bitmap_walk().
Since the bitmap code doesn't actually support any filters yet, it will
fallback to the non-bitmap code if any --filter is specified. But this
lets us exercise that rejection code path, as well as getting us ready
to test filters via rev-list when we _do_ support them.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 1ef180469f..c6850e318b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -372,7 +372,8 @@ static inline int parse_missing_action_value(const char *value)
 	return 0;
 }
 
-static int try_bitmap_count(struct rev_info *revs)
+static int try_bitmap_count(struct rev_info *revs,
+			    struct list_objects_filter_options *filter)
 {
 	uint32_t commit_count = 0,
 		 tag_count = 0,
@@ -407,7 +408,7 @@ static int try_bitmap_count(struct rev_info *revs)
 	 */
 	max_count = revs->max_count;
 
-	bitmap_git = prepare_bitmap_walk(revs, NULL);
+	bitmap_git = prepare_bitmap_walk(revs, filter);
 	if (!bitmap_git)
 		return -1;
 
@@ -423,7 +424,8 @@ static int try_bitmap_count(struct rev_info *revs)
 	return 0;
 }
 
-static int try_bitmap_traversal(struct rev_info *revs)
+static int try_bitmap_traversal(struct rev_info *revs,
+				struct list_objects_filter_options *filter)
 {
 	struct bitmap_index *bitmap_git;
 
@@ -441,7 +443,7 @@ static int try_bitmap_traversal(struct rev_info *revs)
 	if (!revs->tag_objects || !revs->tree_objects || !revs->blob_objects)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, NULL);
+	bitmap_git = prepare_bitmap_walk(revs, filter);
 	if (!bitmap_git)
 		return -1;
 
@@ -612,7 +614,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	    (revs.left_right || revs.cherry_mark))
 		die(_("marked counting is incompatible with --objects"));
 
-	if (filter_options.choice || revs.prune)
+	if (revs.prune)
 		use_bitmap_index = 0;
 
 	save_commit_buffer = (revs.verbose_header ||
@@ -625,9 +627,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		progress = start_delayed_progress(show_progress, 0);
 
 	if (use_bitmap_index) {
-		if (!try_bitmap_count(&revs))
+		if (!try_bitmap_count(&revs, &filter_options))
 			return 0;
-		if (!try_bitmap_traversal(&revs))
+		if (!try_bitmap_traversal(&revs, &filter_options))
 			return 0;
 	}
 
-- 
2.25.0.785.g49bcbe7794

