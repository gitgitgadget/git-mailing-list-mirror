Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29FFD1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbdKJTGN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:13 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51764 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753780AbdKJTGD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:03 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2vPL017477;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cdf-2;
        Fri, 10 Nov 2017 11:06:01 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 69C1922F6297;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 6320E2CDE6A;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 28/30] merge-recursive: Avoid clobbering untracked files with directory renames
Date:   Fri, 10 Nov 2017 11:05:48 -0800
Message-Id: <20171110190550.27059-29-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                   | 39 +++++++++++++++++++++++++++++++++++--
 t/t6043-merge-rename-directories.sh |  6 +++---
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 838bfd32ec..1b3ee5b9fb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1129,6 +1129,25 @@ static int conflict_rename_dir(struct merge_options *o,
 {
 	const struct diff_filespec *dest = pair->two;
 
+	if (!o->call_depth && would_lose_untracked(dest->path)) {
+		char *alt_path = unique_path(o, dest->path, rename_branch);
+		output(o, 1, _("Error: Refusing to lose untracked file at %s; "
+			       "writing to %s instead."),
+		       dest->path, alt_path);
+		/*
+		 * Write the file in worktree at alt_path, but not in the
+		 * index.  Instead, write to dest->path for the index but
+		 * only at the higher appropriate stage.
+		 */
+		if (update_file(o, 0, &dest->oid, dest->mode, alt_path))
+			return -1;
+		free(alt_path);
+		return update_stages(o, dest->path, NULL,
+				     rename_branch == o->branch1 ? dest : NULL,
+				     rename_branch == o->branch1 ? NULL : dest);
+	}
+
+	/* Update dest->path both in index and in worktree */
 	if (update_file(o, 1, &dest->oid, dest->mode, dest->path))
 		return -1;
 	return 0;
@@ -1147,7 +1166,8 @@ static int handle_change_delete(struct merge_options *o,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(path, !o->call_depth, 0)) {
+	if (dir_in_way(path, !o->call_depth, 0) ||
+	    (!o->call_depth && would_lose_untracked(path))) {
 		update_path = alt_path = unique_path(o, path, change_branch);
 	}
 
@@ -1273,6 +1293,10 @@ static int handle_file(struct merge_options *o,
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
+		} else if (!o->call_depth && would_lose_untracked(rename->path)) {
+			dst_name = unique_path(o, rename->path, cur_branch);
+			output(o, 1, _("Refusing to lose untracked file at %s; adding as %s instead"),
+			       rename->path, dst_name);
 		}
 	}
 	if ((ret = update_file(o, 0, &rename->oid, rename->mode, dst_name)))
@@ -1398,7 +1422,18 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		remove_file(o, 0, path, 0);
+		if (would_lose_untracked(path))
+			/*
+			 * Only way we get here is if both renames were from
+			 * a directory rename AND user had an untracked file
+			 * at the location where both files end up after the
+			 * two directory renames.  See testcase 10d of t6043.
+			 */
+			output(o, 1, _("Refusing to lose untracked file at "
+				       "%s, even though it's in the way."),
+			       path);
+		else
+			remove_file(o, 0, path, 0);
 		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
 		if (!ret)
 			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index e737bad2c5..6db764a1b6 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -2660,7 +2660,7 @@ test_expect_success '10b-setup: Overwrite untracked with dir rename + delete' '
 	git commit -m "C"
 '
 
-test_expect_failure '10b-check: Overwrite untracked with dir rename + delete' '
+test_expect_success '10b-check: Overwrite untracked with dir rename + delete' '
 	git checkout B^0 &&
 	echo very >y/c &&
 	echo important >y/d &&
@@ -2727,7 +2727,7 @@ test_expect_success '10c-setup: Overwrite untracked with dir rename/rename(1to2)
 	git commit -m "C"
 '
 
-test_expect_failure '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
+test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)' '
 	git checkout B^0 &&
 	echo important >y/c &&
 
@@ -2793,7 +2793,7 @@ test_expect_success '10d-setup: Delete untracked with dir rename/rename(2to1)' '
 	git commit -m "C"
 '
 
-test_expect_failure '10d-check: Delete untracked with dir rename/rename(2to1)' '
+test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
 	git checkout B^0 &&
 	echo important >y/wham &&
 
-- 
2.15.0.5.g9567be9905

