Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE25C3F68F
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEDB2071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UMDCy057"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgAYXBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:01:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46800 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728765AbgAYXAr (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:47 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7FB0960FC9;
        Sat, 25 Jan 2020 23:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993246;
        bh=aGgZXgjC/u7SYDnExKoklgw7U9IxQ+/KT83xluNkPZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UMDCy057I5DGnUlOtrwOpCzr5jK3lM3QdOsLkJU1gV4M+ffpCUda646jPNs37IgnN
         LQfiSVr/Hj0imY6r7t6+cwc2q9yQt8hZCbHj+37XBMLjod+wxGVMFZNJESfvUfBmmp
         ni83e1/wconE95TVjQs3UAm2qZGPGVZsVuXcSFkbcHmYUL4V8R+Eedj3mCEY4k0xpN
         IGPXXRZq0/NUO3pRyNfylyXPGJykfPV7KCbT8a7vmDBP81XfJFjcH14fkHYlIzhi+X
         kWmxQUBZgwY9XZxv8v48/FusGH9dpvxo3oIC+3xftKBVojMBbMdP4dNsK/hwmOo5Ef
         2MAw7dcEOr3zVy85drNt+gFEv1SDUpfdDyquWHTvvNX6QuW+RX72NjMczbWkCjtsDw
         qJUfyXVsFtdW4gCQnXZKyxtiVpSuLwnSOfPOflAmf6FdinxWUH3nE+ENH5xT0blt/l
         ybjy5NMva95ZbftSv1tdkE+4RaJJCbXrVwBDUHDwwsYAHaWDxAx
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/22] t5313: make test hash independent
Date:   Sat, 25 Jan 2020 23:00:19 +0000
Message-Id: <20200125230035.136348-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make this test hash independent by computing the length of the object
offsets and looking up values which will hash to object IDs with the
right properties.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5313-pack-bounds-checks.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index f1708d415e..8d805f845a 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -38,16 +38,27 @@ munge () {
 # for the initial, and another ofs(4*nr) past that for the extended.
 #
 ofs_table () {
-	echo $((4 + 4 + 4*256 + 20*$1 + 4*$1))
+	echo $((4 + 4 + 4*256 + $(test_oid rawsz)*$1 + 4*$1))
 }
 extended_table () {
 	echo $(($(ofs_table "$1") + 4*$1))
 }
 
+test_expect_success 'setup' '
+	test_oid_init &&
+	test_oid_cache <<-EOF
+	oid000 sha1:1485
+	oid000 sha256:4222
+
+	oidfff sha1:74
+	oidfff sha256:1350
+	EOF
+'
+
 test_expect_success 'set up base packfile and variables' '
 	# the hash of this content starts with ff, which
 	# makes some later computations much simpler
-	echo 74 >file &&
+	echo $(test_oid oidfff) >file &&
 	git add file &&
 	git commit -m base &&
 	git repack -ad &&
@@ -140,10 +151,10 @@ test_expect_success 'bogus offset inside v2 extended table' '
 	# an extended table (if the first object were larger than 2^31).
 	#
 	# Note that the value is important here. We want $object as
-	# the second entry in sorted-sha1 order. The sha1 of 1485 starts
+	# the second entry in sorted-sha1 order. The hash of this object starts
 	# with "000", which sorts before that of $object (which starts
 	# with "fff").
-	second=$(echo 1485 | git hash-object -w --stdin) &&
+	second=$(test_oid oid000 | git hash-object -w --stdin) &&
 	do_pack "$object $second" --index-version=2 &&
 
 	# We have to make extra room for the table, so we cannot
