Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3041F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbdKJWWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:22:16 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45960 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754479AbdKJWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 17:22:05 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAMEE7p003365;
        Fri, 10 Nov 2017 14:22:04 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631me0-1;
        Fri, 10 Nov 2017 14:22:03 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id A929622F94DB;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 9E03A2CDE6A;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 4/9] Add testcases for improved file collision conflict handling
Date:   Fri, 10 Nov 2017 14:21:51 -0800
Message-Id: <20171110222156.23221-5-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.46.g41dca04efb
In-Reply-To: <20171110222156.23221-1-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds testcases dealing with file collisions for the following types of
conflicts:
  * add/add
  * rename/add
  * rename/rename(2to1)
These tests include expectations for new, smarter behavior provided by
handle_file_collision().  Since that function is not in use yet, the
tests are currently expected to fail.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh    |   8 +-
 t/t6042-merge-rename-corner-cases.sh | 210 +++++++++++++++++++++++++++++++++++
 2 files changed, 214 insertions(+), 4 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 18aa88b5c0..8485e04b9b 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -208,11 +208,11 @@ test_expect_success 'git detects differently handled merges conflict' '
 	git cat-file -p C:new_a >>merge-me &&
 	>empty &&
 	test_must_fail git merge-file \
-		-L "Temporary merge branch 2" \
-		-L "" \
 		-L "Temporary merge branch 1" \
-		merged empty merge-me &&
-	sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
+		-L "" \
+		-L "Temporary merge branch 2" \
+		merge-me empty merged &&
+	sed -e "s/^\([<=>]\)/\1\1\1/" merge-me >merged-internal &&
 	test $(git rev-parse :1:new_a) = $(git hash-object merged-internal)
 '
 
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 411550d2b6..d8fe797f0d 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -575,4 +575,214 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 	test ! -f c
 '
 
+test_conflicts_with_adds_and_renames() {
+	test $1 != 0 && side1=rename || side1=add
+	test $2 != 0 && side2=rename || side2=add
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
+	#   'three-related' which collide.  Each of the colliding files
+	#   could have been involved in a rename, in which case there was a
+	#   file named 'one-[un]related' or 'two-[un]related' that was
+	#   modified on the opposite side of history and renamed into the
+	#   collision on this side of history.
+	#
+	# Questions for both three-unrelated and three-related:
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
+		git rm -rf . &&
+		git clean -fdqx &&
+		rm -rf .git &&
+		git init &&
+
+		# Create a simple file with 10 lines
+		ten="0 1 2 3 4 5 6 7 8 9" &&
+		for i in $ten
+		do
+			echo line $i in a sample file
+		done >unrelated1_v1 &&
+		# Create a second version of same file with one more line
+		cat unrelated1_v1 >unrelated1_v2 &&
+		echo another line >>unrelated1_v2 &&
+
+		# Create an unrelated simple file with 10 lines
+		for i in $ten
+		do
+			echo line $i in another sample file
+		done >unrelated2_v1 &&
+		# Create a second version of same file with one more line
+		cat unrelated2_v1 >unrelated2_v2 &&
+		echo another line >>unrelated2_v2 &&
+
+		# Create some related files now
+		for i in $ten
+		do
+			echo Random base content line $i
+		done >related1_v1 &&
+		cp -a related1_v1 related1_v2 &&
+		echo modification >>related1_v2 &&
+
+		cp -a related1_v1 related2_v1 &&
+		echo more stuff >>related2_v1 &&
+		cp -a related2_v1 related2_v2 &&
+		echo yet more stuff >>related2_v2 &&
+
+		# Use a tag to record both these files for simple access,
+		# and clean out these untracked files
+		git tag unrelated1_v1 `git hash-object -w unrelated1_v1` &&
+		git tag unrelated1_v2 `git hash-object -w unrelated1_v2` &&
+		git tag unrelated2_v1 `git hash-object -w unrelated2_v1` &&
+		git tag unrelated2_v2 `git hash-object -w unrelated2_v2` &&
+		git tag related1_v1 `git hash-object -w related1_v1` &&
+		git tag related1_v2 `git hash-object -w related1_v2` &&
+		git tag related2_v1 `git hash-object -w related2_v1` &&
+		git tag related2_v2 `git hash-object -w related2_v2` &&
+		git clean -f &&
+
+		# Setup merge-base, consisting of files named "one-*"
+		# and "two-*" if renames were involved.
+		touch irrelevant_file &&
+		git add irrelevant_file &&
+		if [ $side1 == "rename" ]; then
+			git show unrelated1_v1 >one-unrelated &&
+			git add one-unrelated
+			git show related1_v1 >one-related &&
+			git add one-related
+		fi &&
+		if [ $side2 == "rename" ]; then
+			git show unrelated2_v1 >two-unrelated &&
+			git add two-unrelated
+			git show related2_v1 >two-related &&
+			git add two-related
+		fi &&
+		test_tick && git commit -m initial &&
+
+		git branch L &&
+		git branch R &&
+
+		# Handle the left side
+		git checkout L &&
+		if [ $side1 == "rename" ]; then
+			git mv one-unrelated three-unrelated
+			git mv one-related   three-related
+		else
+			git show unrelated1_v2 >three-unrelated &&
+			git add three-unrelated
+			git show related1_v2 >three-related &&
+			git add three-related
+		fi &&
+		if [ $side2 == "rename" ]; then
+			git show unrelated2_v2 >two-unrelated &&
+			git add two-unrelated
+			git show related2_v2 >two-related &&
+			git add two-related
+		fi &&
+		test_tick && git commit -m L &&
+
+		# Handle the right side
+		git checkout R &&
+		if [ $side1 == "rename" ]; then
+			git show unrelated1_v2 >one-unrelated &&
+			git add one-unrelated
+			git show related1_v2 >one-related &&
+			git add one-related
+		fi &&
+		if [ $side2 == "rename" ]; then
+			git mv two-unrelated three-unrelated
+			git mv two-related three-related
+		else
+			git show unrelated2_v2 >three-unrelated &&
+			git add three-unrelated
+			git show related2_v2 >three-related &&
+			git add three-related
+		fi &&
+		test_tick && git commit -m R
+	'
+
+	test_expect_failure "check simple $side1/$side2 conflict" '
+		git reset --hard &&
+		git checkout L^0 &&
+
+		# Merge must fail; there is a conflict
+		test_must_fail git merge -s recursive R^0 &&
+
+		# Make sure the index has the right number of entries
+		test 5 = $(git ls-files -s | wc -l) &&
+		test 4 = $(git ls-files -u | wc -l) &&
+
+		# Nothing should have touched irrelevant_file
+		test $(git rev-parse :0:irrelevant_file) = $(git rev-parse master:irrelevant_file) &&
+
+		# Even for renames, make sure the index contains the MERGED
+		# version of the file, not the version of the file that existed
+		# on the given side.
+		test $(git rev-parse :2:three-unrelated) = $(git rev-parse unrelated1_v2) &&
+		test $(git rev-parse :3:three-unrelated) = $(git rev-parse unrelated2_v2) &&
+		test $(git rev-parse :2:three-related)   = $(git rev-parse related1_v2) &&
+		test $(git rev-parse :3:three-related)   = $(git rev-parse related2_v2) &&
+
+		# Make sure we have the correct number of untracked files
+		test 2 = $(git ls-files -o | wc -l) &&
+
+		# Make sure each file (with merging if rename involved) is
+		# present in the working tree for the user to work with.
+		test $(git hash-object three-unrelated~HEAD) = $(git rev-parse unrelated1_v2) &&
+		test $(git hash-object three-unrelated~R^0)  = $(git rev-parse unrelated2_v2) &&
+
+		# "three-unrelated" should not exist because there is no
+		# reason to give preference to either three-unrelated~HEAD
+		# or three-unrelated~R^0
+		test ! -f three-unrelated &&
+
+		# Make sure we have the correct merged contents for three-related
+		git show related1_v1 >expected &&
+		cat <<EOF >>expected &&
+<<<<<<< HEAD
+modification
+=======
+more stuff
+yet more stuff
+>>>>>>> R^0
+EOF
+
+		test_cmp expected three-related
+	'
+}
+
+test_conflicts_with_adds_and_renames 1 1
+test_conflicts_with_adds_and_renames 1 0
+test_conflicts_with_adds_and_renames 0 1
+test_conflicts_with_adds_and_renames 0 0
+
 test_done
-- 
2.15.0.46.g41dca04efb

