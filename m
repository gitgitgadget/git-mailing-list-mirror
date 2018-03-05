Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0631F404
	for <e@80x24.org>; Mon,  5 Mar 2018 17:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCERLz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 12:11:55 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59030 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751590AbeCERLw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Mar 2018 12:11:52 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w25H9ate025642;
        Mon, 5 Mar 2018 09:11:26 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2gftenb07j-1;
        Mon, 05 Mar 2018 09:11:26 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 2C62F2215E15;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 22FB92CDEED;
        Mon,  5 Mar 2018 09:11:26 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Somebody <somebody@ex.com>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 1/5] Add testcases for improved file collision conflict handling
Date:   Mon,  5 Mar 2018 09:11:21 -0800
Message-Id: <20180305171125.22331-2-newren@gmail.com>
X-Mailer: git-send-email 2.16.0.41.g6a66043158
In-Reply-To: <20180305171125.22331-1-newren@gmail.com>
References: <20180305171125.22331-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803050200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds testcases dealing with file collisions for the following types of
conflicts:
  * add/add
  * rename/add
  * rename/rename(2to1)
These tests include expectations for proposed smarter behavior which has
not yet been implemented and thus are currently expected to fail.
Subsequent commits will correct that and explain the new behavior.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6042-merge-rename-corner-cases.sh | 220 +++++++++++++++++++++++++++++=
++++++
 1 file changed, 220 insertions(+)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-=
corner-cases.sh
index 411550d2b6..a6c151ef95 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -575,4 +575,224 @@ test_expect_success 'rename/rename/add-dest merge s=
till knows about conflicting
 	test ! -f c
 '
=20
+test_conflicts_with_adds_and_renames() {
+	test $1 !=3D 0 && side1=3Drename || side1=3Dadd
+	test $2 !=3D 0 && side2=3Drename || side2=3Dadd
+
+	# Setup:
+	#          L
+	#         / \
+	#   master   ?
+	#         \ /
+	#          R
+	#
+	# Where:
+	#   Both L and R have files named 'three-unrelated' and
+	#   'three-related' which collide (i.e. 4 files colliding at two
+	#   pathnames).  Each of the colliding files could have been
+	#   involved in a rename, in which case there was a file named
+	#   'one-[un]related' or 'two-[un]related' that was modified on the
+	#   opposite side of history and renamed into the collision on this
+	#   side of history.
+	#
+	# Questions for both sets of collisions:
+	#   1) The index should contain both a stage 2 and stage 3 entry
+	#      for the colliding file.  Does it?
+	#   2) When renames are involved, the content merges are clean, so
+	#      the index should reflect the content merges, not merely the
+	#      version of the colliding file from the prior commit.  Does
+	#      it?
+	#
+	# Questions for three-unrelated:
+	#   3) There should be files in the worktree named
+	#      'three-unrelated~HEAD' and 'three-unrelated~R^0' with the
+	#      (content-merged) version of 'three-unrelated' from the
+	#      appropriate side of the merge.  Are they present?
+	#   4) There should be no file named 'three-unrelated' in the
+	#      working tree.  That'd make it too likely that users would
+	#      use it instead of carefully looking at both
+	#      three-unrelated~HEAD and three-unrelated~R^0.  Is it
+	#      correctly missing?
+	#
+	# Questions for three-related:
+	#   3) There should be a file in the worktree named three-related
+	#      containing the two-way merged contents of the content-merged
+	#      versions of three-related from each of the two colliding
+	#      files.  Is it present?
+	#   4) There should not be any three-related~* files in the working
+	#      tree.
+	test_expect_success "setup simple $side1/$side2 conflict" '
+		test_create_repo simple_${side1}_${side2} &&
+		(
+			cd simple_${side1}_${side2} &&
+
+			# Create a simple file with 10 lines
+			ten=3D"0 1 2 3 4 5 6 7 8 9" &&
+			for i in $ten
+			do
+				echo line $i in a sample file
+			done >unrelated1_v1 &&
+			# Create a 2nd version of same file with one more line
+			cat unrelated1_v1 >unrelated1_v2 &&
+			echo another line >>unrelated1_v2 &&
+
+			# Create an unrelated simple file with 10 lines
+			for i in $ten
+			do
+				echo line $i in another sample file
+			done >unrelated2_v1 &&
+			# Create a 2nd version of same file with one more line
+			cat unrelated2_v1 >unrelated2_v2 &&
+			echo another line >>unrelated2_v2 &&
+
+			# Create some related files now
+			for i in $ten
+			do
+				echo Random base content line $i
+			done >related1_v1 &&
+			cp -a related1_v1 related1_v2 &&
+			echo modification >>related1_v2 &&
+
+			cp -a related1_v1 related2_v1 &&
+			echo more stuff >>related2_v1 &&
+			cp -a related2_v1 related2_v2 &&
+			echo yet more stuff >>related2_v2 &&
+
+			# Use a tag to record both these files for simple
+			# access, and clean out these untracked files
+			git tag unrelated1_v1 `git hash-object -w unrelated1_v1` &&
+			git tag unrelated1_v2 `git hash-object -w unrelated1_v2` &&
+			git tag unrelated2_v1 `git hash-object -w unrelated2_v1` &&
+			git tag unrelated2_v2 `git hash-object -w unrelated2_v2` &&
+			git tag related1_v1 `git hash-object -w related1_v1` &&
+			git tag related1_v2 `git hash-object -w related1_v2` &&
+			git tag related2_v1 `git hash-object -w related2_v1` &&
+			git tag related2_v2 `git hash-object -w related2_v2` &&
+			git clean -f &&
+
+			# Setup merge-base, consisting of files named "one-*"
+			# and "two-*" if renames were involved.
+			touch irrelevant_file &&
+			git add irrelevant_file &&
+			if [ $side1 =3D=3D "rename" ]; then
+				git show unrelated1_v1 >one-unrelated &&
+				git add one-unrelated
+				git show related1_v1 >one-related &&
+				git add one-related
+			fi &&
+			if [ $side2 =3D=3D "rename" ]; then
+				git show unrelated2_v1 >two-unrelated &&
+				git add two-unrelated
+				git show related2_v1 >two-related &&
+				git add two-related
+			fi &&
+			test_tick && git commit -m initial &&
+
+			git branch L &&
+			git branch R &&
+
+			# Handle the left side
+			git checkout L &&
+			if [ $side1 =3D=3D "rename" ]; then
+				git mv one-unrelated three-unrelated
+				git mv one-related   three-related
+			else
+				git show unrelated1_v2 >three-unrelated &&
+				git add three-unrelated
+				git show related1_v2 >three-related &&
+				git add three-related
+			fi &&
+			if [ $side2 =3D=3D "rename" ]; then
+				git show unrelated2_v2 >two-unrelated &&
+				git add two-unrelated
+				git show related2_v2 >two-related &&
+				git add two-related
+			fi &&
+			test_tick && git commit -m L &&
+
+			# Handle the right side
+			git checkout R &&
+			if [ $side1 =3D=3D "rename" ]; then
+				git show unrelated1_v2 >one-unrelated &&
+				git add one-unrelated
+				git show related1_v2 >one-related &&
+				git add one-related
+			fi &&
+			if [ $side2 =3D=3D "rename" ]; then
+				git mv two-unrelated three-unrelated
+				git mv two-related three-related
+			else
+				git show unrelated2_v2 >three-unrelated &&
+				git add three-unrelated
+				git show related2_v2 >three-related &&
+				git add three-related
+			fi &&
+			test_tick && git commit -m R
+		)
+	'
+
+	test_expect_failure "check simple $side1/$side2 conflict" '
+		(
+			cd simple_${side1}_${side2} &&
+
+			git checkout L^0 &&
+
+			# Merge must fail; there is a conflict
+			test_must_fail git merge -s recursive R^0 &&
+
+			# Make sure the index has the right number of entries
+			git ls-files -s >out &&
+			test_line_count =3D 5 out &&
+			git ls-files -u >out &&
+			test_line_count =3D 4 out &&
+
+			# Nothing should have touched irrelevant_file
+			git rev-parse >actual \
+				:0:irrelevant_file \
+				:2:three-unrelated :3:three-unrelated \
+				:2:three-related   :3:three-related   &&
+			git rev-parse >expected \
+				master:irrelevant_file \
+				unrelated1_v2      unrelated2_v2 \
+				related1_v2        related2_v2   &&
+
+			# Ensure we have the correct number of untracked files
+			git ls-files -o >out &&
+			test_line_count =3D 5 out &&
+
+			# Make sure each file (with merging if rename
+			# involved) is present in the working tree for the
+			# user to work with.
+			git hash-object >actual \
+				three-unrelated~HEAD three-unrelated~R^0 &&
+			git rev-parse >expected \
+				unrelated1_v2        unrelated2_v2 &&
+
+			# "three-unrelated" should not exist because there is
+			# no reason to give preference to either
+			# three-unrelated~HEAD or three-unrelated~R^0
+			test_path_is_missing three-unrelated &&
+
+			# Make sure we have the correct merged contents for
+			# three-related
+			git show related1_v1 >expected &&
+			cat <<EOF >>expected &&
+<<<<<<< HEAD
+modification
+=3D=3D=3D=3D=3D=3D=3D
+more stuff
+yet more stuff
+>>>>>>> R^0
+EOF
+
+			test_cmp expected three-related
+		)
+	'
+}
+
+test_conflicts_with_adds_and_renames 1 1
+test_conflicts_with_adds_and_renames 1 0
+test_conflicts_with_adds_and_renames 0 1
+test_conflicts_with_adds_and_renames 0 0
+
 test_done
--=20
2.16.0.41.g6a66043158

