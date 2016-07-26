Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3305203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 21:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbcGZVN4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:13:56 -0400
Received: from siwi.pair.com ([209.68.5.199]:44867 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161053AbcGZVNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:13:53 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id CAE6A84634;
	Tue, 26 Jul 2016 17:13:49 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v3 8/8] status: tests for --porcelain=v2
Date:	Tue, 26 Jul 2016 17:11:23 -0400
Message-Id: <1469567483-58794-9-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Unit tests for porcelain v2 status format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>
---
 t/t7064-wtstatus-pv2.sh | 585 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 585 insertions(+)
 create mode 100755 t/t7064-wtstatus-pv2.sh

diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
new file mode 100755
index 0000000..ff0dd3d
--- /dev/null
+++ b/t/t7064-wtstatus-pv2.sh
@@ -0,0 +1,585 @@
+#!/bin/sh
+
+test_description='git status --porcelain=v2
+
+This test exercises porcelain V2 output for git status.'
+
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	git config --local core.autocrlf false &&
+	echo x >file_x &&
+	echo y >file_y &&
+	echo z >file_z &&
+	mkdir dir1 &&
+	echo a >dir1/file_a &&
+	echo b >dir1/file_b
+'
+
+
+##################################################################
+## Confirm output prior to initial commit.
+##################################################################
+
+test_expect_success pre_initial_commit_0 '
+	cat >expected <<-EOF &&
+	# branch.oid (initial)
+	# branch.head master
+	? actual
+	? dir1/
+	? expected
+	? file_x
+	? file_y
+	? file_z
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=normal >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success pre_initial_commit_1 '
+	git add file_x file_y file_z dir1 &&
+	SHA_A=`git hash-object -t blob -- dir1/file_a` &&
+	SHA_B=`git hash-object -t blob -- dir1/file_b` &&
+	SHA_X=`git hash-object -t blob -- file_x` &&
+	SHA_Y=`git hash-object -t blob -- file_y` &&
+	SHA_Z=`git hash-object -t blob -- file_z` &&
+	SHA_ZERO=0000000000000000000000000000000000000000 &&
+
+	cat >expected <<-EOF &&
+	# branch.oid (initial)
+	# branch.head master
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_A dir1/file_a
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_B dir1/file_b
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_X file_x
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Y file_y
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Z file_z
+	? actual
+	? expected
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+## Try -z on the above
+test_expect_success pre_initial_commit_2 '
+	cat >expected.lf <<-EOF &&
+	# branch.oid (initial)
+	# branch.head master
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_A dir1/file_a
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_B dir1/file_b
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_X file_x
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Y file_y
+	1 A. N... 000000 100644 100644 $SHA_ZERO $SHA_Z file_z
+	? actual
+	? expected
+	EOF
+	perl -pe y/\\012/\\000/ <expected.lf >expected &&
+	rm expected.lf &&
+
+	git status -z --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+##################################################################
+## Create first commit. Confirm commit sha in new track header.
+## Then make some changes on top of it.
+##################################################################
+
+test_expect_success initial_commit_0 '
+	git commit -m initial &&
+	H0=`git rev-parse HEAD` &&
+	cat >expected <<-EOF &&
+	# branch.oid $H0
+	# branch.head master
+	? actual
+	? expected
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success initial_commit_1 '
+	echo x >>file_x &&
+	SHA_X1=`git hash-object -t blob -- file_x` &&
+	rm file_z &&
+	H0=`git rev-parse HEAD` &&
+
+	cat >expected <<-EOF &&
+	# branch.oid $H0
+	# branch.head master
+	1 .M N... 100644 100644 100644 $SHA_X $SHA_X file_x
+	1 .D N... 100644 100644 000000 $SHA_Z $SHA_Z file_z
+	? actual
+	? expected
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success initial_commit_2 '
+	git add file_x &&
+	git rm file_z &&
+	H0=`git rev-parse HEAD` &&
+
+	cat >expected <<-EOF &&
+	# branch.oid $H0
+	# branch.head master
+	1 M. N... 100644 100644 100644 $SHA_X $SHA_X1 file_x
+	1 D. N... 100644 000000 000000 $SHA_Z $SHA_ZERO file_z
+	? actual
+	? expected
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+test_expect_success initial_commit_3 '
+	git mv file_y renamed_y &&
+	H0=`git rev-parse HEAD` &&
+
+	cat >expected.q <<-EOF &&
+	# branch.oid $H0
+	# branch.head master
+	1 M. N... 100644 100644 100644 $SHA_X $SHA_X1 file_x
+	1 D. N... 100644 000000 000000 $SHA_Z $SHA_ZERO file_z
+	2 R. N... 100644 100644 100644 $SHA_Y $SHA_Y R100 renamed_yQfile_y
+	? actual
+	? expected
+	EOF
+	q_to_tab <expected.q >expected &&
+	rm expected.q &&
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+##################################################################
+## Create second commit.
+##################################################################
+
+test_expect_success second_commit_0 '
+	git commit -m second &&
+	H1=`git rev-parse HEAD` &&
+
+	cat >expected <<-EOF &&
+	# branch.oid $H1
+	# branch.head master
+	? actual
+	? expected
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	test_cmp expected actual
+'
+
+
+##################################################################
+## Ignore a file
+##################################################################
+
+test_expect_success ignore_file_0 '
+	echo x.ign >.gitignore &&
+	echo "ignore me" >x.ign &&
+	H1=`git rev-parse HEAD` &&
+
+	cat >expected <<-EOF &&
+	# branch.oid $H1
+	# branch.head master
+	? .gitignore
+	? actual
+	? expected
+	! x.ign
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	rm x.ign &&
+	rm .gitignore &&
+	test_cmp expected actual
+'
+
+
+##################################################################
+## Create some conflicts.
+##################################################################
+
+test_expect_success conflict_AA '
+	git branch AA_A master &&
+	git checkout AA_A &&
+	echo "Branch AA_A" >conflict.txt &&
+	SHA_AA_A=`git hash-object -t blob -- conflict.txt` &&
+	git add conflict.txt &&
+	git commit -m "branch aa_a" &&
+
+	git branch AA_B master &&
+	git checkout AA_B &&
+	echo "Branch AA_B" >conflict.txt &&
+	SHA_AA_B=`git hash-object -t blob -- conflict.txt` &&
+	git add conflict.txt &&
+	git commit -m "branch aa_b" &&
+
+	git branch AA_M AA_B &&
+	git checkout AA_M &&
+	test_must_fail git merge AA_A &&
+
+	HM=`git rev-parse HEAD` &&
+
+	cat >expected <<-EOF &&
+	# branch.oid $HM
+	# branch.head AA_M
+	u AA N... 000000 100644 100644 100644 $SHA_ZERO $SHA_AA_B $SHA_AA_A conflict.txt
+	? actual
+	? expected
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	git reset --hard &&
+	test_cmp expected actual
+'
+
+
+test_expect_success conflict_UU '
+	git branch UU_ANC master &&
+	git checkout UU_ANC &&
+	echo "Ancestor" >conflict.txt &&
+	SHA_UU_ANC=`git hash-object -t blob -- conflict.txt` &&
+	git add conflict.txt &&
+	git commit -m "UU_ANC" &&
+
+	git branch UU_A UU_ANC &&
+	git checkout UU_A &&
+	echo "Branch UU_A" >conflict.txt &&
+	SHA_UU_A=`git hash-object -t blob -- conflict.txt` &&
+	git add conflict.txt &&
+	git commit -m "branch uu_a" &&
+
+	git branch UU_B UU_ANC &&
+	git checkout UU_B &&
+	echo "Branch UU_B" >conflict.txt &&
+	SHA_UU_B=`git hash-object -t blob -- conflict.txt` &&
+	git add conflict.txt &&
+	git commit -m "branch uu_b" &&
+
+	git branch UU_M UU_B &&
+	git checkout UU_M &&
+	test_must_fail git merge UU_A &&
+
+	HM=`git rev-parse HEAD` &&
+
+	cat >expected <<-EOF &&
+	# branch.oid $HM
+	# branch.head UU_M
+	u UU N... 100644 100644 100644 100644 $SHA_UU_ANC $SHA_UU_B $SHA_UU_A conflict.txt
+	? actual
+	? expected
+	EOF
+
+	git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+	git reset --hard &&
+	test_cmp expected actual
+'
+
+
+##################################################################
+## Test upstream fields in branch header
+##################################################################
+
+test_expect_success 'upstream_fields_0' '
+	git checkout master &&
+	git clone . sub_repo &&
+	(
+		## Confirm local master tracks remote master.
+		cd sub_repo &&
+		HUF=`git rev-parse HEAD` &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual &&
+
+		## Test ahead/behind.
+		echo xyz >file_xyz &&
+		git add file_xyz &&
+		git commit -m xyz &&
+
+		HUF=`git rev-parse HEAD` &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +1 -0
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual &&
+
+		## Test upstream-gone case. Fake this by pointing origin/master at
+		## a non-existing commit.
+		OLD=`git rev-parse origin/master` &&
+		NEW=$SHA_ZERO &&
+		mv .git/packed-refs .git/old-packed-refs &&
+		sed "s/$OLD/$NEW/g" <.git/old-packed-refs >.git/packed-refs &&
+
+		HUF=`git rev-parse HEAD` &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HUF
+		# branch.head master
+		# branch.upstream origin/master
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	) &&
+	rm -rf sub_repo
+'
+
+
+##################################################################
+## Test submodule status flags.
+##################################################################
+
+test_expect_success 'submodule_flags_0' '
+	git checkout master &&
+	git clone . sub_repo &&
+	git clone . super_repo &&
+	(	cd super_repo &&
+		git submodule add ../sub_repo sub1 &&
+
+		## Confirm stage/add of clean submodule.
+		HMOD=`git hash-object -t blob -- .gitmodules` &&
+		HSUP=`git rev-parse HEAD` &&
+		HSUB=$HSUP &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $SHA_ZERO $HMOD .gitmodules
+		1 A. S... 000000 160000 160000 $SHA_ZERO $HSUB sub1
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule_flags_1' '
+	(	cd super_repo &&
+		## Make some untracked dirt in the submodule.
+		(	cd sub1 &&
+			echo "dirt" >file_in_sub
+		) &&
+
+		HMOD=`git hash-object -t blob -- .gitmodules` &&
+		HSUP=`git rev-parse HEAD` &&
+		HSUB=$HSUP &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $SHA_ZERO $HMOD .gitmodules
+		1 AM S..U 000000 160000 160000 $SHA_ZERO $HSUB sub1
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule_flags_2' '
+	(	cd super_repo &&
+		## Make some staged dirt in the submodule.
+		(	cd sub1 &&
+			git add file_in_sub
+		) &&
+
+		HMOD=`git hash-object -t blob -- .gitmodules` &&
+		HSUP=`git rev-parse HEAD` &&
+		HSUB=$HSUP &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $SHA_ZERO $HMOD .gitmodules
+		1 AM S.M. 000000 160000 160000 $SHA_ZERO $HSUB sub1
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule_flags_3' '
+	(	cd super_repo &&
+		## Make some staged and unstaged dirt (on the same file) in the submodule.
+		## This does not cause us to get S.MU (because the submodule does not report
+		## a "?" line for the unstaged changes).
+		(	cd sub1 &&
+			echo "more dirt" >>file_in_sub
+		) &&
+
+		HMOD=`git hash-object -t blob -- .gitmodules` &&
+		HSUP=`git rev-parse HEAD` &&
+		HSUB=$HSUP &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $SHA_ZERO $HMOD .gitmodules
+		1 AM S.M. 000000 160000 160000 $SHA_ZERO $HSUB sub1
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule_flags_4' '
+	(	cd super_repo &&
+		## Make some staged and untracked dirt (on different files) in the submodule.
+		(	cd sub1 &&
+			git add file_in_sub &&
+			echo "dirt" >>another_file_in_sub
+		) &&
+
+		HMOD=`git hash-object -t blob -- .gitmodules` &&
+		HSUP=`git rev-parse HEAD` &&
+		HSUB=$HSUP &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $SHA_ZERO $HMOD .gitmodules
+		1 AM S.MU 000000 160000 160000 $SHA_ZERO $HSUB sub1
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule_flags_5' '
+	(	cd super_repo &&
+		## Make a new commit in the submodule.
+		(	cd sub1 &&
+			git add file_in_sub &&
+			rm -f another_file_in_sub &&
+			git commit -m "new commit"
+		) &&
+
+		HMOD=`git hash-object -t blob -- .gitmodules` &&
+		HSUP=`git rev-parse HEAD` &&
+		HSUB=$HSUP &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +0 -0
+		1 A. N... 000000 100644 100644 $SHA_ZERO $HMOD .gitmodules
+		1 AM SC.. 000000 160000 160000 $SHA_ZERO $HSUB sub1
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule_flags_6' '
+	(	cd super_repo &&
+		## Commit the new submodule commit in the super.
+		git add sub1 &&
+		git commit -m "super commit" &&
+
+		HSUP=`git rev-parse HEAD` &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +1 -0
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+test_expect_success 'submodule_flags_7' '
+	(	cd super_repo &&
+		## Make some untracked dirt in the submodule.
+		(	cd sub1 &&
+			echo "yet more dirt" >>file_in_sub
+		) &&
+
+		HMOD=`git hash-object -t blob -- .gitmodules` &&
+		HSUP=`git rev-parse HEAD` &&
+		HSUB=`(cd sub1 && git rev-parse HEAD)` &&
+
+		cat >expected <<-EOF &&
+		# branch.oid $HSUP
+		# branch.head master
+		# branch.upstream origin/master
+		# branch.ab +1 -0
+		1 .M S.M. 160000 160000 160000 $HSUB $HSUB sub1
+		? actual
+		? expected
+		EOF
+
+		git status --porcelain=v2 --branch --ignored --untracked-files=all >actual &&
+		test_cmp expected actual
+	)
+'
+
+##################################################################
+## The end.
+##################################################################
+
+test_done
-- 
2.8.0.rc4.17.gac42084.dirty

