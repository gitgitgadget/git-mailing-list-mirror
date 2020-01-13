Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF073C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62F120678
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 12:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dw/UfAeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMMkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:40:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37622 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728679AbgAMMkj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Jan 2020 07:40:39 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D2760607FD;
        Mon, 13 Jan 2020 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578919239;
        bh=aGgZXgjC/u7SYDnExKoklgw7U9IxQ+/KT83xluNkPZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=dw/UfAeKRPEYVWxFbP2xFy3oZyVm/FNSkjON494B7gOK43LSO+6z2uBjZ3BgBZ056
         uzat7Kp8Ot78rGpLJtyKGVseET+/1pmWh1ZeXM8B9J/EmN0q6CVtjzLYHQ86VLS6H2
         yHZFg0HsAiIzr3gUM7Mf4CSA6zhcBJLeCS2ABubnPGBZuPeGMJWJ3Yv8etbQbZfd5F
         oMOvaiz9R74cgZcF2oGeGgTPoDb0oCSoMZ5PhM4E0yZVdVIpHcjw9tYYf+lv5Jlcfi
         z6JfpBVDi39nlnfD45jebr3IWe9OcklIg65fb2AoARIzalyjLiVYi4lf400zVTkqYb
         8xSlq+yJSd/lDVQ6S0VNoBPFKXlrU+5opIbrjPongTk+ickDghYpk0sat2W83cMrDn
         DpJNHGQlLaC0WneFbWgF/CSc3CtXzNy+wtV74PU2CsZ9cA7FIfmjIpTBpzh3X0CPQA
         P6TyduaDMKEEelMXSRax/Xm8smMdMfileylZyuuppCsvZ6el+MC
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 14/24] t5313: make test hash independent
Date:   Mon, 13 Jan 2020 12:38:47 +0000
Message-Id: <20200113123857.3684632-15-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.rc2.338.g21a285fb81
In-Reply-To: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net>
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
