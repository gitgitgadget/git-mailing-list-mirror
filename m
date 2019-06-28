Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B059C1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 22:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfF1W7x (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 18:59:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56404 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbfF1W7w (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jun 2019 18:59:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f01a:2fd6:a95e:5f84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6062D6101F;
        Fri, 28 Jun 2019 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1561762791;
        bh=T7rijjU2Zgwersyt6zc56DVPUOglzJre5rtDu89Y2RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ysLwSDs7BEjtjGLOf8PVGbzbxvjwjnCRo87xCjWPOw6T0u4ZbM1b1/Bj0wkwUsQRw
         F+7IJgQ2hb/vD0oOakkoH1eaR7dMksZvRY2PAGGsugC0jwZshOSXv4Irh0zrLXgLK8
         ZIvbTfxEpXSEfLOygTYvVv707vOcS3Icq4jZQe1eMxHcfdlBBjIga7I8R1+j5ksbMM
         lJQUSo/IOR6PSemEIqMygJZfAjuKmGZjqU6jpMxfTlLt9LvwMmxe+oBSMSZi5+BTOw
         RIX00GanMJN3bFOsDT1xr9sVZvatohF/TQ2Nt59/vVC/E6Om3tvWG4O8iKV0cLS8l3
         MTI0+kF5sXmRfQe2vjtjLoyE0njDMrWpRxPBzQHRXPfNNCDcKfIQ2rCMBIvPvbZ6H8
         b29mE4fkc3HyoNqGhqQm7TeDT7xPRTy5SwRdEcVyh0s3EWW4AtqB+44QqszxEKn5MS
         x8Hx8+wpxLEA5ndg4yWZFmURIheufM6WjECzNTfMLgv3XbIHM4o
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/10] t1710: make hash independent
Date:   Fri, 28 Jun 2019 22:59:27 +0000
Message-Id: <20190628225928.622372-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190628225928.622372-1-sandals@crustytoothpaste.net>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses several index hashes, which necessarily depend on the
version of the index and the hash algorithm in use.  Use test_oid_cache
to provide values for these for both SHA-1 and SHA-256.  Also, compute
an object ID and use $EMPTY_BLOB to make the remainder of the tests
independent of the hash algorithm in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t1700-split-index.sh | 51 ++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 4f2f84f309..12a5568844 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -20,6 +20,22 @@ create_non_racy_file () {
 	test-tool chmtime =-5 "$1"
 }
 
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	own_v3 sha1:8299b0bcd1ac364e5f1d7768efb62fa2da79a339
+	own_v3 sha256:38a6d2925e3eceec33ad7b34cbff4e0086caa0daf28f31e51f5bd94b4a7af86b
+
+	base_v3 sha1:39d890139ee5356c7ef572216cebcd27aa41f9df
+	base_v3 sha256:c9baeadf905112bf6c17aefbd7d02267afd70ded613c30cafed2d40cb506e1ed
+
+	own_v4 sha1:432ef4b63f32193984f339431fd50ca796493569
+	own_v4 sha256:6738ac6319c25b694afa7bcc313deb182d1a59b68bf7a47b4296de83478c0420
+
+	base_v4 sha1:508851a7f0dfa8691e9f69c7f055865389012491
+	base_v4 sha256:3177d4adfdd4b6904f7e921d91d715a471c0dde7cf6a4bba574927f02b699508
+	EOF
+'
+
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
 	git update-index --split-index &&
@@ -29,11 +45,11 @@ test_expect_success 'enable split index' '
 	# NEEDSWORK: Stop hard-coding checksums.
 	if test "$indexversion" = "4"
 	then
-		own=432ef4b63f32193984f339431fd50ca796493569
-		base=508851a7f0dfa8691e9f69c7f055865389012491
+		own=$(test_oid own_v4)
+		base=$(test_oid base_v4)
 	else
-		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
-		base=39d890139ee5356c7ef572216cebcd27aa41f9df
+		own=$(test_oid own_v3)
+		base=$(test_oid base_v3)
 	fi &&
 
 	cat >expect <<-EOF &&
@@ -99,17 +115,18 @@ test_expect_success 'enable split index again, "one" now belongs to base index"'
 
 test_expect_success 'modify original file, base index untouched' '
 	echo modified | create_non_racy_file one &&
+	file1_blob=$(git hash-object one) &&
 	git update-index one &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
-	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+	100644 $file1_blob 0	one
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	q_to_tab >expect <<-EOF &&
 	$BASE
-	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+	100644 $file1_blob 0Q
 	replacements: 0
 	deletions:
 	EOF
@@ -121,7 +138,7 @@ test_expect_success 'add another file, which stays index' '
 	git update-index --add two &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
-	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+	100644 $file1_blob 0	one
 	100644 $EMPTY_BLOB 0	two
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
@@ -129,7 +146,7 @@ test_expect_success 'add another file, which stays index' '
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	q_to_tab >expect <<-EOF &&
 	$BASE
-	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+	100644 $file1_blob 0Q
 	100644 $EMPTY_BLOB 0	two
 	replacements: 0
 	deletions:
@@ -141,14 +158,14 @@ test_expect_success 'remove file not in base index' '
 	git update-index --force-remove two &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
-	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0	one
+	100644 $file1_blob 0	one
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	q_to_tab >expect <<-EOF &&
 	$BASE
-	100644 2e0996000b7e9019eabcad29391bf0f5c7702f0b 0Q
+	100644 $file1_blob 0Q
 	replacements: 0
 	deletions:
 	EOF
@@ -237,9 +254,9 @@ test_expect_success 'set core.splitIndex config variable to true' '
 	git update-index --add three &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	three
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	three
+	100644 $EMPTY_BLOB 0	two
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 	BASE=$(test-tool dump-split-index .git/index | grep "^base") &&
@@ -257,8 +274,8 @@ test_expect_success 'set core.splitIndex config variable to false' '
 	git update-index --force-remove three &&
 	git ls-files --stage >ls-files.actual &&
 	cat >ls-files.expect <<-EOF &&
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	two
+	100644 $EMPTY_BLOB 0	one
+	100644 $EMPTY_BLOB 0	two
 	EOF
 	test_cmp ls-files.expect ls-files.actual &&
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
@@ -285,7 +302,7 @@ test_expect_success 'set core.splitIndex config variable back to true' '
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	four
+	100644 $EMPTY_BLOB 0	four
 	replacements:
 	deletions:
 	EOF
@@ -309,7 +326,7 @@ test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
 	test-tool dump-split-index .git/index | sed "/^own/d" >actual &&
 	cat >expect <<-EOF &&
 	$BASE
-	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	six
+	100644 $EMPTY_BLOB 0	six
 	replacements:
 	deletions:
 	EOF
