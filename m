Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 275181F453
	for <e@80x24.org>; Sun,  4 Nov 2018 23:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeKEJB4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:01:56 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53216 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729402AbeKEJBz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 04:01:55 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 70C9661B74;
        Sun,  4 Nov 2018 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541375110;
        bh=u4+Pp2zwto/n5XbIYrr2J3R2j56Bt30xMMNk33wPrgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=EGX0vf4WdQOJHW4bq2jrZW7kFvFc8fsJF6Grje248/scCzvpW2Hk8HmYJbkmw9HBE
         vdZeTHQRAhXRgx+TH3OIgAkFlAtRxzH06Fwcxwlta3ciuU7lukJGUU3dku7V5VxY0P
         NGXswpdj8bwYP0t8j57ay8GCaJrgCSMj4u5vYu1oIiCU5kPaQrgad4pkfmMpQUDUd5
         PB58eHBPapfXnGKV7yHlLtY2nYVQ8zDLIGkPR3lfixwq+TmLlHEKoFKPwKQfoiqCRj
         IOljv7Lpxr7VKp9XBS+6uxZ1UzAem0kpMSB/m6oapYJUGdh1oEinunUxUIcnejTpr5
         5lF0mgfNCRujgUFhIv//bvIK7lKxi0fgLLszjTCLQPUUwZD77EtNSNz1P7mjncPhDp
         zTfU9tQwBNSEt0FHM+5aag++3S0FNcOstqYARWYE/LUXO5sI/JaYDZA48an1H6vq/M
         FAuHva6JeLoZe7lUDihx15HDrM8t1WiY/U5Pe3VYxfzaVcuTo8e
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 03/12] hex: introduce functions to print arbitrary hashes
Date:   Sun,  4 Nov 2018 23:44:49 +0000
Message-Id: <20181104234458.139223-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <20181104234458.139223-1-sandals@crustytoothpaste.net>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
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
index 59c8a93046..51580c4b77 100644
--- a/cache.h
+++ b/cache.h
@@ -1364,9 +1364,9 @@ extern int get_oid_hex(const char *hex, struct object_id *sha1);
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
@@ -1374,10 +1374,13 @@ extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
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
index 10af1a29e8..d2e8bb9540 100644
--- a/hex.c
+++ b/hex.c
@@ -73,14 +73,15 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end)
 	return ret;
 }
 
-char *sha1_to_hex_r(char *buffer, const unsigned char *sha1)
+inline char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
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
