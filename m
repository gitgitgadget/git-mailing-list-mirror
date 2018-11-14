Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FD61F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeKNOLn (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:11:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54400 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727154AbeKNOLn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2018 09:11:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9234760B16;
        Wed, 14 Nov 2018 04:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542168616;
        bh=wdFnQVeDPhZrqioTq5NA/sAVnAakqfn9PxbDxlWQ8Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lfBQvBfWShPomyvpUu50B9Pc7D0xWqFTHzi1my/GXqbLNuZwtkOlJ3U1B6olNix3K
         cLJvp8Oc4xpf+gBPe2ERXT4HGv1RD6sA85HRrbAYunH2rU6wboHsvzYEJWhVpRMC/E
         VAto2ilbO0qzXqcJMtO/LboI4TmpISxJpcdVou+HzEhVPE9THrG9u3fvG8ORMfaPB0
         SrJ5bmBpSVQPx/iTHsCtD2B9UPXxMaSDoGW1dQfAN5IwBmCdYI5UeJXAASLmD8jN/E
         eRmF8CQcLGuZtWTtfG72JUVwU7s6BIjypP97817Zuf6o9VrinQFfhyxMhAO+jpD2lk
         +GloLDXkcXarJJg9+NdV988LgYVQVmJ8KGcFiw4HICiaXej2M327PtCyqGK3WGYhkQ
         wtmiHQD8itVgzJJQH+1PyOaiZUQkiJb1sSHwplCt86Tw/Fv8OJnMJl9fIpFcknXa4J
         9uRaCk0yjAi241aUX8Hj7YWhbBZYSoY9yjB8uCErTwWXIhaoRdS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 03/12] hex: introduce functions to print arbitrary hashes
Date:   Wed, 14 Nov 2018 04:09:29 +0000
Message-Id: <20181114040938.517289-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245
In-Reply-To: <20181114040938.517289-1-sandals@crustytoothpaste.net>
References: <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181114040938.517289-1-sandals@crustytoothpaste.net>
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
internal variant, since taking an algorithm pointer is the easiest way
to handle all of the variants in use.

Note that we maintain these functions because there are hashes which
must change based on the hash algorithm in use but are not object IDs
(such as pack checksums).

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h | 15 +++++++++------
 hex.c   | 32 ++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index ca36b44ee0..cb7268deea 100644
--- a/cache.h
+++ b/cache.h
@@ -1365,9 +1365,9 @@ extern int get_oid_hex(const char *hex, struct object_id *sha1);
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
@@ -1375,10 +1375,13 @@ extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
  *
  *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
  */
-extern char *sha1_to_hex_r(char *out, const unsigned char *sha1);
-extern char *oid_to_hex_r(char *out, const struct object_id *oid);
-extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
-extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
+char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const struct git_hash_algo *);
+char *sha1_to_hex_r(char *out, const unsigned char *sha1);
+char *oid_to_hex_r(char *out, const struct object_id *oid);
+char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *);	/* static buffer result! */
+char *sha1_to_hex(const unsigned char *sha1);						/* same static buffer */
+char *hash_to_hex(const unsigned char *hash);						/* same static buffer */
+char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
 
 /*
  * Parse a 40-character hexadecimal object ID starting from hex, updating the
diff --git a/hex.c b/hex.c
index 10af1a29e8..7850a8879d 100644
--- a/hex.c
+++ b/hex.c
@@ -73,14 +73,15 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
 	return ret;
 }
 
-char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
+char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
+			  const struct git_hash_algo *algop)
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
+char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
 {
-	return sha1_to_hex_r(buffer, oid->hash);
+	return hash_to_hex_algop_r(buffer, sha1, &hash_algos[GIT_HASH_SHA1]);
 }
 
-char *sha1_to_hex(const unsigned char *sha1)
+char *oid_to_hex_r(char *buffer, const struct object_id *oid)
+{
+	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
+}
+
+char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *algop)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	return sha1_to_hex_r(hexbuffer[bufno], sha1);
+	return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
+}
+
+char *sha1_to_hex(const unsigned char *sha1)
+{
+	return hash_to_hex_algop(sha1, &hash_algos[GIT_HASH_SHA1]);
+}
+
+char *hash_to_hex(const unsigned char *hash)
+{
+	return hash_to_hex_algop(hash, the_hash_algo);
 }
 
 char *oid_to_hex(const struct object_id *oid)
 {
-	return sha1_to_hex(oid->hash);
+	return hash_to_hex_algop(oid->hash, the_hash_algo);
 }
