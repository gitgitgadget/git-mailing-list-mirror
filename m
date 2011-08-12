From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 31/56] merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
Date: Thu, 11 Aug 2011 23:20:04 -0600
Message-ID: <1313126429-17368-32-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBr-00051N-AC
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab1HLFVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:43 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab1HLFVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:36 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OEzq03hUijBJ94G/ZCt4LtMMhUxFomgQ0CUuvRE+2qc=;
        b=djE5dkNJlYE+wfd+30jOaVwcKXZlIeu7bwFIA2OG9Kgb8yApC+Yyz0XnXVhI14tFzo
         rWfsbecN3awth0Hpf7CYri5jwlUAhuV/q3byHwTu37foIOkGAkx0r8PuPt9Y9x7044BJ
         tJeLtR6pd/syvBefthnyqKSAdzq1IltkNL1sY=
Received: by 10.231.56.160 with SMTP id y32mr1051393ibg.68.1313126496166;
        Thu, 11 Aug 2011 22:21:36 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.34
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179185>

The code for rename_rename_2to1 conflicts (two files both being renamed to
the same filename) was dead since the rename/add path was always being
independently triggered for each of the renames instead.  Further,
reviving the dead code showed that it was inherently buggy and would
always segfault -- among a few other bugs.

Move the else-if branch for the rename/rename block before the rename/add
block to make sure it is checked first, and fix up the rename/rename(2to1)
code segments to make it handle most cases.  Work is still needed to
handle higher dimensional corner cases such as rename/rename/modify/modify
issues.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                 |   70 +++++++++++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh |   17 +++++----
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f395d20..f74feb5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -998,17 +998,36 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 					struct rename *ren2,
 					const char *branch2)
 {
+	char *path = ren1->pair->two->path; /* same as ren2->pair->two->path */
 	/* Two files were renamed to the same thing. */
-	char *new_path1 = unique_path(o, ren1->pair->two->path, branch1);
-	char *new_path2 = unique_path(o, ren2->pair->two->path, branch2);
-	output(o, 1, "Renaming %s to %s and %s to %s instead",
-	       ren1->pair->one->path, new_path1,
-	       ren2->pair->one->path, new_path2);
-	remove_file(o, 0, ren1->pair->two->path, 0);
-	update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path1);
-	update_file(o, 0, ren2->pair->two->sha1, ren2->pair->two->mode, new_path2);
-	free(new_path2);
-	free(new_path1);
+	if (o->call_depth) {
+		struct merge_file_info mfi;
+		struct diff_filespec one, a, b;
+
+		one.path = a.path = b.path = path;
+		hashcpy(one.sha1, null_sha1);
+		one.mode = 0;
+		hashcpy(a.sha1, ren1->pair->two->sha1);
+		a.mode = ren1->pair->two->mode;
+		hashcpy(b.sha1, ren2->pair->two->sha1);
+		b.mode = ren2->pair->two->mode;
+		mfi = merge_file(o, &one, &a, &b, branch1, branch2);
+		output(o, 1, "Adding merged %s", path);
+		update_file(o, 0, mfi.sha, mfi.mode, path);
+	} else {
+		char *new_path1 = unique_path(o, path, branch1);
+		char *new_path2 = unique_path(o, path, branch2);
+		output(o, 1, "Renaming %s to %s and %s to %s instead",
+		       ren1->pair->one->path, new_path1,
+		       ren2->pair->one->path, new_path2);
+		remove_file(o, 0, path, 0);
+		update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode,
+			    new_path1);
+		update_file(o, 0, ren2->pair->two->sha1, ren2->pair->two->mode,
+			    new_path2);
+		free(new_path2);
+		free(new_path1);
+	}
 }
 
 static int process_renames(struct merge_options *o,
@@ -1023,12 +1042,12 @@ static int process_renames(struct merge_options *o,
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
 		string_list_insert(&a_by_dst, sre->pair->two->path)->util
-			= sre->dst_entry;
+			= (void *)sre;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
 		string_list_insert(&b_by_dst, sre->pair->two->path)->util
-			= sre->dst_entry;
+			= (void *)sre;
 	}
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
@@ -1140,6 +1159,23 @@ static int process_renames(struct merge_options *o,
 					clean_merge = 0;
 					conflict_rename_delete(o, ren1->pair, branch1, branch2);
 				}
+			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
+				char *ren2_src, *ren2_dst;
+				ren2 = item->util;
+				ren2_src = ren2->pair->one->path;
+				ren2_dst = ren2->pair->two->path;
+
+				clean_merge = 0;
+				ren2->processed = 1;
+				remove_file(o, 1, ren2_src,
+					    renamed_stage == 3 || would_lose_untracked(ren1_src));
+
+				output(o, 1, "CONFLICT (rename/rename): "
+				       "Rename %s->%s in %s. "
+				       "Rename %s->%s in %s",
+				       ren1_src, ren1_dst, branch1,
+				       ren2_src, ren2_dst, branch2);
+				conflict_rename_rename_2to1(o, ren1, branch1, ren2, branch2);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
 				/* Added file on the other side
@@ -1180,16 +1216,6 @@ static int process_renames(struct merge_options *o,
 					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
 					free(new_path);
 				}
-			} else if ((item = string_list_lookup(renames2Dst, ren1_dst))) {
-				ren2 = item->util;
-				clean_merge = 0;
-				ren2->processed = 1;
-				output(o, 1, "CONFLICT (rename/rename): "
-				       "Rename %s->%s in %s. "
-				       "Rename %s->%s in %s",
-				       ren1_src, ren1_dst, branch1,
-				       ren2->pair->one->path, ren2->pair->two->path, branch2);
-				conflict_rename_rename_2to1(o, ren1, branch1, ren2, branch2);
 			} else
 				try_merge = 1;
 
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 279f33c..b046e1b 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -66,13 +66,13 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
 	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
 
-	cp two merged &&
+	cp one merged &&
 	>empty &&
 	test_must_fail git merge-file \
-		-L "Temporary merge branch 2" \
-		-L "" \
 		-L "Temporary merge branch 1" \
-		merged empty one &&
+		-L "" \
+		-L "Temporary merge branch 2" \
+		merged empty two &&
 	test $(git rev-parse :1:three) = $(git hash-object merged)
 '
 
@@ -145,11 +145,12 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 	cp one merge-me &&
 	>empty &&
 	test_must_fail git merge-file \
-		-L "Temporary merge branch 2" \
-		-L "" \
 		-L "Temporary merge branch 1" \
-		merged empty merge-me &&
-	test $(git rev-parse :1:three) = $(git hash-object merged)
+		-L "" \
+		-L "Temporary merge branch 2" \
+		merge-me empty merged &&
+
+	test $(git rev-parse :1:three) = $(git hash-object merge-me)
 '
 
 #
-- 
1.7.6.100.gac5c1
