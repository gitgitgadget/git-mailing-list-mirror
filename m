Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6EBA1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeDSR6p (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:45 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41712 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752597AbeDSR6h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:37 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHnDfG028656;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdryeas7c-1;
        Thu, 19 Apr 2018 10:58:30 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id BC06622175DE;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id AE0832CDEED;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 36/36] merge-recursive: fix check for skipability of working tree updates
Date:   Thu, 19 Apr 2018 10:58:23 -0700
Message-Id: <20180419175823.7946-37-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The can-working-tree-updates-be-skipped check has had a long and blemished
history.  The update can be skipped iff:
  a) The merge is clean
  b) The merge matches what was in HEAD (content, mode, pathname)
  c) The target path is usable (i.e. not involved in D/F conflict)

Traditionally, we split b into parts:
  b1) The merged result matches the content and mode found in HEAD
  b2) The merged target path existed in HEAD

Steps a & b1 are easy to check; we have always gotten those right.  While
it is easy to overlook step c, this was fixed seven years ago with commit
4ab9a157d069 ("merge_content(): Check whether D/F conflicts are still
present", 2010-09-20).  merge-recursive didn't have a readily available
way to directly check step b2, so various approximations were used:

  * In commit b2c8c0a76274 ("merge-recursive: When we detect we can skip
    an update, actually skip it", 2011-02-28), it was noted that although
    the code claimed it was skipping the update, it did not actually skip
    the update.  The code was made to skip it, but used lstat(path, ...)
    as an approximation to path-was-tracked-in-index-before-merge.

  * In commit 5b448b853030 ("merge-recursive: When we detect we can skip
    an update, actually skip it", 2011-08-11), the problem with using
    lstat was noted.  It was changed to the approximation
       path2 && strcmp(path, path2)
    which is also wrong.  !path2 || strcmp(path, path2) would have been
    better, but would have fallen short with directory renames.

  * In c5b761fb2711 ("merge-recursive: ensure we write updates for
    directory-renamed file", 2018-02-14), the problem with the previous
    approximation was noted and changed to
       was_tracked(path)
    That looks close to what we were trying to answer, but was_tracked()
    as implemented at the time should have been named is_tracked(); it
    returned something different than what we were looking for.

  * To make matters more complex, fixing was_tracked() isn't sufficient
    because the splitting of b into b1 and b2 is wrong.  Consider the
    following merge with a rename/add conflict:
       side A: modify foo, add unrelated bar
       side B: rename foo->bar (but don't modify the mode or contents)
    In this case, the three-way merge of original foo, A's foo, and B's
    bar will result in a desired pathname of bar with the same
    mode/contents that A had for foo.  Thus, A had the right mode and
    contents for the file, and it had the right pathname present (namely,
    bar), but the bar that was present was unrelated to the contents, so
    the working tree update was not skippable.

Fix this by introducing a new function:
   was_tracked_and_matches(o, path, &mfi.oid, mfi.mode)
and use it to directly check for condition b.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                      | 48 +++++++++++++++++---------
 t/t6022-merge-rename.sh                |  2 +-
 t/t6043-merge-rename-directories.sh    |  2 +-
 t/t6046-merge-skip-unneeded-updates.sh | 10 +++---
 4 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 212d34d268..1de8dc1c53 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -779,6 +779,25 @@ static int dir_in_way(const char *path, int check_working_copy, int empty_ok)
 		!(empty_ok && is_empty_dir(path));
 }
 
+/*
+ * Returns whether path was tracked in the index before the merge started,
+ * and its oid and mode match the specified values
+ */
+static int was_tracked_and_matches(struct merge_options *o, const char *path,
+				   const struct object_id *oid, unsigned mode)
+{
+	int pos = index_name_pos(&o->orig_index, path, strlen(path));
+	struct cache_entry *ce;
+
+	if (0 > pos)
+		/* we were not tracking this path before the merge */
+		return 0;
+
+	/* See if the file we were tracking before matches */
+	ce = o->orig_index.cache[pos];
+	return (oid_eq(&ce->oid, oid) && ce->ce_mode == mode);
+}
+
 /*
  * Returns whether path was tracked in the index before the merge started
  */
@@ -2821,23 +2840,20 @@ static int merge_content(struct merge_options *o,
 				       o->branch2, path2, &mfi))
 		return -1;
 
-	if (mfi.clean && !df_conflict_remains &&
-	    oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
-		int path_renamed_outside_HEAD;
+	/*
+	 * We can skip updating the working tree file iff:
+	 *   a) The merge is clean
+	 *   b) The merge matches what was in HEAD (content, mode, pathname)
+	 *   c) The target path is usable (i.e. not involved in D/F conflict)
+	 */
+	if (mfi.clean &&
+	    was_tracked_and_matches(o, path, &mfi.oid, mfi.mode) &&
+	    !df_conflict_remains) {
 		output(o, 3, _("Skipped %s (merged same as existing)"), path);
-		/*
-		 * The content merge resulted in the same file contents we
-		 * already had.  We can return early if those file contents
-		 * are recorded at the correct path (which may not be true
-		 * if the merge involves a rename).
-		 */
-		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
-		if (!path_renamed_outside_HEAD) {
-			if (add_cacheinfo(o, mfi.mode, &mfi.oid, path,
-					  0, (!o->call_depth && !is_dirty), 0))
-				return -1;
-			return mfi.clean;
-		}
+		if (add_cacheinfo(o, mfi.mode, &mfi.oid, path,
+				  0, (!o->call_depth && !is_dirty), 0))
+			return -1;
+		return mfi.clean;
 	}
 
 	if (!mfi.clean) {
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index a1fad6980b..6df2650c03 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -247,7 +247,7 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	git reset --hard HEAD^ &&
 	git checkout change &&
 	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
-	test_i18ngrep "^Skipped B" out
+	test_i18ngrep ! "^Skipped B" out
 '
 
 test_expect_success 'setup for rename + d/f conflicts' '
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 45f620633f..2e28f2908d 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -3884,7 +3884,7 @@ test_expect_success '12b-setup: Moving one directory hierarchy into another' '
 	)
 '
 
-test_expect_failure '12b-check: Moving one directory hierarchy into another' '
+test_expect_success '12b-check: Moving one directory hierarchy into another' '
 	(
 		cd 12b &&
 
diff --git a/t/t6046-merge-skip-unneeded-updates.sh b/t/t6046-merge-skip-unneeded-updates.sh
index 911e2f87a4..880cd782d7 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -64,7 +64,7 @@ test_expect_success '1a-setup: Modify(A)/Modify(B), change on B subset of A' '
 	)
 '
 
-test_expect_failure '1a-check-L: Modify(A)/Modify(B), change on B subset of A' '
+test_expect_success '1a-check-L: Modify(A)/Modify(B), change on B subset of A' '
 	test_when_finished "git -C 1a reset --hard" &&
 	test_when_finished "git -C 1a clean -fd" &&
 	(
@@ -160,7 +160,7 @@ test_expect_success '2a-setup: Modify(A)/rename(B)' '
 	)
 '
 
-test_expect_failure '2a-check-L: Modify/rename, merge into modify side' '
+test_expect_success '2a-check-L: Modify/rename, merge into modify side' '
 	test_when_finished "git -C 2a reset --hard" &&
 	test_when_finished "git -C 2a clean -fd" &&
 	(
@@ -360,7 +360,7 @@ test_expect_success '2c-setup: Modify b & add c VS rename b->c' '
 	)
 '
 
-test_expect_failure '2c-check: Modify b & add c VS rename b->c' '
+test_expect_success '2c-check: Modify b & add c VS rename b->c' '
 	(
 		cd 2c &&
 
@@ -456,7 +456,7 @@ test_expect_success '3a-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	)
 '
 
-test_expect_failure '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+test_expect_success '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	test_when_finished "git -C 3a reset --hard" &&
 	test_when_finished "git -C 3a clean -fd" &&
 	(
@@ -579,7 +579,7 @@ test_expect_success '3b-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	)
 '
 
-test_expect_failure '3b-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+test_expect_success '3b-check-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	test_when_finished "git -C 3b reset --hard" &&
 	test_when_finished "git -C 3b clean -fd" &&
 	(
-- 
2.17.0.290.ge988e9ce2a

