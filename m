Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 263142022A
	for <e@80x24.org>; Mon,  7 Nov 2016 18:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbcKGSbr (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 13:31:47 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:57983 "EHLO
        homiemail-a22.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932791AbcKGSbq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2016 13:31:46 -0500
Received: from homiemail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTP id 378F711406E;
        Mon,  7 Nov 2016 10:31:45 -0800 (PST)
Received: from localhost.localdomain (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id B823F11406C;
        Mon,  7 Nov 2016 10:31:44 -0800 (PST)
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, sbeller@google.com
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH] submodules: allow empty working-tree dirs in merge/cherry-pick
Date:   Mon,  7 Nov 2016 13:31:31 -0500
Message-Id: <1478543491-6286-1-git-send-email-dturner@twosigma.com>
X-Mailer: git-send-email 2.8.0.rc4.22.g8ae061a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a submodule is being merged or cherry-picked into a working
tree that already contains a corresponding empty directory, do not
record a conflict.

One situation where this bug appears is:

- Commit 1 adds a submodule
- Commit 2 removes that submodule and re-adds it into a subdirectory
       (sub1 to sub1/sub1).
- Commit 3 adds an unrelated file.

Now the user checks out commit 1 (first deinitializing the submodule),
and attempts to cherry-pick commit 3.  Previously, this would fail,
because the incoming submodule sub1/sub1 would falsely conflict with
the empty sub1 directory.

This patch ignores the empty sub1 directory, fixing the bug.  We only
ignore the empty directory if the object being emplaced is a
submodule, which expects an empty directory.

Signed-off-by: David Turner <dturner@twosigma.com>
---
 merge-recursive.c           | 21 +++++++++++++++------
 t/t3030-merge-recursive.sh  |  4 ++--
 t/t3426-rebase-submodule.sh |  3 ---
 3 files changed, 17 insertions(+), 11 deletions(-)

Note that there are four calls to dir_in_way, and only two of them
have changed their semantics.  This is because the merge code is quite
complicated, and I don't fully understand it.  So I did not have time
to analyze the remaining calls to see whether they, too, should be
changed.  For me, there are no test failures either way, indicating
that probably these cases are rare.

The reason behind the empty_ok parameter (as opposed to just always
allowing empy directories to be blown away) is found in t6022's 'pair
rename to parent of other (D/F conflicts) w/ untracked dir'.  This
test would fail with an unconditional rename, because it wouldn't
generate the conflict file.  It's not clear how important that
behavior is (I do not recall ever noticing the file~branch thing
before), but it seemed better to preserve it in case it was important.

diff --git a/merge-recursive.c b/merge-recursive.c
index 9041c2f..e64b48b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -664,7 +664,13 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	return strbuf_detach(&newpath, NULL);
 }
 
-static int dir_in_way(const char *path, int check_working_copy)
+/**
+ * Check whether a directory in the index is in the way of an incoming
+ * file.  Return 1 if so.  If check_working_copy is non-zero, also
+ * check the working directory.  If empty_ok is non-zero, also return
+ * 0 in the case where the working-tree dir exists but is empty.
+ */
+static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 {
 	int pos;
 	struct strbuf dirpath = STRBUF_INIT;
@@ -684,7 +690,8 @@ static int dir_in_way(const char *path, int check_working_copy)
 	}
 
 	strbuf_release(&dirpath);
-	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode);
+	return check_working_copy && !lstat(path, &st) && S_ISDIR(st.st_mode) &&
+		!(empty_ok && is_empty_dir(path));
 }
 
 static int was_tracked(const char *path)
@@ -1062,7 +1069,7 @@ static int handle_change_delete(struct merge_options *o,
 {
 	char *renamed = NULL;
 	int ret = 0;
-	if (dir_in_way(path, !o->call_depth)) {
+	if (dir_in_way(path, !o->call_depth, 0)) {
 		renamed = unique_path(o, path, a_oid ? o->branch1 : o->branch2);
 	}
 
@@ -1195,7 +1202,7 @@ static int handle_file(struct merge_options *o,
 		remove_file(o, 0, rename->path, 0);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
-		if (dir_in_way(rename->path, !o->call_depth)) {
+		if (dir_in_way(rename->path, !o->call_depth, 0)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
@@ -1704,7 +1711,8 @@ static int merge_content(struct merge_options *o,
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 
-		if (dir_in_way(path, !o->call_depth))
+		if (dir_in_way(path, !o->call_depth,
+			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
 	if (merge_file_special_markers(o, &one, &a, &b,
@@ -1862,7 +1870,8 @@ static int process_entry(struct merge_options *o,
 			oid = b_oid;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path, !o->call_depth)) {
+		if (dir_in_way(path, !o->call_depth,
+			       S_ISGITLINK(a_mode))) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 470f334..be074a1 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -575,13 +575,13 @@ test_expect_success 'merge removes empty directories' '
 	test_must_fail test -d d
 '
 
-test_expect_failure 'merge-recursive simple w/submodule' '
+test_expect_success 'merge-recursive simple w/submodule' '
 
 	git checkout submod &&
 	git merge remove
 '
 
-test_expect_failure 'merge-recursive simple w/submodule result' '
+test_expect_sucess 'merge-recursive simple w/submodule result' '
 
 	git ls-files -s >actual &&
 	(
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index d5b896d..ebf4f5e 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -38,9 +38,6 @@ git_rebase_interactive () {
 	git rebase -i "$1"
 }
 
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-# The real reason "replace directory with submodule" fails is because a
-# directory "sub1" exists, but we reuse the suppression added for merge here
 test_submodule_switch "git_rebase_interactive"
 
 test_done
-- 
2.8.0.rc4.22.g8ae061a

