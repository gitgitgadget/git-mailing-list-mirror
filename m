From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 28/48] merge-recursive: Split update_stages_and_entry; only update stages at end
Date: Wed,  8 Jun 2011 01:30:58 -0600
Message-ID: <1307518278-23814-29-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDO-0005pC-Np
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab1FHH35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:57 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab1FHH3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:52 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=kN7hqkgOSkJfMp2E+f5ssR9jLGGAHvtsokOCyrdMHqY=;
        b=O+rGGJxrcLH+zaAWpEZPzkRpdHin/SpKP+08WHKimtU/EBVu3pBnwnkKETk3u+NcaX
         LCwbNGpo3Dn3//Rap7yVuXYk+WtllFjFSulvYT91x/Vs7KStovbN8L/9wLYAGVhTNtrR
         3UtnGBwVrMYnZl7g+DKqycj3fEWYgIpV+TkZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XNzpWfA0gJ3LH6YN0rjOrapExR77fh962sTsAV+GTJnMvREE3+krgoaaSsF1d230jX
         w+4n9o8JFKef9LeI+FwwCgmsvKyruQ17xbmfPqskDAv+h2ZziTMYWR35juqhLPtC+Wlv
         D+OH5ute9rgBgMdeH+cEEzuE+MTfOtnXABRiM=
Received: by 10.68.39.105 with SMTP id o9mr566259pbk.45.1307518192193;
        Wed, 08 Jun 2011 00:29:52 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.50
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175314>

Instead of having the process_renames logic update the stages in the index
for the rename destination, have the index updated after process_entry or
process_df_entry.  This will also allow us to have process_entry determine
whether a file was tracked and existed in the working copy before the
merge started.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b4baa35..7878b30 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -90,6 +90,7 @@ struct stage_data {
 	} stages[4];
 	struct rename_df_conflict_info *rename_df_conflict_info;
 	unsigned processed:1;
+	unsigned involved_in_rename:1;
 };
 
 static inline void setup_rename_df_conflict_info(enum rename_type rename_type,
@@ -516,15 +517,11 @@ static int update_stages(const char *path, const struct diff_filespec *o,
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
@@ -532,7 +529,6 @@ static int update_stages_and_entry(const char *path,
 	hashcpy(entry->stages[1].sha, o->sha1);
 	hashcpy(entry->stages[2].sha, a->sha1);
 	hashcpy(entry->stages[3].sha, b->sha1);
-	return update_stages(path, o, a, b);
 }
 
 static int remove_file(struct merge_options *o, int clean,
@@ -1084,12 +1080,11 @@ static int process_renames(struct merge_options *o,
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
@@ -1194,7 +1189,8 @@ static int process_renames(struct merge_options *o,
 					b = ren1->pair->two;
 					a = &src_other;
 				}
-				update_stages_and_entry(ren1_dst, ren1->dst_entry, one, a, b, 1);
+				update_entry(ren1->dst_entry, one, a, b);
+				ren1->dst_entry->involved_in_rename = 1;
 				if (dir_in_way(ren1_dst, 0 /*check_wc*/)) {
 					setup_rename_df_conflict_info(RENAME_NORMAL,
 								      ren1->pair,
@@ -1291,6 +1287,7 @@ static void handle_delete_modify(struct merge_options *o,
 }
 
 static int merge_content(struct merge_options *o,
+			 unsigned involved_in_rename,
 			 const char *path,
 			 unsigned char *o_sha, int o_mode,
 			 unsigned char *a_sha, int a_mode,
@@ -1331,6 +1328,8 @@ static int merge_content(struct merge_options *o,
 			reason = "submodule";
 		output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 				reason, path);
+		if (involved_in_rename)
+			update_stages(path, &one, &a, &b);
 	}
 
 	if (df_conflict_remains) {
@@ -1415,7 +1414,7 @@ static int process_entry(struct merge_options *o,
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		clean_merge = merge_content(o, path,
+		clean_merge = merge_content(o, entry->involved_in_rename, path,
 					    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
 					    NULL);
 	} else if (!o_sha && !a_sha && !b_sha) {
@@ -1459,7 +1458,7 @@ static int process_df_entry(struct merge_options *o,
 		char *src;
 		switch (conflict_info->rename_type) {
 		case RENAME_NORMAL:
-			clean_merge = merge_content(o, path,
+			clean_merge = merge_content(o, entry->involved_in_rename, path,
 						    o_sha, o_mode, a_sha, a_mode, b_sha, b_mode,
 						    conflict_info->branch1);
 			break;
-- 
1.7.6.rc0.62.g2d69f
