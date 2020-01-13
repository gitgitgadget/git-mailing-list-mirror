Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AA6C33CB0
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67992073D
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="o2Tbbzzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgAMMkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:45 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37620 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728621AbgAMMkh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:37 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C6925607FE;
        Mon, 13 Jan 2020 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919237;
        bh=P7Eb1uTkSRBA1VkCADh0qnpHNCwZGD8+akROJz/FO6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=o2TbbzzvbFhbRut6sTww5KyjAM6Z+JopUc+F/Jpu/45/Hg22BzojiWfaoE886Bv6g
         RLRYltv9kumhYrbWXRfBCnZA9KVtIYWT0FoDuT42Duz+YMZ2ODAhhVvtnzQHoGS0dj
         RHL/x7yZ5tx50R2uT5ZVwkJHPIvoKOimbSax5FdId7SZmGIoXPp8L5Jh25AkDENqoJ
         84ezKms2ugqL5a38XwooIrkQryzTGt8JTMRaJEIxdX70gYROZ2xWL6s3Rz+vIC2+5l
         wej6hW3fGHif5vXBvMvfkx9LzIaNFu8kcSzRiBrpCzwahtqZzYiyvSSkyVNGvTU5Qm
         /nDqQvokJDWfxHM9iD1sQKTq4ymbJYh3d7o2ehJ/rW4Jw2PAFdNG0ICYR7GZPHcRNJ
         mpon5rjx9jaOCBBAZh+zSmu5VA+J4z2BkONvI7SqEs4IPDqcoF6rq3GiIJi1U+h1YH
         /rMT1F4Nn8GKSnsqVUhifk2f1vXe51z9YRNvqHn8asBd0c/OGSv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 10/24] t4060: make test work with SHA-256
Date:   Mon, 13 Jan 2020 12:38:43 +0000
Message-Id: <20200113123857.3684632-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this test, there are two main types of object IDs we see in the
diffs: the ones for the submodules, which we care about, and the ones
for the individual files, which are unrelated to what we're testing.
Much of the test already computes the former, so extend the rest of the
test to do so as well.  Add a diff comparison function that normalizes
the differences in the latter, since they're not explicitly what we're
testing.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4060-diff-submodule-option-diff-format.sh | 126 ++++++++++---------
 1 file changed, 70 insertions(+), 56 deletions(-)

diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 9dcb69df5c..fc8229c726 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -42,6 +42,17 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
+diff_cmp () {
+       for i in "$1" "$2"
+       do
+		sed -e 's/^index 0000000\.\.[0-9a-f]*/index 0000000..1234567/' \
+		-e 's/^index [0-9a-f]*\.\.[0-9a-f]*/index 1234567..89abcde/' \
+		"$i" >"$i.compare" || return 1
+       done &&
+       test_cmp "$1.compare" "$2.compare" &&
+       rm -f "$1.compare" "$2.compare"
+}
+
 test_expect_success 'setup repository' '
 	test_create_repo sm1 &&
 	add_file . foo &&
@@ -69,7 +80,7 @@ test_expect_success 'added submodule' '
 	@@ -0,0 +1 @@
 	+foo2
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'added submodule, set diff.submodule' '
@@ -93,7 +104,7 @@ test_expect_success 'added submodule, set diff.submodule' '
 	@@ -0,0 +1 @@
 	+foo2
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success '--submodule=short overrides diff.submodule' '
@@ -109,7 +120,7 @@ test_expect_success '--submodule=short overrides diff.submodule' '
 	@@ -0,0 +1 @@
 	+Subproject commit $fullhead1
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'diff.submodule does not affect plumbing' '
@@ -124,7 +135,7 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 	@@ -0,0 +1 @@
 	+Subproject commit $fullhead1
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 commit_file sm1 &&
@@ -142,7 +153,7 @@ test_expect_success 'modified submodule(forward)' '
 	@@ -0,0 +1 @@
 	+foo3
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule(forward)' '
@@ -157,7 +168,7 @@ test_expect_success 'modified submodule(forward)' '
 	@@ -0,0 +1 @@
 	+foo3
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule(forward) --submodule' '
@@ -166,7 +177,7 @@ test_expect_success 'modified submodule(forward) --submodule' '
 	Submodule sm1 $head1..$head2:
 	  > Add foo3 ($added foo3)
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 fullhead2=$(cd sm1; git rev-parse --verify HEAD)
@@ -181,7 +192,7 @@ test_expect_success 'modified submodule(forward) --submodule=short' '
 	-Subproject commit $fullhead1
 	+Subproject commit $fullhead2
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 commit_file sm1 &&
@@ -210,7 +221,7 @@ test_expect_success 'modified submodule(backward)' '
 	@@ -1 +0,0 @@
 	-foo3
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 head4=$(add_file sm1 foo4 foo5)
@@ -247,7 +258,7 @@ test_expect_success 'modified submodule(backward and forward)' '
 	@@ -0,0 +1 @@
 	+foo5
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 commit_file sm1 &&
@@ -291,7 +302,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	@@ -0,0 +1 @@
 	+sm1
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'typechanged submodule(submodule->blob)' '
@@ -327,7 +338,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	@@ -0,0 +1 @@
 	+foo5
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 rm -rf sm1 &&
@@ -344,7 +355,7 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	@@ -0,0 +1 @@
 	+sm1
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 rm -f sm1 &&
@@ -356,7 +367,7 @@ test_expect_success 'nonexistent commit' '
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...$head6 (commits not present)
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 commit_file
@@ -386,11 +397,12 @@ test_expect_success 'typechanged submodule(blob->submodule)' '
 	@@ -0,0 +1 @@
 	+foo7
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 commit_file sm1 &&
 test_expect_success 'submodule is up to date' '
+	head7=$(git -C sm1 rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
 '
@@ -401,7 +413,7 @@ test_expect_success 'submodule contains untracked content' '
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'submodule contains untracked content (untracked ignored)' '
@@ -433,7 +445,7 @@ test_expect_success 'submodule contains untracked and modified content' '
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 # NOT OK
@@ -450,7 +462,7 @@ test_expect_success 'submodule contains untracked and modified content (untracke
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'submodule contains untracked and modified content (dirty ignored)' '
@@ -478,7 +490,7 @@ test_expect_success 'submodule contains modified content' '
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 (cd sm1; git commit -mchange foo6 >/dev/null) &&
@@ -486,7 +498,7 @@ head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
 test_expect_success 'submodule is modified' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9..$head8:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6
@@ -495,7 +507,7 @@ test_expect_success 'submodule is modified' '
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule contains untracked content' '
@@ -503,7 +515,7 @@ test_expect_success 'modified submodule contains untracked content' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
-	Submodule sm1 17243c9..$head8:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6
@@ -512,13 +524,13 @@ test_expect_success 'modified submodule contains untracked content' '
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
 	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9..$head8:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6
@@ -527,13 +539,13 @@ test_expect_success 'modified submodule contains untracked content (untracked ig
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule contains untracked content (dirty ignored)' '
 	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6
@@ -542,7 +554,7 @@ test_expect_success 'modified submodule contains untracked content (dirty ignore
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule contains untracked content (all ignored)' '
@@ -556,7 +568,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 	cat >expected <<-EOF &&
 	Submodule sm1 contains untracked content
 	Submodule sm1 contains modified content
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..dfda541 100644
 	--- a/sm1/foo6
@@ -566,7 +578,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
 	+new
 	+modification
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
@@ -574,7 +586,7 @@ test_expect_success 'modified submodule contains untracked and modified content
 	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..e20e2d9 100644
 	--- a/sm1/foo6
@@ -585,14 +597,14 @@ test_expect_success 'modified submodule contains untracked and modified content
 	+modification
 	+modification
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule contains untracked and modified content (dirty ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..3e75765 100644
 	--- a/sm1/foo6
@@ -601,7 +613,7 @@ test_expect_success 'modified submodule contains untracked and modified content
 	-foo6
 	+new
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
@@ -616,7 +628,7 @@ test_expect_success 'modified submodule contains modified content' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
-	Submodule sm1 17243c9..cfce562:
+	Submodule sm1 $head7..$head8:
 	diff --git a/sm1/foo6 b/sm1/foo6
 	index 462398b..ac466ca 100644
 	--- a/sm1/foo6
@@ -629,29 +641,29 @@ test_expect_success 'modified submodule contains modified content' '
 	+modification
 	+modification
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 rm -rf sm1
 test_expect_success 'deleted submodule' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9...0000000 (submodule deleted)
+	Submodule sm1 $head7...0000000 (submodule deleted)
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'create second submodule' '
 	test_create_repo sm2 &&
-	head7=$(add_file sm2 foo8 foo9) &&
+	head9=$(add_file sm2 foo8 foo9) &&
 	git add sm2
 '
 
 test_expect_success 'multiple submodules' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9...0000000 (submodule deleted)
-	Submodule sm2 0000000...a5a65c9 (new submodule)
+	Submodule sm1 $head7...0000000 (submodule deleted)
+	Submodule sm2 0000000...$head9 (new submodule)
 	diff --git a/sm2/foo8 b/sm2/foo8
 	new file mode 100644
 	index 0000000..db9916b
@@ -667,13 +679,13 @@ test_expect_success 'multiple submodules' '
 	@@ -0,0 +1 @@
 	+foo9
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'path filter' '
 	git diff-index -p --submodule=diff HEAD sm2 >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm2 0000000...a5a65c9 (new submodule)
+	Submodule sm2 0000000...$head9 (new submodule)
 	diff --git a/sm2/foo8 b/sm2/foo8
 	new file mode 100644
 	index 0000000..db9916b
@@ -689,15 +701,15 @@ test_expect_success 'path filter' '
 	@@ -0,0 +1 @@
 	+foo9
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 commit_file sm2
 test_expect_success 'given commit' '
 	git diff-index -p --submodule=diff HEAD^ >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9...0000000 (submodule deleted)
-	Submodule sm2 0000000...a5a65c9 (new submodule)
+	Submodule sm1 $head7...0000000 (submodule deleted)
+	Submodule sm2 0000000...$head9 (new submodule)
 	diff --git a/sm2/foo8 b/sm2/foo8
 	new file mode 100644
 	index 0000000..db9916b
@@ -713,7 +725,7 @@ test_expect_success 'given commit' '
 	@@ -0,0 +1 @@
 	+foo9
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'setup .git file for sm2' '
@@ -726,8 +738,8 @@ test_expect_success 'setup .git file for sm2' '
 test_expect_success 'diff --submodule=diff with .git file' '
 	git diff --submodule=diff HEAD^ >actual &&
 	cat >expected <<-EOF &&
-	Submodule sm1 17243c9...0000000 (submodule deleted)
-	Submodule sm2 0000000...a5a65c9 (new submodule)
+	Submodule sm1 $head7...0000000 (submodule deleted)
+	Submodule sm2 0000000...$head9 (new submodule)
 	diff --git a/sm2/foo8 b/sm2/foo8
 	new file mode 100644
 	index 0000000..db9916b
@@ -743,25 +755,27 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	@@ -0,0 +1 @@
 	+foo9
 	EOF
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'setup nested submodule' '
 	git submodule add -f ./sm2 &&
 	git commit -a -m "add sm2" &&
 	git -C sm2 submodule add ../sm2 nested &&
-	git -C sm2 commit -a -m "nested sub"
+	git -C sm2 commit -a -m "nested sub" &&
+	head10=$(git -C sm2 rev-parse --short --verify HEAD)
 '
 
 test_expect_success 'move nested submodule HEAD' '
 	echo "nested content" >sm2/nested/file &&
 	git -C sm2/nested add file &&
-	git -C sm2/nested commit --allow-empty -m "new HEAD"
+	git -C sm2/nested commit --allow-empty -m "new HEAD" &&
+	head11=$(git -C sm2/nested rev-parse --short --verify HEAD)
 '
 
 test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
 	cat >expected <<-EOF &&
-	Submodule nested a5a65c9..b55928c:
+	Submodule nested $head9..$head11:
 	diff --git a/nested/file b/nested/file
 	new file mode 100644
 	index 0000000..ca281f5
@@ -772,13 +786,13 @@ test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
 	EOF
 	git -C sm2 diff --submodule=diff >actual 2>err &&
 	test_must_be_empty err &&
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_expect_success 'diff --submodule=diff recurses into nested submodules' '
 	cat >expected <<-EOF &&
 	Submodule sm2 contains modified content
-	Submodule sm2 a5a65c9..280969a:
+	Submodule sm2 $head9..$head10:
 	diff --git a/sm2/.gitmodules b/sm2/.gitmodules
 	new file mode 100644
 	index 0000000..3a816b8
@@ -788,7 +802,7 @@ test_expect_success 'diff --submodule=diff recurses into nested submodules' '
 	+[submodule "nested"]
 	+	path = nested
 	+	url = ../sm2
-	Submodule nested 0000000...b55928c (new submodule)
+	Submodule nested 0000000...$head11 (new submodule)
 	diff --git a/sm2/nested/file b/sm2/nested/file
 	new file mode 100644
 	index 0000000..ca281f5
@@ -813,7 +827,7 @@ test_expect_success 'diff --submodule=diff recurses into nested submodules' '
 	EOF
 	git diff --submodule=diff >actual 2>err &&
 	test_must_be_empty err &&
-	test_cmp expected actual
+	diff_cmp expected actual
 '
 
 test_done
