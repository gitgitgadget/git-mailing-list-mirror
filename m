From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 35/56] merge-recursive: Cleanup and consolidation of rename_conflict_info
Date: Thu, 11 Aug 2011 23:20:08 -0600
Message-ID: <1313126429-17368-36-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBr-00051N-TZ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab1HLFVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:47 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab1HLFVo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:44 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uQWZs3gnUREh2V1iXFV0TO58c/i8lJ1zz0h/SSLUQSk=;
        b=UA/2uHgW45sDfCuR1XgtjKpHqkrT1TovMZZ2gomurQUE9WiOfO5RIsnQMiGn+VqNV+
         giKFisfbZ7PvCCAGWm427s17pkqIw4Mw2TvV6NJEepiNuGJ+oV57551JRkrI1nnrimeA
         YhHrYs5q03LM/QPJk5E+caJ74yN8Dps9ZTfeQ=
Received: by 10.42.144.68 with SMTP id a4mr473865icv.427.1313126503981;
        Thu, 11 Aug 2011 22:21:43 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.41
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179186>

The consolidation of process_entry() and process_df_entry() allows us to
consolidate more code paths concerning rename conflicts, and to do
a few additional related cleanups.  It also means we are using
rename_df_conflict_info in some cases where there is no D/F conflict;
rename it to rename_conflict_info.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |  134 ++++++++++++++++++++++++++---------------------------
 1 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 74b1139..0635e1b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -66,10 +66,11 @@ static int sha_eq(const unsigned char *a, const unsigned char *b)
 enum rename_type {
 	RENAME_NORMAL = 0,
 	RENAME_DELETE,
+	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO
 };
 
-struct rename_df_conflict_info {
+struct rename_conflict_info {
 	enum rename_type rename_type;
 	struct diff_filepair *pair1;
 	struct diff_filepair *pair2;
@@ -88,34 +89,33 @@ struct stage_data {
 		unsigned mode;
 		unsigned char sha[20];
 	} stages[4];
-	struct rename_df_conflict_info *rename_df_conflict_info;
+	struct rename_conflict_info *rename_conflict_info;
 	unsigned processed:1;
-	unsigned involved_in_rename:1;
 };
 
-static inline void setup_rename_df_conflict_info(enum rename_type rename_type,
-						 struct diff_filepair *pair1,
-						 struct diff_filepair *pair2,
-						 const char *branch1,
-						 const char *branch2,
-						 struct stage_data *dst_entry1,
-						 struct stage_data *dst_entry2)
+static inline void setup_rename_conflict_info(enum rename_type rename_type,
+					      struct diff_filepair *pair1,
+					      struct diff_filepair *pair2,
+					      const char *branch1,
+					      const char *branch2,
+					      struct stage_data *dst_entry1,
+					      struct stage_data *dst_entry2)
 {
-	struct rename_df_conflict_info *ci = xcalloc(1, sizeof(struct rename_df_conflict_info));
+	struct rename_conflict_info *ci = xcalloc(1, sizeof(struct rename_conflict_info));
 	ci->rename_type = rename_type;
 	ci->pair1 = pair1;
 	ci->branch1 = branch1;
 	ci->branch2 = branch2;
 
 	ci->dst_entry1 = dst_entry1;
-	dst_entry1->rename_df_conflict_info = ci;
+	dst_entry1->rename_conflict_info = ci;
 	dst_entry1->processed = 0;
 
 	assert(!pair2 == !dst_entry2);
 	if (dst_entry2) {
 		ci->dst_entry2 = dst_entry2;
 		ci->pair2 = pair2;
-		dst_entry2->rename_df_conflict_info = ci;
+		dst_entry2->rename_conflict_info = ci;
 	}
 }
 
@@ -954,10 +954,29 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	/* One file was renamed in both branches, but to different names. */
 	char *del[2];
 	int delp = 0;
+	const char *src      = pair1->one->path;
 	const char *ren1_dst = pair1->two->path;
 	const char *ren2_dst = pair2->two->path;
 	const char *dst_name1 = ren1_dst;
 	const char *dst_name2 = ren2_dst;
+
+	output(o, 1, "CONFLICT (rename/rename): "
+	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
+	       "rename \"%s\"->\"%s\" in \"%s\"%s",
+	       src, pair1->two->path, branch1,
+	       src, pair2->two->path, branch2,
+	       o->call_depth ? " (left unresolved)" : "");
+	if (o->call_depth) {
+		/*
+		 * FIXME: Why remove file from cache, and then
+		 * immediately readd it?  Why not just overwrite using
+		 * update_file only?  Also...this is buggy for
+		 * rename/add-source situations...
+		 */
+		remove_file_from_cache(src);
+		update_file(o, 0, pair1->one->sha1, pair1->one->mode, src);
+	}
+
 	if (dir_in_way(ren1_dst, !o->call_depth)) {
 		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
@@ -1098,20 +1117,16 @@ static int process_renames(struct merge_options *o,
 		if (ren2) {
 			const char *ren2_src = ren2->pair->one->path;
 			const char *ren2_dst = ren2->pair->two->path;
+			enum rename_type rename_type;
 			/* Renamed in 1 and renamed in 2 */
 			if (strcmp(ren1_src, ren2_src) != 0)
 				die("ren1.src != ren2.src");
 			ren2->dst_entry->processed = 1;
 			ren2->processed = 1;
 			if (strcmp(ren1_dst, ren2_dst) != 0) {
-				setup_rename_df_conflict_info(RENAME_ONE_FILE_TO_TWO,
-							      ren1->pair,
-							      ren2->pair,
-							      branch1,
-							      branch2,
-							      ren1->dst_entry,
-							      ren2->dst_entry);
+				rename_type = RENAME_ONE_FILE_TO_TWO;
 			} else {
+				rename_type = RENAME_ONE_FILE_TO_ONE;
 				/* BUG: We should only remove ren1_src in
 				 * the base stage (think of rename +
 				 * add-source cases).
@@ -1121,8 +1136,14 @@ static int process_renames(struct merge_options *o,
 					     ren1->pair->one,
 					     ren1->pair->two,
 					     ren2->pair->two);
-				ren1->dst_entry->involved_in_rename = 1;
 			}
+			setup_rename_conflict_info(rename_type,
+						   ren1->pair,
+						   ren2->pair,
+						   branch1,
+						   branch2,
+						   ren1->dst_entry,
+						   ren2->dst_entry);
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
 			struct string_list_item *item;
@@ -1153,19 +1174,13 @@ static int process_renames(struct merge_options *o,
 			try_merge = 0;
 
 			if (sha_eq(src_other.sha1, null_sha1)) {
-				if (dir_in_way(ren1_dst, 0 /*check_wc*/)) {
-					ren1->dst_entry->processed = 0;
-					setup_rename_df_conflict_info(RENAME_DELETE,
-								      ren1->pair,
-								      NULL,
-								      branch1,
-								      branch2,
-								      ren1->dst_entry,
-								      NULL);
-				} else {
-					clean_merge = 0;
-					conflict_rename_delete(o, ren1->pair, branch1, branch2);
-				}
+				setup_rename_conflict_info(RENAME_DELETE,
+							   ren1->pair,
+							   NULL,
+							   branch1,
+							   branch2,
+							   ren1->dst_entry,
+							   NULL);
 			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
 				char *ren2_src, *ren2_dst;
 				ren2 = item->util;
@@ -1239,16 +1254,13 @@ static int process_renames(struct merge_options *o,
 					a = &src_other;
 				}
 				update_entry(ren1->dst_entry, one, a, b);
-				ren1->dst_entry->involved_in_rename = 1;
-				if (dir_in_way(ren1_dst, 0 /*check_wc*/)) {
-					setup_rename_df_conflict_info(RENAME_NORMAL,
-								      ren1->pair,
-								      NULL,
-								      branch1,
-								      NULL,
-								      ren1->dst_entry,
-								      NULL);
-				}
+				setup_rename_conflict_info(RENAME_NORMAL,
+							   ren1->pair,
+							   NULL,
+							   branch1,
+							   NULL,
+							   ren1->dst_entry,
+							   NULL);
 			}
 		}
 	}
@@ -1336,12 +1348,11 @@ static void handle_delete_modify(struct merge_options *o,
 }
 
 static int merge_content(struct merge_options *o,
-			 unsigned involved_in_rename,
 			 const char *path,
 			 unsigned char *o_sha, int o_mode,
 			 unsigned char *a_sha, int a_mode,
 			 unsigned char *b_sha, int b_mode,
-			 const char *df_rename_conflict_branch)
+			 struct rename_conflict_info *rename_conflict_info)
 {
 	const char *reason = "content";
 	struct merge_file_info mfi;
@@ -1361,8 +1372,7 @@ static int merge_content(struct merge_options *o,
 	b.mode = b_mode;
 
 	mfi = merge_file(o, &one, &a, &b, o->branch1, o->branch2);
-	if (df_rename_conflict_branch &&
-	    dir_in_way(path, !o->call_depth)) {
+	if (rename_conflict_info && dir_in_way(path, !o->call_depth)) {
 		df_conflict_remains = 1;
 	}
 
@@ -1377,7 +1387,7 @@ static int merge_content(struct merge_options *o,
 			reason = "submodule";
 		output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 				reason, path);
-		if (involved_in_rename && !df_conflict_remains)
+		if (rename_conflict_info && !df_conflict_remains)
 			update_stages(path, &one, &a, &b);
 	}
 
@@ -1400,7 +1410,7 @@ static int merge_content(struct merge_options *o,
 			}
 
 		}
-		new_path = unique_path(o, path, df_rename_conflict_branch);
+		new_path = unique_path(o, path, rename_conflict_info->branch1);
 		output(o, 1, "Adding as %s instead", new_path);
 		update_file(o, 0, mfi.sha, mfi.mode, new_path);
 		free(new_path);
@@ -1430,14 +1440,14 @@ static int process_entry(struct merge_options *o,
 	unsigned char *b_sha = stage_sha(entry->stages[3].sha, b_mode);
 
 	entry->processed = 1;
-	if (entry->rename_df_conflict_info) {
-		struct rename_df_conflict_info *conflict_info = entry->rename_df_conflict_info;
-		char *src;
+	if (entry->rename_conflict_info) {
+		struct rename_conflict_info *conflict_info = entry->rename_conflict_info;
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
-			clean_merge = merge_content(o, entry->involved_in_rename, path,
+		case RENAME_ONE_FILE_TO_ONE:
+			clean_merge = merge_content(o, path,
 						    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
-						    conflict_info->branch1);
+						    conflict_info);
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
@@ -1446,19 +1456,7 @@ static int process_entry(struct merge_options *o,
 					       conflict_info->branch2);
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
-			src = conflict_info->pair1->one->path;
 			clean_merge = 0;
-			output(o, 1, "CONFLICT (rename/rename): "
-			       "Rename \"%s\"->\"%s\" in branch \"%s\" "
-			       "rename \"%s\"->\"%s\" in \"%s\"%s",
-			       src, conflict_info->pair1->two->path, conflict_info->branch1,
-			       src, conflict_info->pair2->two->path, conflict_info->branch2,
-			       o->call_depth ? " (left unresolved)" : "");
-			if (o->call_depth) {
-				remove_file_from_cache(src);
-				update_file(o, 0, conflict_info->pair1->one->sha1,
-					    conflict_info->pair1->one->mode, src);
-			}
 			conflict_rename_rename_1to2(o, conflict_info->pair1,
 						    conflict_info->branch1,
 						    conflict_info->pair2,
@@ -1533,7 +1531,7 @@ static int process_entry(struct merge_options *o,
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		clean_merge = merge_content(o, entry->involved_in_rename, path,
+		clean_merge = merge_content(o, path,
 					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
 					    NULL);
 	} else if (!o_sha && !a_sha && !b_sha) {
-- 
1.7.6.100.gac5c1
