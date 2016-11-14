Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8C21F858
	for <e@80x24.org>; Mon, 14 Nov 2016 13:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbcKNNku (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 08:40:50 -0500
Received: from mail.zhinst.com ([212.126.164.98]:46800 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbcKNNjP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 08:39:15 -0500
Received: from ziws08.zhinst.com ([10.42.0.7])
        by mail.zhinst.com (Kerio Connect 9.2.0) with ESMTP;
        Mon, 14 Nov 2016 14:39:10 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2] diffcore-delta: remove unused parameter to diffcore_count_changes()
Date:   Mon, 14 Nov 2016 14:39:05 +0100
Message-Id: <20161114133905.6632-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0.rc0.7.gbe5a750
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The delta_limit parameter to diffcore_count_changes() has been unused
since commit ba23bbc8e ("diffcore-delta: make change counter to byte
oriented again.", 2006-03-04).

Remove the parameter and adjust all callers.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
v2: In the commit message, reference the correct commit where the parameter
    usage was removed. Spotted by Jeff King.

 diff.c            | 2 +-
 diffcore-break.c  | 1 -
 diffcore-delta.c  | 1 -
 diffcore-rename.c | 4 ----
 diffcore.h        | 1 -
 5 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 8981477c436d..ec8728362dae 100644
--- a/diff.c
+++ b/diff.c
@@ -2023,7 +2023,7 @@ static void show_dirstat(struct diff_options *options)
 		if (DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
 			diff_populate_filespec(p->one, 0);
 			diff_populate_filespec(p->two, 0);
-			diffcore_count_changes(p->one, p->two, NULL, NULL, 0,
+			diffcore_count_changes(p->one, p->two, NULL, NULL,
 					       &copied, &added);
 			diff_free_filespec_data(p->one);
 			diff_free_filespec_data(p->two);
diff --git a/diffcore-break.c b/diffcore-break.c
index 881a74f29e4f..c64359f489c8 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -73,7 +73,6 @@ static int should_break(struct diff_filespec *src,
 
 	if (diffcore_count_changes(src, dst,
 				   &src->cnt_data, &dst->cnt_data,
-				   0,
 				   &src_copied, &literal_added))
 		return 0;
 
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 2ebedb32d18a..ebe70fb06851 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -166,7 +166,6 @@ int diffcore_count_changes(struct diff_filespec *src,
 			   struct diff_filespec *dst,
 			   void **src_count_p,
 			   void **dst_count_p,
-			   unsigned long delta_limit,
 			   unsigned long *src_copied,
 			   unsigned long *literal_added)
 {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 54a2396653df..f7444c86bde3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -145,7 +145,6 @@ static int estimate_similarity(struct diff_filespec *src,
 	 * call into this function in that case.
 	 */
 	unsigned long max_size, delta_size, base_size, src_copied, literal_added;
-	unsigned long delta_limit;
 	int score;
 
 	/* We deal only with regular files.  Symlink renames are handled
@@ -191,11 +190,8 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
 		return 0;
 
-	delta_limit = (unsigned long)
-		(base_size * (MAX_SCORE-minimum_score) / MAX_SCORE);
 	if (diffcore_count_changes(src, dst,
 				   &src->cnt_data, &dst->cnt_data,
-				   delta_limit,
 				   &src_copied, &literal_added))
 		return 0;
 
diff --git a/diffcore.h b/diffcore.h
index c11b8465fc8e..623024135478 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -142,7 +142,6 @@ extern int diffcore_count_changes(struct diff_filespec *src,
 				  struct diff_filespec *dst,
 				  void **src_count_p,
 				  void **dst_count_p,
-				  unsigned long delta_limit,
 				  unsigned long *src_copied,
 				  unsigned long *literal_added);
 
-- 
2.9.0


