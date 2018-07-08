Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25D01F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 23:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933335AbeGHXhg (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 19:37:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932878AbeGHXgw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 19:36:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2960F60747;
        Sun,  8 Jul 2018 23:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531093011;
        bh=Dh07yAP0S1WYJ5syUYfyivyovR7vMSPjpKYViBtKKXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=fPIxOPVpsPSC20ryhX290LN37O8iTtjk3mkjoj3zNNFPGEYF4U+/ax/B1RATJJXi0
         rzAt276K8N+WFz56WcpiVYCdgd6j55vYBuSD+ajr/3ezpurFkTrfwtBafU++AAKyMi
         HK1uopRb5CbCaN82MeIK3+QnrTfyxDDQAyO97FLuMa6XJ5RIaZURxCyx2RI0b++v64
         rv2yQfW8bC9pSUlDkbGi6Hm+F5TwOWx8OrqV2pbARLmRiCXBFKypQFO/sHN4mA2ir/
         PSrPEciCSLJa5NRKYUtH8rmHX3CVVzdot1p0SRjdtrM1XxKrkYYqN4aYOBrp6gLVsB
         pwiAjuH6+gu6ngIDmKMWYsJjm5SwQG1hxkHwn64KwemN12mL6BEDPJrBdtTQnT+duQ
         IQeYm/kCyQzmk9HbWL3tN5uNW6eL/xic4UsjaoG4Jm3rSRJdSLqAN9Vq31ns2GvDG5
         tJMFlXeLaGpQf37v2IuLhjTgA9dgrtHqBSoCNo/L7f7gdqi09zv
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/17] hex: switch to using the_hash_algo
Date:   Sun,  8 Jul 2018 23:36:24 +0000
Message-Id: <20180708233638.520172-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180708233638.520172-1-sandals@crustytoothpaste.net>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the GIT_SHA1_* constants, switch to using the_hash_algo
to convert object IDs to and from hex format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 hex.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hex.c b/hex.c
index 8df2d63728..10af1a29e8 100644
--- a/hex.c
+++ b/hex.c
@@ -50,7 +50,7 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
-	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
+	for (i = 0; i < the_hash_algo->rawsz; i++) {
 		int val = hex2chr(hex);
 		if (val < 0)
 			return -1;
@@ -69,7 +69,7 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
 {
 	int ret = get_oid_hex(hex, oid);
 	if (!ret)
-		*end = hex + GIT_SHA1_HEXSZ;
+		*end = hex + the_hash_algo->hexsz;
 	return ret;
 }
 
@@ -79,7 +79,7 @@ char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 	char *buf = buffer;
 	int i;
 
-	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
+	for (i = 0; i < the_hash_algo->rawsz; i++) {
 		unsigned int val = *sha1++;
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
