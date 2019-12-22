Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF1BC3F68F
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948F120733
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="q3eVOZ1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfLVGsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:32 -0500
Received: from mr85p00im-hyfv06011401.me.com ([17.58.23.191]:36542 "EHLO
        mr85p00im-hyfv06011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbfLVGsc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576997310; bh=CG5yi1nF4CXVhQYsmDi+ZIzymJKktrw8iDwp1sHa1e4=;
        h=From:To:Subject:Date:Message-Id;
        b=q3eVOZ1QtAP8LU0z7U76Jn5a+XH74N4hGR3OLIwaB9TkghuSgVpg5iCRKt49rRkl7
         j+IelwMWFqMSxG+tzpNdGSDjzJ1/cqlNMCrXp+U2cs+FFcBhgFJv+NuTmvNZrKwbfY
         1SYTFENyuHWunKcI2RpHOfidHUjILRG6Z4bTuA8tV6VEmk6PJc6hEi4ACCZbeA1OIZ
         2H2wdW7t6iT5QluVRxXW74LXoat+QyzXE/UOadC3AYLRaWvvr/EIsD1araK8oDtySa
         IKCj+sk2L8gGB9Qk6EqAC81LRNMEW605ecgj+saLAKa8PABvpqxUz2xVDAqWJatqSX
         pmVe4JngNIl3w==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id D3637D20A2D;
        Sun, 22 Dec 2019 06:48:29 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 4/6] Add an implementation of the SHA224 truncated hash algorithm
Date:   Sun, 22 Dec 2019 19:48:07 +1300
Message-Id: <20191222064809.35667-5-michaeljclark@mac.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191222064809.35667-1-michaeljclark@mac.com>
References: <20191222064809.35667-1-michaeljclark@mac.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-22_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1912220061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

- Update existing SHA256 implementation adding initialization
  vector for SHA224 and add algorithm to list of hash algos.
- Add sha224 commands to test-tool.
- Add sha224 hash tests to t/t0015-hash.sh
---
 hash.h                 | 34 +++++++++++++++++++++++++++-------
 sha/sha256/gcrypt.h    | 15 ++++++++++++++-
 sha/sha256/sha256.c    | 18 +++++++++++++++++-
 sha/sha256/sha256.h    |  9 +++++++++
 sha1-file.c            | 41 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-sha256.c |  5 +++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0015-hash.sh        | 26 ++++++++++++++++++++++++++
 9 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/hash.h b/hash.h
index 4826de3c80d4..16924203d035 100644
--- a/hash.h
+++ b/hash.h
@@ -54,6 +54,18 @@
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
 
+#ifndef platform_SHA224_CTX
+#define platform_SHA224_CTX	SHA224_CTX
+#define platform_SHA224_Init	SHA224_Init
+#define platform_SHA224_Update	SHA224_Update
+#define platform_SHA224_Final	SHA224_Final
+#endif
+
+#define git_SHA224_CTX		platform_SHA224_CTX
+#define git_SHA224_Init		platform_SHA224_Init
+#define git_SHA224_Update	platform_SHA224_Update
+#define git_SHA224_Final	platform_SHA224_Final
+
 #ifndef platform_SHA256_CTX
 #define platform_SHA256_CTX	SHA256_CTX
 #define platform_SHA256_Init	SHA256_Init
@@ -101,20 +113,22 @@
 #define GIT_HASH_SHA1 1
 /* SHA-256  */
 #define GIT_HASH_SHA256 2
+/* SHA-224  */
+#define GIT_HASH_SHA224 3
 /* SHA-512  */
-#define GIT_HASH_SHA512 3
+#define GIT_HASH_SHA512 4
 /* SHA-512-224  */
-#define GIT_HASH_SHA512_224 4
+#define GIT_HASH_SHA512_224 5
 /* SHA-512-256  */
-#define GIT_HASH_SHA512_256 5
+#define GIT_HASH_SHA512_256 6
 /* SHA-3-224 */
-#define GIT_HASH_SHA3_224 6
+#define GIT_HASH_SHA3_224 7
 /* SHA-3-256 */
-#define GIT_HASH_SHA3_256 7
+#define GIT_HASH_SHA3_256 8
 /* SHA-3-384 */
-#define GIT_HASH_SHA3_384 8
+#define GIT_HASH_SHA3_384 9
 /* SHA-3-512 */
-#define GIT_HASH_SHA3_512 9
+#define GIT_HASH_SHA3_512 10
 /* Number of algorithms supported (including unknown). */
 #define GIT_HASH_NALGOS (GIT_HASH_SHA3_512 + 1)
 
@@ -188,6 +202,12 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 /* The block size of SHA-1. */
 #define GIT_SHA1_BLKSZ 64
 
+/* The length in bytes and in hex digits of an object name (SHA-224 value). */
+#define GIT_SHA224_RAWSZ 28
+#define GIT_SHA224_HEXSZ (2 * GIT_SHA224_RAWSZ)
+/* The block size of SHA-224. */
+#define GIT_SHA224_BLKSZ 64
+
 /* The length in bytes and in hex digits of an object name (SHA-256 value). */
 #define GIT_SHA256_RAWSZ 32
 #define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
diff --git a/sha/sha256/gcrypt.h b/sha/sha256/gcrypt.h
index 09bd8bb20062..3de8614eb1d8 100644
--- a/sha/sha256/gcrypt.h
+++ b/sha/sha256/gcrypt.h
@@ -3,10 +3,16 @@
 
 #include <gcrypt.h>
 
+#define SHA224_DIGEST_SIZE 28
 #define SHA256_DIGEST_SIZE 32
 
 typedef gcry_md_hd_t gcrypt_SHA256_CTX;
 
+inline void gcrypt_SHA224_Init(gcrypt_SHA256_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA224, 0);
+}
+
 inline void gcrypt_SHA256_Init(gcrypt_SHA256_CTX *ctx)
 {
 	gcry_md_open(ctx, GCRY_MD_SHA256, 0);
@@ -19,7 +25,9 @@ inline void gcrypt_SHA256_Update(gcrypt_SHA256_CTX *ctx, const void *data, size_
 
 inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX *ctx)
 {
-	memcpy(digest, gcry_md_read(*ctx, GCRY_MD_SHA256), SHA256_DIGEST_SIZE);
+	int algo = gcry_md_get_algo(ctx);
+	unsigned int dlen = gcry_md_get_algo_dlen(algo);
+	memcpy(digest, gcry_md_read(*ctx, algo), dlen);
 }
 
 #define platform_SHA256_CTX gcrypt_SHA256_CTX
@@ -27,4 +35,9 @@ inline void gcrypt_SHA256_Final(unsigned char *digest, gcrypt_SHA256_CTX *ctx)
 #define platform_SHA256_Update gcrypt_SHA256_Update
 #define platform_SHA256_Final gcrypt_SHA256_Final
 
+#define platform_SHA224_CTX gcrypt_SHA256_CTX
+#define platform_SHA224_Init gcrypt_SHA224_Init
+#define platform_SHA224_Update gcrypt_SHA256_Update
+#define platform_SHA224_Final gcrypt_SHA256_Final
+
 #endif
diff --git a/sha/sha256/sha256.c b/sha/sha256/sha256.c
index 37850b4e52e0..a774d7562d6e 100644
--- a/sha/sha256/sha256.c
+++ b/sha/sha256/sha256.c
@@ -6,8 +6,24 @@
 
 #define BLKSIZE blk_SHA256_BLKSIZE
 
+void blk_SHA224_Init(blk_SHA256_CTX *ctx)
+{
+	ctx->digestlen = blk_SHA224_HASHSIZE;
+	ctx->offset = 0;
+	ctx->size = 0;
+	ctx->state[0] = 0xc1059ed8ul;
+	ctx->state[1] = 0x367cd507ul;
+	ctx->state[2] = 0x3070dd17ul;
+	ctx->state[3] = 0xf70e5939ul;
+	ctx->state[4] = 0xffc00b31ul;
+	ctx->state[5] = 0x68581511ul;
+	ctx->state[6] = 0x64f98fa7ul;
+	ctx->state[7] = 0xbefa4fa4ul;
+}
+
 void blk_SHA256_Init(blk_SHA256_CTX *ctx)
 {
+	ctx->digestlen = blk_SHA256_HASHSIZE;
 	ctx->offset = 0;
 	ctx->size = 0;
 	ctx->state[0] = 0x6a09e667ul;
@@ -191,6 +207,6 @@ void blk_SHA256_Final(unsigned char *digest, blk_SHA256_CTX *ctx)
 	blk_SHA256_Update(ctx, padlen, 8);
 
 	/* copy output */
-	for (i = 0; i < 8; i++, digest += sizeof(uint32_t))
+	for (i = 0; i < (ctx->digestlen >> 2); i++, digest += sizeof(uint32_t))
 		put_be32(digest, ctx->state[i]);
 }
diff --git a/sha/sha256/sha256.h b/sha/sha256/sha256.h
index 5099d6421d37..e513eafa8199 100644
--- a/sha/sha256/sha256.h
+++ b/sha/sha256/sha256.h
@@ -2,16 +2,20 @@
 #define SHA256_BLOCK_SHA256_H
 
 #define blk_SHA256_BLKSIZE 64
+#define blk_SHA224_HASHSIZE 28
+#define blk_SHA256_HASHSIZE 32
 
 struct blk_SHA256_CTX {
 	uint32_t state[8];
 	uint64_t size;
 	uint32_t offset;
+	uint32_t digestlen;
 	uint8_t buf[blk_SHA256_BLKSIZE];
 };
 
 typedef struct blk_SHA256_CTX blk_SHA256_CTX;
 
+void blk_SHA224_Init(blk_SHA256_CTX *ctx);
 void blk_SHA256_Init(blk_SHA256_CTX *ctx);
 void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len);
 void blk_SHA256_Final(unsigned char *digest, blk_SHA256_CTX *ctx);
@@ -21,4 +25,9 @@ void blk_SHA256_Final(unsigned char *digest, blk_SHA256_CTX *ctx);
 #define platform_SHA256_Update blk_SHA256_Update
 #define platform_SHA256_Final blk_SHA256_Final
 
+#define platform_SHA224_CTX blk_SHA256_CTX
+#define platform_SHA224_Init blk_SHA224_Init
+#define platform_SHA224_Update blk_SHA256_Update
+#define platform_SHA224_Final blk_SHA256_Final
+
 #endif
diff --git a/sha1-file.c b/sha1-file.c
index 1f5b835a9f24..b73847bea5d2 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -40,6 +40,10 @@
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
 	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
 	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+#define EMPTY_TREE_SHA224_BIN_LITERAL \
+	"\xc8\x24\x29\x25\x0d\x41\x1b\x49\x91\xa3" \
+	"\xde\x9b\x42\xf5\x00\x90\x8a\x4a\x24\x2a" \
+	"\x8d\x3b\x34\x85\xe5\xe3\xbf\x71"
 #define EMPTY_TREE_SHA256_BIN_LITERAL \
 	"\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
 	"\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5" \
@@ -89,6 +93,10 @@
 #define EMPTY_BLOB_SHA1_BIN_LITERAL \
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
 	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
+#define EMPTY_BLOB_SHA224_BIN_LITERAL \
+	"\xfc\xdd\x1b\x16\x6d\xde\x80\x33\x06\xa4" \
+	"\x48\x52\xe0\xb7\xdc\xdf\x73\xba\xd0\xde" \
+	"\xc5\x6f\x00\x1f\xeb\x39\xea\x89"
 #define EMPTY_BLOB_SHA256_BIN_LITERAL \
 	"\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
 	"\x67\xe3\xb1\xe9\xa7\xdc\xda\x11\x85\x43" \
@@ -142,6 +150,12 @@ static const struct object_id empty_tree_oid = {
 static const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
+static const struct object_id empty_tree_oid_sha224 = {
+	EMPTY_TREE_SHA224_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha224 = {
+	EMPTY_BLOB_SHA224_BIN_LITERAL
+};
 static const struct object_id empty_tree_oid_sha256 = {
 	EMPTY_TREE_SHA256_BIN_LITERAL
 };
@@ -206,6 +220,20 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 	git_SHA1_Final(hash, &ctx->sha1);
 }
 
+static void git_hash_sha224_init(git_hash_ctx *ctx)
+{
+	git_SHA224_Init(&ctx->sha256);
+}
+
+static void git_hash_sha224_update(git_hash_ctx *ctx, const void *data, size_t len)
+{
+	git_SHA224_Update(&ctx->sha256, data, len);
+}
+
+static void git_hash_sha224_final(unsigned char *hash, git_hash_ctx *ctx)
+{
+	git_SHA224_Final(hash, &ctx->sha256);
+}
 
 static void git_hash_sha256_init(git_hash_ctx *ctx)
 {
@@ -331,6 +359,19 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		&empty_tree_oid_sha256,
 		&empty_blob_oid_sha256,
 	},
+	{
+		"sha224",
+		/* "s224", big-endian */
+		0x73323234,
+		GIT_SHA224_RAWSZ,
+		GIT_SHA224_HEXSZ,
+		GIT_SHA224_BLKSZ,
+		git_hash_sha224_init,
+		git_hash_sha224_update,
+		git_hash_sha224_final,
+		&empty_tree_oid_sha224,
+		&empty_blob_oid_sha224,
+	},
 	{
 		"sha512",
 		/* "s512", big-endian */
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
index 0ac6a99d5f2a..f79aca916128 100644
--- a/t/helper/test-sha256.c
+++ b/t/helper/test-sha256.c
@@ -1,6 +1,11 @@
 #include "test-tool.h"
 #include "cache.h"
 
+int cmd__sha224(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA224);
+}
+
 int cmd__sha256(int ac, const char **av)
 {
 	return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 7acae78e9b87..762c4cb01d19 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -56,6 +56,7 @@ static struct test_cmd cmds[] = {
 	{ "serve-v2", cmd__serve_v2 },
 	{ "sha1", cmd__sha1 },
 	{ "sha1-array", cmd__sha1_array },
+	{ "sha224", cmd__sha224 },
 	{ "sha256", cmd__sha256 },
 	{ "sha512", cmd__sha512 },
 	{ "sha512-224", cmd__sha512_224 },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8aa5cee7710b..e4f63baef948 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -46,6 +46,7 @@ int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_array(int argc, const char **argv);
+int cmd__sha224(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
 int cmd__sha512(int argc, const char **argv);
 int cmd__sha512_224(int argc, const char **argv);
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
index c68a9ef2145c..225145d52653 100755
--- a/t/t0015-hash.sh
+++ b/t/t0015-hash.sh
@@ -52,6 +52,32 @@ test_expect_success 'test basic SHA-256 hash values' '
 	grep 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321 actual
 '
 
+test_expect_success 'test basic SHA-224 hash values' '
+	test-tool sha224 </dev/null >actual &&
+	grep d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f actual &&
+	printf "a" | test-tool sha224 >actual &&
+	grep abd37534c7d9a2efb9465de931cd7055ffdb8879563ae98078d6d6d5 actual &&
+	printf "abc" | test-tool sha224 >actual &&
+	grep 23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7 actual &&
+	printf "message digest" | test-tool sha224 >actual &&
+	grep 2cb21c83ae2f004de7e81c3c7019cbcb65b71ab656b22d6d0c39b8eb actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha224 >actual &&
+	grep 45a5f72c39c5cff2522eb3429799e49e5f44b356ef926bcf390dccc2 actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha224 >actual &&
+	grep 20794655980c91d8bbb4c1ea97618a4bf03f42581948b2ee4ee7ad67 actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha224 >actual &&
+	grep 22c732697633e465ba836e11c7829ee185a72b53fbf35fde511bfbcd actual &&
+	printf "blob 0\0" | test-tool sha224 >actual &&
+	grep fcdd1b166dde803306a44852e0b7dcdf73bad0dec56f001feb39ea89 actual &&
+	printf "blob 3\0abc" | test-tool sha224 >actual &&
+	grep 22d78642a42d232e5b21911de160bed5b033badbecb8fc8b693e6ffe actual &&
+	printf "tree 0\0" | test-tool sha224 >actual &&
+	grep c82429250d411b4991a3de9b42f500908a4a242a8d3b3485e5e3bf71 actual
+'
+
 test_expect_success 'test basic SHA-512/224 hash values' '
 	test-tool sha512-224 </dev/null >actual &&
 	grep 6ed0dd02806fa89e25de060c19d3ac86cabb87d6a0ddd05c333b84f4 actual &&
-- 
2.20.1

