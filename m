From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 54/56] merge-recursive: Avoid unnecessary file rewrites
Date: Thu, 11 Aug 2011 23:20:27 -0600
Message-ID: <1313126429-17368-55-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD6-0005ix-Gv
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab1HLFWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:33 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab1HLFWb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:31 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VSzkWwbcrkbh3xyHRjJISX/UxvjvvaGI8i8zwHBMtVU=;
        b=Kpscl/PxR5nyGoBo7R4e23aJprQR9/tXryyfbKCvyZxuHt3z4Ohl4Wh3A8JlJTgUKz
         QkEK3HWmQa539uuP7dMCXQlEY5z6+WwBzycL/RS8cj/EAnl3P8nZ0u/scjbto/fjvqym
         6+fqph7mKsJGv3J0LgnghKX8xDyAbBcQTuqZE=
Received: by 10.231.3.129 with SMTP id 1mr1113072ibn.42.1313126550837;
        Thu, 11 Aug 2011 22:22:30 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.29
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179208>

Often times, a potential conflict at a path is resolved by merge-recursive
by using the content that was already present at that location.  In such
cases, we do not want to overwrite the content that is already present, as
that could trigger unnecessary recompilations.  One of the patches earlier
in this series ("merge-recursive: When we detect we can skip an update,
actually skip it") fixed the cases that involved content merges, but there
were a few other cases as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Completely new patch (about a problem that existed previous to v1, but which
I hadn't noticed).

 merge-recursive.c       |   30 ++++++++++++++++++++++++------
 t/t6022-merge-rename.sh |    6 +++---
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b2deb53..f088132 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1038,7 +1038,14 @@ static void handle_change_delete(struct merge_options *o,
 		       change_past, o->branch1, o->branch1, path,
 		       NULL == renamed ? "" : " at ",
 		       NULL == renamed ? "" : renamed);
-		update_file(o, 0, a_sha, a_mode, renamed ? renamed : path);
+		if (renamed)
+			update_file(o, 0, a_sha, a_mode, renamed);
+		/*
+		 * No need to call update_file() on path when !renamed, since
+		 * that would needlessly touch path.  We could call
+		 * update_file_flags() with update_cache=0 and update_wd=0,
+		 * but that's a no-op.
+		 */
 	}
 	free(renamed);
 }
@@ -1398,10 +1405,20 @@ static int process_renames(struct merge_options *o,
 							   NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
-				/* Added file on the other side
-				   identical to the file being
-				   renamed: clean merge */
-				update_file(o, 1, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
+				/*
+				 * Added file on the other side identical to
+				 * the file being renamed: clean merge.
+				 * Also, there is no need to overwrite the
+				 * file already in the working copy, so call
+				 * update_file_flags() instead of
+				 * update_file().
+				 */
+				update_file_flags(o,
+						  ren1->pair->two->sha1,
+						  ren1->pair->two->mode,
+						  ren1_dst,
+						  1, /* update_cache */
+						  0  /* update_wd    */);
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
 				clean_merge = 0;
 				try_merge = 1;
@@ -1729,7 +1746,8 @@ static int process_entry(struct merge_options *o,
 			free(new_path);
 		} else {
 			output(o, 2, "Adding %s", path);
-			update_file(o, 1, sha, mode, path);
+			/* do not overwrite file if already present */
+			update_file_flags(o, sha, mode, path, 1, !a_sha);
 		}
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index c2993fc..9d8584e 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -696,7 +696,7 @@ test_expect_success 'setup avoid unnecessary update, dir->(file,nothing)' '
 	git commit -m "Add a newfile"
 '
 
-test_expect_failure 'avoid unnecessary update, dir->(file,nothing)' '
+test_expect_success 'avoid unnecessary update, dir->(file,nothing)' '
 	git checkout -q master^0 &&
 	test-chmtime =1000000000 df &&
 	test-chmtime -v +0 df >expect &&
@@ -726,7 +726,7 @@ test_expect_success 'setup avoid unnecessary update, modify/delete' '
 	git commit -m "Modify file"
 '
 
-test_expect_failure 'avoid unnecessary update, modify/delete' '
+test_expect_success 'avoid unnecessary update, modify/delete' '
 	git checkout -q master^0 &&
 	test-chmtime =1000000000 file &&
 	test-chmtime -v +0 file >expect &&
@@ -755,7 +755,7 @@ test_expect_success 'setup avoid unnecessary update, rename/add-dest' '
 	git commit -m "Rename file"
 '
 
-test_expect_failure 'avoid unnecessary update, rename/add-dest' '
+test_expect_success 'avoid unnecessary update, rename/add-dest' '
 	git checkout -q master^0 &&
 	test-chmtime =1000000000 newfile &&
 	test-chmtime -v +0 newfile >expect &&
-- 
1.7.6.100.gac5c1
