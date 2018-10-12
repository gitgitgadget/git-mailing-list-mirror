Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABCAB1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 21:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeJMFAX (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 01:00:23 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39096 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbeJMFAV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Oct 2018 01:00:21 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CLNeLM011253;
        Fri, 12 Oct 2018 14:25:56 -0700
Received: from mail.palantir.com (mxw2.palantir.com [66.70.54.22] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mxtwhajth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 Oct 2018 14:25:56 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.160.10.15) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 12 Oct 2018 14:25:54 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 12 Oct 2018 14:25:54 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Fri, 12 Oct 2018 14:25:53 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 7FDF3209F073;  Fri, 12 Oct 2018 14:25:53 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/4] merge-recursive: increase marker length with depth of recursion
Date:   Fri, 12 Oct 2018 14:25:49 -0700
Message-ID: <20181012212551.7689-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.235.g7c386e1068
In-Reply-To: <20181012212551.7689-1-newren@gmail.com>
References: <20181012212551.7689-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120214
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using merge.conflictstyle=diff3 to have the "base version" be shown
in conflicts, there is the possibility that the base version itself has
conflicts in it.  This comes about when there are more than one merge
base, and the merging of those merge bases produces a conflict.
Since this process applies recursively, it is possible to have conflict
markers nested at an arbitrary depth; to be able to differentiate the
conflict markers from different nestings, we make them all of different
lengths.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 ll-merge.c                        |  4 +++-
 ll-merge.h                        |  1 +
 merge-recursive.c                 | 22 +++++++++++++++-------
 t/t6036-recursive-corner-cases.sh |  2 +-
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 0e2800f7bb..aabc1b5c2e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -384,7 +384,9 @@ int ll_merge(mmbuffer_t *result_buf,
 	if (opts->virtual_ancestor) {
 		if (driver->recursive)
 			driver = find_ll_merge_driver(driver->recursive);
-		marker_size += 2;
+	}
+	if (opts->extra_marker_size) {
+		marker_size += opts->extra_marker_size;
 	}
 	return driver->fn(driver, result_buf, path, ancestor, ancestor_label,
 			  ours, our_label, theirs, their_label,
diff --git a/ll-merge.h b/ll-merge.h
index b72b19921e..5b4e158502 100644
--- a/ll-merge.h
+++ b/ll-merge.h
@@ -11,6 +11,7 @@ struct ll_merge_options {
 	unsigned virtual_ancestor : 1;
 	unsigned variant : 2;	/* favor ours, favor theirs, or union merge */
 	unsigned renormalize : 1;
+	unsigned extra_marker_size;
 	long xdl_opts;
 };
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 5206d6cfb6..2452788d28 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1039,7 +1039,8 @@ static int merge_3way(struct merge_options *o,
 		      const struct diff_filespec *a,
 		      const struct diff_filespec *b,
 		      const char *branch1,
-		      const char *branch2)
+		      const char *branch2,
+		      const int extra_marker_size)
 {
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
@@ -1047,6 +1048,7 @@ static int merge_3way(struct merge_options *o,
 	int merge_status;
 
 	ll_opts.renormalize = o->renormalize;
+	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = o->xdl_opts;
 
 	if (o->call_depth) {
@@ -1281,6 +1283,7 @@ static int merge_mode_and_contents(struct merge_options *o,
 				   const char *filename,
 				   const char *branch1,
 				   const char *branch2,
+				   const int extra_marker_size,
 				   struct merge_file_info *result)
 {
 	result->merge = 0;
@@ -1321,7 +1324,8 @@ static int merge_mode_and_contents(struct merge_options *o,
 			int ret = 0, merge_status;
 
 			merge_status = merge_3way(o, &result_buf, one, a, b,
-						  branch1, branch2);
+						  branch1, branch2,
+						  extra_marker_size);
 
 			if ((merge_status < 0) || !result_buf.ptr)
 				ret = err(o, _("Failed to execute internal merge"));
@@ -1610,7 +1614,8 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 		struct diff_filespec other;
 		struct diff_filespec *add;
 		if (merge_mode_and_contents(o, one, a, b, one->path,
-					    ci->branch1, ci->branch2, &mfi))
+					    ci->branch1, ci->branch2,
+					    o->call_depth * 2, &mfi))
 			return -1;
 
 		/*
@@ -1677,9 +1682,11 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	path_side_1_desc = xstrfmt("%s (was %s)", path, a->path);
 	path_side_2_desc = xstrfmt("%s (was %s)", path, b->path);
 	if (merge_mode_and_contents(o, a, c1, &ci->ren1_other, path_side_1_desc,
-				    o->branch1, o->branch2, &mfi_c1) ||
+				    o->branch1, o->branch2,
+				    o->call_depth * 2, &mfi_c1) ||
 	    merge_mode_and_contents(o, b, &ci->ren2_other, c2, path_side_2_desc,
-				    o->branch1, o->branch2, &mfi_c2))
+				    o->branch1, o->branch2,
+				    o->call_depth * 2, &mfi_c2))
 		return -1;
 	free(path_side_1_desc);
 	free(path_side_2_desc);
@@ -2725,7 +2732,7 @@ static int process_renames(struct merge_options *o,
 
 					if (merge_mode_and_contents(o, &one, &a, &b, ren1_dst,
 								    branch1, branch2,
-								    &mfi)) {
+								    o->call_depth * 2, &mfi)) {
 						clean_merge = -1;
 						goto cleanup_and_return;
 					}
@@ -3022,7 +3029,8 @@ static int handle_content_merge(struct merge_options *o,
 			df_conflict_remains = 1;
 	}
 	if (merge_mode_and_contents(o, &one, &a, &b, path,
-				    o->branch1, o->branch2, &mfi))
+				    o->branch1, o->branch2,
+				    o->call_depth * 2, &mfi))
 		return -1;
 
 	/*
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 1d1135082c..21954db624 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1487,7 +1487,7 @@ test_expect_success "setup virtual merge base with nested conflicts" '
 	)
 '
 
-test_expect_failure "check virtual merge base with nested conflicts" '
+test_expect_success "check virtual merge base with nested conflicts" '
 	(
 		cd virtual_merge_base_has_nested_conflicts &&
 
-- 
2.19.0.235.g7c386e1068

