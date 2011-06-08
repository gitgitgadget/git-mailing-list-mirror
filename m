From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 45/48] merge-recursive: Make modify/delete handling code reusable
Date: Wed,  8 Jun 2011 01:31:15 -0600
Message-ID: <1307518278-23814-46-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEo-0006q0-0C
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab1FHHav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:30:51 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:37577 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab1FHHaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:25 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so191910pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0s6VQ75/u8K1c2h+vrsgaCbqdspeYGIXawAjHgxHXs4=;
        b=aGfdOkQ9wPuRwTdlkv9v79zsMHKTur6VTUOTreZHNMLuISFSQGy0fLLtye1qYqB6DQ
         US8dEDxWt64qmUe+lrIYLuC2T+DWj5LUx3dhp87WG2ghFP1/Yq1oHJ+JkpuGxyccVtk8
         z6nQ0DdwWUp39+kCy+EQZCUMAOVr6vNaDeQQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=swyexLbVJLBcjifrk+y+bRhyOekj3mcuJzZwKPu9stDXgS38e9DgY8QKUmtdpr9b0n
         9bGwOPpwxbVld5WQptXLSMZ3rWHuFPz4Q6xhR79x8QKEeOcQYf/C2XxO+AF76iIhR3V6
         nz7qSiX8ldPPsu706DOhOKNTiAGzjhBdiYQK0=
Received: by 10.68.21.231 with SMTP id y7mr592194pbe.493.1307518225717;
        Wed, 08 Jun 2011 00:30:25 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.23
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175328>

modify/delete and rename/delete share a lot of similarities; we'd like all
the criss-cross and D/F conflict handling specializations to be shared
between the two.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c       |   89 +++++++++++++++++++++++++++-------------------
 t/t6022-merge-rename.sh |    4 +-
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ea538e9..e38c5b0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -979,6 +979,50 @@ static struct merge_file_info merge_file(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2);
 }
 
+static void handle_change_delete(struct merge_options *o,
+				 const char *path,
+				 const unsigned char *o_sha, int o_mode,
+				 const unsigned char *a_sha, int a_mode,
+				 const unsigned char *b_sha, int b_mode,
+				 const char *change, const char *change_past)
+{
+	char *new_path = NULL;
+	int free_me = 0;
+	if (dir_in_way(path, !o->call_depth)) {
+		new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+		free_me = 1;
+	}
+
+	if (o->call_depth) {
+		/*
+		 * We cannot arbitrarily accept either a_sha or b_sha as
+		 * correct; since there is no true "middle point" between
+		 * them, simply reuse the base version for virtual merge base.
+		 */
+		remove_file_from_cache(path);
+		update_file(o, 0, o_sha, o_mode, new_path ? new_path : path);
+	} else if (!a_sha) {
+		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
+		       "and %s in %s. Version %s of %s left in tree%s%s.",
+		       change, path, o->branch1,
+		       change_past, o->branch2, o->branch2, path,
+		       NULL == new_path ? "" : " at ",
+		       NULL == new_path ? "" : new_path);
+		update_file(o, 0, b_sha, b_mode, new_path ? new_path : path);
+	} else {
+		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
+		       "and %s in %s. Version %s of %s left in tree%s%s.",
+		       change, path, o->branch2,
+		       change_past, o->branch1, o->branch1, path,
+		       NULL == new_path ? "" : " at ",
+		       NULL == new_path ? "" : new_path);
+		update_file(o, 0, a_sha, a_mode, new_path ? new_path : path);
+	}
+	if (free_me)
+		free(new_path);
+
+}
+
 static void conflict_rename_delete(struct merge_options *o,
 				   struct diff_filepair *pair,
 				   const char *rename_branch,
@@ -1396,47 +1440,18 @@ error_return:
 	return ret;
 }
 
-static void handle_delete_modify(struct merge_options *o,
+static void handle_modify_delete(struct merge_options *o,
 				 const char *path,
 				 unsigned char *o_sha, int o_mode,
 				 unsigned char *a_sha, int a_mode,
 				 unsigned char *b_sha, int b_mode)
 {
-	char *new_path = NULL;
-	int free_me = 0;
-	if (dir_in_way(path, !o->call_depth)) {
-		new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
-		free_me = 1;
-	}
-
-	if (o->call_depth) {
-		/*
-		 * We cannot arbitrarily accept either a_sha or b_sha as
-		 * correct; since there is no true "middle point" between
-		 * them, simply reuse the base version for virtual merge base.
-		 */
-		remove_file_from_cache(path);
-		update_file(o, 0, o_sha, o_mode, new_path ? new_path : path);
-	} else if (!a_sha) {
-		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-		       "and modified in %s. Version %s of %s left in tree%s%s.",
-		       path, o->branch1,
-		       o->branch2, o->branch2, path,
-		       NULL == new_path ? "" : " at ",
-		       NULL == new_path ? "" : new_path);
-		update_file(o, 0, b_sha, b_mode, new_path ? new_path : path);
-	} else {
-		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-		       "and modified in %s. Version %s of %s left in tree%s%s.",
-		       path, o->branch2,
-		       o->branch1, o->branch1, path,
-		       NULL == new_path ? "" : " at ",
-		       NULL == new_path ? "" : new_path);
-		update_file(o, 0, a_sha, a_mode, new_path ? new_path : path);
-	}
-	if (free_me)
-		free(new_path);
-
+	handle_change_delete(o,
+			     path,
+			     o_sha, o_mode,
+			     a_sha, a_mode,
+			     b_sha, b_mode,
+			     "modify", "modified");
 }
 
 static int merge_content(struct merge_options *o,
@@ -1586,7 +1601,7 @@ static int process_entry(struct merge_options *o,
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			handle_delete_modify(o, path, o_sha, o_mode,
+			handle_modify_delete(o, path, o_sha, o_mode,
 					     a_sha, a_mode, b_sha, b_mode);
 		}
 	} else if ((!o_sha && a_sha && !b_sha) ||
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index cfce3d3..a1ed00b 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -303,7 +303,7 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	git checkout -q renamed-file-has-no-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way >output &&
 
-	grep "CONFLICT (delete/modify): dir/file-in-the-way" output &&
+	grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~HEAD instead" output &&
 
@@ -325,7 +325,7 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_must_fail git merge --strategy=recursive renamed-file-has-no-conflicts >output 2>errors &&
 
 	! grep "error: refusing to lose untracked file at" errors &&
-	grep "CONFLICT (delete/modify): dir/file-in-the-way" output &&
+	grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
 
-- 
1.7.6.rc0.62.g2d69f
