From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 36/56] merge-recursive: Provide more info in conflict markers with file renames
Date: Thu, 11 Aug 2011 23:20:09 -0600
Message-ID: <1313126429-17368-37-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCK-0005Kt-Lw
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab1HLFV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:57 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1HLFV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:56 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=j8T8DaAXFEelY8WrxK0lzbyiqfJWfCZPA8SOPWYmZx4=;
        b=xEJu3K0awAHmmLqvfFrZbTW9jMmzKdEGXIZZdD4/NSvUiVsleFjmt6fv6tPzDdjSZ0
         NSlv2ByvWjqMqXFTzKKDVIqf0WK1oVLHBCoGTlRIhc74f7ZnhGGD1TFwXMzvzDp7SdyG
         loXfr0RYpUFMZF91WULroAFWzpVWcUvpGymCE=
Received: by 10.42.157.5 with SMTP id b5mr494187icx.442.1313126516286;
        Thu, 11 Aug 2011 22:21:56 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.44
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179191>

Whenever there are merge conflicts in file contents, we would mark the
different sides of the conflict with the two branches being merged.
However, when there is a rename involved as well, the branchname is not
sufficient to specify where the conflicting content came from.  In such
cases, mark the two sides of the conflict with branchname:filename rather
than just branchname.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v1: Fix bug where I could get filenames from two
  branches reversed depending on the direction of the merge.

 merge-recursive.c                    |   28 +++++++++++-
 t/t6022-merge-rename.sh              |   75 ++++++++++++++++++++++++++++++++--
 t/t6042-merge-rename-corner-cases.sh |    2 +-
 3 files changed, 97 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0635e1b..bc99f1a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1355,6 +1355,7 @@ static int merge_content(struct merge_options *o,
 			 struct rename_conflict_info *rename_conflict_info)
 {
 	const char *reason = "content";
+	char *side1 = NULL, *side2 = NULL;
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
@@ -1371,10 +1372,31 @@ static int merge_content(struct merge_options *o,
 	hashcpy(b.sha1, b_sha);
 	b.mode = b_mode;
 
-	mfi = merge_file(o, &one, &a, &b, o->branch1, o->branch2);
-	if (rename_conflict_info && dir_in_way(path, !o->call_depth)) {
-		df_conflict_remains = 1;
+	if (rename_conflict_info) {
+		const char *path1, *path2;
+		struct diff_filepair *pair1 = rename_conflict_info->pair1;
+
+		path1 = (o->branch1 == rename_conflict_info->branch1) ?
+			pair1->two->path : pair1->one->path;
+		/* If rename_conflict_info->pair2 != NULL, we are in
+		 * RENAME_ONE_FILE_TO_ONE case.  Otherwise, we have a
+		 * normal rename.
+		 */
+		path2 = (rename_conflict_info->pair2 ||
+			 o->branch2 == rename_conflict_info->branch1) ?
+			pair1->two->path : pair1->one->path;
+		side1 = xmalloc(strlen(o->branch1) + strlen(path1) + 2);
+		side2 = xmalloc(strlen(o->branch2) + strlen(path2) + 2);
+		sprintf(side1, "%s:%s", o->branch1, path1);
+		sprintf(side2, "%s:%s", o->branch2, path2);
+
+		if (dir_in_way(path, !o->call_depth))
+			df_conflict_remains = 1;
 	}
+	mfi = merge_file(o, &one, &a, &b,
+			 side1 ? side1 : o->branch1, side2 ? side2 : o->branch2);
+	free(side1);
+	free(side2);
 
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode)
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index fcc1d4c..4695cbc 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -351,11 +351,11 @@ cat >expected <<\EOF &&
 8
 9
 10
-<<<<<<< HEAD
+<<<<<<< HEAD:dir
 12
 =======
 11
->>>>>>> dir-not-in-way
+>>>>>>> dir-not-in-way:sub/file
 EOF
 
 test_expect_success 'Rename+D/F conflict; renamed file cannot merge, dir not in way' '
@@ -405,11 +405,11 @@ cat >expected <<\EOF &&
 8
 9
 10
-<<<<<<< HEAD
+<<<<<<< HEAD:sub/file
 11
 =======
 12
->>>>>>> renamed-file-has-conflicts
+>>>>>>> renamed-file-has-conflicts:dir
 EOF
 
 test_expect_success 'Same as previous, but merged other way' '
@@ -700,4 +700,71 @@ test_expect_success 'merge rename + small change' '
 	test $(git rev-parse HEAD:renamed_file) = $(git rev-parse HEAD~1:file)
 '
 
+test_expect_success 'setup for use of extended merge markers' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n" >original_file &&
+	git add original_file &&
+	git commit -mA &&
+
+	git checkout -b rename &&
+	echo 9 >>original_file &&
+	git add original_file &&
+	git mv original_file renamed_file &&
+	git commit -mB &&
+
+	git checkout master &&
+	echo 8.5 >>original_file &&
+	git add original_file &&
+	git commit -mC
+'
+
+cat >expected <<\EOF &&
+1
+2
+3
+4
+5
+6
+7
+8
+<<<<<<< HEAD:renamed_file
+9
+=======
+8.5
+>>>>>>> master^0:original_file
+EOF
+
+test_expect_success 'merge master into rename has correct extended markers' '
+	git checkout rename^0 &&
+	test_must_fail git merge -s recursive master^0 &&
+	test_cmp expected renamed_file
+'
+
+cat >expected <<\EOF &&
+1
+2
+3
+4
+5
+6
+7
+8
+<<<<<<< HEAD:original_file
+8.5
+=======
+9
+>>>>>>> rename^0:renamed_file
+EOF
+
+test_expect_success 'merge rename into master has correct extended markers' '
+	git reset --hard &&
+	git checkout master^0 &&
+	test_must_fail git merge -s recursive rename^0 &&
+	test_cmp expected renamed_file
+'
+
 test_done
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 968055d..bfc3179 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -258,7 +258,7 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 	test -f newfile~HEAD
 '
 
-test_expect_failure 'rename/directory conflict + content merge conflict' '
+test_expect_success 'rename/directory conflict + content merge conflict' '
 	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
-- 
1.7.6.100.gac5c1
