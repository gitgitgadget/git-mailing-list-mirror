Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC881F453
	for <e@80x24.org>; Fri, 19 Oct 2018 19:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJTDiq (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 23:38:46 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:33216 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727754AbeJTDiq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Oct 2018 23:38:46 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9JJNkqX028046;
        Fri, 19 Oct 2018 12:31:17 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2n6h853fnh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 Oct 2018 12:31:16 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 19 Oct 2018 12:31:15 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 19 Oct 2018 12:31:15 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Fri, 19 Oct 2018 12:31:13 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 4DFA72101E7E;  Fri, 19 Oct 2018 12:31:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 3/8] merge-recursive: increase marker length with depth of recursion
Date:   Fri, 19 Oct 2018 12:31:06 -0700
Message-ID: <20181019193111.12051-4-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.230.g45940724d5
In-Reply-To: <20181019193111.12051-1-newren@gmail.com>
References: <20181014020537.17991-1-newren@gmail.com>
 <20181019193111.12051-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190172
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Later patches in this series will modify file collision conflict
handling (e.g. from rename/add and rename/rename(2to1) conflicts) so
that multiply nested conflict markers can arise even before considering
conflicts in the virtual merge base.  Including the virtual merge base
will provide a way to get triply (or higher) nested conflict markers.
This new way to get nested conflict markers will force the need for a
more general mechanism to extend the length of conflict markers in order
to differentiate between different nestings.

Along with this change to conflict marker length handling, we want to
make sure that we don't regress handling for other types of conflicts
with nested conflict markers.  Add a more involved testcase using
merge.conflictstyle=diff3, where not only does the virtual merge base
contain conflicts, but its virtual merge base does as well (i.e. a case
with triply nested conflict markers).  While there are multiple
reasonable ways to handle nested conflict markers in the virtual merge
base for this type of situation, the easiest approach that dovetails
well with the new needs for the file collision conflict handling is to
require that the length of the conflict markers increase with each
subsequent nesting.

Subsequent patches which change the rename/add and rename/rename(2to1)
conflict handling will modify the extra_marker_size flag appropriately
for their new needs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 ll-merge.c                        |   4 +-
 ll-merge.h                        |   1 +
 merge-recursive.c                 |  25 +++--
 t/t6036-recursive-corner-cases.sh | 151 ++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+), 9 deletions(-)

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
index 73b5710386..f795c92a69 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1058,7 +1058,8 @@ static int merge_3way(struct merge_options *o,
 		      const struct diff_filespec *a,
 		      const struct diff_filespec *b,
 		      const char *branch1,
-		      const char *branch2)
+		      const char *branch2,
+		      const int extra_marker_size)
 {
 	mmfile_t orig, src1, src2;
 	struct ll_merge_options ll_opts = {0};
@@ -1066,6 +1067,7 @@ static int merge_3way(struct merge_options *o,
 	int merge_status;
 
 	ll_opts.renormalize = o->renormalize;
+	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = o->xdl_opts;
 
 	if (o->call_depth) {
@@ -1300,6 +1302,7 @@ static int merge_mode_and_contents(struct merge_options *o,
 				   const char *filename,
 				   const char *branch1,
 				   const char *branch2,
+				   const int extra_marker_size,
 				   struct merge_file_info *result)
 {
 	if (o->branch1 != branch1) {
@@ -1310,7 +1313,8 @@ static int merge_mode_and_contents(struct merge_options *o,
 		 */
 		return merge_mode_and_contents(o, one, b, a,
 					       filename,
-					       branch2, branch1, result);
+					       branch2, branch1,
+					       extra_marker_size, result);
 	}
 
 	result->merge = 0;
@@ -1351,7 +1355,8 @@ static int merge_mode_and_contents(struct merge_options *o,
 			int ret = 0, merge_status;
 
 			merge_status = merge_3way(o, &result_buf, one, a, b,
-						  branch1, branch2);
+						  branch1, branch2,
+						  extra_marker_size);
 
 			if ((merge_status < 0) || !result_buf.ptr)
 				ret = err(o, _("Failed to execute internal merge"));
@@ -1640,7 +1645,8 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 		struct diff_filespec other;
 		struct diff_filespec *add;
 		if (merge_mode_and_contents(o, one, a, b, one->path,
-					    ci->branch1, ci->branch2, &mfi))
+					    ci->branch1, ci->branch2,
+					    o->call_depth * 2, &mfi))
 			return -1;
 
 		/*
@@ -1707,9 +1713,11 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	path_side_1_desc = xstrfmt("version of %s from %s", path, a->path);
 	path_side_2_desc = xstrfmt("version of %s from %s", path, b->path);
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
@@ -2755,7 +2763,7 @@ static int process_renames(struct merge_options *o,
 
 					if (merge_mode_and_contents(o, &one, &a, &b, ren1_dst,
 								    branch1, branch2,
-								    &mfi)) {
+								    o->call_depth * 2, &mfi)) {
 						clean_merge = -1;
 						goto cleanup_and_return;
 					}
@@ -3052,7 +3060,8 @@ static int handle_content_merge(struct merge_options *o,
 			df_conflict_remains = 1;
 	}
 	if (merge_mode_and_contents(o, &one, &a, &b, path,
-				    o->branch1, o->branch2, &mfi))
+				    o->branch1, o->branch2,
+				    o->call_depth * 2, &mfi))
 		return -1;
 
 	/*
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 78138a7fb4..32fd0a2995 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1596,4 +1596,155 @@ test_expect_failure "check nested conflicts" '
 	)
 '
 
+# Setup:
+#          L1---L2---L3
+#         /  \ /  \ /  \
+#   master    X1   X2   ?
+#         \  / \  / \  /
+#          R1---R2---R3
+#
+# Where:
+#   master has one file named 'content'
+#   branches L1 and R1 both modify each of the two files in conflicting ways
+#
+#   L<n> (n>1) is a merge of R<n-1> into L<n-1>
+#   R<n> (n>1) is a merge of L<n-1> into R<n-1>
+#   L<n> and R<n> resolve the conflicts differently.
+#
+#   X<n> is an auto-generated merge-base used when merging L<n+1> and R<n+1>.
+#   By construction, X1 has conflict markers due to conflicting versions.
+#   X2, due to using merge.conflictstyle=3, has nested conflict markers.
+#
+#   So, merging R3 into L3 using merge.conflictstyle=3 should show the
+#   nested conflict markers from X2 in the base version -- that means we
+#   have three levels of conflict markers.  Can we distinguish all three?
+
+test_expect_success "setup virtual merge base with nested conflicts" '
+	test_create_repo virtual_merge_base_has_nested_conflicts &&
+	(
+		cd virtual_merge_base_has_nested_conflicts &&
+
+		# Create some related files now
+		for i in $(test_seq 1 10)
+		do
+			echo Random base content line $i
+		done >content &&
+
+		# Setup original commit
+		git add content &&
+		test_tick && git commit -m initial &&
+
+		git branch L &&
+		git branch R &&
+
+		# Create L1
+		git checkout L &&
+		echo left >>content &&
+		git add content &&
+		test_tick && git commit -m "version L1 of content" &&
+		git tag L1 &&
+
+		# Create R1
+		git checkout R &&
+		echo right >>content &&
+		git add content &&
+		test_tick && git commit -m "verson R1 of content" &&
+		git tag R1 &&
+
+		# Create L2
+		git checkout L &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge R1 &&
+		git checkout L1 content &&
+		test_tick && git commit -m "version L2 of content" &&
+		git tag L2 &&
+
+		# Create R2
+		git checkout R &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge L1 &&
+		git checkout R1 content &&
+		test_tick && git commit -m "version R2 of content" &&
+		git tag R2 &&
+
+		# Create L3
+		git checkout L &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge R2 &&
+		git checkout L1 content &&
+		test_tick && git commit -m "version L3 of content" &&
+		git tag L3 &&
+
+		# Create R3
+		git checkout R &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge L2 &&
+		git checkout R1 content &&
+		test_tick && git commit -m "version R3 of content" &&
+		git tag R3
+	)
+'
+
+test_expect_success "check virtual merge base with nested conflicts" '
+	(
+		cd virtual_merge_base_has_nested_conflicts &&
+
+		git checkout L3^0 &&
+
+		# Merge must fail; there is a conflict
+		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R3^0 &&
+
+		# Make sure the index has the right number of entries
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		# Ensure we have the correct number of untracked files
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		# Compare :[23]:content to expected values
+		git rev-parse L1:content R1:content >expect &&
+		git rev-parse :2:content :3:content >actual &&
+		test_cmp expect actual &&
+
+		# Imitate X1 merge base, except without long enough conflict
+		# markers because a subsequent sed will modify them.  Put
+		# result into vmb.
+		git cat-file -p master:content >base &&
+		git cat-file -p L:content >left &&
+		git cat-file -p R:content >right &&
+		cp left merged-once &&
+		test_must_fail git merge-file --diff3 \
+			-L "Temporary merge branch 1" \
+			-L "merged common ancestors"  \
+			-L "Temporary merge branch 2" \
+			merged-once \
+			base        \
+			right       &&
+		sed -e "s/^\([<|=>]\)/\1\1\1/" merged-once >vmb &&
+
+		# Imitate X2 merge base, overwriting vmb.  Note that we
+		# extend both sets of conflict markers to make them longer
+		# with the sed command.
+		cp left merged-twice &&
+		test_must_fail git merge-file --diff3 \
+			-L "Temporary merge branch 1" \
+			-L "merged common ancestors"  \
+			-L "Temporary merge branch 2" \
+			merged-twice \
+			vmb          \
+			right        &&
+		sed -e "s/^\([<|=>]\)/\1\1\1/" merged-twice >vmb &&
+
+		# Compare :1:content to expected value
+		git cat-file -p :1:content >actual &&
+		test_cmp vmb actual &&
+
+		# Determine expected content in final outer merge, compare to
+		# what the merge generated.
+		cp -f left expect &&
+		test_must_fail git merge-file --diff3                      \
+			-L "HEAD"  -L "merged common ancestors"  -L "R3^0" \
+			expect     vmb                           right     &&
+		test_cmp expect content
+	)
+'
+
 test_done
-- 
2.19.1.1079.gae8ff35a65

