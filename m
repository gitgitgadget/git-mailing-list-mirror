Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBBDC35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F2A20838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="norzF3Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGAxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:53:34 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55516 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgBGAxd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:53:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DBE856079D;
        Fri,  7 Feb 2020 00:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581036812;
        bh=W8bEjW1jK7+sbmlEA7koqzn6MKq3jzwfUKdh7EQsURk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=norzF3DwIBC6Rv4WJA2nL/dfET4PkOKLWrlRyhokqVRbyqa/bueKD/ByeO2JBOkrw
         GlH0TN3iT6I7+38n7yynRucPBJeM9YAG9lsAzXqvhE39js72Wt8yd3fCnHvmDnGe1l
         7px2l+vjv/FSpk0jICmVHQ+nxlDfVZHqXEo5GR9iCa81a3tgV2kVVuL50pwaNzprYk
         v9NP6YweDP4R1KPnm9THqqKj3yQWz/E5zVJYRG3LKr0MqiNQzvtI8SbSMe/gFUc21E
         idY+KPOyP7agFQRNk2Vh3meWcfF+5IZT6skpXqEFhfGB7jCwv0COPx1d2+l0jRwZva
         Xij95sVGkmKD2KVcUMIC22ihM5hP/OGRnwr/0gBHRqxmvFmNocrP/Vfb6VnC8TIWhc
         saNyIt8rMn9/tGz5+mJvxBCa2LgeAMDXjmdQNGQ3Mh2eIl8gYEoVcvOfQUuXfmRrVq
         xgJ1UIYoO5x/NMNqgWz+dz1IEmVPXA+Tp/4lsAa7ynaDfGmmpVZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/21] t/lib-pack: support SHA-256
Date:   Fri,  7 Feb 2020 00:52:34 +0000
Message-Id: <20200207005254.1495851-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7
In-Reply-To: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
References: <20200207005254.1495851-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the support routines for generating packs to support both SHA-1
and SHA-256.  Compute the trailing pack checksum and its length
correctly depending on the algorithm, and look up the object names based
on the algorithm as well.  Ensure we initialize the algorithm facts so
that our callers need not do so.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-pack.sh | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index c4d907a450..f3463170b3 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -35,9 +35,11 @@ pack_header () {
 # have hardcoded some well-known objects. See the case statements below for the
 # complete list.
 pack_obj () {
+	test_oid_init
+
 	case "$1" in
 	# empty blob
-	e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
+	$EMPTY_BLOB)
 		case "$2" in
 		'')
 			printf '\060\170\234\003\0\0\0\0\1'
@@ -47,7 +49,7 @@ pack_obj () {
 		;;
 
 	# blob containing "\7\76"
-	e68fe8129b546b101aee9510c5328e7f21ca1d18)
+	$(test_oid packlib_7_76))
 		case "$2" in
 		'')
 			printf '\062\170\234\143\267\3\0\0\116\0\106'
@@ -59,11 +61,18 @@ pack_obj () {
 			printf '\234\143\142\142\142\267\003\0\0\151\0\114'
 			return
 			;;
+		37c8e2c15bb22b912e59b43fd51a4f7e9465ed0b5084c5a1411d991cbe630683)
+			printf '\165\67\310\342\301\133\262\53\221\56\131' &&
+			printf '\264\77\325\32\117\176\224\145\355\13\120' &&
+			printf '\204\305\241\101\35\231\34\276\143\6\203\170' &&
+			printf '\234\143\142\142\142\267\003\0\0\151\0\114'
+			return
+			;;
 		esac
 		;;
 
 	# blob containing "\7\0"
-	01d7713666f4de822776c7622c10f1b07de280dc)
+	$(test_oid packlib_7_0))
 		case "$2" in
 		'')
 			printf '\062\170\234\143\147\0\0\0\20\0\10'
@@ -75,6 +84,13 @@ pack_obj () {
 			printf '\143\142\142\142\147\0\0\0\53\0\16'
 			return
 			;;
+		5d8e6fc40f2dab00e6983a48523fe57e621f46434cb58dbd4422fba03380d886)
+			printf '\165\135\216\157\304\17\55\253\0\346\230\72' &&
+			printf '\110\122\77\345\176\142\37\106\103\114\265' &&
+			printf '\215\275\104\42\373\240\63\200\330\206\170\234' &&
+			printf '\143\142\142\142\147\0\0\0\53\0\16'
+			return
+			;;
 		esac
 		;;
 	esac
@@ -86,7 +102,7 @@ pack_obj () {
 	then
 		echo "$1" | git pack-objects --stdout >pack_obj.tmp &&
 		size=$(wc -c <pack_obj.tmp) &&
-		dd if=pack_obj.tmp bs=1 count=$((size - 20 - 12)) skip=12 &&
+		dd if=pack_obj.tmp bs=1 count=$((size - $(test_oid rawsz) - 12)) skip=12 &&
 		rm -f pack_obj.tmp
 		return
 	fi
@@ -97,7 +113,8 @@ pack_obj () {
 
 # Compute and append pack trailer to "$1"
 pack_trailer () {
-	test-tool sha1 -b <"$1" >trailer.tmp &&
+	test_oid_init &&
+	test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
 	cat trailer.tmp >>"$1" &&
 	rm -f trailer.tmp
 }
@@ -108,3 +125,11 @@ pack_trailer () {
 clear_packs () {
 	rm -f .git/objects/pack/*
 }
+
+test_oid_cache <<-EOF
+packlib_7_0 sha1:01d7713666f4de822776c7622c10f1b07de280dc
+packlib_7_0 sha256:37c8e2c15bb22b912e59b43fd51a4f7e9465ed0b5084c5a1411d991cbe630683
+
+packlib_7_76 sha1:e68fe8129b546b101aee9510c5328e7f21ca1d18
+packlib_7_76 sha256:5d8e6fc40f2dab00e6983a48523fe57e621f46434cb58dbd4422fba03380d886
+EOF
