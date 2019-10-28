Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565B61F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJ1A7k (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729068AbfJ1A7h (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4CB3C62061;
        Mon, 28 Oct 2019 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224376;
        bh=caxNNuYwTJoI8ptat8Y449AK/P/k0yNfqXKdzaJFfYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=jley64wzz0BBBBmAI0pte5b53QjpQKF5KE3DGXZ8xAyMPBo9T6/xdKBwDeAbHa0rx
         Ozg7VMJ6XR3Jf64TChvKl2kM4AtBxYkynSwev0WkZ0XJ0J7hsWHa6yoUCB729FSS3c
         xgdOeQ6/NNCFvGMqpZ94VG7ObvL2DPWKCGWB+HlRWhzRWObnfyNRai801MQkghVmTb
         3KghDnAxzx3X+NipBh9RRLdtdcmrJZ5mQLgMdpxRoirAH4yEbBNgZ1cmk/pxglZ6ts
         mydCWeP2LXWJFC19F1VRao9oDgOhI7ck5ETEyvylKil85ycbSdX6YwAZXEKCX3Vzb6
         EQliMeMaoKez1ZAQXuyTPk6tuUjx2CabZYyc+hv9zWOfnjbWWpl3A8Nqpgngac7vSI
         T86CSoo6PQwzfEbr8Qm3FIMup0TedlSFWmYqsiCz/POMnSvBpu3MrqreqXKx+yeINo
         c51+Qha570pjPyBAa5R2IeCiPCxv3MTVoDnV+ul6HuIkOHLm4sy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 13/15] t4044: update test to work with SHA-256
Date:   Mon, 28 Oct 2019 00:59:05 +0000
Message-Id: <20191028005907.24985-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test produces pseudo-collisions and tests git diff's behavior with
them, and is therefore sensitive to the hash in use. Update the test to
compute the collisions for both SHA-1 and SHA-256 using appropriate
constants. Move the heredocs inside the setup block so that all of the
setup code can be tested for failure.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4044-diff-index-unique-abbrev.sh | 46 +++++++++++++++++++----------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index 647905e01f..4701796d10 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -3,34 +3,48 @@
 test_description='test unique sha1 abbreviation on "index from..to" line'
 . ./test-lib.sh
 
-if ! test_have_prereq SHA1
-then
-       skip_all='not using SHA-1 for objects'
-       test_done
-fi
-
-cat >expect_initial <<EOF
-100644 blob 51d2738463ea4ca66f8691c91e33ce64b7d41bb1	foo
-EOF
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF &&
+	val1 sha1:4827
+	val1 sha256:5664
 
-cat >expect_update <<EOF
-100644 blob 51d2738efb4ad8a1e40bed839ab8e116f0a15e47	foo
-EOF
+	val2 sha1:11742
+	val2 sha256:10625
 
-test_expect_success 'setup' '
-	echo 4827 > foo &&
+	hash1 sha1:51d2738463ea4ca66f8691c91e33ce64b7d41bb1
+	hash1 sha256:ae31dfff0af93b2c62b0098a039b38569c43b0a7e97b873000ca42d128f27350
+
+	hasht1 sha1:51d27384
+	hasht1 sha256:ae31dfff
+
+	hash2 sha1:51d2738efb4ad8a1e40bed839ab8e116f0a15e47
+	hash2 sha256:ae31dffada88a46fd5f53c7ed5aa25a7a8951f1d5e88456c317c8d5484d263e5
+
+	hasht2 sha1:51d2738e
+	hasht2 sha256:ae31dffa
+	EOF
+
+	cat >expect_initial <<-EOF &&
+	100644 blob $(test_oid hash1)	foo
+	EOF
+
+	cat >expect_update <<-EOF &&
+	100644 blob $(test_oid hash2)	foo
+	EOF
+
+	echo "$(test_oid val1)" > foo &&
 	git add foo &&
 	git commit -m "initial" &&
 	git cat-file -p HEAD: > actual &&
 	test_cmp expect_initial actual &&
-	echo 11742 > foo &&
+	echo "$(test_oid val2)" > foo &&
 	git commit -a -m "update" &&
 	git cat-file -p HEAD: > actual &&
 	test_cmp expect_update actual
 '
 
 cat >expect <<EOF
-index 51d27384..51d2738e 100644
+index $(test_oid hasht1)..$(test_oid hasht2) 100644
 EOF
 
 test_expect_success 'diff does not produce ambiguous index line' '
