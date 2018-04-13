Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA461F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDMT4T (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:56:19 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59666 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751896AbeDMT4Q (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 15:56:16 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3DJsCDX016202;
        Fri, 13 Apr 2018 12:56:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h95bs58tp-1;
        Fri, 13 Apr 2018 12:56:10 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 112932215BC7;
        Fri, 13 Apr 2018 12:56:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 082492CDEEA;
        Fri, 13 Apr 2018 12:56:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     torvalds@linux-foundation.org, gitster@pobox.com,
        sbeller@google.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v9 30/30] merge-recursive: fix check for skipability of working tree updates
Date:   Fri, 13 Apr 2018 12:56:07 -0700
Message-Id: <20180413195607.18091-5-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.35.g6dd7ede834
In-Reply-To: <20180413195607.18091-1-newren@gmail.com>
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
 <20180413195607.18091-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804130184
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The can-working-tree-updates-be-skipped check has had a long and blemished
history.  The update can be skipped iff:
  a) The merged contents match what was in HEAD
  b) The merged mode matches what was in HEAD
  c) The target path is usable and matches what was in HEAD

Steps a & b are easy to check; we have always gotten those right.  Step c
is just:
  c1) Nothing else is in the way of putting the content at the target path
      (i.e. it isn't involved in any D/F conflicts)
  c2) target path was tracked in the index before the merge

While it is easy to overlook c1, this was fixed seven years ago with
commit 4ab9a157d069 ("merge_content(): Check whether D/F conflicts are
still present", 2010-09-20).  merge-recursive didn't have a readily
available way to directly check c2, so various approximations were
used:

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
    That looks like exactly what we were trying to answer, and is what
    was_tracked() was *intended* for, but not what was_tracked()
    actually returned.

Since the previous commit made was_tracked(path) actually mean "path was
tracked in the index before the merge", we can now use it instead of
other approximations to answer the question "was path tracked in the
index before the merge?"  So, although the code change in this commit is
the same one made in c5b761fb2711, it now safe and correct due to the
prior fix to was_tracked().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                      | 20 +++++++++++++-------
 t/t6043-merge-rename-directories.sh    |  2 +-
 t/t6046-merge-skip-unneeded-updates.sh |  4 ++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index adc800f188..1b71d00fdb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2786,16 +2786,22 @@ static int merge_content(struct merge_options *o,
 				       o->branch2, path2, &mfi))
 		return -1;
 
+	/*
+	 * We can skip updating the working tree file iff:
+	 *   a) The merged contents match what was in HEAD
+	 *   b) The merged mode matches what was in HEAD
+	 *   c) The target path is usable and matches what was in HEAD
+	 * We test (a) & (b) here.
+	 */
 	if (mfi.clean && oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
-		int path_renamed_outside_HEAD;
 		/*
-		 * The content merge resulted in the same file contents we
-		 * already had.  We can return early if those file contents
-		 * are recorded at the correct path (which may not be true
-		 * if the merge involves a rename or there's a D/F conflict).
+		 * Case c has two pieces:
+		 *   c1) Nothing else is in the way of writing the merged
+		 *       results to path (i.e. it isn't involved in any
+		 *       D/F conflict)
+		 *   c2) path was tracked in the index before the merge
 		 */
-		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
-		if (!df_conflict_remains && !path_renamed_outside_HEAD) {
+		if (!df_conflict_remains && was_tracked(o, path)) {
 			output(o, 3, _("Skipped %s (merged same as existing)"), path);
 			add_cacheinfo(o, mfi.mode, &mfi.oid, path,
 				      0, (!o->call_depth), 0);
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
index 89c3a953ae..4dcec7226c 100755
--- a/t/t6046-merge-skip-unneeded-updates.sh
+++ b/t/t6046-merge-skip-unneeded-updates.sh
@@ -64,7 +64,7 @@ test_expect_success '1a-setup: Modify(A)/Modify(B), change on B subset of A' '
 	)
 '
 
-test_expect_failure '1a-check-L: Modify(A)/Modify(B), change on B subset of A' '
+test_expect_success '1a-check-L: Modify(A)/Modify(B), change on B subset of A' '
 	test_when_finished "git -C 1a reset --hard" &&
 	(
 		cd 1a &&
@@ -346,7 +346,7 @@ test_expect_success '3a-setup: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	)
 '
 
-test_expect_failure '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
+test_expect_success '3a-check-L: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 	test_when_finished "git -C 3a reset --hard" &&
 	(
 		cd 3a &&
-- 
2.16.0.35.g6dd7ede834

