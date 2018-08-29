Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8581F404
	for <e@80x24.org>; Wed, 29 Aug 2018 00:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeH2ExY (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 00:53:24 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37322 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbeH2ExY (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 00:53:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2DE566081A
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535504348;
        bh=aTAUHBtr5JEM4vGqbbaGgAVwP3MMHAqG8qvQUw8YWxI=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=mCMFpurWRWrWTfkrHxW20yPy7k3r1hQs8ge3e8wW3zoC3Zf3wG243bhrsY3p2sKAU
         kHgoJt75V9lPm3czs4jMjmi1nE94Qw1NF1EuKwrM/LruF0avx0DzVdUnOyRDjPabMD
         6wY3BPY2SHBHcYvVuXdsV/xuiPh7kme9w5x8zhhKT9BVeHpdZlyazZuMqOboz/tL8X
         Jr99u5NFtcCkDiEm0ZAwaRiMz1Iqj1bOIy8DE/kSINo0T/wpMQIFisksKsL1r0YtEN
         3Z4+/0hpWn9RRLJwORcWkP1bD4Wzn1oR3mAAcd54SXNvqRA/2l8wUvFCftZPsCXNaZ
         N5j6Y64OVwq8mqiwm6dXEmwDG5raKomD1AwG0UnvUrkFGNmncGq2hVPBXs7NV9V4BB
         lMnjZdEdyIctmLRRVyLDXFD0CUPRtQ/y6EkdfEyCUg/goH81vQMKE6Dt8TVitr8ug1
         CUiCyPOWa9W27c/yOSJRSp5T7FmUhLjeg5K/4rrdGYOTxWsCZve
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 03/12] hex: introduce functions to print arbitrary hashes
Date:   Wed, 29 Aug 2018 00:58:48 +0000
Message-Id: <20180829005857.980820-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
In-Reply-To: <20180829005857.980820-1-sandals@crustytoothpaste.net>
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, we have functions that turn an arbitrary SHA-1 value or an
object ID into hex format, either using a static buffer or with a
user-provided buffer.  Add variants of these functions that can handle
an arbitrary hash algorithm, specified by constant.  Update the
documentation as well.

While we're at it, remove the "extern" declaration from this family of
functions, since it's not needed and our style now recommends against
it.

We use the variant taking the algorithm structure pointer as the
internal variant, since in the future we'll want to replace sha1_to_hex
with a hash_to_hex that handles the_hash_algo, and taking an algorithm
pointer is the easiest way to handle all of the variants in use.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 14 ++++++++------
 hex.c   | 32 ++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 4d014541ab..3cb953445c 100644
--- a/cache.h
+++ b/cache.h
@@ -1351,9 +1351,9 @@ extern int get_oid_hex(const char *hex, struct object_id *sha1);
 extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
 
 /*
- * Convert a binary sha1 to its hex equivalent. The `_r` variant is reentrant,
+ * Convert a binary hash to its hex equivalent. The `_r` variant is reentrant,
  * and writes the NUL-terminated output to the buffer `out`, which must be at
- * least `GIT_SHA1_HEXSZ + 1` bytes, and returns a pointer to out for
+ * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
  * convenience.
  *
  * The non-`_r` variant returns a static buffer, but uses a ring of 4
@@ -1361,10 +1361,12 @@ extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
  *
  *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
  */
-extern char *sha1_to_hex_r(char *out, const unsigned char *sha1);
-extern char *oid_to_hex_r(char *out, const struct object_id *oid);
-extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
-extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
+char *hash_to_hex_algo_r(char *buffer, const unsigned char *hash, int algo);
+char *sha1_to_hex_r(char *out, const unsigned char *sha1);
+char *oid_to_hex_r(char *out, const struct object_id *oid);
+char *hash_to_hex_algo(const unsigned char *hash, int algo);	/* static buffer result! */
+char *sha1_to_hex(const unsigned char *sha1);			/* same static buffer */
+char *oid_to_hex(const struct object_id *oid);			/* same static buffer */
 
 /*
  * Parse a 40-character hexadecimal object ID starting from hex, updating the
diff --git a/hex.c b/hex.c
index 10af1a29e8..870032a868 100644
--- a/hex.c
+++ b/hex.c
@@ -73,14 +73,15 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
 	return ret;
 }
 
-char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
+static inline char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
+					const struct git_hash_algo *algop)
 {
 	static const char hex[] = "0123456789abcdef";
 	char *buf = buffer;
 	int i;
 
-	for (i = 0; i < the_hash_algo->rawsz; i++) {
-		unsigned int val = *sha1++;
+	for (i = 0; i < algop->rawsz; i++) {
+		unsigned int val = *hash++;
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
 	}
@@ -89,20 +90,35 @@ char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 	return buffer;
 }
 
-char *oid_to_hex_r(char *buffer, const struct object_id *oid)
+char *hash_to_hex_algo_r(char *buffer, const unsigned char *hash, int algo)
 {
-	return sha1_to_hex_r(buffer, oid->hash);
+	return hash_to_hex_algop_r(buffer, hash, &hash_algos[algo]);
 }
 
-char *sha1_to_hex(const unsigned char *sha1)
+char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
+{
+	return hash_to_hex_algo_r(buffer, sha1, GIT_HASH_SHA1);
+}
+
+char *oid_to_hex_r(char *buffer, const struct object_id *oid)
+{
+	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
+}
+
+char *hash_to_hex_algo(const unsigned char *hash, int algo)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	return sha1_to_hex_r(hexbuffer[bufno], sha1);
+	return hash_to_hex_algo_r(hexbuffer[bufno], hash, algo);
+}
+
+char *sha1_to_hex(const unsigned char *sha1)
+{
+	return hash_to_hex_algo(sha1, GIT_HASH_SHA1);
 }
 
 char *oid_to_hex(const struct object_id *oid)
 {
-	return sha1_to_hex(oid->hash);
+	return hash_to_hex_algo(oid->hash, hash_algo_by_ptr(the_hash_algo));
 }
