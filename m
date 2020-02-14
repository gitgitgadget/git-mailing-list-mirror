Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E31C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CCE222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394914AbgBNSW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:22:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:43708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2393301AbgBNSWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 13:22:25 -0500
Received: (qmail 22969 invoked by uid 109); 14 Feb 2020 18:22:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 18:22:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23665 invoked by uid 111); 14 Feb 2020 18:31:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 13:31:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 13:22:22 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/15] rev-list: allow bitmaps when counting objects
Message-ID: <20200214182222.GG150965@coredump.intra.peff.net>
References: <20200214182147.GA654525@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200214182147.GA654525@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prior commit taught "--count --objects" to work without bitmaps. We
should be able to get the same answer much more quickly with bitmaps.

Note that we punt on the max_count case here. This perhaps _could_ be
made to work if we find all of the boundary commits and treat them as
UNINTERESTING, subtracting them (and their reachable objects) from the
set we return. That implies an actual commit traversal, but we'd still
be faster due to avoiding opening up any trees. Given the complexity and
the fact that anyone is unlikely to want this, it makes sense to just
fall back to the non-bitmap case for now.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c      | 21 ++++++++++++++++++---
 t/t5310-pack-bitmaps.sh |  6 ++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9452123988..70f3207ecc 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -374,7 +374,10 @@ static inline int parse_missing_action_value(const char *value)
 
 static int try_bitmap_count(struct rev_info *revs)
 {
-	uint32_t commit_count;
+	uint32_t commit_count = 0,
+		 tag_count = 0,
+		 tree_count = 0,
+		 blob_count = 0;
 	int max_count;
 	struct bitmap_index *bitmap_git;
 
@@ -389,6 +392,15 @@ static int try_bitmap_count(struct rev_info *revs)
 	if (revs->left_right || revs->cherry_mark)
 		return -1;
 
+	/*
+	 * If we're counting reachable objects, we can't handle a max count of
+	 * commits to traverse, since we don't know which objects go with which
+	 * commit.
+	 */
+	if (revs->max_count >= 0 &&
+	    (revs->tag_objects || revs->tree_objects || revs->blob_objects))
+		return -1;
+
 	/*
 	 * This must be saved before doing any walking, since the revision
 	 * machinery will count it down to zero while traversing.
@@ -399,11 +411,14 @@ static int try_bitmap_count(struct rev_info *revs)
 	if (!bitmap_git)
 		return -1;
 
-	count_bitmap_commit_list(bitmap_git, &commit_count, NULL, NULL, NULL);
+	count_bitmap_commit_list(bitmap_git, &commit_count,
+				 revs->tree_objects ? &tree_count : NULL,
+				 revs->blob_objects ? &blob_count : NULL,
+				 revs->tag_objects ? &tag_count : NULL);
 	if (max_count >= 0 && max_count < commit_count)
 		commit_count = max_count;
 
-	printf("%d\n", commit_count);
+	printf("%d\n", commit_count + tree_count + blob_count + tag_count);
 	free_bitmap_index(bitmap_git);
 	return 0;
 }
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6640329ebf..7ba7d294a5 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -74,6 +74,12 @@ rev_list_tests() {
 		test_cmp expect actual
 	'
 
+	test_expect_success "counting objects via bitmap ($state)" '
+		git rev-list --count --objects HEAD >expect &&
+		git rev-list --use-bitmap-index --count --objects HEAD >actual &&
+		test_cmp expect actual
+	'
+
 	test_expect_success "enumerate --objects ($state)" '
 		git rev-list --objects --use-bitmap-index HEAD >tmp &&
 		cut -d" " -f1 <tmp >tmp2 &&
-- 
2.25.0.796.gcc29325708

