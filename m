From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 33/56] merge-recursive: Improve handling of rename target vs. directory addition
Date: Thu, 11 Aug 2011 23:20:06 -0600
Message-ID: <1313126429-17368-34-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkD3-0005ix-JQ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab1HLFVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:55 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab1HLFVk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:40 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VH6DjzHnUpno7F7YDFjV0lbebmwykG8/sEMh8/4D7b4=;
        b=YYH52pM69H/2tUNHRMwbFo/PBxhuEOATnaOdD+p3NA+xFov73kbWEeKIrsG1FFdAfJ
         rOt6Z9i1WcQlBqyF95dDHlrLfGCJyq2La/sauiq3LR4JOyeD7JjEvnVwFkXXujxOFymP
         EUt3bpszhRZHufRSkQAGM6aFCl93wA3ooOxmU=
Received: by 10.231.24.7 with SMTP id t7mr1134532ibb.31.1313126499893;
        Thu, 11 Aug 2011 22:21:39 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.38
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179201>

When dealing with file merging and renames and D/F conflicts and possible
criss-cross merges (how's that for a corner case?), we did not do a
thorough job ensuring the index and working directory had the correct
contents.   Fix the logic in merge_content() to handle this.  Also,
correct some erroneous tests in t6022 that were expecting the wrong number
of unmerged index entries.  These changes fix one of the tests in t6042
(and almost fix another one from t6042 as well).

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                    |   27 ++++++++++++++++++++++-----
 t/t6022-merge-rename.sh              |    4 ++--
 t/t6042-merge-rename-corner-cases.sh |    2 +-
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5f28905..f1160d5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1381,19 +1381,34 @@ static int merge_content(struct merge_options *o,
 			reason = "submodule";
 		output(o, 1, "CONFLICT (%s): Merge conflict in %s",
 				reason, path);
-		if (involved_in_rename)
+		if (involved_in_rename && !df_conflict_remains)
 			update_stages(path, &one, &a, &b);
 	}
 
 	if (df_conflict_remains) {
 		char *new_path;
-		update_file_flags(o, mfi.sha, mfi.mode, path,
-				  o->call_depth || mfi.clean, 0);
+		if (o->call_depth) {
+			remove_file_from_cache(path);
+		} else {
+			if (!mfi.clean)
+				update_stages(path, &one, &a, &b);
+			else {
+				int file_from_stage2 = was_tracked(path);
+				struct diff_filespec merged;
+				hashcpy(merged.sha1, mfi.sha);
+				merged.mode = mfi.mode;
+
+				update_stages(path, NULL,
+					      file_from_stage2 ? &merged : NULL,
+					      file_from_stage2 ? NULL : &merged);
+			}
+
+		}
 		new_path = unique_path(o, path, df_rename_conflict_branch);
-		mfi.clean = 0;
 		output(o, 1, "Adding as %s instead", new_path);
-		update_file_flags(o, mfi.sha, mfi.mode, new_path, 0, 1);
+		update_file(o, 0, mfi.sha, mfi.mode, new_path);
 		free(new_path);
+		mfi.clean = 0;
 	} else {
 		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
 	}
@@ -1582,6 +1597,8 @@ static int process_df_entry(struct merge_options *o,
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
+			if (o->call_depth)
+				remove_file_from_cache(path);
 			update_file(o, 0, sha, mode, new_path);
 			if (o->call_depth)
 				remove_file_from_cache(path);
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 6ff4bd2..fcc1d4c 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -307,7 +307,7 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~HEAD instead" output &&
 
-	test 2 -eq "$(git ls-files -u | wc -l)" &&
+	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
@@ -329,7 +329,7 @@ test_expect_success 'Same as previous, but merged other way' '
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
 
-	test 2 -eq "$(git ls-files -u | wc -l)" &&
+	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
 
 	test_must_fail git diff --quiet &&
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 668ec6d..968055d 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -234,7 +234,7 @@ test_expect_success 'setup content merge + rename/directory conflict' '
 	git commit -m left
 '
 
-test_expect_failure 'rename/directory conflict + clean content merge' '
+test_expect_success 'rename/directory conflict + clean content merge' '
 	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
-- 
1.7.6.100.gac5c1
