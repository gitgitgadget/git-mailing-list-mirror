Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFAEDE9A0
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 09:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbjINJnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbjINJms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 05:42:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC7726B2
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 02:40:00 -0700 (PDT)
Received: (qmail 27333 invoked by uid 109); 14 Sep 2023 09:39:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 09:39:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21330 invoked by uid 111); 14 Sep 2023 09:40:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Sep 2023 05:40:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Sep 2023 05:39:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 3/4] merge-ort: drop unused parameters from
 detect_and_process_renames()
Message-ID: <20230914093958.GC2254894@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914093409.GA2254811@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function takes three trees representing the merge base and both
sides of the merge, but never looks at any of them. This is due to
f78cf97617 (merge-ort: call diffcore_rename() directly, 2021-02-14).
Prior to that commit, we passed pairs of trees to diff_tree_oid(). But
after that commit, we collect a custom diff_queue for each pair in the
merge_options struct, and just run diffcore_rename() on the result. So
the function does not need to know about the original trees at all
anymore.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ort.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 31c663b297..20eefd9b5e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3324,10 +3324,7 @@ static int collect_renames(struct merge_options *opt,
 	return clean;
 }
 
-static int detect_and_process_renames(struct merge_options *opt,
-				      struct tree *merge_base,
-				      struct tree *side1,
-				      struct tree *side2)
+static int detect_and_process_renames(struct merge_options *opt)
 {
 	struct diff_queue_struct combined = { 0 };
 	struct rename_info *renames = &opt->priv->renames;
@@ -4964,8 +4961,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 	trace2_region_leave("merge", "collect_merge_info", opt->repo);
 
 	trace2_region_enter("merge", "renames", opt->repo);
-	result->clean = detect_and_process_renames(opt, merge_base,
-						   side1, side2);
+	result->clean = detect_and_process_renames(opt);
 	trace2_region_leave("merge", "renames", opt->repo);
 	if (opt->priv->renames.redo_after_renames == 2) {
 		trace2_region_enter("merge", "reset_maps", opt->repo);
-- 
2.42.0.628.g8a27295885

