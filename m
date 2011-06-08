From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 36/48] merge-recursive: Provide more info in conflict markers with file renames
Date: Wed,  8 Jun 2011 01:31:06 -0600
Message-ID: <1307518278-23814-37-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEi-0006q0-1J
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab1FHHaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1FHHaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:08 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=AoiHbWxM0FoDOsVJ0g0VJ2IYHzmge26iaskSNPLmrJ4=;
        b=Gw98ncWYSIQZ6X7ynrdSwRQhECVlRahR4PvwV7offBi8PClT3ooL1Vyofu1ZF8Weo7
         XTxyawnMvXrHAGJkohX3k+pzQGokCYYD06R/6O8o67F6qQWcu76L0fjUcec3tGWSjsNm
         RpThvyuryGzniDDGmLPs10KV1wbLOlSA8zbec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m2FBJzidCvy1LOc38df3vfsaYyHWg3NAsDqAKfr0im5iVAke4PHl038RHfXdkFPnWT
         OuOsyxL6/fkF5H+ZxU94l/JTbGzSQ203ru5rPlFY+D0f6vOAsCvcDiqM537AbfO08VKQ
         ILaifU7LjySAQd/17oviWarxmL86A3hKZM0dI=
Received: by 10.68.21.130 with SMTP id v2mr692670pbe.338.1307518208521;
        Wed, 08 Jun 2011 00:30:08 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.06
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175320>

Whenever there are merge conflicts in file contents, we would mark the
different sides of the conflict with the two branches being merged.
However, when there is a rename involved as well, the branchname is not
sufficient to specify where the conflicting content came from.  In such
cases, mark the two sides of the conflict with branchname:filename rather
than just branchname.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    |   20 +++++++++++++++++---
 t/t6022-merge-rename.sh              |    8 ++++----
 t/t6039-merge-rename-corner-cases.sh |    2 +-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5d0a62c..da507a3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1340,6 +1340,7 @@ static int merge_content(struct merge_options *o,
 			 struct rename_conflict_info *rename_conflict_info)
 {
 	const char *reason = "content";
+	char *side1 = NULL, *side2 = NULL;
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
@@ -1356,10 +1357,23 @@ static int merge_content(struct merge_options *o,
 	hashcpy(b.sha1, b_sha);
 	b.mode = b_mode;
 
-	mfi = merge_file(o, &one, &a, &b, o->branch1, o->branch2);
-	if (rename_conflict_info && dir_in_way(path, !o->call_depth)) {
-		df_conflict_remains = 1;
+	if (rename_conflict_info) {
+		const char *path1 = rename_conflict_info->pair2 ?
+				    rename_conflict_info->pair2->one->path : path;
+		const char *path2 = rename_conflict_info->pair1 ?
+				    rename_conflict_info->pair1->one->path : path;
+		side1 = xmalloc(strlen(o->branch1) + strlen(path1) + 2);
+		side2 = xmalloc(strlen(o->branch2) + strlen(path2) + 2);
+		sprintf(side1, "%s:%s", o->branch1, path1);
+		sprintf(side2, "%s:%s", o->branch2, path2);
+
+		if (dir_in_way(path, !o->call_depth))
+			df_conflict_remains = 1;
 	}
+	mfi = merge_file(o, &one, &a, &b,
+			 side1 ? side1:o->branch1, side2 ? side2:o->branch2);
+	free(side1);
+	free(side2);
 
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a.mode &&
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index cd1e8fb..cfce3d3 100755
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
+<<<<<<< HEAD:dir
 11
 =======
 12
->>>>>>> renamed-file-has-conflicts
+>>>>>>> renamed-file-has-conflicts:sub/file
 EOF
 
 test_expect_success 'Same as previous, but merged other way' '
diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index 18e7821..4d2fd10 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -258,7 +258,7 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 	test -f newfile~HEAD
 '
 
-test_expect_failure 'rename/directory conflict + content merge conflict' '
+test_expect_success 'rename/directory conflict + content merge conflict' '
 	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
-- 
1.7.6.rc0.62.g2d69f
