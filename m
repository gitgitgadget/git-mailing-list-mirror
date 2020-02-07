Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BEDC352A3
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568DE21775
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="icfUj4fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBGAxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55584 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgBGAxk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:40 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5A64A607F2;
        Fri,  7 Feb 2020 00:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036818;
        bh=d570N9h4wLAG/qvAZVH+KxGvfAmDSNkkzoDJcYZppVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=icfUj4frHknygLyGHMuae8NXwofxnQF9A17mFFMFiCyHOoTAKTDAqfiJfbNuhV7rm
         7aoXS+ctaqnclFEC6sJEuQYoxYMGnQ0NZpKd6dvfRTx2w6eYbJ7+ius/6kFk3vDJZG
         G50yY6kSL4L8SiobBRqC1Rhf8Ol+OKq1/MOe4dHgEpXXYPjUHEFvQj3UlakEQMDHwv
         rNCYKeWK4JVX9yRMCWOyWmhpgMRjTQNMVkRhm3awI9lA7JGzyWjd//oWj/pG7bJVVU
         0ubbmKwH2QNeYEs2NZeeoGpsGVH0btENk4HSDNtBtq0eEBQr6fCerOhYuFW6J2i15Q
         YGP9Lgnh3qXQOHUTbxBjylN6vPwDmB0d1YzKHn2uwo9kmV/zEx+ZTpLSUZTPnMVXOB
         ap9i4odmsGLIfsXN2VEthoTt8Ja3FOO7e30PWGn+Kxz+VocaF7wNFey/tSt+FX1ucT
         Jillbca5S+hdVuYFAnH+kjpzppBIYzA9FJLeI32d//0ibsie6v0
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/21] t5313: make test hash independent
Date:   Fri,  7 Feb 2020 00:52:46 +0000
Message-Id: <20200207005254.1495851-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
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
index f1708d415e..2a4557efc2 100755
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
+	# the second entry in sorted-hash order. The hash of this object starts
 	# with "000", which sorts before that of $object (which starts
 	# with "fff").
-	second=$(echo 1485 | git hash-object -w --stdin) &&
+	second=$(test_oid oid000 | git hash-object -w --stdin) &&
 	do_pack "$object $second" --index-version=2 &&
 
 	# We have to make extra room for the table, so we cannot
