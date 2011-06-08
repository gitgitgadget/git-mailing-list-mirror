From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 33/48] merge-recursive: Improve handling of rename target vs. directory addition
Date: Wed,  8 Jun 2011 01:31:03 -0600
Message-ID: <1307518278-23814-34-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDP-0005pC-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab1FHHaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab1FHHaC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:02 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=tEID0C1caWu8ujr5xcHdl16TY3yuxRkPxakJGq8p2O8=;
        b=kOWFixG5OgqPb1UANqZD4QHVrsEwp+J0lJSI89ZjEvKQSkLRkiB4RUhA/G4tj4NNas
         qeHppfXfsZEMRETISLqJ4y3W2vb0wEbLDD2vIzxWhrE0dAA3JODvqZDGra1S4jVIYf/y
         is/qO1bxsdGdHbtleZiTirJgQFCoJ5j5MlYeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HGyiLRJ1F6+FL7pjVLEwrC9VXiH3ffAs/tW4AqTtCm2yU4hDIiiKht9Ph5qcG7H+d8
         uTLup9LntPJUzsEENCKHZS1z+EsMtj2S0op45KgC4PNdop752zwyYobE+cNGIllBT7Cj
         g+wGw7rYuw4sd8mY1OXy6eJgLT7vmzr/KPS9Q=
Received: by 10.68.21.231 with SMTP id y7mr592054pbe.493.1307518202562;
        Wed, 08 Jun 2011 00:30:02 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.00
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175313>

When dealing with file merging and renames and D/F conflicts and possible
criss-cross merges (how's that for a corner case?), we did not do a
thorough job ensuring the index and working directory had the correct
contents.   Fix the logic in merge_content() to handle this.  Also,
correct some erroneous tests in t6022 that were expecting the wrong number
of unmerged index entries.  These changes fix one of the tests in t6039
(and almost fix another one from t6039 as well).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    |   27 ++++++++++++++++++++++-----
 t/t6022-merge-rename.sh              |    4 ++--
 t/t6039-merge-rename-corner-cases.sh |    2 +-
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5ccc59c..e6a97b2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1370,19 +1370,34 @@ static int merge_content(struct merge_options *o,
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
@@ -1574,6 +1589,8 @@ static int process_df_entry(struct merge_options *o,
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
+			if (o->call_depth)
+				remove_file_from_cache(path);
 			update_file(o, 0, sha, mode, new_path);
 			if (o->call_depth)
 				remove_file_from_cache(path);
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 5e2a686..cd1e8fb 100755
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
diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index 4f94528..18e7821 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
@@ -234,7 +234,7 @@ test_expect_success 'setup content merge + rename/directory conflict' '
 	git commit -m left
 '
 
-test_expect_failure 'rename/directory conflict + clean content merge' '
+test_expect_success 'rename/directory conflict + clean content merge' '
 	git reset --hard &&
 	git reset --hard &&
 	git clean -fdqx &&
-- 
1.7.6.rc0.62.g2d69f
