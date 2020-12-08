Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,MONEY_NOHTML,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5DEC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958D023AFE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgLHWrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:47:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62577 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgLHWrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:47:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21049108D52;
        Tue,  8 Dec 2020 17:46:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u27KEDf8GarG+SIlMQor9bpm1CI=; b=igaee2
        8kSCqZbwD3swcVS5IWzf88+Eeh+nvQ+2SyvI6teNqpvYnGJmmlrbmLFyKIrQDL5W
        RexHtw8SSMGkCXENx3v+VC8ZvAKZ71NFHEYaDeQHKLeRgnMrssfXc0UI7D79SCsz
        pIIl9+2AbXw4B7LRUYTFtfiyDfb3E4dquxi2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s1HCVhtVKR4436reLFPFYNlJmyZjq+rI
        xzqxic0aIa4bkZhm9rFNYANuc/+KizoD/jSkMYw+5toSVe/OGfkgxyLX1eefUJsC
        icykqzntgcEfPlnEg9sYd0Wb1RAYqbbCK2EDhQYTw8KIm73blm8xtnjsdwtvT00P
        T9HHFGhrHgE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19AB0108D51;
        Tue,  8 Dec 2020 17:46:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B82A108D50;
        Tue,  8 Dec 2020 17:46:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3] t7064: avoid relying on a specific default branch name
References: <pull.811.git.1607264857628.gitgitgadget@gmail.com>
        <pull.811.v2.git.1607354380671.gitgitgadget@gmail.com>
Date:   Tue, 08 Dec 2020 14:46:54 -0800
In-Reply-To: <pull.811.v2.git.1607354380671.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 07 Dec 2020 15:19:40
        +0000")
Message-ID: <xmqq360f6hlt.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4621DF2C-39A7-11EB-BA6E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To allow us to consider a change in the default behavior of `git init`
where it uses a more inclusive name for the initial branch, we must
first teach the test suite not to rely on a specific default branch
name. In this patch, we teach t7064 that trick.

To that end, we set a specific name for the initial branch. Ideally, we
would simply start out by calling `git branch -M initial-branch`, but
there is a bug in `git branch -M` that does not allow renaming branches
unless they already have commits. This will be fixed in the
`js/init-defaultbranch-advice` topic, and until that time, we use the
equivalent (but less intuitive) `git checkout -f --orphan`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * v2 used to depend on an older round of a topic that is not in
   'next' (sj/untracked-files-in-submoduledirectory-is-not-dirty).
   As the topic stopped touching this test, I rebased the patch on
   top of 3a0b884c (Tenth batch, 2020-12-02)

 t/t7064-wtstatus-pv2.sh | 103 ++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 51 deletions(-)

diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 537787e598..601b47830b 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -9,6 +9,7 @@ This test exercises porcelain V2 output for git status.'
 
 
 test_expect_success setup '
+	git checkout -f --orphan initial-branch &&
 	test_tick &&
 	git config core.autocrlf false &&
 	echo x >file_x &&
@@ -22,7 +23,7 @@ test_expect_success setup '
 test_expect_success 'before initial commit, nothing added, only untracked' '
 	cat >expect <<-EOF &&
 	# branch.oid (initial)
-	# branch.head master
+	# branch.head initial-branch
 	? actual
 	? dir1/
 	? expect
@@ -45,7 +46,7 @@ test_expect_success 'before initial commit, things added' '
 
 	cat >expect <<-EOF &&
 	# branch.oid (initial)
-	# branch.head master
+	# branch.head initial-branch
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_A dir1/file_a
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_B dir1/file_b
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_X file_x
@@ -62,7 +63,7 @@ test_expect_success 'before initial commit, things added' '
 test_expect_success 'before initial commit, things added (-z)' '
 	lf_to_nul >expect <<-EOF &&
 	# branch.oid (initial)
-	# branch.head master
+	# branch.head initial-branch
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_A dir1/file_a
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_B dir1/file_b
 	1 A. N... 000000 100644 100644 $ZERO_OID $OID_X file_x
@@ -81,7 +82,7 @@ test_expect_success 'make first commit, comfirm HEAD oid and branch' '
 	H0=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	? actual
 	? expect
 	EOF
@@ -98,7 +99,7 @@ test_expect_success 'after first commit, create unstaged changes' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 .M N... 100644 100644 100644 $OID_X $OID_X file_x
 	1 .D N... 100644 100644 000000 $OID_Z $OID_Z file_z
 	? actual
@@ -126,7 +127,7 @@ test_expect_success 'after first commit, stage existing changes' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
 	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	? actual
@@ -143,7 +144,7 @@ test_expect_success 'rename causes 2 path lines' '
 
 	q_to_tab >expect <<-EOF &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
 	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
@@ -161,7 +162,7 @@ test_expect_success 'rename causes 2 path lines (-z)' '
 	## Lines use NUL path separator and line terminator, so double transform here.
 	q_to_nul <<-EOF | lf_to_nul >expect &&
 	# branch.oid $H0
-	# branch.head master
+	# branch.head initial-branch
 	1 M. N... 100644 100644 100644 $OID_X $OID_X1 file_x
 	1 D. N... 100644 000000 000000 $OID_Z $ZERO_OID file_z
 	2 R. N... 100644 100644 100644 $OID_Y $OID_Y R100 renamed_yQfile_y
@@ -179,7 +180,7 @@ test_expect_success 'make second commit, confirm clean and new HEAD oid' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H1
-	# branch.head master
+	# branch.head initial-branch
 	? actual
 	? expect
 	EOF
@@ -231,7 +232,7 @@ test_expect_success 'create and commit permanent ignore file' '
 
 	cat >expect <<-EOF &&
 	# branch.oid $H1
-	# branch.head master
+	# branch.head initial-branch
 	EOF
 
 	git status --porcelain=v2 --branch >actual &&
@@ -257,14 +258,14 @@ test_expect_success 'verify --intent-to-add output' '
 test_expect_success 'verify AA (add-add) conflict' '
 	test_when_finished "git reset --hard" &&
 
-	git branch AA_A master &&
+	git branch AA_A initial-branch &&
 	git checkout AA_A &&
 	echo "Branch AA_A" >conflict.txt &&
 	OID_AA_A=$(git hash-object -t blob -- conflict.txt) &&
 	git add conflict.txt &&
 	git commit -m "branch aa_a" &&
 
-	git branch AA_B master &&
+	git branch AA_B initial-branch &&
 	git checkout AA_B &&
 	echo "Branch AA_B" >conflict.txt &&
 	OID_AA_B=$(git hash-object -t blob -- conflict.txt) &&
@@ -290,7 +291,7 @@ test_expect_success 'verify AA (add-add) conflict' '
 test_expect_success 'verify UU (edit-edit) conflict' '
 	test_when_finished "git reset --hard" &&
 
-	git branch UU_ANC master &&
+	git branch UU_ANC initial-branch &&
 	git checkout UU_ANC &&
 	echo "Ancestor" >conflict.txt &&
 	OID_UU_ANC=$(git hash-object -t blob -- conflict.txt) &&
@@ -328,18 +329,18 @@ test_expect_success 'verify UU (edit-edit) conflict' '
 '
 
 test_expect_success 'verify upstream fields in branch header' '
-	git checkout master &&
+	git checkout initial-branch &&
 	test_when_finished "rm -rf sub_repo" &&
 	git clone . sub_repo &&
 	(
-		## Confirm local master tracks remote master.
+		## Confirm local initial-branch tracks remote initial-branch.
 		cd sub_repo &&
 		HUF=$(git rev-parse HEAD) &&
 
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		EOF
 
@@ -355,8 +356,8 @@ test_expect_success 'verify upstream fields in branch header' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		EOF
 
@@ -367,9 +368,9 @@ test_expect_success 'verify upstream fields in branch header' '
 		git status --porcelain=v2 --untracked-files=all >actual &&
 		test_must_be_empty actual &&
 
-		## Test upstream-gone case. Fake this by pointing origin/master at
-		## a non-existing commit.
-		OLD=$(git rev-parse origin/master) &&
+		## Test upstream-gone case. Fake this by pointing
+		## origin/initial-branch at a non-existing commit.
+		OLD=$(git rev-parse origin/initial-branch) &&
 		NEW=$ZERO_OID &&
 		mv .git/packed-refs .git/old-packed-refs &&
 		sed "s/$OLD/$NEW/g" <.git/old-packed-refs >.git/packed-refs &&
@@ -378,8 +379,8 @@ test_expect_success 'verify upstream fields in branch header' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		EOF
 
 		git status --porcelain=v2 --branch --untracked-files=all >actual &&
@@ -388,19 +389,19 @@ test_expect_success 'verify upstream fields in branch header' '
 '
 
 test_expect_success 'verify --[no-]ahead-behind with V2 format' '
-	git checkout master &&
+	git checkout initial-branch &&
 	test_when_finished "rm -rf sub_repo" &&
 	git clone . sub_repo &&
 	(
-		## Confirm local master tracks remote master.
+		## Confirm local initial-branch tracks remote initial-branch.
 		cd sub_repo &&
 		HUF=$(git rev-parse HEAD) &&
 
 		# Confirm --no-ahead-behind reports traditional branch.ab with 0/0 for equal branches.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		EOF
 
@@ -410,8 +411,8 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		# Confirm --ahead-behind reports traditional branch.ab with 0/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		EOF
 
@@ -428,8 +429,8 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		# Confirm --no-ahead-behind reports branch.ab with ?/? for non-equal branches.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +? -?
 		EOF
 
@@ -439,8 +440,8 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		# Confirm --ahead-behind reports traditional branch.ab with 1/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		EOF
 
@@ -458,7 +459,7 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 '
 
 test_expect_success 'create and add submodule, submodule appears clean (A. S...)' '
-	git checkout master &&
+	git checkout initial-branch &&
 	git clone . sub_repo &&
 	git clone . super_repo &&
 	(	cd super_repo &&
@@ -471,8 +472,8 @@ test_expect_success 'create and add submodule, submodule appears clean (A. S...)
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -496,8 +497,8 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -521,8 +522,8 @@ test_expect_success 'staged changes in added submodule (AM S.M.)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -548,8 +549,8 @@ test_expect_success 'staged and unstaged changes in added (AM S.M.)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -575,8 +576,8 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -602,8 +603,8 @@ test_expect_success 'commit within the submodule appears as new commit in super
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +0 -0
 		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
 		1 AM SC.. 000000 160000 160000 $ZERO_OID $HSUB sub1
@@ -625,8 +626,8 @@ test_expect_success 'stage submodule in super and commit' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		EOF
 
@@ -646,8 +647,8 @@ test_expect_success 'make unstaged changes in existing submodule (.M S.M.)' '
 
 		cat >expect <<-EOF &&
 		# branch.oid $HSUP
-		# branch.head master
-		# branch.upstream origin/master
+		# branch.head initial-branch
+		# branch.upstream origin/initial-branch
 		# branch.ab +1 -0
 		1 .M S.M. 160000 160000 160000 $HSUB $HSUB sub1
 		EOF
-- 
2.29.2-624-g5c89c56a78

