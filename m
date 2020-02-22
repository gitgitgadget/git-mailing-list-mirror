Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6BEC35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661D8206ED
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="A2pgtBac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgBVUSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:18:06 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39076 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbgBVUSG (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 22 Feb 2020 15:18:06 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E6B176079C
        for <git@vger.kernel.org>; Sat, 22 Feb 2020 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582402685;
        bh=Jyzh/+8JdSqCyzClFXmXxxmIe0I6aIhQg/LvFgoCr3E=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=A2pgtBacQdQcOt0k0FRtMC80dK2iYVBlArx767vtKSEyyYGcRHiOQQUIntAg/MCfH
         9nDVWRRf/cCR+t2lZH4LiVWAKj8fATNvE2gAez291cXWY60UhxKX54Z6H5vrFhyx6a
         I7XbHWdzsGWh2QAGkYkKar2AzUGZd8oSR7RoGLqHtFwAPcItJ33g6GLOxxrw1cUPv8
         XmVSTpQhhnHEbNdQQ3U19PYgVKWlN57c7ak/TzH+xm2ZX2ybN6th7Akux6RcOzM1sj
         V7/h56sP46rTqIDntBoiFWZN8FGi8zWrjLEdtRBUgHsv5Mk+hvYvuzYhydCMxLlOtX
         NJ2JfuoX1OFLVy49wdIkgza2q/Ln2Wz/9wuvAJP3eDDD9wTWGhn6sTu0a3nYPnh2xG
         SXC9x5E2GiNlWsz0XDua1OG9Dzq6411rq68rVn10RYYcIymlHV2NIuIiZDEcPgtIVP
         EVfWzq4LXahul9TcpV17CzY5QsU/vjQwjM/ELmh+UwEfH0ZRh5i
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v2 03/24] hex: introduce parsing variants taking hash algorithms
Date:   Sat, 22 Feb 2020 20:17:28 +0000
Message-Id: <20200222201749.937983-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200222201749.937983-1-sandals@crustytoothpaste.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce variants of get_oid_hex and parse_oid_hex that parse an
arbitrary hash algorithm, implementing internal functions to avoid
duplication.  These functions can be used in the transport code to parse
refs properly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h |  7 +++++++
 hex.c   | 35 +++++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 37c899b53f..4c9c21a11d 100644
--- a/cache.h
+++ b/cache.h
@@ -1481,6 +1481,9 @@ int set_disambiguate_hint_config(const char *var, const char *value);
 int get_sha1_hex(const char *hex, unsigned char *sha1);
 int get_oid_hex(const char *hex, struct object_id *sha1);
 
+/* Like get_oid_hex, but for an arbitrary hash algorithm. */
+int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
+
 /*
  * Read `len` pairs of hexadecimal digits from `hex` and write the
  * values to `binary` as `len` bytes. Return 0 on success, or -1 if
@@ -1516,6 +1519,10 @@ char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
  */
 int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
 
+/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
+int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char **end,
+			const struct git_hash_algo *algo);
+
 /*
  * This reads short-hand syntax that not only evaluates to a commit
  * object name, but also can act as if the end user spelled the name
diff --git a/hex.c b/hex.c
index fd7f00c43f..10e24dc2e4 100644
--- a/hex.c
+++ b/hex.c
@@ -47,30 +47,49 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 	return 0;
 }
 
-int get_sha1_hex(const char *hex, unsigned char *sha1)
+static int get_hash_hex_algop(const char *hex, unsigned char *hash,
+			      const struct git_hash_algo *algop)
 {
 	int i;
-	for (i = 0; i < the_hash_algo->rawsz; i++) {
+	for (i = 0; i < algop->rawsz; i++) {
 		int val = hex2chr(hex);
 		if (val < 0)
 			return -1;
-		*sha1++ = val;
+		*hash++ = val;
 		hex += 2;
 	}
 	return 0;
 }
 
+int get_sha1_hex(const char *hex, unsigned char *sha1)
+{
+	return get_hash_hex_algop(hex, sha1, the_hash_algo);
+}
+
+int get_oid_hex_algop(const char *hex, struct object_id *oid,
+		      const struct git_hash_algo *algop)
+{
+	return get_hash_hex_algop(hex, oid->hash, algop);
+}
+
 int get_oid_hex(const char *hex, struct object_id *oid)
 {
-	return get_sha1_hex(hex, oid->hash);
+	return get_oid_hex_algop(hex, oid, the_hash_algo);
+}
+
+int parse_oid_hex_algop(const char *hex, struct object_id *oid,
+			const char **end,
+			const struct git_hash_algo *algop)
+{
+	int ret = get_hash_hex_algop(hex, oid->hash, algop);
+	if (!ret)
+		*end = hex + algop->hexsz;
+	return ret;
 }
 
 int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
 {
-	int ret = get_oid_hex(hex, oid);
-	if (!ret)
-		*end = hex + the_hash_algo->hexsz;
-	return ret;
+	return parse_oid_hex_algop(hex, oid, end, the_hash_algo);
 }
 
 char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
