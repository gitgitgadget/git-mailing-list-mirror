From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 31/48] merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
Date: Wed,  8 Jun 2011 01:31:01 -0600
Message-ID: <1307518278-23814-32-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDP-0005pC-9E
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab1FHHaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHH36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:58 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=PHaQOaJ+wKrKn3xh+beNP8cgCM8TziSizeiFW1h0km0=;
        b=hj/Je6QNiOQD3Vo31HqIkmAq8G7aj3+DwCD++ln/Sj1s8trxPm7If/AaJParE4jmQz
         Fj2OZjAqGCogxHi/zq+/PrdUqam5xDz8vP876WUmJPQorkK7OO407VQC1WF6ccJM7ILx
         rtWCwx1SAhNEpTaXAFNkdn5RRS9k3aC1guFNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eTW0kIZLo7S/+14sG533/R+l4BG9Thh3kGaerJZkbLy0mo4ACn/UUZXFyiR4eNm0Nf
         8VIkVkv62pAElyvX+PNgEcIuKGKXxdv+JBF1VHEc1Bf7tdD3fmtgjMOn28OCKda/41Tf
         4vghznP9xVIOrFLisQ/evW1HoW1UzGr34DTqk=
Received: by 10.68.21.130 with SMTP id v2mr692620pbe.338.1307518198137;
        Wed, 08 Jun 2011 00:29:58 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.56
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175315>

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
---
 merge-recursive.c                 |   70 +++++++++++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh |   17 +++++----
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 749e501..4c42838 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -983,17 +983,36 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
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
@@ -1008,12 +1027,12 @@ static int process_renames(struct merge_options *o,
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
 		string_list_insert(&a_by_dst, sre->pair->two->path)->util
-			= sre->dst_entry;
+			= (void*)sre;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
 		string_list_insert(&b_by_dst, sre->pair->two->path)->util
-			= sre->dst_entry;
+			= (void*)sre;
 	}
 
 	for (i = 0, j = 0; i < a_renames->nr || j < b_renames->nr;) {
@@ -1125,6 +1144,23 @@ static int process_renames(struct merge_options *o,
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
@@ -1165,16 +1201,6 @@ static int process_renames(struct merge_options *o,
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
index dea2a65..8d1d303 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -60,13 +60,13 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
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
 
@@ -139,11 +139,12 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
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
1.7.6.rc0.62.g2d69f
