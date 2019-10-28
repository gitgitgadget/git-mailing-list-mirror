Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F51F1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfJ1A7d (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54276 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729020AbfJ1A7b (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:31 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EB5B862060;
        Mon, 28 Oct 2019 00:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224370;
        bh=Io3GEtjGxkxTXgMRRT6rCYpv5ba/nutgRmzDADdppIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IkSVGMRdW2vOlxEFY7K9gqipk6ywgBQdqSC9aMBRMyHiFulgzZwseTAGXssQjVsaU
         rAwgE6/4+omTu6SlUjaTKqrN2S+gxhOJsOZBSXh4eXrSxksZqXyo6XkM/wIOjiGHCX
         4qnYfEthixms/m3jyId8yGxV5QKoqefHxFZqncgVjY2HdUECfw3LwP1nd1WcV1omkl
         i4Dcw5gg2K0Bow56w7SKd+J9Ze24C07DZ/OvodWJ429C2UD9Ibg6BP9TbvPWz/jZ94
         dDbBS3VAFgGjXdcCHgPDeD2JQnS7pXAsSUXgXORs7WvbkBC+z4An6nBljOpgPHB6pW
         L9nRA+WDsAEPsudBBybcUvfUgg0SfbdWSREVjXdNOMK16en1H1Xx/Rkdxh9mLYZSxI
         zShrPvoKgpxnONM1M7Db22aH0ZTLEvBEK1Hh4TEz0FCRM4HoBNXW+fflG9hgo4hfOi
         vDnwnTTFQUwknUxfBpZI6J8RcqvdaSwukPA3L1ubtLGeaDOkVmO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 07/15] t4011: abstract away SHA-1-specific constants
Date:   Mon, 28 Oct 2019 00:58:59 +0000
Message-Id: <20191028005907.24985-8-sandals@crustytoothpaste.net>
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
using hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4011-diff-symlink.sh | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 5ae19b987d..717034bb50 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -9,11 +9,24 @@ test_description='Test diff of symlinks.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
+# Print the short OID of a symlink with the given name.
+symlink_oid () {
+	local oid=$(printf "%s" "$1" | git hash-object --stdin) &&
+	git rev-parse --short "$oid"
+}
+
+# Print the short OID of the given file.
+short_oid () {
+	local oid=$(git hash-object "$1") &&
+	git rev-parse --short "$oid"
+}
+
 test_expect_success 'diff new symlink and file' '
-	cat >expected <<-\EOF &&
+	symlink=$(symlink_oid xyzzy) &&
+	cat >expected <<-EOF &&
 	diff --git a/frotz b/frotz
 	new file mode 120000
-	index 0000000..7c465af
+	index 0000000..$symlink
 	--- /dev/null
 	+++ b/frotz
 	@@ -0,0 +1 @@
@@ -21,7 +34,7 @@ test_expect_success 'diff new symlink and file' '
 	\ No newline at end of file
 	diff --git a/nitfol b/nitfol
 	new file mode 100644
-	index 0000000..7c465af
+	index 0000000..$symlink
 	--- /dev/null
 	+++ b/nitfol
 	@@ -0,0 +1 @@
@@ -46,10 +59,10 @@ test_expect_success 'diff unchanged symlink and file'  '
 '
 
 test_expect_success 'diff removed symlink and file' '
-	cat >expected <<-\EOF &&
+	cat >expected <<-EOF &&
 	diff --git a/frotz b/frotz
 	deleted file mode 120000
-	index 7c465af..0000000
+	index $symlink..0000000
 	--- a/frotz
 	+++ /dev/null
 	@@ -1 +0,0 @@
@@ -57,7 +70,7 @@ test_expect_success 'diff removed symlink and file' '
 	\ No newline at end of file
 	diff --git a/nitfol b/nitfol
 	deleted file mode 100644
-	index 7c465af..0000000
+	index $symlink..0000000
 	--- a/nitfol
 	+++ /dev/null
 	@@ -1 +0,0 @@
@@ -90,9 +103,10 @@ test_expect_success 'diff identical, but newly created symlink and file' '
 '
 
 test_expect_success 'diff different symlink and file' '
-	cat >expected <<-\EOF &&
+	new=$(symlink_oid yxyyz) &&
+	cat >expected <<-EOF &&
 	diff --git a/frotz b/frotz
-	index 7c465af..df1db54 120000
+	index $symlink..$new 120000
 	--- a/frotz
 	+++ b/frotz
 	@@ -1 +1 @@
@@ -101,7 +115,7 @@ test_expect_success 'diff different symlink and file' '
 	+yxyyz
 	\ No newline at end of file
 	diff --git a/nitfol b/nitfol
-	index 7c465af..df1db54 100644
+	index $symlink..$new 100644
 	--- a/nitfol
 	+++ b/nitfol
 	@@ -1 +1 @@
@@ -137,14 +151,16 @@ test_expect_success SYMLINKS 'setup symlinks with attributes' '
 '
 
 test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
-	cat >expect <<-\EOF &&
+	file=$(short_oid file.bin) &&
+	link=$(symlink_oid file.bin) &&
+	cat >expect <<-EOF &&
 	diff --git a/file.bin b/file.bin
 	new file mode 100644
-	index 0000000..d95f3ad
+	index 0000000..$file
 	Binary files /dev/null and b/file.bin differ
 	diff --git a/link.bin b/link.bin
 	new file mode 120000
-	index 0000000..dce41ec
+	index 0000000..$link
 	--- /dev/null
 	+++ b/link.bin
 	@@ -0,0 +1 @@
