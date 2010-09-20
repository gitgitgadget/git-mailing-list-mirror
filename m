From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 24/37] merge-recursive: Update conflict_rename_rename_1to2() call signature
Date: Mon, 20 Sep 2010 02:28:57 -0600
Message-ID: <1284971350-30590-25-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblI-0006R4-Hz
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab0ITI2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854Ab0ITI2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:20 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tmISAWzQAnnRxDUZn4imJ2UPQ/9bcCKRdX98+nDr7i8=;
        b=oPelpKgb46itjg68F7PYD/pRgK6/DOo3M+fu6mMEmePpebeIacOZYV2pKoPOCPl2Pe
         9hWToFs6ciZMUPvw5+ligYINOPJDy1Qu+DWEpxTi4xjfdhc3fUFtmnIePMlXC9DpZnMd
         NsBIcnxQoJs3gK5ZeOHoXpJn0/C61sAq1q1OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XorUgU8yai0Hl40e4vdDp1gOP+d/uQDh/p2PbBINwvKZk3+aG12RwV9iqyl6bISWcm
         7KaF6k/lIQhyK12Dl8TaKyfVugqYroz2445VLuZYCWKKkBcssTi1G692tgHhzlRyGIGd
         D387ErcQKPQXCiOVYJ2bcAXVtxY4H6dSxOz8g=
Received: by 10.142.151.34 with SMTP id y34mr808691wfd.171.1284971300662;
        Mon, 20 Sep 2010 01:28:20 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156574>

To facilitate having this function called later using information stored
in a rename_df_conflict_info struct, accept a diff_filepair instead of a
rename.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b8222ad..237d1ac 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -821,16 +821,16 @@ static void conflict_rename_delete(struct merge_options *o,
 }
 
 static void conflict_rename_rename_1to2(struct merge_options *o,
-					struct rename *ren1,
+					struct diff_filepair *pair1,
 					const char *branch1,
-					struct rename *ren2,
+					struct diff_filepair *pair2,
 					const char *branch2)
 {
 	/* One file was renamed in both branches, but to different names. */
 	char *del[2];
 	int delp = 0;
-	const char *ren1_dst = ren1->pair->two->path;
-	const char *ren2_dst = ren2->pair->two->path;
+	const char *ren1_dst = pair1->two->path;
+	const char *ren2_dst = pair2->two->path;
 	const char *dst_name1 = ren1_dst;
 	const char *dst_name2 = ren2_dst;
 	if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
@@ -851,12 +851,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		/*
 		 * Uncomment to leave the conflicting names in the resulting tree
 		 *
-		 * update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, dst_name1);
-		 * update_file(o, 0, ren2->pair->two->sha1, ren2->pair->two->mode, dst_name2);
+		 * update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
+		 * update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
 		 */
 	} else {
-		update_stages(dst_name1, NULL, ren1->pair->two, NULL, 1);
-		update_stages(dst_name2, NULL, NULL, ren2->pair->two, 1);
+		update_stages(dst_name1, NULL, pair1->two, NULL, 1);
+		update_stages(dst_name2, NULL, NULL, pair2->two, 1);
 	}
 	while (delp--)
 		free(del[delp]);
@@ -970,7 +970,7 @@ static int process_renames(struct merge_options *o,
 					update_file(o, 0, ren1->pair->one->sha1,
 						    ren1->pair->one->mode, src);
 				}
-				conflict_rename_rename_1to2(o, ren1, branch1, ren2, branch2);
+				conflict_rename_rename_1to2(o, ren1->pair, branch1, ren2->pair, branch2);
 			} else {
 				struct merge_file_info mfi;
 				remove_file(o, 1, ren1_src, 1);
-- 
1.7.3.271.g16009
