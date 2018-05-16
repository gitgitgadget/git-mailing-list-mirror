Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E571F406
	for <e@80x24.org>; Wed, 16 May 2018 01:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeEPB7h (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:59:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47422 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752555AbeEPB6x (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 May 2018 21:58:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:64f1:3b3f:8f13:59ed])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 452D16074C;
        Wed, 16 May 2018 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1526435932;
        bh=BXcJLkDCDoZ5ZXnZR0BpQANCQmQYyfRL5ThDS15MBqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HMLHHOKIqCNgl3KEfRWhSsWHjR1fcWTQGSYOlP87avzsYPH2fEUVgskABVTQwjVOq
         bSWVXokuMKPRNuM65RbgYNjG8yCUOtlqwfVmiiQ06xtqyBko+gJcljQDDGrwxZh5aU
         cfszSAjfb16mEQO6Pt0d8TgB9tMmaJtXj0jtxvG4igCxr0O9UxNzst13mgNq78pry5
         mXXK9lgn0/4At7VPseDHUbBCuNCElRT3nhApXA64gn6cqMpBDe3iUAA7XsDeK2FK9M
         RQTgrBXuWPh8FIM1mIvWRPMs+KqyhRHpxrZgeyySpLzyMIEfB+WauWeWv6mGZ0CbKz
         KUgIMtGF45DgSVDvtM8dcVRCld412ORmGJpiVlupXT5y7kVbXz2B3j/E62Unkbg94P
         bI4D/zpPKl9PFIOYGoutWKAIoHF2oxqU6RgohvDEzjfGt/eYnAUR6jwJXypuxiLa4/
         L6nK7s7OLgT1Ac30qsNaoU7+8y6VWGV/QEQqQ2rJEOM3MPC6DDa
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 16/28] t4008: abstract away SHA-1-specific constants
Date:   Wed, 16 May 2018 01:56:18 +0000
Message-Id: <20180516015630.661349-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d
In-Reply-To: <20180516015630.661349-1-sandals@crustytoothpaste.net>
References: <20180516015630.661349-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes variables for blobs instead of using
hard-coded hashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4008-diff-break-rewrite.sh | 59 +++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 9dd1bc5e16..b1ccd4102e 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -27,29 +27,32 @@ Further, with -B and -M together, these should turn into two renames.
 test_expect_success setup '
 	cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
 	cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
+	blob0_id=$(git hash-object file0) &&
+	blob1_id=$(git hash-object file1) &&
 	git update-index --add file0 file1 &&
 	git tag reference $(git write-tree)
 '
 
 test_expect_success 'change file1 with copy-edit of file0 and remove file0' '
 	sed -e "s/git/GIT/" file0 >file1 &&
+	blob2_id=$(git hash-object file1) &&
 	rm -f file0 &&
 	git update-index --remove file0 file1
 '
 
 test_expect_success 'run diff with -B (#1)' '
 	git diff-index -B --cached reference >current &&
-	cat >expect <<-\EOF &&
-	:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
-	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
+	cat >expect <<-EOF &&
+	:100644 000000 $blob0_id $ZERO_OID D	file0
+	:100644 100644 $blob1_id $blob2_id M100	file1
 	EOF
 	compare_diff_raw expect current
 '
 
 test_expect_success 'run diff with -B and -M (#2)' '
 	git diff-index -B -M reference >current &&
-	cat >expect <<-\EOF &&
-	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec R100	file0	file1
+	cat >expect <<-EOF &&
+	:100644 100644 $blob0_id $blob2_id R100	file0	file1
 	EOF
 	compare_diff_raw expect current
 '
@@ -66,18 +69,18 @@ test_expect_success 'swap file0 and file1' '
 
 test_expect_success 'run diff with -B (#3)' '
 	git diff-index -B reference >current &&
-	cat >expect <<-\EOF &&
-	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M100	file0
-	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
+	cat >expect <<-EOF &&
+	:100644 100644 $blob0_id $blob1_id M100	file0
+	:100644 100644 $blob1_id $blob0_id M100	file1
 	EOF
 	compare_diff_raw expect current
 '
 
 test_expect_success 'run diff with -B and -M (#4)' '
 	git diff-index -B -M reference >current &&
-	cat >expect <<-\EOF &&
-	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	file1	file0
-	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 R100	file0	file1
+	cat >expect <<-EOF &&
+	:100644 100644 $blob1_id $blob1_id R100	file1	file0
+	:100644 100644 $blob0_id $blob0_id R100	file0	file1
 	EOF
 	compare_diff_raw expect current
 '
@@ -85,14 +88,15 @@ test_expect_success 'run diff with -B and -M (#4)' '
 test_expect_success 'make file0 into something completely different' '
 	rm -f file0 &&
 	test_ln_s_add frotz file0 &&
+	slink_id=$(printf frotz | git hash-object --stdin) &&
 	git update-index file1
 '
 
 test_expect_success 'run diff with -B (#5)' '
 	git diff-index -B reference >current &&
-	cat >expect <<-\EOF &&
-	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
+	cat >expect <<-EOF &&
+	:100644 120000 $blob0_id $slink_id T	file0
+	:100644 100644 $blob1_id $blob0_id M100	file1
 	EOF
 	compare_diff_raw expect current
 '
@@ -103,9 +107,9 @@ test_expect_success 'run diff with -B -M (#6)' '
 	# file0 changed from regular to symlink.  file1 is the same as the preimage
 	# of file0.  Because the change does not make file0 disappear, file1 is
 	# denoted as a copy of file0
-	cat >expect <<-\EOF &&
-	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 C	file0	file1
+	cat >expect <<-EOF &&
+	:100644 120000 $blob0_id $slink_id T	file0
+	:100644 100644 $blob0_id $blob0_id C	file0	file1
 	EOF
 	compare_diff_raw expect current
 '
@@ -115,9 +119,9 @@ test_expect_success 'run diff with -M (#7)' '
 
 	# This should not mistake file0 as the copy source of new file1
 	# due to type differences.
-	cat >expect <<-\EOF &&
-	:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M	file1
+	cat >expect <<-EOF &&
+	:100644 120000 $blob0_id $slink_id T	file0
+	:100644 100644 $blob1_id $blob0_id M	file1
 	EOF
 	compare_diff_raw expect current
 '
@@ -128,25 +132,26 @@ test_expect_success 'file1 edited to look like file0 and file0 rename-edited to
 	git checkout-index -f -u -a &&
 	sed -e "s/git/GIT/" file0 >file1 &&
 	sed -e "s/git/GET/" file0 >file2 &&
+	blob3_id=$(git hash-object file2) &&
 	rm -f file0 &&
 	git update-index --add --remove file0 file1 file2
 '
 
 test_expect_success 'run diff with -B (#8)' '
 	git diff-index -B reference >current &&
-	cat >expect <<-\EOF &&
-	:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
-	:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
-	:000000 100644 0000000000000000000000000000000000000000 69a939f651686f56322566e2fd76715947a24162 A	file2
+	cat >expect <<-EOF &&
+	:100644 000000 $blob0_id $ZERO_OID D	file0
+	:100644 100644 $blob1_id $blob2_id M100	file1
+	:000000 100644 $ZERO_OID $blob3_id A	file2
 	EOF
 	compare_diff_raw expect current
 '
 
 test_expect_success 'run diff with -B -C (#9)' '
 	git diff-index -B -C reference >current &&
-	cat >expect <<-\EOF &&
-	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec C095	file0	file1
-	:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 69a939f651686f56322566e2fd76715947a24162 R095	file0	file2
+	cat >expect <<-EOF &&
+	:100644 100644 $blob0_id $blob2_id C095	file0	file1
+	:100644 100644 $blob0_id $blob3_id R095	file0	file2
 	EOF
 	compare_diff_raw expect current
 '
