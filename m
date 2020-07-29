Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68738C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476592067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 23:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mzrreOp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgG2XPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:15:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41116 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbgG2XPC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Jul 2020 19:15:02 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0635F61020;
        Wed, 29 Jul 2020 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596064498;
        bh=pybST+Ml60xM98F42OzVvvCAYKpI2wVMt8HjANV3VuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=mzrreOp5xnHD0EepQ7MbJSutFwck8m2Vok5ZxcxyIXmcMFZkebmRF4vrQ78jwAU28
         bQyQYoUEMAFzdwHxxtaNVE18HGZ0jsqoxOIcpLJEVzeL7YB8MwMnNNcbvarUdrOSYD
         jOum99AuyOA+INh+ApXlI4/CH8Ee72trMr9BZIVrdxRS02w/RMDtF+N5Q0O3r8k9dw
         KRpXaWOssT26TxyDNEwFeCwa/pMaQEi4Zm1r35xCrwSGpvCzrT9OcwFI/2miKcSA49
         XwFAxPvV+MGap/D1PHajpe1KniyIPQtfb+qv9kZ5M0ztU79W6r/zpsYzbMBsrGG8k+
         IY1N/OZAes1H8hUiviH0zSvNboTZAH+UySul0X0w1bq7KioIz60Z9F9FQLoVqpFT7W
         2uIWlr1Ge1WlAPcDIrVQeVRaB7FuENR7HCMhCKkY/cbQqoyhlcyRag0cLn4npu9ON0
         Sc9r3bmDdK+D1LhyXaGlgpjH3EIumY490volxCCqjwmBcrtspSr
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 27/39] t5308: make test work with SHA-256
Date:   Wed, 29 Jul 2020 23:14:16 +0000
Message-Id: <20200729231428.3658647-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test needs multiple object IDs that have the same first byte.
Update the pack test code to generate a suitable packed value for
SHA-256.  Update the test to use this value when using SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-pack.sh                     |  8 ++++++++
 t/t5308-pack-detect-duplicates.sh | 20 ++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index f3463170b3..0c799d53c6 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -93,6 +93,14 @@ pack_obj () {
 			;;
 		esac
 		;;
+	# blob containing "\3\326"
+	471819e8c52bf11513f100b2810a8aa0622d5cd3d1c913758a071dd4b3bad8fe)
+		case "$2" in
+		'')
+			printf '\062\170\234\143\276\006\000\000\336\000\332'
+			return
+			;;
+		esac
 	esac
 
 	# If it's not a delta, we can convince pack-objects to generate a pack
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 6845c1f3c3..693b2411c8 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -4,23 +4,27 @@ test_description='handling of duplicate objects in incoming packfiles'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
-if ! test_have_prereq SHA1
-then
-       skip_all='not using SHA-1 for objects'
-       test_done
-fi
+test_expect_success 'setup' '
+	test_oid_cache <<-EOF
+	lo_oid sha1:e68fe8129b546b101aee9510c5328e7f21ca1d18
+	lo_oid sha256:471819e8c52bf11513f100b2810a8aa0622d5cd3d1c913758a071dd4b3bad8fe
+
+	missing_oid sha1:e69d000000000000000000000000000000000000
+	missing_oid sha256:4720000000000000000000000000000000000000000000000000000000000000
+	EOF
+'
 
 # The sha1s we have in our pack. It's important that these have the same
 # starting byte, so that they end up in the same fanout section of the index.
 # That lets us make sure we are exercising the binary search with both sets.
-LO_SHA1=e68fe8129b546b101aee9510c5328e7f21ca1d18
-HI_SHA1=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+LO_SHA1=$(test_oid lo_oid)
+HI_SHA1=$EMPTY_BLOB
 
 # And here's a "missing sha1" which will produce failed lookups. It must also
 # be in the same fanout section, and should be between the two (so that during
 # our binary search, we are sure to end up looking at one or the other of the
 # duplicate runs).
-MISSING_SHA1='e69d000000000000000000000000000000000000'
+MISSING_SHA1=$(test_oid missing_oid)
 
 # git will never intentionally create packfiles with
 # duplicate objects, so we have to construct them by hand.
