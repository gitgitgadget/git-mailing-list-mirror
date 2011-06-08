From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 41/48] merge-recursive: Defer rename/rename(2to1) handling until process_entry
Date: Wed,  8 Jun 2011 01:31:11 -0600
Message-ID: <1307518278-23814-42-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEk-0006q0-K3
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab1FHHaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHHaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:18 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=vae/s8gh2fSFXLRKIYI8+6G4iO54YAuQJDTLaNdDoio=;
        b=W4hjqLNA3qVGzqTtllETIccajur8LlaKtooULT4YOH+83rHbK32TDeQpF/oNDPDQbq
         P+md/1UBakpWPzn7JFijOMkDrXEILl+Yf60CJZ2ZdmQXmlHYIwcknr5/ekx31DkOhysZ
         E4LLQcitIlmDjYd1X8IEP7Bn2cw5g4+U95TqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ni0DLiKiE2iK0ZnbJgPbX/0qdXz1aoimD7pNj1vgoL9Cb3OgtbzN00slFGsyvHcipN
         TrMWjXtg7bUJ2LuwwZleO/Czot1CylrgpbpeeraIlSsB851CGydoaGLo0svCT18aK5V/
         UuH9IrUt3k436nKbev0+QWxl8mHYkth73U2as=
Received: by 10.68.28.133 with SMTP id b5mr546052pbh.264.1307518217889;
        Wed, 08 Jun 2011 00:30:17 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.16
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175332>

This puts the code for the different types of double rename conflicts
closer together (fewer lines of other code separating the two paths) and
increases similarity between how they are handled.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |  104 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9c0daf5..dbc1dd3 100644
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
@@ -1006,32 +1007,40 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
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
@@ -1062,6 +1071,7 @@ static int process_renames(struct merge_options *o,
 		struct rename *ren1 = NULL, *ren2 = NULL;
 		const char *branch1, *branch2;
 		const char *ren1_src, *ren1_dst;
+		struct string_list_item *lookup;
 
 		if (i >= a_renames->nr) {
 			ren2 = b_renames->items[j++].util;
@@ -1093,30 +1103,30 @@ static int process_renames(struct merge_options *o,
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
@@ -1136,9 +1146,32 @@ static int process_renames(struct merge_options *o,
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
@@ -1173,23 +1206,6 @@ static int process_renames(struct merge_options *o,
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
@@ -1475,6 +1491,10 @@ static int process_entry(struct merge_options *o,
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
1.7.6.rc0.62.g2d69f
