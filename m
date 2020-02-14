Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACFEC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484B92168B
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404462AbgBNSWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:43726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2394918AbgBNSWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:33 -0500
Received: (qmail 22995 invoked by uid 109); 14 Feb 2020 18:22:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23681 invoked by uid 111); 14 Feb 2020 18:31:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/15] rev-list: use bitmap filters for traversal
Message-ID: <20200214182232.GK150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
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
 builtin/rev-list.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 6ff5e175fa..35e14ad2ed 100644
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
 
@@ -434,7 +436,7 @@ static int try_bitmap_traversal(struct rev_info *revs)
 	if (revs->max_count >= 0)
 		return -1;
 
-	bitmap_git = prepare_bitmap_walk(revs, NULL);
+	bitmap_git = prepare_bitmap_walk(revs, filter);
 	if (!bitmap_git)
 		return -1;
 
@@ -605,9 +607,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	    (revs.left_right || revs.cherry_mark))
 		die(_("marked counting is incompatible with --objects"));
 
-	if (filter_options.choice)
-		use_bitmap_index = 0;
-
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
 			      revs.grep_filter.header_list);
@@ -618,9 +617,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
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
2.25.0.796.gcc29325708

