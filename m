Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60AE1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeKHOON (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:14:13 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44912 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeKHOOM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 09:14:12 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA84dbBD024774;
        Wed, 7 Nov 2018 20:40:35 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm96drdsf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 20:40:35 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 20:40:33 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 20:40:33 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id B4CDC2101E7C;
        Wed,  7 Nov 2018 20:40:33 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 01/10] Add testcases for consistency in file collision conflict handling
Date:   Wed, 7 Nov 2018 20:40:22 -0800
Message-ID: <20181108044031.25885-2-newren@gmail.com>
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

Add testcases dealing with file collisions for the following types of
conflicts:
  * add/add
  * rename/add
  * rename/rename(2to1)

All these conflict types simplify down to two files "colliding"
and should thus be handled similarly.  This means that rename/add and
rename/rename(2to1) conflicts need to be modified to behave the same as
add/add conflicts currently do: the colliding files should be two-way
merged (instead of the current behavior of writing the two colliding
files out to separate temporary unique pathnames).  Add testcases which
check this; subsequent commits will fix the conflict handling to make
these tests pass.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6042-merge-rename-corner-cases.sh | 162 +++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b97aca7fa2..b6fed2cb9a 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -937,4 +937,166 @@ test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename
 	)
 '
 
+test_conflicts_with_adds_and_renames() {
+	sideL=$1
+	sideR=$2
+	expect=$3
+
+	# Setup:
+	#          L
+	#         / \
+	#   master   ?
+	#         \ /
+	#          R
+	#
+	# Where:
+	#   Both L and R have files named 'three' which collide.  Each of
+	#   the colliding files could have been involved in a rename, in
+	#   which case there was a file named 'one' or 'two' that was
+	#   modified on the opposite side of history and renamed into the
+	#   collision on this side of history.
+	#
+	# Questions:
+	#   1) The index should contain both a stage 2 and stage 3 entry
+	#      for the colliding file.  Does it?
+	#   2) When renames are involved, the content merges are clean, so
+	#      the index should reflect the content merges, not merely the
+	#      version of the colliding file from the prior commit.  Does
+	#      it?
+	#   3) There should be a file in the worktree named 'three'
+	#      containing the two-way merged contents of the content-merged
+	#      versions of 'three' from each of the two colliding
+	#      files.  Is it present?
+	#   4) There should not be any three~* files in the working
+	#      tree
+	test_expect_success "setup simple $sideL/$sideR conflict" '
+		test_create_repo simple_${sideL}_${sideR} &&
+		(
+			cd simple_${sideL}_${sideR} &&
+
+			# Create some related files now
+			for i in $(test_seq 1 10)
+			do
+				echo Random base content line $i
+			done >file_v1 &&
+			cp file_v1 file_v2 &&
+			echo modification >>file_v2 &&
+
+			cp file_v1 file_v3 &&
+			echo more stuff >>file_v3 &&
+			cp file_v3 file_v4 &&
+			echo yet more stuff >>file_v4 &&
+
+			# Use a tag to record both these files for simple
+			# access, and clean out these untracked files
+			git tag file_v1 $(git hash-object -w file_v1) &&
+			git tag file_v2 $(git hash-object -w file_v2) &&
+			git tag file_v3 $(git hash-object -w file_v3) &&
+			git tag file_v4 $(git hash-object -w file_v4) &&
+			git clean -f &&
+
+			# Setup original commit (or merge-base), consisting of
+			# files named "one" and "two" if renames were involved.
+			touch irrelevant_file &&
+			git add irrelevant_file &&
+			if [ $sideL = "rename" ]
+			then
+				git show file_v1 >one &&
+				git add one
+			fi &&
+			if [ $sideR = "rename" ]
+			then
+				git show file_v3 >two &&
+				git add two
+			fi &&
+			test_tick && git commit -m initial &&
+
+			git branch L &&
+			git branch R &&
+
+			# Handle the left side
+			git checkout L &&
+			if [ $sideL = "rename" ]
+			then
+				git mv one three
+			else
+				git show file_v2 >three &&
+				git add three
+			fi &&
+			if [ $sideR = "rename" ]
+			then
+				git show file_v4 >two &&
+				git add two
+			fi &&
+			test_tick && git commit -m L &&
+
+			# Handle the right side
+			git checkout R &&
+			if [ $sideL = "rename" ]
+			then
+				git show file_v2 >one &&
+				git add one
+			fi &&
+			if [ $sideR = "rename" ]
+			then
+				git mv two three
+			else
+				git show file_v4 >three &&
+				git add three
+			fi &&
+			test_tick && git commit -m R
+		)
+	'
+
+	test_expect_$expect "check simple $sideL/$sideR conflict" '
+		(
+			cd simple_${sideL}_${sideR} &&
+
+			git checkout L^0 &&
+
+			# Merge must fail; there is a conflict
+			test_must_fail git merge -s recursive R^0 &&
+
+			# Make sure the index has the right number of entries
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			# Ensure we have the correct number of untracked files
+			git ls-files -o >out &&
+			test_line_count = 1 out &&
+
+			# Nothing should have touched irrelevant_file
+			git rev-parse >actual      \
+				:0:irrelevant_file \
+				:2:three           \
+				:3:three           &&
+			git rev-parse >expected        \
+				master:irrelevant_file \
+				file_v2                \
+				file_v4                &&
+			test_cmp expected actual &&
+
+			# Make sure we have the correct merged contents for
+			# three
+			git show file_v1 >expected &&
+			cat <<-\EOF >>expected &&
+			<<<<<<< HEAD
+			modification
+			=======
+			more stuff
+			yet more stuff
+			>>>>>>> R^0
+			EOF
+
+			test_cmp expected three
+		)
+	'
+}
+
+test_conflicts_with_adds_and_renames rename rename failure
+test_conflicts_with_adds_and_renames rename add    failure
+test_conflicts_with_adds_and_renames add    rename failure
+test_conflicts_with_adds_and_renames add    add    success
+
 test_done
-- 
2.19.1.858.g526e8fe740.dirty

