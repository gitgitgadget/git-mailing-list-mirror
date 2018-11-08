Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3722C1F454
	for <e@80x24.org>; Thu,  8 Nov 2018 04:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeKHOOM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:14:12 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44910 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728539AbeKHOOM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 09:14:12 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA84d3Up024298;
        Wed, 7 Nov 2018 20:40:35 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm96drdsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 20:40:35 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 20:40:33 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 20:40:33 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id BB15B2101E7D;
        Wed,  7 Nov 2018 20:40:33 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 02/10] t6036, t6042: testcases for rename collision of already conflicting files
Date:   Wed, 7 Nov 2018 20:40:23 -0800
Message-ID: <20181108044031.25885-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
In-Reply-To: <20181108044031.25885-1-newren@gmail.com>
References: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
 <20181108044031.25885-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a single file is renamed, it can also be modified, yielding the
possibility of that renamed file having content conflicts.  If two
different such files are renamed into the same location, then two-way
merging those files may result in nested conflicts.  Add a testcase that
makes sure we get this case correct, and uses different lengths of
conflict markers to differentiate between the different nestings.

Also add another case with an extra (i.e. third) level of conflict
markers due to using merge.conflictstyle=diff3 and the virtual merge
base also having conflicts present.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh    | 194 +++++++++++++++++++++++++++
 t/t6042-merge-rename-corner-cases.sh | 118 ++++++++++++++++
 2 files changed, 312 insertions(+)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index e1cef58f2a..f229d7e47b 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -1402,4 +1402,198 @@ test_expect_failure 'check conflicting modes for regular file' '
 	)
 '
 
+# Setup:
+#          L1---L2
+#         /  \ /  \
+#   master    X    ?
+#         \  / \  /
+#          R1---R2
+#
+# Where:
+#   master has two files, named 'b' and 'a'
+#   branches L1 and R1 both modify each of the two files in conflicting ways
+#
+#   L2 is a merge of R1 into L1; more on it later.
+#   R2 is a merge of L1 into R1; more on it later.
+#
+#   X is an auto-generated merge-base used when merging L2 and R2.
+#   since X is a merge of L1 and R1, it has conflicting versions of each file
+#
+#   More about L2 and R2:
+#     - both resolve the conflicts in 'b' and 'a' differently
+#     - L2 renames 'b' to 'm'
+#     - R2 renames 'a' to 'm'
+#
+#   In the end, in file 'm' we have four different conflicting files (from
+#   two versions of 'b' and two of 'a').  In addition, if
+#   merge.conflictstyle is diff3, then the base version also has
+#   conflict markers of its own, leading to a total of three levels of
+#   conflict markers.  This is a pretty weird corner case, but we just want
+#   to ensure that we handle it as well as practical.
+
+test_expect_success 'setup nested conflicts' '
+	test_create_repo nested_conflicts &&
+	(
+		cd nested_conflicts &&
+
+		# Create some related files now
+		for i in $(test_seq 1 10)
+		do
+			echo Random base content line $i
+		done >initial &&
+
+		cp initial b_L1 &&
+		cp initial b_R1 &&
+		cp initial b_L2 &&
+		cp initial b_R2 &&
+		cp initial a_L1 &&
+		cp initial a_R1 &&
+		cp initial a_L2 &&
+		cp initial a_R2 &&
+
+		test_write_lines b b_L1 >>b_L1 &&
+		test_write_lines b b_R1 >>b_R1 &&
+		test_write_lines b b_L2 >>b_L2 &&
+		test_write_lines b b_R2 >>b_R2 &&
+		test_write_lines a a_L1 >>a_L1 &&
+		test_write_lines a a_R1 >>a_R1 &&
+		test_write_lines a a_L2 >>a_L2 &&
+		test_write_lines a a_R2 >>a_R2 &&
+
+		# Setup original commit (or merge-base), consisting of
+		# files named "b" and "a"
+		cp initial b &&
+		cp initial a &&
+		echo b >>b &&
+		echo a >>a &&
+		git add b a &&
+		test_tick && git commit -m initial &&
+
+		git branch L &&
+		git branch R &&
+
+		# Handle the left side
+		git checkout L &&
+		mv -f b_L1 b &&
+		mv -f a_L1 a &&
+		git add b a &&
+		test_tick && git commit -m "version L1 of files" &&
+		git tag L1 &&
+
+		# Handle the right side
+		git checkout R &&
+		mv -f b_R1 b &&
+		mv -f a_R1 a &&
+		git add b a &&
+		test_tick && git commit -m "verson R1 of files" &&
+		git tag R1 &&
+
+		# Create first merge on left side
+		git checkout L &&
+		test_must_fail git merge R1 &&
+		mv -f b_L2 b &&
+		mv -f a_L2 a &&
+		git add b a &&
+		git mv b m &&
+		test_tick && git commit -m "left merge, rename b->m" &&
+		git tag L2 &&
+
+		# Create first merge on right side
+		git checkout R &&
+		test_must_fail git merge L1 &&
+		mv -f b_R2 b &&
+		mv -f a_R2 a &&
+		git add b a &&
+		git mv a m &&
+		test_tick && git commit -m "right merge, rename a->m" &&
+		git tag R2
+	)
+'
+
+test_expect_failure 'check nested conflicts' '
+	(
+		cd nested_conflicts &&
+
+		git clean -f &&
+		git checkout L2^0 &&
+
+		# Merge must fail; there is a conflict
+		test_must_fail git -c merge.conflictstyle=diff3 merge -s recursive R2^0 &&
+
+		# Make sure the index has the right number of entries
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		# Ensure we have the correct number of untracked files
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		# Create a and b from virtual merge base X
+		git cat-file -p master:a >base &&
+		git cat-file -p L1:a >ours &&
+		git cat-file -p R1:a >theirs &&
+		test_must_fail git merge-file --diff3 \
+			-L "Temporary merge branch 1" \
+			-L "merged common ancestors"  \
+			-L "Temporary merge branch 2" \
+			ours  \
+			base  \
+			theirs &&
+		sed -e "s/^\([<|=>]\)/\1\1/" ours >vmb_a &&
+
+		git cat-file -p master:b >base &&
+		git cat-file -p L1:b >ours &&
+		git cat-file -p R1:b >theirs &&
+		test_must_fail git merge-file --diff3 \
+			-L "Temporary merge branch 1" \
+			-L "merged common ancestors"  \
+			-L "Temporary merge branch 2" \
+			ours  \
+			base  \
+			theirs &&
+		sed -e "s/^\([<|=>]\)/\1\1/" ours >vmb_b &&
+
+		# Compare :2:m to expected values
+		git cat-file -p L2:m >ours &&
+		git cat-file -p R2:b >theirs &&
+		test_must_fail git merge-file --diff3  \
+			-L "HEAD:m"                    \
+			-L "merged common ancestors:b" \
+			-L "R2^0:b"                    \
+			ours                           \
+			vmb_b                          \
+			theirs                         &&
+		sed -e "s/^\([<|=>]\)/\1\1/" ours >m_stage_2 &&
+		git cat-file -p :2:m >actual &&
+		test_cmp m_stage_2 actual &&
+
+		# Compare :3:m to expected values
+		git cat-file -p L2:a >ours &&
+		git cat-file -p R2:m >theirs &&
+		test_must_fail git merge-file --diff3  \
+			-L "HEAD:a"                    \
+			-L "merged common ancestors:a" \
+			-L "R2^0:m"                    \
+			ours                           \
+			vmb_a                          \
+			theirs                         &&
+		sed -e "s/^\([<|=>]\)/\1\1/" ours >m_stage_3 &&
+		git cat-file -p :3:m >actual &&
+		test_cmp m_stage_3 actual &&
+
+		# Compare m to expected contents
+		>empty &&
+		cp -a m_stage_2 expected_final_m &&
+		test_must_fail git merge-file --diff3 \
+			-L "HEAD"                     \
+			-L "merged common ancestors"  \
+			-L "R2^0"                     \
+			expected_final_m              \
+			empty                         \
+			m_stage_3                     &&
+		test_cmp expected_final_m m
+	)
+'
+
 test_done
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b6fed2cb9a..23c3b6dffa 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -1099,4 +1099,122 @@ test_conflicts_with_adds_and_renames rename add    failure
 test_conflicts_with_adds_and_renames add    rename failure
 test_conflicts_with_adds_and_renames add    add    success
 
+# Setup:
+#          L
+#         / \
+#   master   ?
+#         \ /
+#          R
+#
+# Where:
+#   master has two files, named 'one' and 'two'.
+#   branches L and R both modify 'one', in conflicting ways.
+#   branches L and R both modify 'two', in conflicting ways.
+#   branch L also renames 'one' to 'three'.
+#   branch R also renames 'two' to 'three'.
+#
+#   So, we have four different conflicting files that all end up at path
+#   'three'.
+test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
+	test_create_repo nested_conflicts_from_rename_rename &&
+	(
+		cd nested_conflicts_from_rename_rename &&
+
+		# Create some related files now
+		for i in $(test_seq 1 10)
+		do
+			echo Random base content line $i
+		done >file_v1 &&
+
+		cp file_v1 file_v2 &&
+		cp file_v1 file_v3 &&
+		cp file_v1 file_v4 &&
+		cp file_v1 file_v5 &&
+		cp file_v1 file_v6 &&
+
+		echo one  >>file_v1 &&
+		echo uno  >>file_v2 &&
+		echo eins >>file_v3 &&
+
+		echo two  >>file_v4 &&
+		echo dos  >>file_v5 &&
+		echo zwei >>file_v6 &&
+
+		# Setup original commit (or merge-base), consisting of
+		# files named "one" and "two".
+		mv file_v1 one &&
+		mv file_v4 two &&
+		git add one two &&
+		test_tick && git commit -m english &&
+
+		git branch L &&
+		git branch R &&
+
+		# Handle the left side
+		git checkout L &&
+		git mv one three &&
+		mv -f file_v2 three &&
+		mv -f file_v5 two &&
+		git add two three &&
+		test_tick && git commit -m spanish &&
+
+		# Handle the right side
+		git checkout R &&
+		git mv two three &&
+		mv -f file_v3 one &&
+		mv -f file_v6 three &&
+		git add one three &&
+		test_tick && git commit -m german
+	)
+'
+
+test_expect_failure 'check nested conflicts from rename/rename(2to1)' '
+	(
+		cd nested_conflicts_from_rename_rename &&
+
+		git checkout L^0 &&
+
+		# Merge must fail; there is a conflict
+		test_must_fail git merge -s recursive R^0 &&
+
+		# Make sure the index has the right number of entries
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		# Ensure we have the correct number of untracked files
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		# Compare :2:three to expected values
+		git cat-file -p master:one >base &&
+		git cat-file -p L:three >ours &&
+		git cat-file -p R:one >theirs &&
+		test_must_fail git merge-file    \
+			-L "HEAD:three"  -L ""  -L "R^0:one" \
+			ours             base   theirs &&
+		sed -e "s/^\([<=>]\)/\1\1/" ours >L-three &&
+		git cat-file -p :2:three >expect &&
+		test_cmp expect L-three &&
+
+		# Compare :2:three to expected values
+		git cat-file -p master:two >base &&
+		git cat-file -p L:two >ours &&
+		git cat-file -p R:three >theirs &&
+		test_must_fail git merge-file    \
+			-L "HEAD:two"  -L ""  -L "R^0:three" \
+			ours           base   theirs &&
+		sed -e "s/^\([<=>]\)/\1\1/" ours >R-three &&
+		git cat-file -p :3:three >expect &&
+		test_cmp expect R-three &&
+
+		# Compare three to expected contents
+		>empty &&
+		test_must_fail git merge-file    \
+			-L "HEAD"  -L ""  -L "R^0" \
+			L-three    empty  R-three &&
+		test_cmp three L-three
+	)
+'
+
 test_done
-- 
2.19.1.858.g526e8fe740.dirty

