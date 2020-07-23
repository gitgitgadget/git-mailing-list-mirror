Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC220C43458
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB3B20771
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KlEQLpGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbgGWBKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:18 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387540AbgGWBJ5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:09:57 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 141B760CF7
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466596;
        bh=goOwrFKT3jIZZ5OGkgBL3vofX/12AmAlVGsYY+lDvfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=KlEQLpGl99qat47+7Vq8nbN0E7TTgWQh7yfVAKLrrzBMIouzBtOIhvUrlM4tO9mb4
         MoEEwbq562mNTPAaebW4igI/Kqrz6Uo9G2Q7Ol5CbBXBrZWPdyV6S/rE+26s8qm19Q
         EVxN0atm0XwxF3tKoLsUSx9z3JjguDnlC8zE8FA/4XXx9HWtvfjQoYopPVyNChtKE7
         Yrmbvmdh8tovZvdqM5dIH+aIWhT0/pJREMO+T1rRXML5h+JE4n60SJJrT2IZ0iGmuS
         MfCRr8OKkwdpC4Jsy5HVsv8jURz/YC4v8dzr6sFQJAxxSqoISXYveV40Lc3CfHhfWf
         dvaRR/5eIXS4G7zCjvo4ZMxUc9MexbLHAt8EqBT4F4Oac4jAsaojB9vY70EgArTzys
         Af8pJmkRJFgLgW+VvWnmbLbigtS1xLeiJ4TPnHjbVzOXf48c3nUUfwhfvGvqYr8T9g
         VRPurtorTQHFvsebbRvavWlBpeYIENXiKOi9IXupIPUIkPzPlbw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 13/39] t7102: abstract away SHA-1-specific constants
Date:   Thu, 23 Jul 2020 01:09:17 +0000
Message-Id: <20200723010943.2329634-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7102-reset.sh | 93 +++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 97be0d968d..22161b3b2d 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -37,17 +37,23 @@ test_expect_success 'creating initial files and commits' '
 
 	echo "2nd line 1st file" >>first &&
 	git commit -a -m "modify 1st file" &&
+	head5p2=$(git rev-parse --verify HEAD) &&
+	head5p2f=$(git rev-parse --short HEAD:first) &&
 
 	git rm first &&
 	git mv second secondfile &&
 	git commit -a -m "remove 1st and rename 2nd" &&
+	head5p1=$(git rev-parse --verify HEAD) &&
+	head5p1s=$(git rev-parse --short HEAD:secondfile) &&
 
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
 	# "git commit -m" would break MinGW, as Windows refuse to pass
 	# $test_encoding encoded parameter to git.
 	commit_msg $test_encoding | git -c "i18n.commitEncoding=$test_encoding" commit -a -F - &&
-	head5=$(git rev-parse --verify HEAD)
+	head5=$(git rev-parse --verify HEAD) &&
+	head5s=$(git rev-parse --short HEAD:secondfile) &&
+	head5sl=$(git rev-parse HEAD:secondfile)
 '
 # git log --pretty=oneline # to see those SHA1 involved
 
@@ -94,7 +100,7 @@ test_expect_success 'giving a non existing revision should fail' '
 
 test_expect_success 'reset --soft with unmerged index should fail' '
 	touch .git/MERGE_HEAD &&
-	echo "100644 44c5b5884550c17758737edcced463447b91d42b 1	un" |
+	echo "100644 $head5sl 1	un" |
 		git update-index --index-info &&
 	test_must_fail git reset --soft HEAD &&
 	rm .git/MERGE_HEAD &&
@@ -192,7 +198,7 @@ test_expect_success \
 >.diff_expect
 cat >.cached_expect <<EOF
 diff --git a/secondfile b/secondfile
-index 1bbba79..44c5b58 100644
+index $head5p1s..$head5s 100644
 --- a/secondfile
 +++ b/secondfile
 @@ -1 +1,2 @@
@@ -207,7 +213,7 @@ secondfile:
 EOF
 test_expect_success '--soft reset only should show changes in diff --cached' '
 	git reset --soft HEAD^ &&
-	check_changes d1a4bc3abce4829628ae2dcb0d60ef3d1a78b1c4 &&
+	check_changes $head5p1 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
 			$head5
 '
@@ -242,7 +248,7 @@ EOF
 test_expect_success \
 	'--hard reset should change the files and undo commits permanently' '
 	git reset --hard HEAD~2 &&
-	check_changes ddaefe00f1da16864591c61fdc7adb5d7cd6b74e &&
+	check_changes $head5p2 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
 			$head4
 '
@@ -251,7 +257,7 @@ test_expect_success \
 cat >.cached_expect <<EOF
 diff --git a/first b/first
 deleted file mode 100644
-index 8206c22..0000000
+index $head5p2f..0000000
 --- a/first
 +++ /dev/null
 @@ -1,2 +0,0 @@
@@ -259,14 +265,14 @@ index 8206c22..0000000
 -2nd line 1st file
 diff --git a/second b/second
 deleted file mode 100644
-index 1bbba79..0000000
+index $head5p1s..0000000
 --- a/second
 +++ /dev/null
 @@ -1 +0,0 @@
 -2nd file
 diff --git a/secondfile b/secondfile
 new file mode 100644
-index 0000000..44c5b58
+index 0000000..$head5s
 --- /dev/null
 +++ b/secondfile
 @@ -0,0 +1,2 @@
@@ -286,13 +292,13 @@ test_expect_success \
 	echo "1st line 2nd file" >secondfile &&
 	echo "2nd line 2nd file" >>secondfile &&
 	git add secondfile &&
-	check_changes ddaefe00f1da16864591c61fdc7adb5d7cd6b74e
+	check_changes $head5p2
 '
 
 cat >.diff_expect <<EOF
 diff --git a/first b/first
 deleted file mode 100644
-index 8206c22..0000000
+index $head5p2f..0000000
 --- a/first
 +++ /dev/null
 @@ -1,2 +0,0 @@
@@ -300,7 +306,7 @@ index 8206c22..0000000
 -2nd line 1st file
 diff --git a/second b/second
 deleted file mode 100644
-index 1bbba79..0000000
+index $head5p1s..0000000
 --- a/second
 +++ /dev/null
 @@ -1 +0,0 @@
@@ -314,9 +320,8 @@ secondfile:
 EOF
 test_expect_success '--mixed reset to HEAD should unadd the files' '
 	git reset &&
-	check_changes ddaefe00f1da16864591c61fdc7adb5d7cd6b74e &&
-	test "$(git rev-parse ORIG_HEAD)" = \
-			ddaefe00f1da16864591c61fdc7adb5d7cd6b74e
+	check_changes $head5p2 &&
+	test "$(git rev-parse ORIG_HEAD)" = $head5p2
 '
 
 >.diff_expect
@@ -328,7 +333,7 @@ secondfile:
 EOF
 test_expect_success 'redoing the last two commits should succeed' '
 	git add secondfile &&
-	git reset --hard ddaefe00f1da16864591c61fdc7adb5d7cd6b74e &&
+	git reset --hard $head5p2 &&
 
 	git rm first &&
 	git mv second secondfile &&
@@ -389,47 +394,55 @@ test_expect_success \
 	check_changes $head5
 '
 
-cat > expect << EOF
-diff --git a/file1 b/file1
-index d00491f..7ed6ff8 100644
---- a/file1
-+++ b/file1
-@@ -1 +1 @@
--1
-+5
-diff --git a/file2 b/file2
-deleted file mode 100644
-index 0cfbf08..0000000
---- a/file2
-+++ /dev/null
-@@ -1 +0,0 @@
--2
-EOF
-cat > cached_expect << EOF
-diff --git a/file4 b/file4
-new file mode 100644
-index 0000000..b8626c4
---- /dev/null
-+++ b/file4
-@@ -0,0 +1 @@
-+4
-EOF
 test_expect_success 'test --mixed <paths>' '
 	echo 1 > file1 &&
 	echo 2 > file2 &&
 	git add file1 file2 &&
 	test_tick &&
 	git commit -m files &&
+	before1=$(git rev-parse --short HEAD:file1) &&
+	before2=$(git rev-parse --short HEAD:file2) &&
 	git rm file2 &&
 	echo 3 > file3 &&
 	echo 4 > file4 &&
 	echo 5 > file1 &&
+	after1=$(git rev-parse --short $(git hash-object file1)) &&
+	after4=$(git rev-parse --short $(git hash-object file4)) &&
 	git add file1 file3 file4 &&
 	git reset HEAD -- file1 file2 file3 &&
 	test_must_fail git diff --quiet &&
 	git diff > output &&
+
+	cat > expect <<-EOF &&
+	diff --git a/file1 b/file1
+	index $before1..$after1 100644
+	--- a/file1
+	+++ b/file1
+	@@ -1 +1 @@
+	-1
+	+5
+	diff --git a/file2 b/file2
+	deleted file mode 100644
+	index $before2..0000000
+	--- a/file2
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-2
+	EOF
+
 	test_cmp expect output &&
 	git diff --cached > output &&
+
+	cat > cached_expect <<-EOF &&
+	diff --git a/file4 b/file4
+	new file mode 100644
+	index 0000000..$after4
+	--- /dev/null
+	+++ b/file4
+	@@ -0,0 +1 @@
+	+4
+	EOF
+
 	test_cmp cached_expect output
 '
 
