From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 29/56] merge-recursive: Split update_stages_and_entry; only update stages at end
Date: Thu, 11 Aug 2011 23:20:02 -0600
Message-ID: <1313126429-17368-30-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBq-00051N-5D
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab1HLFVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:37 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab1HLFVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:32 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=d1JPtNhs7n1W7GCb4W/cGhFtkA5MllxlquSVCYmrv/M=;
        b=pazshe8X9fHEEc/xJ8luktXAsBzn1UGQJMg4GCWzsbmwH7x9TqKxTFyB4Jr2u5bCCN
         KfdWjvBtG9b5ycH/tggsuq1RkQquJtRkDthIRcjfiOWGhg8+tscWiQ0h5DgFFUvPzRCj
         w4BM+u9vaUMSi/yz5meDdG0oRVFybydrgH2lE=
Received: by 10.231.130.105 with SMTP id r41mr1169983ibs.14.1313126492520;
        Thu, 11 Aug 2011 22:21:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.30
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179181>

Instead of having the process_renames logic update the stages in the index
for the rename destination, have the index updated after process_entry or
process_df_entry.  This will also allow us to have process_entry determine
whether a file was tracked and existed in the working copy before the
merge started.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1547691..650d5ec 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -90,6 +90,7 @@ struct stage_data {
 	} stages[4];
 	struct rename_df_conflict_info *rename_df_conflict_info;
 	unsigned processed:1;
+	unsigned involved_in_rename:1;
 };
 
 static inline void setup_rename_df_conflict_info(enum rename_type rename_type,
@@ -524,15 +525,11 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 	return 0;
 }
 
-static int update_stages_and_entry(const char *path,
-				   struct stage_data *entry,
-				   struct diff_filespec *o,
-				   struct diff_filespec *a,
-				   struct diff_filespec *b,
-				   int clear)
+static void update_entry(struct stage_data *entry,
+			 struct diff_filespec *o,
+			 struct diff_filespec *a,
+			 struct diff_filespec *b)
 {
-	int options;
-
 	entry->processed = 0;
 	entry->stages[1].mode = o->mode;
 	entry->stages[2].mode = a->mode;
@@ -540,7 +537,6 @@ static int update_stages_and_entry(const char *path,
 	hashcpy(entry->stages[1].sha, o->sha1);
 	hashcpy(entry->stages[2].sha, a->sha1);
 	hashcpy(entry->stages[3].sha, b->sha1);
-	return update_stages(path, o, a, b);
 }
 
 static int remove_file(struct merge_options *o, int clean,
@@ -1099,12 +1095,11 @@ static int process_renames(struct merge_options *o,
 							      ren2->dst_entry);
 			} else {
 				remove_file(o, 1, ren1_src, 1);
-				update_stages_and_entry(ren1_dst,
-							ren1->dst_entry,
-							ren1->pair->one,
-							ren1->pair->two,
-							ren2->pair->two,
-							1 /* clear */);
+				update_entry(ren1->dst_entry,
+					     ren1->pair->one,
+					     ren1->pair->two,
+					     ren2->pair->two);
+				ren1->dst_entry->involved_in_rename = 1;
 			}
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
@@ -1209,7 +1204,8 @@ static int process_renames(struct merge_options *o,
 					b = ren1->pair->two;
 					a = &src_other;
 				}
-				update_stages_and_entry(ren1_dst, ren1->dst_entry, one, a, b, 1);
+				update_entry(ren1->dst_entry, one, a, b);
+				ren1->dst_entry->involved_in_rename = 1;
 				if (dir_in_way(ren1_dst, 0 /*check_wc*/)) {
 					setup_rename_df_conflict_info(RENAME_NORMAL,
 								      ren1->pair,
@@ -1306,6 +1302,7 @@ static void handle_delete_modify(struct merge_options *o,
 }
 
 static int merge_content(struct merge_options *o,
+			 unsigned involved_in_rename,
 			 const char *path,
 			 unsigned char *o_sha, int o_mode,
 			 unsigned char *a_sha, int a_mode,
@@ -1346,6 +1343,8 @@ static int merge_content(struct merge_options *o,
 			reason = "submodule";
 		output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 				reason, path);
+		if (involved_in_rename)
+			update_stages(path, &one, &a, &b);
 	}
 
 	if (df_conflict_remains) {
@@ -1430,7 +1429,7 @@ static int process_entry(struct merge_options *o,
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		clean_merge = merge_content(o, path,
+		clean_merge = merge_content(o, entry->involved_in_rename, path,
 					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
 					    NULL);
 	} else if (!o_sha && !a_sha && !b_sha) {
@@ -1474,7 +1473,7 @@ static int process_df_entry(struct merge_options *o,
 		char *src;
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
-			clean_merge = merge_content(o, path,
+			clean_merge = merge_content(o, entry->involved_in_rename, path,
 						    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
 						    conflict_info->branch1);
 			break;
-- 
1.7.6.100.gac5c1
