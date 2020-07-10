Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909C2C433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B02B20663
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 02:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="LSpDSIUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGJCsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:48:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40398 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbgGJCso (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Jul 2020 22:48:44 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C44760A70;
        Fri, 10 Jul 2020 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1594349315;
        bh=pybST+Ml60xM98F42OzVvvCAYKpI2wVMt8HjANV3VuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=LSpDSIUPB2ckPE8nZXFAnFEzzyVzkGvTPt/zXz8Ne9KuqvEcZnFr74upib7nv3kvT
         bE29kvZnLrCEj0LEGTxrW75Uon7GhaGItO8rxy2WLi+RKc7TssGaAOPghAauonHV9t
         2dCi41lAq4dPl1akFUqYFCOtzbSTsM0WDbWof+Fm3L4OGVV9VZF0kbSu55MpUgUjF9
         0OD13rlQ1Vp3cng4dD40g8dJBbwBKJJrDaxfSmsNHNODmPmmytv9Jh7nS0vTbGnbb0
         3dx/jLREbCtfKnbmgM+DE2MHsJRdBcCp0bB+6g8B4KYdiIPs+UUxyghFvwhXDygVeT
         TGKs2G3XFv6FaplEAhT2O5tcOHsH6jBLRbnJJr3cqohcIQ+4c1lV/JJZRgxFiHPGXC
         lbA6DiLPveZg60GLuakau/8tLIUMbMIUkLE9yWBdUKcxwR7aLpWZRP3vVlbfuT39LN
         W23n9a5k+HycfMGG6Z59cj+J/rU+8z6m4WIbeP4CO1IhnsiiHsH
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 27/38] t5308: make test work with SHA-256
Date:   Fri, 10 Jul 2020 02:47:17 +0000
Message-Id: <20200710024728.3100527-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.353.gb9a2d1a020
In-Reply-To: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
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
