Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F9B1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 06:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeFCG6b (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 02:58:31 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41286 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751033AbeFCG6Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 02:58:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w536vSIi026810;
        Sat, 2 Jun 2018 23:58:14 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jbr4js7rx-1;
        Sat, 02 Jun 2018 23:58:13 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 9BD4E228A269;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 9246B2CDE66;
        Sat,  2 Jun 2018 23:58:13 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 6/7] merge-recursive: enforce rule that index matches head before merging
Date:   Sat,  2 Jun 2018 23:58:09 -0700
Message-Id: <20180603065810.23841-7-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.49.g3c08dc0fef
In-Reply-To: <20180603065810.23841-1-newren@gmail.com>
References: <20180603065810.23841-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-03_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806030084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

builtin/merge.c says that when we are about to perform a merge:

    ...the index must be in sync with the head commit.  The strategies are
    responsible to ensure this.

merge-recursive has always relied on unpack_trees() to enforce this
requirement, except in the case of an "Already up to date!" merge.
unpack-trees.c does not actually enforce this requirement, though.  It
allows for a pair of exceptions, in cases which it refers to as #14(ALT)
and #2ALT.  Documentation/technical/trivial-merge.txt can be consulted for
the precise meanings of the various case numbers and their meanings for
unpack-trees.c, but we have a high-level description of the intent behind
these two exceptions in a combined and summarized form in
Documentation/git-merge.txt:

    ...[merge will] abort if there are any changes registered in the index
    relative to the `HEAD` commit.  (One exception is when the changed index
    entries are in the state that would result from the merge already.)

While this high-level description does describe conditions under which it
would be safe to allow the index to diverge from HEAD, it does not match
what is actually implemented.  In particular, unpack-trees.c has no
knowledge of renames, and these two exceptions were written assuming that
no renames take place.  Once renames get into the mix, it is no longer
safe to allow the index to not match for #2ALT.  We could modify
unpack-trees to only allow #14(ALT) as an exception, but that would be
more strict than required for the resolve strategy (since the resolve
strategy doesn't handle renames at all).  Therefore, unpack_trees.c seems
like the wrong place to fix this.

Further, if someone fixes the combination of break and rename detection
and modifies merge-recursive to take advantage of the combination, then it
will also no longer be safe to allow the index to not match for #14(ALT)
when the recursive strategy is in use.  Therefore, leaving one of the
exceptions in place with the recursive merge strategy feels like we are
just leaving a latent bug in the code for folks in the future to stumble
across.

It may be possible to fix both unpack-trees and merge-recursive in a way
that implements the exception as stated in Documentation/git-merge.txt,
but it would be somewhat complex, possibly also buggy at first, and
ultimately, not all that valuable.  Instead, just enforce the requirement
stated in builtin/merge.c; error out if the index does not match the HEAD
commit, just like the 'ours' and 'octopus' strategies do.

Some testcase fixups were in order:
  t6044: We no longer expect stray staged changes to sometimes result
         in the merge continuing.  Also, fixes a case where a merge
         didn't abort but should have.
  t7504: had a few tests that had stray staged changes that were not
         actually part of the test under consideration
  t7611: had many tests designed to show that `git merge --abort` could
	 not always restore the index and working tree to the state they
	 were in before the merge started.  The tests that were associated
	 with having changes in the index before the merge started are no
         longer applicable, so they have been removed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                        |  14 +--
 t/t6044-merge-unrelated-index-changes.sh |  19 ++--
 t/t7504-commit-msg-hook.sh               |   4 +-
 t/t7611-merge-abort.sh                   | 118 -----------------------
 4 files changed, 18 insertions(+), 137 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 762aa087d0..4640b47a19 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3254,6 +3254,13 @@ int merge_trees(struct merge_options *o,
 		struct tree **result)
 {
 	int code, clean;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!o->call_depth && index_has_changes(&sb, head)) {
+		err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
+		    sb.buf);
+		return -1;
+	}
 
 	if (o->subtree_shift) {
 		merge = shift_tree_object(head, merge, o->subtree_shift);
@@ -3261,13 +3268,6 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
-		struct strbuf sb = STRBUF_INIT;
-
-		if (!o->call_depth && index_has_changes(&sb, head)) {
-			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
-			    sb.buf);
-			return -1;
-		}
 		output(o, 0, _("Already up to date!"));
 		*result = head;
 		return 1;
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index e609f14f87..6e0ecab9c0 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -137,7 +137,7 @@ test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	test_i18ngrep "Already up to date" out
 '
 
-test_expect_failure 'recursive, when file has staged changes not matching HEAD nor what a merge would give' '
+test_expect_success 'recursive, when file has staged changes not matching HEAD nor what a merge would give' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -145,14 +145,12 @@ test_expect_failure 'recursive, when file has staged changes not matching HEAD n
 	test_seq 1 10 >subdir/a &&
 	git add subdir/a &&
 
-	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
-	# Since subdir/a matches neither HEAD nor what the merge would write
-	# to that file, the merge should fail to avoid overwriting what is
-	# currently found in subdir/a
-	test_must_fail git merge -s recursive E^0
+	# We have staged changes; merge should error out
+	test_must_fail git merge -s recursive E^0 2>err &&
+	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
-test_expect_failure 'recursive, when file has staged changes matching what a merge would give' '
+test_expect_success 'recursive, when file has staged changes matching what a merge would give' '
 	git reset --hard &&
 	git checkout B^0 &&
 
@@ -160,10 +158,9 @@ test_expect_failure 'recursive, when file has staged changes matching what a mer
 	test_seq 1 11 >subdir/a &&
 	git add subdir/a &&
 
-	# HEAD has no subdir/a; merge would write 1..11 to subdir/a;
-	# Since subdir/a matches what the merge would write to that file,
-	# the merge should be safe to proceed
-	git merge -s recursive E^0
+	# We have staged changes; merge should error out
+	test_must_fail git merge -s recursive E^0 2>err &&
+	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
 test_expect_success 'octopus, unrelated file touched' '
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 302a3a2082..31b9c6a2c1 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -157,6 +157,7 @@ test_expect_success 'merge bypasses failing hook with --no-verify' '
 	test_when_finished "git branch -D newbranch" &&
 	test_when_finished "git checkout -f master" &&
 	git checkout --orphan newbranch &&
+	git rm -f file &&
 	: >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
@@ -168,7 +169,7 @@ test_expect_success 'merge bypasses failing hook with --no-verify' '
 chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
 
-	echo "content" >> file &&
+	echo "content" >file &&
 	git add file &&
 	git commit -m "content"
 
@@ -249,6 +250,7 @@ test_expect_success 'hook called in git-merge picks up commit message' '
 	test_when_finished "git branch -D newbranch" &&
 	test_when_finished "git checkout -f master" &&
 	git checkout --orphan newbranch &&
+	git rm -f file &&
 	: >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index 7b4798e8e4..7c84a518aa 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -187,31 +187,6 @@ test_expect_success 'Fail clean merge with matching dirty worktree' '
 	test_cmp expect actual
 '
 
-test_expect_success 'Abort clean merge with matching dirty index' '
-	git add bar &&
-	git diff --staged > expect &&
-	git merge --no-commit clean_branch &&
-	test -f .git/MERGE_HEAD &&
-	### When aborting the merge, git will discard all staged changes,
-	### including those that were staged pre-merge. In other words,
-	### --abort will LOSE any staged changes (the staged changes that
-	### are lost must match the merge result, or the merge would not
-	### have been allowed to start). Change expectations accordingly:
-	rm expect &&
-	touch expect &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff --staged > actual &&
-	test_cmp expect actual &&
-	test -z "$(git diff)"
-'
-
-test_expect_success 'Reset worktree changes' '
-	git reset --hard "$pre_merge_head"
-'
-
 test_expect_success 'Fail conflicting merge with matching dirty worktree' '
 	echo barf > bar &&
 	git diff > expect &&
@@ -223,97 +198,4 @@ test_expect_success 'Fail conflicting merge with matching dirty worktree' '
 	test_cmp expect actual
 '
 
-test_expect_success 'Abort conflicting merge with matching dirty index' '
-	git add bar &&
-	git diff --staged > expect &&
-	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
-	### When aborting the merge, git will discard all staged changes,
-	### including those that were staged pre-merge. In other words,
-	### --abort will LOSE any staged changes (the staged changes that
-	### are lost must match the merge result, or the merge would not
-	### have been allowed to start). Change expectations accordingly:
-	rm expect &&
-	touch expect &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff --staged > actual &&
-	test_cmp expect actual &&
-	test -z "$(git diff)"
-'
-
-test_expect_success 'Reset worktree changes' '
-	git reset --hard "$pre_merge_head"
-'
-
-test_expect_success 'Abort merge with pre- and post-merge worktree changes' '
-	# Pre-merge worktree changes
-	echo xyzzy > foo &&
-	echo barf > bar &&
-	git add bar &&
-	git diff > expect &&
-	git diff --staged > expect-staged &&
-	# Perform merge
-	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
-	# Post-merge worktree changes
-	echo yzxxz > foo &&
-	echo blech > baz &&
-	### When aborting the merge, git will discard staged changes (bar)
-	### and unmerged changes (baz). Other changes that are neither
-	### staged nor marked as unmerged (foo), will be preserved. For
-	### these changed, git cannot tell pre-merge changes apart from
-	### post-merge changes, so the post-merge changes will be
-	### preserved. Change expectations accordingly:
-	git diff -- foo > expect &&
-	rm expect-staged &&
-	touch expect-staged &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff > actual &&
-	test_cmp expect actual &&
-	git diff --staged > actual-staged &&
-	test_cmp expect-staged actual-staged
-'
-
-test_expect_success 'Reset worktree changes' '
-	git reset --hard "$pre_merge_head"
-'
-
-test_expect_success 'Abort merge with pre- and post-merge index changes' '
-	# Pre-merge worktree changes
-	echo xyzzy > foo &&
-	echo barf > bar &&
-	git add bar &&
-	git diff > expect &&
-	git diff --staged > expect-staged &&
-	# Perform merge
-	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
-	# Post-merge worktree changes
-	echo yzxxz > foo &&
-	echo blech > baz &&
-	git add foo bar &&
-	### When aborting the merge, git will discard all staged changes
-	### (foo, bar and baz), and no changes will be preserved. Whether
-	### the changes were staged pre- or post-merge does not matter
-	### (except for not preventing starting the merge).
-	### Change expectations accordingly:
-	rm expect expect-staged &&
-	touch expect &&
-	touch expect-staged &&
-	# Abort merge
-	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
-	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
-	git diff > actual &&
-	test_cmp expect actual &&
-	git diff --staged > actual-staged &&
-	test_cmp expect-staged actual-staged
-'
-
 test_done
-- 
2.18.0.rc0.49.g3c08dc0fef

