Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660EBC2D0D4
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E5020733
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="LywrJpab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLVGs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:29 -0500
Received: from mr85p00im-hyfv06011401.me.com ([17.58.23.191]:36375 "EHLO
        mr85p00im-hyfv06011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfLVGs3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576997307; bh=vmff1nqE5B6xE/CCBZeL2/eFT5LpliQQWYvPYqqHjJg=;
        h=From:To:Subject:Date:Message-Id;
        b=LywrJpabCrZTRd3BcSEMWkGyH0DDXDTryLoCNDqOwNhlIj2mCPrYOaZpI1FVvR0VM
         G4CqiWBxq8TiJeUsgljwyP+XW27ocfVYEFxdA2vH/ByjRCC7CNdJBS7efp/TNGRNcR
         Yfv/dS2lLa/n2FgnSn7F991YWCQBrTWCA6aoGftepBVdG7qQEz7ZEO1ytUX1agoxjW
         ot5vERetNIZM5tbY3WGO0OKgP35X7EGOpyMwFBlNLbJzav/1/dMoPYnjVyfwB0JYdo
         XOsWbi1Gsy9L+VLqAp2/5fhknC+MO0mQwhteJPTXfEnksBGY7iUSWFWMq8wO9aUaFc
         ngLWCMSw9O+TA==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 468BED209F7;
        Sun, 22 Dec 2019 06:48:26 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 2/6] Add an implementation of the SHA-512 hash algorithm
Date:   Sun, 22 Dec 2019 19:48:05 +1300
Message-Id: <20191222064809.35667-3-michaeljclark@mac.com>
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

- Add SHA-512 hash algorithm implementation derived from the
  SHA-256 implementation translated to 64-bit and 80 rounds.
- Add configuration machinery to select builtin impl or gcrypt.
- Add sha512-224, sha512-256 and sha512 commands to test-tool.
- Add sha512 hash tests to t/t0015-hash.sh
---
 Makefile               |  14 +++
 hash.h                 |  46 ++++++-
 sha/sha512/gcrypt.h    |  43 +++++++
 sha/sha512/sha512.c    | 206 +++++++++++++++++++++++++++++++
 sha/sha512/sha512.h    |  31 +++++
 sha1-file.c            | 268 +++++++++++++++++++++++++++++++++++++++++
 t/helper/test-sha512.c |  17 +++
 t/helper/test-tool.c   |   3 +
 t/helper/test-tool.h   |   3 +
 t/t0015-hash.sh        |  80 ++++++++++++
 10 files changed, 707 insertions(+), 4 deletions(-)
 create mode 100644 sha/sha512/gcrypt.h
 create mode 100644 sha/sha512/sha512.c
 create mode 100644 sha/sha512/sha512.h
 create mode 100644 t/helper/test-sha512.c

diff --git a/Makefile b/Makefile
index bac1b30b2f1f..2cd505b21ebb 100644
--- a/Makefile
+++ b/Makefile
@@ -183,6 +183,8 @@ all::
 #
 # Define BLK_SHA256 to use the built-in SHA-256 routines.
 #
+# Define BLK_SHA512 to use the built-in SHA-512 routines.
+#
 # Define GCRYPT_SHA256 to use the SHA-256 routines in libgcrypt.
 #
 # Define OPENSSL_SHA256 to use the SHA-256 routines in OpenSSL.
@@ -739,6 +741,7 @@ TEST_BUILTINS_OBJS += test-serve-v2.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha256.o
+TEST_BUILTINS_OBJS += test-sha512.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
@@ -1712,6 +1715,14 @@ else
 endif
 endif
 
+ifdef GCRYPT_SHA512
+	BASIC_CFLAGS += -DSHA512_GCRYPT
+	EXTLIBS += -lgcrypt
+else
+	LIB_OBJS += sha/sha512/sha512.o
+	BASIC_CFLAGS += -DSHA512_BLK
+endif
+
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
@@ -2784,6 +2795,9 @@ EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha/sha256/gcrypt.h
 endif
+ifndef GCRYPT_SHA512
+	EXCEPT_HDRS += sha/sha512/gcrypt.h
+endif
 CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 HCC = $(HCO:hco=hcc)
diff --git a/hash.h b/hash.h
index f1b941218dc8..ea96fccce0c8 100644
--- a/hash.h
+++ b/hash.h
@@ -23,6 +23,12 @@
 #include "sha/sha256/sha256.h"
 #endif
 
+#if defined(SHA512_GCRYPT)
+#include "sha/sha512/gcrypt.h"
+#else
+#include "sha/sha512/sha512.h"
+#endif
+
 #ifndef platform_SHA_CTX
 /*
  * platform's underlying implementation of SHA-1; could be OpenSSL,
@@ -54,6 +60,13 @@
 #define git_SHA256_Update	platform_SHA256_Update
 #define git_SHA256_Final	platform_SHA256_Final
 
+#define git_SHA512_CTX		platform_SHA512_CTX
+#define git_SHA512_Init		platform_SHA512_Init
+#define git_SHA512_224_Init	platform_SHA512_224_Init
+#define git_SHA512_256_Init	platform_SHA512_256_Init
+#define git_SHA512_Update	platform_SHA512_Update
+#define git_SHA512_Final	platform_SHA512_Final
+
 #ifdef SHA1_MAX_BLOCK_SIZE
 #include "compat/sha1-chunked.h"
 #undef git_SHA1_Update
@@ -74,13 +87,20 @@
 #define GIT_HASH_SHA1 1
 /* SHA-256  */
 #define GIT_HASH_SHA256 2
+/* SHA-512  */
+#define GIT_HASH_SHA512 3
+/* SHA-512-224  */
+#define GIT_HASH_SHA512_224 4
+/* SHA-512-256  */
+#define GIT_HASH_SHA512_256 5
 /* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
+#define GIT_HASH_NALGOS (GIT_HASH_SHA512_256 + 1)
 
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
 	git_SHA256_CTX sha256;
+	git_SHA512_CTX sha512;
 };
 typedef union git_hash_ctx git_hash_ctx;
 
@@ -151,11 +171,29 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 /* The block size of SHA-256. */
 #define GIT_SHA256_BLKSZ 64
 
+/* The length in bytes and in hex digits of an object name (SHA-512 value). */
+#define GIT_SHA512_RAWSZ 64
+#define GIT_SHA512_HEXSZ (2 * GIT_SHA512_RAWSZ)
+/* The block size of SHA-512. */
+#define GIT_SHA512_BLKSZ 128
+
+/* The length in bytes and in hex digits of an object name (SHA-512-224 value). */
+#define GIT_SHA512_224_RAWSZ 28
+#define GIT_SHA512_224_HEXSZ (2 * GIT_SHA512_224_RAWSZ)
+/* The block size of SHA-512-224. */
+#define GIT_SHA512_224_BLKSZ 128
+
+/* The length in bytes and in hex digits of an object name (SHA-512-256 value). */
+#define GIT_SHA512_256_RAWSZ 32
+#define GIT_SHA512_256_HEXSZ (2 * GIT_SHA512_256_RAWSZ)
+/* The block size of SHA-512-256. */
+#define GIT_SHA512_256_BLKSZ 128
+
 /* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
+#define GIT_MAX_RAWSZ GIT_SHA512_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA512_HEXSZ
 /* The largest possible block size for any supported hash. */
-#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
+#define GIT_MAX_BLKSZ GIT_SHA512_BLKSZ
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
diff --git a/sha/sha512/gcrypt.h b/sha/sha512/gcrypt.h
new file mode 100644
index 000000000000..fdc0097d0777
--- /dev/null
+++ b/sha/sha512/gcrypt.h
@@ -0,0 +1,43 @@
+#ifndef SHA512_GCRYPT_H
+#define SHA512_GCRYPT_H
+
+#include <gcrypt.h>
+
+#define SHA512_DIGEST_SIZE 64
+
+typedef gcry_md_hd_t gcrypt_SHA512_CTX;
+
+inline void gcrypt_SHA512_Init(gcrypt_SHA512_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA512, 0);
+}
+
+inline void gcrypt_SHA512_224_Init(gcrypt_SHA512_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA512_224, 0);
+}
+
+inline void gcrypt_SHA512_256_Init(gcrypt_SHA512_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA512_256, 0);
+}
+
+inline void gcrypt_SHA512_Update(gcrypt_SHA512_CTX *ctx, const void *data, size_t len)
+{
+	gcry_md_write(*ctx, data, len);
+}
+
+inline void gcrypt_SHA512_Final(unsigned char *digest, gcrypt_SHA512_CTX *ctx)
+{
+	int algo = gcry_md_get_algo(ctx);
+	unsigned int dlen = gcry_md_get_algo_dlen(algo);
+	memcpy(digest, gcry_md_read(*ctx, algo), dlen);
+}
+
+#define platform_SHA512_CTX gcrypt_SHA512_CTX
+#define platform_SHA512_Init gcrypt_SHA512_Init
+#define platform_SHA512_256_Init gcrypt_SHA512_256_Init
+#define platform_SHA512_Update gcrypt_SHA512_Update
+#define platform_SHA512_Final gcrypt_SHA512_Final
+
+#endif
diff --git a/sha/sha512/sha512.c b/sha/sha512/sha512.c
new file mode 100644
index 000000000000..8c1955627648
--- /dev/null
+++ b/sha/sha512/sha512.c
@@ -0,0 +1,206 @@
+#include "git-compat-util.h"
+#include "./sha512.h"
+
+static const uint64_t SHA_512_K[80] = {
+	0x428a2f98d728ae22ull, 0x7137449123ef65cdull,
+	0xb5c0fbcfec4d3b2full, 0xe9b5dba58189dbbcull,
+	0x3956c25bf348b538ull, 0x59f111f1b605d019ull,
+	0x923f82a4af194f9bull, 0xab1c5ed5da6d8118ull,
+	0xd807aa98a3030242ull, 0x12835b0145706fbeull,
+	0x243185be4ee4b28cull, 0x550c7dc3d5ffb4e2ull,
+	0x72be5d74f27b896full, 0x80deb1fe3b1696b1ull,
+	0x9bdc06a725c71235ull, 0xc19bf174cf692694ull,
+	0xe49b69c19ef14ad2ull, 0xefbe4786384f25e3ull,
+	0x0fc19dc68b8cd5b5ull, 0x240ca1cc77ac9c65ull,
+	0x2de92c6f592b0275ull, 0x4a7484aa6ea6e483ull,
+	0x5cb0a9dcbd41fbd4ull, 0x76f988da831153b5ull,
+	0x983e5152ee66dfabull, 0xa831c66d2db43210ull,
+	0xb00327c898fb213full, 0xbf597fc7beef0ee4ull,
+	0xc6e00bf33da88fc2ull, 0xd5a79147930aa725ull,
+	0x06ca6351e003826full, 0x142929670a0e6e70ull,
+	0x27b70a8546d22ffcull, 0x2e1b21385c26c926ull,
+	0x4d2c6dfc5ac42aedull, 0x53380d139d95b3dfull,
+	0x650a73548baf63deull, 0x766a0abb3c77b2a8ull,
+	0x81c2c92e47edaee6ull, 0x92722c851482353bull,
+	0xa2bfe8a14cf10364ull, 0xa81a664bbc423001ull,
+	0xc24b8b70d0f89791ull, 0xc76c51a30654be30ull,
+	0xd192e819d6ef5218ull, 0xd69906245565a910ull,
+	0xf40e35855771202aull, 0x106aa07032bbd1b8ull,
+	0x19a4c116b8d2d0c8ull, 0x1e376c085141ab53ull,
+	0x2748774cdf8eeb99ull, 0x34b0bcb5e19b48a8ull,
+	0x391c0cb3c5c95a63ull, 0x4ed8aa4ae3418acbull,
+	0x5b9cca4f7763e373ull, 0x682e6ff3d6b2b8a3ull,
+	0x748f82ee5defb2fcull, 0x78a5636f43172f60ull,
+	0x84c87814a1f0ab72ull, 0x8cc702081a6439ecull,
+	0x90befffa23631e28ull, 0xa4506cebde82bde9ull,
+	0xbef9a3f7b2c67915ull, 0xc67178f2e372532bull,
+	0xca273eceea26619cull, 0xd186b8c721c0c207ull,
+	0xeada7dd6cde0eb1eull, 0xf57d4f7fee6ed178ull,
+	0x06f067aa72176fbaull, 0x0a637dc5a2c898a6ull,
+	0x113f9804bef90daeull, 0x1b710b35131c471bull,
+	0x28db77f523047d84ull, 0x32caab7b40c72493ull,
+	0x3c9ebe0a15c9bebcull, 0x431d67c49c100d4cull,
+	0x4cc5d4becb3e42b6ull, 0x597f299cfc657e2aull,
+	0x5fcb6fab3ad6faecull, 0x6c44198c4a475817ull
+};
+
+void blk_SHA512_224_Init(blk_SHA512_CTX *ctx)
+{
+	ctx->size = 0;
+	ctx->digestlen = blk_SHA512_224_HASHSIZE;
+	ctx->state[0] = 0x8c3d37c819544da2ull;
+	ctx->state[1] = 0x73e1996689dcd4d6ull;
+	ctx->state[2] = 0x1dfab7ae32ff9c82ull;
+	ctx->state[3] = 0x679dd514582f9fcfull;
+	ctx->state[4] = 0x0f6d2b697bd44da8ull;
+	ctx->state[5] = 0x77e36f7304c48942ull;
+	ctx->state[6] = 0x3f9d85a86a1d36c8ull;
+	ctx->state[7] = 0x1112e6ad91d692a1ull;
+}
+
+void blk_SHA512_256_Init(blk_SHA512_CTX *ctx)
+{
+	ctx->size = 0;
+	ctx->digestlen = blk_SHA512_256_HASHSIZE;
+	ctx->state[0] = 0x22312194fc2bf72cull;
+	ctx->state[1] = 0x9f555fa3c84c64c2ull;
+	ctx->state[2] = 0x2393b86b6f53b151ull;
+	ctx->state[3] = 0x963877195940eabdull;
+	ctx->state[4] = 0x96283ee2a88effe3ull;
+	ctx->state[5] = 0xbe5e1e2553863992ull;
+	ctx->state[6] = 0x2b0199fc2c85b8aaull;
+	ctx->state[7] = 0x0eb72ddc81c52ca2ull;
+}
+
+void blk_SHA512_Init(blk_SHA512_CTX *ctx)
+{
+	ctx->size = 0;
+	ctx->digestlen = blk_SHA512_HASHSIZE;
+	ctx->state[0] = 0x6a09e667f3bcc908ull;
+	ctx->state[1] = 0xbb67ae8584caa73bull;
+	ctx->state[2] = 0x3c6ef372fe94f82bull;
+	ctx->state[3] = 0xa54ff53a5f1d36f1ull;
+	ctx->state[4] = 0x510e527fade682d1ull;
+	ctx->state[5] = 0x9b05688c2b3e6c1full;
+	ctx->state[6] = 0x1f83d9abfb41bd6bull;
+	ctx->state[7] = 0x5be0cd19137e2179ull;
+}
+
+static inline uint64_t ror(uint64_t x, unsigned n)
+{
+	return (x >> n) | (x << (64 - n));
+}
+
+static inline uint64_t ch(uint64_t x, uint64_t y, uint64_t z)
+{
+	return z ^ (x & (y ^ z));
+}
+
+static inline uint64_t maj(uint64_t x, uint64_t y, uint64_t z)
+{
+	return ((x | y) & z) | (x & y);
+}
+
+static inline uint64_t sigma0(uint64_t x)
+{
+	return ror(x, 28) ^ ror(x, 34) ^ ror(x, 39);
+}
+
+static inline uint64_t sigma1(uint64_t x)
+{
+	return ror(x, 14) ^ ror(x, 18) ^ ror(x, 41);
+}
+
+static inline uint64_t gamma0(uint64_t x)
+{
+	return ror(x, 1) ^ ror(x, 8) ^ (x >> 7);
+}
+
+static inline uint64_t gamma1(uint64_t x)
+{
+	return ror(x, 19) ^ ror(x, 61) ^ (x >> 6);
+}
+
+static void blk_SHA512_Transform(blk_SHA512_CTX *ctx, const unsigned char *buf)
+{
+	uint64_t S[8], W[80], t0, t1;
+	int i;
+
+	/* copy state into S */
+	for (i = 0; i < 8; i++)
+		S[i] = ctx->state[i];
+
+	/* copy the state into 1024-bits into W[0..15] */
+	for (i=0; i<16; i++, buf += sizeof(uint64_t)) {
+		W[i] = get_be64(buf);
+	}
+
+	/* fill W[16..80] */
+	for (; i<80; i++) {
+		W[i] = gamma1(W[i - 2]) + W[i - 7] + gamma0(W[i - 15]) + W[i - 16];
+	}
+
+	/* compute SHA rounds */
+	for (i=0; i<80; i++) {
+		t0 = W[i] + S[7] + sigma1(S[4]) + ch(S[4], S[5], S[6]) + SHA_512_K[i];
+		t1 = maj(S[0], S[1], S[2]) + sigma0(S[0]);
+		S[7] = S[6];
+		S[6] = S[5];
+		S[5] = S[4];
+		S[4] = S[3] + t0;
+		S[3] = S[2];
+		S[2] = S[1];
+		S[1] = S[0];
+		S[0] = t0 + t1;
+	}
+
+	for (i = 0; i < 8; i++)
+		ctx->state[i] += S[i];
+}
+
+void blk_SHA512_Update(blk_SHA512_CTX *ctx, const void *data, size_t len)
+{
+	unsigned int len_buf = ctx->size & 127;
+
+	ctx->size += len;
+
+	/* Read the data into buf and process blocks as they get full */
+	if (len_buf) {
+		unsigned int left = 128 - len_buf;
+		if (len < left)
+			left = len;
+		memcpy(len_buf + ctx->buf, data, left);
+		len_buf = (len_buf + left) & 127;
+		len -= left;
+		data = ((const char *)data + left);
+		if (len_buf)
+			return;
+		blk_SHA512_Transform(ctx, ctx->buf);
+	}
+	while (len >= 128) {
+		blk_SHA512_Transform(ctx, data);
+		data = ((const char *)data + 128);
+		len -= 128;
+	}
+	if (len)
+		memcpy(ctx->buf, data, len);
+}
+
+void blk_SHA512_Final(uint8_t *digest, blk_SHA512_CTX *ctx)
+{
+	static const unsigned char pad[128] = { 0x80 };
+	unsigned int padlen[2];
+	int i;
+
+	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
+	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
+	padlen[1] = htonl((uint32_t)(ctx->size << 3));
+
+	i = ctx->size & 127;
+	blk_SHA512_Update(ctx, pad, 1 + (127 & (119 - i)));
+	blk_SHA512_Update(ctx, padlen, 8);
+
+	/* copy output */
+	for (i = 0; i < 8; i++, digest += sizeof(uint64_t))
+		put_be64(digest, ctx->state[i]);
+}
diff --git a/sha/sha512/sha512.h b/sha/sha512/sha512.h
new file mode 100644
index 000000000000..bc063f0af868
--- /dev/null
+++ b/sha/sha512/sha512.h
@@ -0,0 +1,31 @@
+#ifndef SHA512_BLOCK_SHA512_H
+#define SHA512_BLOCK_SHA512_H
+
+#define blk_SHA512_BLKSIZE 128
+#define blk_SHA512_224_HASHSIZE 28
+#define blk_SHA512_256_HASHSIZE 32
+#define blk_SHA512_HASHSIZE 64
+
+struct blk_SHA512_CTX {
+	uint64_t state[8];
+	uint64_t size;
+	uint64_t digestlen;
+	uint8_t buf[blk_SHA512_BLKSIZE];
+};
+
+typedef struct blk_SHA512_CTX blk_SHA512_CTX;
+
+void blk_SHA512_Init(blk_SHA512_CTX *ctx);
+void blk_SHA512_224_Init(blk_SHA512_CTX *ctx);
+void blk_SHA512_256_Init(blk_SHA512_CTX *ctx);
+void blk_SHA512_Update(blk_SHA512_CTX *ctx, const void *data, size_t len);
+void blk_SHA512_Final(unsigned char *digest, blk_SHA512_CTX *ctx);
+
+#define platform_SHA512_CTX blk_SHA512_CTX
+#define platform_SHA512_Init blk_SHA512_Init
+#define platform_SHA512_224_Init blk_SHA512_224_Init
+#define platform_SHA512_256_Init blk_SHA512_256_Init
+#define platform_SHA512_Update blk_SHA512_Update
+#define platform_SHA512_Final blk_SHA512_Final
+
+#endif
diff --git a/sha1-file.c b/sha1-file.c
index 188de57634bb..1f5b835a9f24 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -45,6 +45,46 @@
 	"\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5" \
 	"\x3b\x14\xb4\xb9\xb9\x39\xdd\x74\xde\xcc" \
 	"\x53\x21"
+#define EMPTY_TREE_SHA512_224_BIN_LITERAL \
+	"\xaa\xff\x3a\xb0\x67\xb1\x51\xd0\xbc\x31" \
+	"\x30\x27\x7d\x64\xa1\x1e\xb2\x57\xe0\xfe" \
+	"\xca\x74\xe0\xdc\xb7\xe3\x83\x03"
+#define EMPTY_TREE_SHA512_256_BIN_LITERAL \
+	"\x2c\xfe\x78\xf8\xea\x2f\xa9\xd2\x19\x37" \
+	"\x48\x68\xe7\xaa\x1f\xe4\x91\x62\x2b\xcb" \
+	"\x58\x15\xdc\xf3\xad\x12\xf3\x08\xbe\x79" \
+	"\x59\xdb"
+#define EMPTY_TREE_SHA512_BIN_LITERAL \
+	"\xd5\x1f\xd9\x2f\xdd\x8b\x29\xd0\x8f\x5c" \
+	"\xba\x26\x1a\xbb\x22\x15\x29\xe6\xff\xb1" \
+	"\x26\x4c\x51\x1b\xe2\x16\xd2\xf5\x30\x6e" \
+	"\xcd\xcc\x38\xe2\x39\x2d\xe4\xf6\x2c\x74" \
+	"\x56\x07\xa9\x76\x80\xfc\x7c\xcb\xbe\x73" \
+	"\x04\x4d\xfc\x03\xd8\x9e\xd9\x5b\xa5\x49" \
+	"\x67\x90\x91\x95"
+#define EMPTY_TREE_SHA3_224_BIN_LITERAL \
+	"\x1e\x04\xf2\x3d\xe0\xb2\xb7\xd1\xb8\x5e" \
+	"\x67\x68\xfa\x99\x7a\x99\xbd\x01\x19\xde" \
+	"\xc8\x15\x8a\xe0\xad\x07\xe1\x83"
+#define EMPTY_TREE_SHA3_256_BIN_LITERAL \
+	"\x30\x21\x1e\xd4\x85\xc9\x12\xe5\xbc\x28" \
+	"\x5b\xd0\xbd\x89\x59\xdd\xbf\xb5\x87\x5c" \
+	"\xaf\xb0\xae\x28\xe0\xab\xfa\x10\x77\xb2" \
+	"\xb2\x14"
+#define EMPTY_TREE_SHA3_384_BIN_LITERAL \
+	"\x92\xe9\x9a\xe9\x28\x1a\x89\xdc\x33\x2c" \
+	"\x9c\xe8\xf2\x83\x1d\xb5\x0e\xcc\x54\x78" \
+	"\x4d\x51\xc3\xeb\xd5\xc1\x15\x1e\x8f\xd6" \
+	"\x03\xfb\x40\x8a\xbb\xbb\x9d\xcf\x57\x13" \
+	"\xed\x21\x56\x67\x89\xce\x80\x59"
+#define EMPTY_TREE_SHA3_512_BIN_LITERAL \
+	"\x8f\x86\xcb\x67\xce\x0a\x8b\xc8\x65\xb3" \
+	"\x00\x73\x3c\x27\xda\xde\x0e\xa8\xfe\x66" \
+	"\x29\x9b\x4b\xc6\x36\x8e\xc8\x4f\x53\x13" \
+	"\x4c\x36\x7c\x66\xf0\xe3\x37\x62\x61\xab" \
+	"\x5a\x86\xd7\x22\xad\x0d\x98\x39\x1a\x3c" \
+	"\x1c\x47\x2d\x67\x91\xda\x46\x4a\x78\x36" \
+	"\x00\x6d\xe1\x2c"
 
 #define EMPTY_BLOB_SHA1_BIN_LITERAL \
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
@@ -54,6 +94,46 @@
 	"\x67\xe3\xb1\xe9\xa7\xdc\xda\x11\x85\x43" \
 	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
 	"\x18\x13"
+#define EMPTY_BLOB_SHA512_224_BIN_LITERAL \
+	"\xa8\x6d\x3c\x63\x33\x98\x60\x44\x56\x07" \
+	"\xd6\xcf\xd3\x55\x12\x92\xa6\xfb\x04\x9f" \
+	"\x0f\xaa\x22\x2a\x7c\x10\x02\x7b"
+#define EMPTY_BLOB_SHA512_256_BIN_LITERAL \
+	"\x65\x76\x66\x8d\x3a\xcf\x02\x2c\x9c\x77" \
+	"\x92\x0c\x83\x49\xed\x6c\xcd\x8f\xc5\x96" \
+	"\x84\x5e\x87\xc3\x8b\x9e\x74\x90\x16\xc9" \
+	"\x84\xb3"
+#define EMPTY_BLOB_SHA512_BIN_LITERAL \
+	"\xba\x4d\x0b\xb3\xec\x89\x0f\xdc\x47\xa1" \
+	"\x0d\xf5\x3a\x59\x1a\x79\x85\x22\x37\xd5" \
+	"\xe6\x35\x45\x5d\xa9\x0a\x37\x42\xd7\x48" \
+	"\x27\x08\xb5\x7d\xe2\xff\xab\xc7\x58\x1f" \
+	"\x58\x1e\xe8\x07\x5f\xba\xb3\x47\x62\x70" \
+	"\x94\x2c\xdf\x87\xfa\x7d\xd6\x89\x5d\xaa" \
+	"\x65\x09\x89\x6c"
+#define EMPTY_BLOB_SHA3_224_BIN_LITERAL \
+	"\xf1\xe7\x29\x35\xac\x5c\x52\xd5\xc0\x9b" \
+	"\x40\x88\x42\xe2\x07\xc4\x2e\x54\x34\x42" \
+	"\x40\x07\x36\x4f\xdb\x46\x80\x63"
+#define EMPTY_BLOB_SHA3_256_BIN_LITERAL \
+	"\x5a\xad\xde\x7d\x8c\xa5\xb9\xb3\x52\xc2" \
+	"\x50\xce\x9b\x79\x9f\x5d\x81\x88\x93\xfe" \
+	"\x89\xdc\x52\xb4\x9f\x43\x8c\x8a\x9b\xa0" \
+	"\xa5\x45"
+#define EMPTY_BLOB_SHA3_384_BIN_LITERAL \
+	"\xa5\x3e\x08\x8a\xbe\x90\x8d\x8c\x94\x58" \
+	"\xa8\xba\x95\x56\x90\xc4\x17\xf7\x68\x03" \
+	"\x1e\xcf\x15\x6a\x16\x62\x44\x1f\xae\xda" \
+	"\x50\x2e\x83\x8f\x26\x60\x16\x4b\x61\xa7" \
+	"\x8b\x15\xac\x75\xe0\xf8\xde\xd4"
+#define EMPTY_BLOB_SHA3_512_BIN_LITERAL \
+	"\x43\x53\xa5\x0d\x0d\x3d\x8e\xdd\x23\x17" \
+	"\x63\xfb\x01\x02\x11\x62\x86\xaa\x6d\x76" \
+	"\x0a\x77\x21\x33\xe3\x2c\x12\x4a\x99\x8a" \
+	"\x19\x46\x7d\x78\x90\x64\xdd\x76\x3e\x57" \
+	"\xb5\x47\xff\x3a\x31\x88\x2d\xa3\xd2\x03" \
+	"\x13\x78\xcf\xe0\xfa\x57\x74\xc1\x2e\xea" \
+	"\x51\x05\x5a\x51"
 
 const struct object_id null_oid;
 static const struct object_id empty_tree_oid = {
@@ -68,6 +148,48 @@ static const struct object_id empty_tree_oid_sha256 = {
 static const struct object_id empty_blob_oid_sha256 = {
 	EMPTY_BLOB_SHA256_BIN_LITERAL
 };
+static const struct object_id empty_tree_oid_sha512 = {
+	EMPTY_TREE_SHA512_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha512 = {
+	EMPTY_BLOB_SHA512_BIN_LITERAL
+};
+static const struct object_id empty_tree_oid_sha512_224 = {
+	EMPTY_TREE_SHA512_224_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha512_224 = {
+	EMPTY_BLOB_SHA512_224_BIN_LITERAL
+};
+static const struct object_id empty_tree_oid_sha512_256 = {
+	EMPTY_TREE_SHA512_256_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha512_256 = {
+	EMPTY_BLOB_SHA512_256_BIN_LITERAL
+};
+static const struct object_id empty_tree_oid_sha3_224 = {
+	EMPTY_TREE_SHA3_224_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha3_224 = {
+	EMPTY_BLOB_SHA3_224_BIN_LITERAL
+};
+static const struct object_id empty_tree_oid_sha3_256 = {
+	EMPTY_TREE_SHA3_256_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha3_256 = {
+	EMPTY_BLOB_SHA3_256_BIN_LITERAL
+};
+static const struct object_id empty_tree_oid_sha3_384 = {
+	EMPTY_TREE_SHA3_384_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha3_384 = {
+	EMPTY_BLOB_SHA3_384_BIN_LITERAL
+};
+static const struct object_id empty_tree_oid_sha3_512 = {
+	EMPTY_TREE_SHA3_512_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha3_512 = {
+	EMPTY_BLOB_SHA3_512_BIN_LITERAL
+};
 
 static void git_hash_sha1_init(git_hash_ctx *ctx)
 {
@@ -100,6 +222,61 @@ static void git_hash_sha256_final(unsigned char *hash, git_hash_ctx *ctx)
 	git_SHA256_Final(hash, &ctx->sha256);
 }
 
+static void git_hash_sha512_init(git_hash_ctx *ctx)
+{
+	git_SHA512_Init(&ctx->sha512);
+}
+
+static void git_hash_sha512_224_init(git_hash_ctx *ctx)
+{
+	git_SHA512_224_Init(&ctx->sha512);
+}
+
+static void git_hash_sha512_256_init(git_hash_ctx *ctx)
+{
+	git_SHA512_256_Init(&ctx->sha512);
+}
+
+static void git_hash_sha512_update(git_hash_ctx *ctx, const void *data, size_t len)
+{
+	git_SHA512_Update(&ctx->sha512, data, len);
+}
+
+static void git_hash_sha512_final(unsigned char *hash, git_hash_ctx *ctx)
+{
+	git_SHA512_Final(hash, &ctx->sha512);
+}
+
+static void git_hash_sha3_224_init(git_hash_ctx *ctx)
+{
+	git_SHA3_224_Init(&ctx->sha3);
+}
+
+static void git_hash_sha3_256_init(git_hash_ctx *ctx)
+{
+	git_SHA3_256_Init(&ctx->sha3);
+}
+
+static void git_hash_sha3_384_init(git_hash_ctx *ctx)
+{
+	git_SHA3_384_Init(&ctx->sha3);
+}
+
+static void git_hash_sha3_512_init(git_hash_ctx *ctx)
+{
+	git_SHA3_512_Init(&ctx->sha3);
+}
+
+static void git_hash_sha3_update(git_hash_ctx *ctx, const void *data, size_t len)
+{
+	git_SHA3_Update(&ctx->sha3, data, len);
+}
+
+static void git_hash_sha3_final(unsigned char *hash, git_hash_ctx *ctx)
+{
+	git_SHA3_Final(hash, &ctx->sha3);
+}
+
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
 	BUG("trying to init unknown hash");
@@ -153,6 +330,97 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		git_hash_sha256_final,
 		&empty_tree_oid_sha256,
 		&empty_blob_oid_sha256,
+	},
+	{
+		"sha512",
+		/* "s512", big-endian */
+		0x73353132,
+		GIT_SHA512_RAWSZ,
+		GIT_SHA512_HEXSZ,
+		GIT_SHA512_BLKSZ,
+		git_hash_sha512_init,
+		git_hash_sha512_update,
+		git_hash_sha512_final,
+		&empty_tree_oid_sha512,
+		&empty_blob_oid_sha512,
+	},
+	{
+		"sha512/224",
+		/* "s226", big-endian */
+		0x73323236,
+		GIT_SHA512_224_RAWSZ,
+		GIT_SHA512_224_HEXSZ,
+		GIT_SHA512_224_BLKSZ,
+		git_hash_sha512_224_init,
+		git_hash_sha512_update,
+		git_hash_sha512_final,
+		&empty_tree_oid_sha512_224,
+		&empty_blob_oid_sha512_224,
+	},
+	{
+		"sha512/256",
+		/* "s228", big-endian */
+		0x73323238,
+		GIT_SHA512_256_RAWSZ,
+		GIT_SHA512_256_HEXSZ,
+		GIT_SHA512_256_BLKSZ,
+		git_hash_sha512_256_init,
+		git_hash_sha512_update,
+		git_hash_sha512_final,
+		&empty_tree_oid_sha512_256,
+		&empty_blob_oid_sha512_256,
+	},
+	{
+		"sha3-224",
+		/* "s388", big-endian */
+		0x73333838,
+		GIT_SHA3_224_RAWSZ,
+		GIT_SHA3_224_HEXSZ,
+		GIT_SHA3_224_BLKSZ,
+		git_hash_sha3_224_init,
+		git_hash_sha3_update,
+		git_hash_sha3_final,
+		&empty_tree_oid_sha3_224,
+		&empty_blob_oid_sha3_224,
+	},
+	{
+		"sha3-256",
+		/* "s398", big-endian */
+		0x73333938,
+		GIT_SHA3_256_RAWSZ,
+		GIT_SHA3_256_HEXSZ,
+		GIT_SHA3_256_BLKSZ,
+		git_hash_sha3_256_init,
+		git_hash_sha3_update,
+		git_hash_sha3_final,
+		&empty_tree_oid_sha3_256,
+		&empty_blob_oid_sha3_256,
+	},
+	{
+		"sha3-384",
+		/* "s3a8", big-endian */
+		0x73336138,
+		GIT_SHA3_384_RAWSZ,
+		GIT_SHA3_384_HEXSZ,
+		GIT_SHA3_384_BLKSZ,
+		git_hash_sha3_384_init,
+		git_hash_sha3_update,
+		git_hash_sha3_final,
+		&empty_tree_oid_sha3_384,
+		&empty_blob_oid_sha3_384,
+	},
+	{
+		"sha3-512",
+		/* "s3b8", big-endian */
+		0x73336238,
+		GIT_SHA3_512_RAWSZ,
+		GIT_SHA3_512_HEXSZ,
+		GIT_SHA3_512_BLKSZ,
+		git_hash_sha3_512_init,
+		git_hash_sha3_update,
+		git_hash_sha3_final,
+		&empty_tree_oid_sha3_512,
+		&empty_blob_oid_sha3_512,
 	}
 };
 
diff --git a/t/helper/test-sha512.c b/t/helper/test-sha512.c
new file mode 100644
index 000000000000..c80941a2a595
--- /dev/null
+++ b/t/helper/test-sha512.c
@@ -0,0 +1,17 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__sha512(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA512);
+}
+
+int cmd__sha512_224(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA512_224);
+}
+
+int cmd__sha512_256(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA512_256);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f20989d4497b..47deff9c6ef4 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -57,6 +57,9 @@ static struct test_cmd cmds[] = {
 	{ "sha1", cmd__sha1 },
 	{ "sha1-array", cmd__sha1_array },
 	{ "sha256", cmd__sha256 },
+	{ "sha512", cmd__sha512 },
+	{ "sha512-224", cmd__sha512_224 },
+	{ "sha512-256", cmd__sha512_256 },
 	{ "sigchain", cmd__sigchain },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8ed2af71d1b2..927540dff7dd 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -47,6 +47,9 @@ int cmd__serve_v2(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_array(int argc, const char **argv);
 int cmd__sha256(int argc, const char **argv);
+int cmd__sha512(int argc, const char **argv);
+int cmd__sha512_224(int argc, const char **argv);
+int cmd__sha512_256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
index 291e9061f39d..4735befe1c72 100755
--- a/t/t0015-hash.sh
+++ b/t/t0015-hash.sh
@@ -52,4 +52,84 @@ test_expect_success 'test basic SHA-256 hash values' '
 	grep 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321 actual
 '
 
+test_expect_success 'test basic SHA-512/224 hash values' '
+	test-tool sha512-224 </dev/null >actual &&
+	grep 6ed0dd02806fa89e25de060c19d3ac86cabb87d6a0ddd05c333b84f4 actual &&
+	printf "a" | test-tool sha512-224 >actual &&
+	grep d5cdb9ccc769a5121d4175f2bfdd13d6310e0d3d361ea75d82108327 actual &&
+	printf "abc" | test-tool sha512-224 >actual &&
+	grep 4634270f707b6a54daae7530460842e20e37ed265ceee9a43e8924aa actual &&
+	printf "message digest" | test-tool sha512-224 >actual &&
+	grep ad1a4db188fe57064f4f24609d2a83cd0afb9b398eb2fcaeaae2c564 actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha512-224 >actual &&
+	grep ff83148aa07ec30655c1b40aff86141c0215fe2a54f767d3f38743d8 actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha512-224 >actual &&
+	grep 37ab331d76f0d36de422bd0edeb22a28accd487b7a8453ae965dd287 actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha512-224 >actual &&
+	grep 6a312ce7c451ef28bf9ad33f5ce85ddf2d9f07097660160dbcb5c4c4 actual &&
+	printf "blob 0\0" | test-tool sha512-224 >actual &&
+	grep a86d3c63339860445607d6cfd3551292a6fb049f0faa222a7c10027b actual &&
+	printf "blob 3\0abc" | test-tool sha512-224 >actual &&
+	grep 9d6948b51bccf6b9814288d3e8cbca42f5e31b825ec613b23a45a546 actual &&
+	printf "tree 0\0" | test-tool sha512-224 >actual &&
+	grep aaff3ab067b151d0bc3130277d64a11eb257e0feca74e0dcb7e38303 actual
+'
+
+test_expect_success 'test basic SHA-512/256 hash values' '
+	test-tool sha512-256 </dev/null >actual &&
+	grep c672b8d1ef56ed28ab87c3622c5114069bdd3ad7b8f9737498d0c01ecef0967a actual &&
+	printf "a" | test-tool sha512-256 >actual &&
+	grep 455e518824bc0601f9fb858ff5c37d417d67c2f8e0df2babe4808858aea830f8 actual &&
+	printf "abc" | test-tool sha512-256 >actual &&
+	grep 53048e2681941ef99b2e29b76b4c7dabe4c2d0c634fc6d46e0e2f13107e7af23 actual &&
+	printf "message digest" | test-tool sha512-256 >actual &&
+	grep 0cf471fd17ed69d990daf3433c89b16d63dec1bb9cb42a6094604ee5d7b4e9fb actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha512-256 >actual &&
+	grep fc3189443f9c268f626aea08a756abe7b726b05f701cb08222312ccfd6710a26 actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha512-256 >actual &&
+	grep 9a59a052930187a97038cae692f30708aa6491923ef5194394dc68d56c74fb21 actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha512-256 >actual &&
+	grep b8803f7dc283e57eeb6340a3ba9d9a2098125500008b5bfdfeeb6ddd0582d2b8 actual &&
+	printf "blob 0\0" | test-tool sha512-256 >actual &&
+	grep 6576668d3acf022c9c77920c8349ed6ccd8fc596845e87c38b9e749016c984b3 actual &&
+	printf "blob 3\0abc" | test-tool sha512-256 >actual &&
+	grep 815d5a4e692c971eea251f5e8d86b42953640027d8f1163d9f33adeb5e1f7a7a actual &&
+	printf "tree 0\0" | test-tool sha512-256 >actual &&
+	grep 2cfe78f8ea2fa9d219374868e7aa1fe491622bcb5815dcf3ad12f308be7959db actual
+
+'
+
+test_expect_success 'test basic SHA-512 hash values' '
+	test-tool sha512 </dev/null >actual &&
+	grep cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e actual &&
+	printf "a" | test-tool sha512 >actual &&
+	grep 1f40fc92da241694750979ee6cf582f2d5d7d28e18335de05abc54d0560e0f5302860c652bf08d560252aa5e74210546f369fbbbce8c12cfc7957b2652fe9a75 actual &&
+	printf "abc" | test-tool sha512 >actual &&
+	grep ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f actual &&
+	printf "message digest" | test-tool sha512 >actual &&
+	grep 107dbf389d9e9f71a3a95f6c055b9251bc5268c2be16d6c13492ea45b0199f3309e16455ab1e96118e8a905d5597b72038ddb372a89826046de66687bb420e7c actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha512 >actual &&
+	grep 4dbff86cc2ca1bae1e16468a05cb9881c97f1753bce3619034898faa1aabe429955a1bf8ec483d7421fe3c1646613a59ed5441fb0f321389f77f48a879c7b1f1 actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha512 >actual &&
+	grep e718483d0ce769644e2e42c7bc15b4638e1f98b13b2044285632a803afa973ebde0ff244877ea60a4cb0432ce577c31beb009c5c2c49aa2e4eadb217ad8cc09b actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha512 >actual &&
+	grep daeddbe45570b154876086f66464a1a1ea6b623bd6bf53132a92f3326e0edb5cb8bf3eef58fe0b15c87526a226bd3242cad65f1f2025f1dbde0c30e41a9f8253 actual &&
+	printf "blob 0\0" | test-tool sha512 >actual &&
+	grep ba4d0bb3ec890fdc47a10df53a591a79852237d5e635455da90a3742d7482708b57de2ffabc7581f581ee8075fbab3476270942cdf87fa7dd6895daa6509896c actual &&
+	printf "blob 3\0abc" | test-tool sha512 >actual &&
+	grep 55abbe2a993e9d900dcd5e1315dbf5bc634af92500bf4242fd9c5bba38090ee043fc886018aab7fa7d855abf41162a1fcb49ef7bd56778fd6c0b9d1a7ba00a71 actual &&
+	printf "tree 0\0" | test-tool sha512 >actual &&
+	grep d51fd92fdd8b29d08f5cba261abb221529e6ffb1264c511be216d2f5306ecdcc38e2392de4f62c745607a97680fc7ccbbe73044dfc03d89ed95ba54967909195 actual
+
+'
+
 test_done
-- 
2.20.1

