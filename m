From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 44/48] merge-recursive: Consider modifications in rename/rename(2to1) conflicts
Date: Wed,  8 Jun 2011 01:31:14 -0600
Message-ID: <1307518278-23814-45-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEl-0006q0-6m
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab1FHHa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHHaY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:24 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=U4SySINdgNaDSMhXcFMA4u4qapUN6WTWIvYS3Bs/kbg=;
        b=gQpyUHKEQoqJrHpvirqf8jfGz6mOV9HAM6pwPQGS00KJX2rn+D1QTuOuQ3hWCOWAT3
         kLH36PsIm3gxBubQ8qjSOqJAnyGRsPN8cXRt4vdE5YKnOGWecDtfDjVGN96ChDkSq0Ck
         Q4Pf8RUaP1GLGZ9h9nSZrzmOY1Cdx19Z6AMfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=s1lkJt+iKiWw46OnSn3o7uyfUxpj6Thk4gOyGaNw+f+hl4WbtrGLdfTfRGEJk93ohA
         1YJWZ37lL9LJqEoQwzxlaDIvpH5Afa6LoTARAIl9YwOvekJO6ceXiDEv2KRfAMTl0bRJ
         QG7z4hwVisjX9Leb07fJChJN5z7eDQK9Zt3vM=
Received: by 10.68.0.99 with SMTP id 3mr614451pbd.375.1307518223833;
        Wed, 08 Jun 2011 00:30:23 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.21
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175325>

Our previous conflict resolution for renaming two different files to the
same name ignored the fact that each of those files may have modifications
from both sides of history to consider.  We need to do a three-way merge
for each of those files, and then handle the conflict of both sets of
merged contents trying to be recorded with the same name.

It is important to note that this changes our strategy in the recursive
case.  After doing a three-way content merge of each of the files
involved, we still are faced with the fact that we are trying to put both
of the results (including conflict markers) into the same path.  We could
do another two-way merge, but I think that becomes confusing.  Also,
taking a hint from the modify/delete and rename/delete cases we handled
earlier, a more useful "common ground" would be to keep the three-way
content merge but record it with the original filename.  The renames can
still be detected, we just allow it to be done in the o->call_depth=0
case.  This seems to result in simpler & easier to understand merge
conflicts as well, as evidenced by some of the changes needed in our
testsuite in t6036.  (However, it should be noted that this change will
cause problems those renames also occur along with a file being added
whose name matches the source of the rename.  Since git currently cannot
detect rename/add-source situations, though, this codepath is not
currently used for those cases anyway.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    |   30 ++++++++++++++++++--------
 t/t6036-recursive-corner-cases.sh    |   38 +++++++++-------------------------
 t/t6039-merge-rename-corner-cases.sh |    2 +-
 3 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b8fd686..ea538e9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1068,6 +1068,8 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	struct diff_filespec *c1 = ci->pair1->two;
 	struct diff_filespec *c2 = ci->pair2->two;
 	char *path = c1->path; /* == c2->path */
+	struct merge_file_info mfi_c1;
+	struct merge_file_info mfi_c2;
 
 	output(o, 1, "CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1078,22 +1080,32 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, would_lose_untracked(b->path));
 
+	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
+					    o->branch1, c1->path,
+					    o->branch2, ci->ren1_other.path);
+	mfi_c2 = merge_file_special_markers(o, b, &ci->ren2_other, c2,
+					    o->branch1, ci->ren2_other.path,
+					    o->branch2, c2->path);
+
 	if (o->call_depth) {
-		struct merge_file_info mfi;
-		mfi = merge_file(o, path, null_sha1, 0,
-				 c1->sha1, c1->mode,
-				 c2->sha1, c2->mode,
-				 ci->branch1, ci->branch2);
-		output(o, 1, "Adding merged %s", path);
-		update_file(o, 0, mfi.sha, mfi.mode, path);
+		/*
+		 * If mfi_c1.clean && mfi_c2.clean, then it might make
+		 * sense to do a two-way merge of those results.  But, I
+		 * think in all cases, it makes sense to have the virtual
+		 * merge base just undo the renames; they can be detected
+		 * again later for the non-recursive merge.
+		 */
+		remove_file(o, 0, path, 0);
+		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, a->path);
+		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, b->path);
 	} else {
 		char *new_path1 = unique_path(o, path, ci->branch1);
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, "Renaming %s to %s and %s to %s instead",
 		       a->path, new_path1, b->path, new_path2);
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, c1->sha1, c1->mode, new_path1);
-		update_file(o, 0, c2->sha1, c2->mode, new_path2);
+		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
+		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, new_path2);
 		free(new_path2);
 		free(new_path1);
 	}
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index a1b609f..5c3868a 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -51,23 +51,15 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 
 	test_must_fail git merge -s recursive R2^0 &&
 
-	test 5 = $(git ls-files -s | wc -l) &&
-	test 3 = $(git ls-files -u | wc -l) &&
-	test 0 = $(git ls-files -o | wc -l) &&
+	test 2 = $(git ls-files -s | wc -l) &&
+	test 2 = $(git ls-files -u | wc -l) &&
+	test 2 = $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse :0:one) = $(git rev-parse L2:one) &&
-	test $(git rev-parse :0:two) = $(git rev-parse R2:two) &&
 	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
 	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
 
-	cp one merged &&
-	>empty &&
-	test_must_fail git merge-file \
-		-L "Temporary merge branch 1" \
-		-L "" \
-		-L "Temporary merge branch 2" \
-		merged empty two &&
-	test $(git rev-parse :1:three) = $(git hash-object merged)
+	test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
+	test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
 '
 
 #
@@ -126,25 +118,15 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 
 	test_must_fail git merge -s recursive R2^0 &&
 
-	test 5 = $(git ls-files -s | wc -l) &&
-	test 3 = $(git ls-files -u | wc -l) &&
-	test 0 = $(git ls-files -o | wc -l) &&
+	test 2 = $(git ls-files -s | wc -l) &&
+	test 2 = $(git ls-files -u | wc -l) &&
+	test 2 = $(git ls-files -o | wc -l) &&
 
-	test $(git rev-parse :0:one) = $(git rev-parse L2:one) &&
-	test $(git rev-parse :0:two) = $(git rev-parse R2:two) &&
 	test $(git rev-parse :2:three) = $(git rev-parse L2:three) &&
 	test $(git rev-parse :3:three) = $(git rev-parse R2:three) &&
 
-	head -n 10 two >merged &&
-	cp one merge-me &&
-	>empty &&
-	test_must_fail git merge-file \
-		-L "Temporary merge branch 1" \
-		-L "" \
-		-L "Temporary merge branch 2" \
-		merge-me empty merged &&
-
-	test $(git rev-parse :1:three) = $(git hash-object merge-me)
+	test $(git rev-parse L2:three) = $(git hash-object three~HEAD) &&
+	test $(git rev-parse R2:three) = $(git hash-object three~R2^0)
 '
 
 #
diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index 4d2fd10..86e96d0 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -524,7 +524,7 @@ test_expect_success 'setup rename/rename (2to1) + modify/modify' '
 	git commit -m C
 '
 
-test_expect_failure 'handle rename/rename (2to1) conflict correctly' '
+test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 	git checkout B^0 &&
 
 	test_must_fail git merge -s recursive C^0 >out &&
-- 
1.7.6.rc0.62.g2d69f
