Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15E21F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfJ1A7h (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729020AbfJ1A7f (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:35 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 56A3B61C71;
        Mon, 28 Oct 2019 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224373;
        bh=qYenGaKPDZjYRksMpqhkwpFuFulBPHCDF0wPtaeFYNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wXm1kKjwZZmPZXcvWGVvWRBzQrY1IBg7Ti+kKg1hbT4zVgmf9bD60X2CL1qOUmOb/
         6m1DOeWmdJUcWrQ7n66vuQ2dHB7TLAbpY0ZFEkXGb26r1aFBGA1foSwIDsUv0AyMDY
         kPKHquOVnKB6xAdMRyl+iIvsgQHQW525ZVAPsrtk82cj8yuvPuwwGzDX4MMg/bgmcb
         XfDnUeguGVDiyV2Jh+Je6w8eWHDXEsrEbupgeIgf6fcO0jco8+9ox/8b8BxXRlHoCr
         rNKBI7j9dN2D6MZTdj0dFNG06+ACA2kXIyqeuG45yqcDKUagcDNQxmnT/3Pxj6meo1
         /H08402mCszk4anE/rQKqL3/Y/zcq1LZDPyRq13Bn8Njh4ZcXmhQCd8kVC5Dt/eSY/
         vwKC5IfNPVD+RZFFDzIwb5b3doIJRMALLwRRbUYgpRSwMuTPhVNejydirbq6eY+UPg
         HtMwvvLxMxCFQZmFslMW4lIN6VYy57W92FshT0xyUAjyx/H6nwH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 10/15] t4034: abstract away SHA-1-specific constants
Date:   Mon, 28 Oct 2019 00:59:02 +0000
Message-Id: <20191028005907.24985-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for object IDs instead of
using hard-coded hashes.  Move some expected result heredocs around so
that they can use computed variables.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4034-diff-words.sh | 93 +++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 9a93c2a3e0..fb145aa173 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -19,9 +19,11 @@ cat >post.simple <<-\EOF
 
 	aeff = aeff * ( aaa )
 EOF
-cat >expect.letter-runs-are-words <<-\EOF
+pre=$(git rev-parse --short $(git hash-object pre.simple))
+post=$(git rev-parse --short $(git hash-object post.simple))
+cat >expect.letter-runs-are-words <<-EOF
 	<BOLD>diff --git a/pre b/post<RESET>
-	<BOLD>index 330b04f..5ed8eff 100644<RESET>
+	<BOLD>index $pre..$post 100644<RESET>
 	<BOLD>--- a/pre<RESET>
 	<BOLD>+++ b/post<RESET>
 	<CYAN>@@ -1,3 +1,7 @@<RESET>
@@ -33,9 +35,9 @@ cat >expect.letter-runs-are-words <<-\EOF
 
 	<GREEN>aeff = aeff * ( aaa<RESET> )
 EOF
-cat >expect.non-whitespace-is-word <<-\EOF
+cat >expect.non-whitespace-is-word <<-EOF
 	<BOLD>diff --git a/pre b/post<RESET>
-	<BOLD>index 330b04f..5ed8eff 100644<RESET>
+	<BOLD>index $pre..$post 100644<RESET>
 	<BOLD>--- a/pre<RESET>
 	<BOLD>+++ b/post<RESET>
 	<CYAN>@@ -1,3 +1,7 @@<RESET>
@@ -49,9 +51,12 @@ cat >expect.non-whitespace-is-word <<-\EOF
 EOF
 
 word_diff () {
+	pre=$(git rev-parse --short $(git hash-object pre)) &&
+	post=$(git rev-parse --short $(git hash-object post)) &&
 	test_must_fail git diff --no-index "$@" pre post >output &&
 	test_decode_color <output >output.decrypted &&
-	test_cmp expect output.decrypted
+	sed -e "2s/index [^ ]*/index $pre..$post/" expect >expected
+	test_cmp expected output.decrypted
 }
 
 test_language_driver () {
@@ -77,9 +82,9 @@ test_expect_success 'set up pre and post with runs of whitespace' '
 '
 
 test_expect_success 'word diff with runs of whitespace' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>index $pre..$post 100644<RESET>
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1,3 +1,7 @@<RESET>
@@ -97,9 +102,9 @@ test_expect_success 'word diff with runs of whitespace' '
 '
 
 test_expect_success '--word-diff=porcelain' '
-	sed 's/#.*$//' >expect <<-\EOF &&
+	sed 's/#.*$//' >expect <<-EOF &&
 		diff --git a/pre b/post
-		index 330b04f..5ed8eff 100644
+		index $pre..$post 100644
 		--- a/pre
 		+++ b/post
 		@@ -1,3 +1,7 @@
@@ -121,9 +126,9 @@ test_expect_success '--word-diff=porcelain' '
 '
 
 test_expect_success '--word-diff=plain' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 		diff --git a/pre b/post
-		index 330b04f..5ed8eff 100644
+		index $pre..$post 100644
 		--- a/pre
 		+++ b/post
 		@@ -1,3 +1,7 @@
@@ -140,9 +145,9 @@ test_expect_success '--word-diff=plain' '
 '
 
 test_expect_success '--word-diff=plain --color' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>index $pre..$post 100644<RESET>
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1,3 +1,7 @@<RESET>
@@ -158,9 +163,9 @@ test_expect_success '--word-diff=plain --color' '
 '
 
 test_expect_success 'word diff without context' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>index $pre..$post 100644<RESET>
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1 +1 @@<RESET>
@@ -207,9 +212,9 @@ test_expect_success 'command-line overrides config' '
 '
 
 test_expect_success 'command-line overrides config: --word-diff-regex' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>index $pre..$post 100644<RESET>
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1,3 +1,7 @@<RESET>
@@ -234,9 +239,9 @@ test_expect_success 'setup: remove diff driver regex' '
 '
 
 test_expect_success 'use configured regex' '
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index 330b04f..5ed8eff 100644<RESET>
+		<BOLD>index $pre..$post 100644<RESET>
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1,3 +1,7 @@<RESET>
@@ -254,9 +259,11 @@ test_expect_success 'use configured regex' '
 test_expect_success 'test parsing words for newline' '
 	echo "aaa (aaa)" >pre &&
 	echo "aaa (aaa) aaa" >post &&
-	cat >expect <<-\EOF &&
+	pre=$(git rev-parse --short $(git hash-object pre)) &&
+	post=$(git rev-parse --short $(git hash-object post)) &&
+	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index c29453b..be22f37 100644<RESET>
+		<BOLD>index $pre..$post 100644<RESET>
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1 +1 @@<RESET>
@@ -268,9 +275,11 @@ test_expect_success 'test parsing words for newline' '
 test_expect_success 'test when words are only removed at the end' '
 	echo "(:" >pre &&
 	echo "(" >post &&
-	cat >expect <<-\EOF &&
+	pre=$(git rev-parse --short $(git hash-object pre)) &&
+	post=$(git rev-parse --short $(git hash-object post)) &&
+	cat >expect <<-EOF &&
 		<BOLD>diff --git a/pre b/post<RESET>
-		<BOLD>index 289cb9d..2d06f37 100644<RESET>
+		<BOLD>index $pre..$post 100644<RESET>
 		<BOLD>--- a/pre<RESET>
 		<BOLD>+++ b/post<RESET>
 		<CYAN>@@ -1 +1 @@<RESET>
@@ -282,9 +291,11 @@ test_expect_success 'test when words are only removed at the end' '
 test_expect_success '--word-diff=none' '
 	echo "(:" >pre &&
 	echo "(" >post &&
-	cat >expect <<-\EOF &&
+	pre=$(git rev-parse --short $(git hash-object pre)) &&
+	post=$(git rev-parse --short $(git hash-object post)) &&
+	cat >expect <<-EOF &&
 		diff --git a/pre b/post
-		index 289cb9d..2d06f37 100644
+		index $pre..$post 100644
 		--- a/pre
 		+++ b/post
 		@@ -1 +1 @@
@@ -317,16 +328,6 @@ test_language_driver ruby
 test_language_driver tex
 
 test_expect_success 'word-diff with diff.sbe' '
-	cat >expect <<-\EOF &&
-	diff --git a/pre b/post
-	index a1a53b5..bc8fe6d 100644
-	--- a/pre
-	+++ b/post
-	@@ -1,3 +1,3 @@
-	a
-
-	[-b-]{+c+}
-	EOF
 	cat >pre <<-\EOF &&
 	a
 
@@ -337,21 +338,35 @@ test_expect_success 'word-diff with diff.sbe' '
 
 	c
 	EOF
+	pre=$(git rev-parse --short $(git hash-object pre)) &&
+	post=$(git rev-parse --short $(git hash-object post)) &&
+	cat >expect <<-EOF &&
+	diff --git a/pre b/post
+	index $pre..$post 100644
+	--- a/pre
+	+++ b/post
+	@@ -1,3 +1,3 @@
+	a
+
+	[-b-]{+c+}
+	EOF
 	test_config diff.suppress-blank-empty true &&
 	word_diff --word-diff=plain
 '
 
 test_expect_success 'word-diff with no newline at EOF' '
-	cat >expect <<-\EOF &&
+	printf "%s" "a a a a a" >pre &&
+	printf "%s" "a a ab a a" >post &&
+	pre=$(git rev-parse --short $(git hash-object pre)) &&
+	post=$(git rev-parse --short $(git hash-object post)) &&
+	cat >expect <<-EOF &&
 	diff --git a/pre b/post
-	index 7bf316e..3dd0303 100644
+	index $pre..$post 100644
 	--- a/pre
 	+++ b/post
 	@@ -1 +1 @@
 	a a [-a-]{+ab+} a a
 	EOF
-	printf "%s" "a a a a a" >pre &&
-	printf "%s" "a a ab a a" >post &&
 	word_diff --word-diff=plain
 '
 
