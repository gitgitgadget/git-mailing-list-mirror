From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 42/56] merge-recursive: Defer rename/rename(2to1) handling until process_entry
Date: Thu, 11 Aug 2011 23:20:15 -0600
Message-ID: <1313126429-17368-43-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD9-0005ix-E0
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481Ab1HLFWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:53 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab1HLFWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:08 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SAWlQkwRSXuvqiOwF+QAPXiMe4IjxDwielhN03N/JrM=;
        b=arXTjJr8zO1Zv9u+Duo+zST4AijI4K2dyKALk64+ivUwEvP8lK9QfMFyGEQpoI/2G1
         qIr/bQZOwEEhkrVeBYHvEQmF3IcgxosNgXqnfwswffJYqmpTPpcCaHihrGY+G7lVKShX
         cmiYd5OEvjuo5lrA8sim0SfoagYtjkKLWaU9s=
Received: by 10.231.119.161 with SMTP id z33mr1091700ibq.91.1313126527972;
        Thu, 11 Aug 2011 22:22:07 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.06
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179211>

This puts the code for the different types of double rename conflicts
closer together (fewer lines of other code separating the two paths) and
increases similarity between how they are handled.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |  104 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8b65051..77c2c41 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -67,7 +67,8 @@ enum rename_type {
 	RENAME_NORMAL = 0,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
-	RENAME_ONE_FILE_TO_TWO
+	RENAME_ONE_FILE_TO_TWO,
+	RENAME_TWO_FILES_TO_ONE
 };
 
 struct rename_conflict_info {
@@ -1021,32 +1022,40 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 }
 
 static void conflict_rename_rename_2to1(struct merge_options *o,
-					struct rename *ren1,
-					const char *branch1,
-					struct rename *ren2,
-					const char *branch2)
+					struct rename_conflict_info *ci)
 {
-	char *path = ren1->pair->two->path; /* same as ren2->pair->two->path */
-	/* Two files were renamed to the same thing. */
+	/* Two files, a & b, were renamed to the same thing, c. */
+	struct diff_filespec *a = ci->pair1->one;
+	struct diff_filespec *b = ci->pair2->one;
+	struct diff_filespec *c1 = ci->pair1->two;
+	struct diff_filespec *c2 = ci->pair2->two;
+	char *path = c1->path; /* == c2->path */
+
+	output(o, 1, "CONFLICT (rename/rename): "
+	       "Rename %s->%s in %s. "
+	       "Rename %s->%s in %s",
+	       a->path, c1->path, ci->branch1,
+	       b->path, c2->path, ci->branch2);
+
+	remove_file(o, 1, a->path, would_lose_untracked(a->path));
+	remove_file(o, 1, b->path, would_lose_untracked(b->path));
+
 	if (o->call_depth) {
 		struct merge_file_info mfi;
 		mfi = merge_file(o, path, null_sha1, 0,
-				 ren1->pair->two->sha1, ren1->pair->two->mode,
-				 ren2->pair->two->sha1, ren2->pair->two->mode,
-				 branch1, branch2);
+				 c1->sha1, c1->mode,
+				 c2->sha1, c2->mode,
+				 ci->branch1, ci->branch2);
 		output(o, 1, "Adding merged %s", path);
 		update_file(o, 0, mfi.sha, mfi.mode, path);
 	} else {
-		char *new_path1 = unique_path(o, path, branch1);
-		char *new_path2 = unique_path(o, path, branch2);
+		char *new_path1 = unique_path(o, path, ci->branch1);
+		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, "Renaming %s to %s and %s to %s instead",
-		       ren1->pair->one->path, new_path1,
-		       ren2->pair->one->path, new_path2);
+		       a->path, new_path1, b->path, new_path2);
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode,
-			    new_path1);
-		update_file(o, 0, ren2->pair->two->sha1, ren2->pair->two->mode,
-			    new_path2);
+		update_file(o, 0, c1->sha1, c1->mode, new_path1);
+		update_file(o, 0, c2->sha1, c2->mode, new_path2);
 		free(new_path2);
 		free(new_path1);
 	}
@@ -1077,6 +1086,7 @@ static int process_renames(struct merge_options *o,
 		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branch1, *branch2;
 		const char *ren1_src, *ren1_dst;
+		struct string_list_item *lookup;
 
 		if (i >= a_renames->nr) {
 			ren2 = b_renames->items[j++].util;
@@ -1108,30 +1118,30 @@ static int process_renames(struct merge_options *o,
 			ren1 = tmp;
 		}
 
+		if (ren1->processed)
+			continue;
+		ren1->processed = 1;
 		ren1->dst_entry->processed = 1;
 		/* BUG: We should only mark src_entry as processed if we
 		 * are not dealing with a rename + add-source case.
 		 */
 		ren1->src_entry->processed = 1;
 
-		if (ren1->processed)
-			continue;
-		ren1->processed = 1;
-
 		ren1_src = ren1->pair->one->path;
 		ren1_dst = ren1->pair->two->path;
 
 		if (ren2) {
+			/* One file renamed on both sides */
 			const char *ren2_src = ren2->pair->one->path;
 			const char *ren2_dst = ren2->pair->two->path;
 			enum rename_type rename_type;
-			/* Renamed in 1 and renamed in 2 */
 			if (strcmp(ren1_src, ren2_src) != 0)
-				die("ren1.src != ren2.src");
+				die("ren1_src != ren2_src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
 				rename_type = RENAME_ONE_FILE_TO_TWO;
+				clean_merge = 0;
 			} else {
 				rename_type = RENAME_ONE_FILE_TO_ONE;
 				/* BUG: We should only remove ren1_src in
@@ -1151,9 +1161,32 @@ static int process_renames(struct merge_options *o,
 						   branch2,
 						   ren1->dst_entry,
 						   ren2->dst_entry);
+		} else if ((lookup = string_list_lookup(renames2Dst, ren1_dst))) {
+			/* Two different files renamed to the same thing */
+			char *ren2_dst;
+			ren2 = lookup->util;
+			ren2_dst = ren2->pair->two->path;
+			if (strcmp(ren1_dst, ren2_dst) != 0)
+				die("ren1_dst != ren2_dst");
+
+			clean_merge = 0;
+			ren2->processed = 1;
+			/*
+			 * BUG: We should only mark src_entry as processed
+			 * if we are not dealing with a rename + add-source
+			 * case.
+			 */
+			ren2->src_entry->processed = 1;
+
+			setup_rename_conflict_info(RENAME_TWO_FILES_TO_ONE,
+						   ren1->pair,
+						   ren2->pair,
+						   branch1,
+						   branch2,
+						   ren1->dst_entry,
+						   ren2->dst_entry);
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
-			struct string_list_item *item;
 			/* we only use sha1 and mode of these */
 			struct diff_filespec src_other, dst_other;
 			int try_merge;
@@ -1188,23 +1221,6 @@ static int process_renames(struct merge_options *o,
 							   branch2,
 							   ren1->dst_entry,
 							   NULL);
-			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
-				char *ren2_src, *ren2_dst;
-				ren2 = item->util;
-				ren2_src = ren2->pair->one->path;
-				ren2_dst = ren2->pair->two->path;
-
-				clean_merge = 0;
-				ren2->processed = 1;
-				remove_file(o, 1, ren2_src,
-					    renamed_stage == 3 || would_lose_untracked(ren1_src));
-
-				output(o, 1, "CONFLICT (rename/rename): "
-				       "Rename %s->%s in %s. "
-				       "Rename %s->%s in %s",
-				       ren1_src, ren1_dst, branch1,
-				       ren2_src, ren2_dst, branch2);
-				conflict_rename_rename_2to1(o, ren1, branch1, ren2, branch2);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
 				/* Added file on the other side
@@ -1504,6 +1520,10 @@ static int process_entry(struct merge_options *o,
 			clean_merge = 0;
 			conflict_rename_rename_1to2(o, conflict_info);
 			break;
+		case RENAME_TWO_FILES_TO_ONE:
+			clean_merge = 0;
+			conflict_rename_rename_2to1(o, conflict_info);
+			break;
 		default:
 			entry->processed = 0;
 			break;
-- 
1.7.6.100.gac5c1
