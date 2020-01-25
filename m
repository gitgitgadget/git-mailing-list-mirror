Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B62C3F68F
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BA92075E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oFPTaR0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgAYXAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:00:42 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46796 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgAYXAl (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 18:00:41 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F3DDA60B16;
        Sat, 25 Jan 2020 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579993241;
        bh=W8bEjW1jK7+sbmlEA7koqzn6MKq3jzwfUKdh7EQsURk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=oFPTaR0VHlVP+3Jh82rzCPV9kieHsmjEkrrnKdM1F6J4UjZ9fLV67fNtbX+ddwchp
         /n/gKLr/mQJi7RfEXU9atxlIlgTCeqS7vuhjT+xAqbZj0/mRLP7sJEidfvHWKA/1Wp
         ufpPoHXVqb9SwQb1aas83OyowFDgj0uc3XCmNQQxhWPFCvIquGZHBNUGGpQJCI7Ota
         IF+XEzzyJUk+LdNe6KsqykPwvrO7Kw/Ak+Mv0QrgmCUv2b4zvsbEsK/4r7AQAS6pim
         B+N3DzBwX7abxkMZcpx07PkDaWwpNiWxKIu1DpLDKxZiq9dysJnXWkdBsGMy+r9LvY
         BzKIyXdvdCpqWFG5Izd1Eddtm2MUbqZYmnoJb04rE7qxuqNQa1imgZZJAU9PINwwq5
         pZEaGWRED50W+bFvjTMI9GJl4pHom9xBBrszQtuPAJr737K+O95kZGNP8HoIas10Cl
         UV+lPETrbPfqCKTIAa2HaED+rgUpry6tpSHIzJ3sw3I8h6pq+eX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 01/22] t/lib-pack: support SHA-256
Date:   Sat, 25 Jan 2020 23:00:07 +0000
Message-Id: <20200125230035.136348-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.0.24.g3f081b084b0
In-Reply-To: <20200125230035.136348-1-sandals@crustytoothpaste.net>
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
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
