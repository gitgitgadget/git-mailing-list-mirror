Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92847C2D0D3
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68965206CB
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mac.com header.i=@mac.com header.b="fWqhSeel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfLVGsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 01:48:31 -0500
Received: from mr85p00im-hyfv06011401.me.com ([17.58.23.191]:36522 "EHLO
        mr85p00im-hyfv06011401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbfLVGsb (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 01:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1576997309; bh=DDYVF/GUnAvYCYVNzldkAbNHNFmEqlRgF5KB1J0ayv8=;
        h=From:To:Subject:Date:Message-Id:Content-Type;
        b=fWqhSeelkWApoE+tBffySklQXMawcz5667Y+hRFkmiGyCPWYWuNTtRoC+th9Fe3R+
         /Ci/buFgqz1lsK6d9IES6gSjjXgUzbwl2DUGgkuP8zbTCVEFgidBnAy6tFuCBJPN+L
         6xXxgkPTs3bth0ZuIC06hDmbSYd1xHWtq2uGz6oNb1I+/Wtdg/FfcNpzEL23dzZVWx
         gAZRs+2NQA250tgZPyzIhAYsZSnRc2aubD48Ad86f8PSR7WE+e1ru/jJBj+nmhn8P4
         W3fMS7Ebajyy5Ni00VcRYgL0Gi8Q7GS8+c52xb1U96JI56gsOtmP9FKX3EQ5Y+yGyO
         AXty403VZYG0g==
Received: from localhost.localdomain (125-237-36-9-fibre.sparkbb.co.nz [125.237.36.9])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 24859D20971;
        Sun, 22 Dec 2019 06:48:27 +0000 (UTC)
From:   Michael Clark <michaeljclark@mac.com>
To:     git@vger.kernel.org
Cc:     Michael Clark <michaeljclark@mac.com>
Subject: [PATCH 3/6] Add an implementation of the SHA-3 hash algorithm
Date:   Sun, 22 Dec 2019 19:48:06 +1300
Message-Id: <20191222064809.35667-4-michaeljclark@mac.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191222064809.35667-1-michaeljclark@mac.com>
References: <20191222064809.35667-1-michaeljclark@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

- Add SHA3-224, SHA3-256, SHA3-384 and SHA3-512 hash algorithms
  derived from the Keccak SHA-3 submission to NIST (Round 3), 2011
  by Guido Bertoni, Joan Daemen, Michaël Peeters and Gilles Van Assche
- Add configuration machinery to select builtin impl or gcrypt.
- Add sha3-224, sha3-256, sha3-384 and sha3-512 commands to test-tool.
- Add sha3 hash tests to t/t0015-hash.sh
---
 Makefile             |   9 ++
 hash.h               |  49 +++++++-
 sha/sha3/gcrypt.h    |  53 +++++++++
 sha/sha3/sha3.c      | 271 +++++++++++++++++++++++++++++++++++++++++++
 sha/sha3/sha3.h      |  34 ++++++
 t/helper/test-sha3.c |  22 ++++
 t/helper/test-tool.c |   4 +
 t/helper/test-tool.h |   4 +
 t/t0015-hash.sh      | 108 +++++++++++++++++
 9 files changed, 553 insertions(+), 1 deletion(-)
 create mode 100644 sha/sha3/gcrypt.h
 create mode 100644 sha/sha3/sha3.c
 create mode 100644 sha/sha3/sha3.h
 create mode 100644 t/helper/test-sha3.c

diff --git a/Makefile b/Makefile
index 2cd505b21ebb..6bf9900291cb 100644
--- a/Makefile
+++ b/Makefile
@@ -742,6 +742,7 @@ TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
 TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sha512.o
+TEST_BUILTINS_OBJS += test-sha3.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
@@ -1723,6 +1724,14 @@ else
 	BASIC_CFLAGS += -DSHA512_BLK
 endif
 
+ifdef GCRYPT_SHA3
+	BASIC_CFLAGS += -DSHA3_GCRYPT
+	EXTLIBS += -lgcrypt
+else
+	LIB_OBJS += sha/sha3/sha3.o
+	BASIC_CFLAGS += -DSHA3_BLK
+endif
+
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
diff --git a/hash.h b/hash.h
index ea96fccce0c8..4826de3c80d4 100644
--- a/hash.h
+++ b/hash.h
@@ -29,6 +29,12 @@
 #include "sha/sha512/sha512.h"
 #endif
 
+#if defined(SHA3_GCRYPT)
+#include "sha/sha3/gcrypt.h"
+#else
+#include "sha/sha3/sha3.h"
+#endif
+
 #ifndef platform_SHA_CTX
 /*
  * platform's underlying implementation of SHA-1; could be OpenSSL,
@@ -67,6 +73,14 @@
 #define git_SHA512_Update	platform_SHA512_Update
 #define git_SHA512_Final	platform_SHA512_Final
 
+#define git_SHA3_CTX 		platform_SHA3_CTX
+#define git_SHA3_224_Init 	platform_SHA3_224_Init
+#define git_SHA3_256_Init 	platform_SHA3_256_Init
+#define git_SHA3_384_Init 	platform_SHA3_384_Init
+#define git_SHA3_512_Init 	platform_SHA3_512_Init
+#define git_SHA3_Update 	platform_SHA3_Update
+#define git_SHA3_Final	 	platform_SHA3_Final
+
 #ifdef SHA1_MAX_BLOCK_SIZE
 #include "compat/sha1-chunked.h"
 #undef git_SHA1_Update
@@ -93,14 +107,23 @@
 #define GIT_HASH_SHA512_224 4
 /* SHA-512-256  */
 #define GIT_HASH_SHA512_256 5
+/* SHA-3-224 */
+#define GIT_HASH_SHA3_224 6
+/* SHA-3-256 */
+#define GIT_HASH_SHA3_256 7
+/* SHA-3-384 */
+#define GIT_HASH_SHA3_384 8
+/* SHA-3-512 */
+#define GIT_HASH_SHA3_512 9
 /* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA512_256 + 1)
+#define GIT_HASH_NALGOS (GIT_HASH_SHA3_512 + 1)
 
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
 	git_SHA256_CTX sha256;
 	git_SHA512_CTX sha512;
+	git_SHA3_CTX sha3;
 };
 typedef union git_hash_ctx git_hash_ctx;
 
@@ -189,6 +212,30 @@ static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 /* The block size of SHA-512-256. */
 #define GIT_SHA512_256_BLKSZ 128
 
+/* The length in bytes and in hex digits of an object name (SHA-3-224 value). */
+#define GIT_SHA3_224_RAWSZ 28
+#define GIT_SHA3_224_HEXSZ (2 * GIT_SHA3_224_RAWSZ)
+/* The block size of SHA-3-224. */
+#define GIT_SHA3_224_BLKSZ 128
+
+/* The length in bytes and in hex digits of an object name (SHA-3-256 value). */
+#define GIT_SHA3_256_RAWSZ 32
+#define GIT_SHA3_256_HEXSZ (2 * GIT_SHA3_256_RAWSZ)
+/* The block size of SHA-3-256. */
+#define GIT_SHA3_256_BLKSZ 128
+
+/* The length in bytes and in hex digits of an object name (SHA-3-384 value). */
+#define GIT_SHA3_384_RAWSZ 48
+#define GIT_SHA3_384_HEXSZ (2 * GIT_SHA3_384_RAWSZ)
+/* The block size of SHA-3-384. */
+#define GIT_SHA3_384_BLKSZ 128
+
+/* The length in bytes and in hex digits of an object name (SHA-3-512 value). */
+#define GIT_SHA3_512_RAWSZ 64
+#define GIT_SHA3_512_HEXSZ (2 * GIT_SHA3_512_RAWSZ)
+/* The block size of SHA-3-512. */
+#define GIT_SHA3_512_BLKSZ 128
+
 /* The length in byte and in hex digits of the largest possible hash value. */
 #define GIT_MAX_RAWSZ GIT_SHA512_RAWSZ
 #define GIT_MAX_HEXSZ GIT_SHA512_HEXSZ
diff --git a/sha/sha3/gcrypt.h b/sha/sha3/gcrypt.h
new file mode 100644
index 000000000000..47a1482d65bc
--- /dev/null
+++ b/sha/sha3/gcrypt.h
@@ -0,0 +1,53 @@
+#ifndef SHA3_GCRYPT_H
+#define SHA3_GCRYPT_H
+
+#include <gcrypt.h>
+
+#define SHA3_224_DIGEST_SIZE 28
+#define SHA3_256_DIGEST_SIZE 32
+#define SHA3_384_DIGEST_SIZE 48
+#define SHA3_512_DIGEST_SIZE 64
+
+typedef gcry_md_hd_t gcrypt_SHA3_CTX;
+
+inline void gcrypt_SHA3_224_Init(gcrypt_SHA3_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA3_224, 0);
+}
+
+inline void gcrypt_SHA3_256_Init(gcrypt_SHA3_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA3_256, 0);
+}
+
+inline void gcrypt_SHA3_384_Init(gcrypt_SHA3_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA3_384, 0);
+}
+
+inline void gcrypt_SHA3_512_Init(gcrypt_SHA3_CTX *ctx)
+{
+	gcry_md_open(ctx, GCRY_MD_SHA3_512, 0);
+}
+
+inline void gcrypt_SHA3_Update(gcrypt_SHA3_CTX *ctx, const void *data, size_t len)
+{
+	gcry_md_write(*ctx, data, len);
+}
+
+inline void gcrypt_SHA3_Final(unsigned char *digest, gcrypt_SHA3_CTX *ctx)
+{
+	int algo = gcry_md_get_algo(ctx);
+	unsigned int dlen = gcry_md_get_algo_dlen(algo);
+	memcpy(digest, gcry_md_read(*ctx, algo), dlen);
+}
+
+#define platform_SHA3_CTX gcrypt_SHA3_CTX
+#define platform_SHA3_224_Init gcrypt_SHA3_224_Init
+#define platform_SHA3_256_Init gcrypt_SHA3_256_Init
+#define platform_SHA3_384_Init gcrypt_SHA3_384_Init
+#define platform_SHA3_512_Init gcrypt_SHA3_512_Init
+#define platform_SHA3_Update gcrypt_SHA3_Update
+#define platform_SHA3_Final gcrypt_SHA3_Final
+
+#endif
diff --git a/sha/sha3/sha3.c b/sha/sha3/sha3.c
new file mode 100644
index 000000000000..572cbf88f163
--- /dev/null
+++ b/sha/sha3/sha3.c
@@ -0,0 +1,271 @@
+/*
+ * sha3.c
+ *
+ * an implementation of Secure Hash Algorithm 3 (Keccak) based on:
+ * The Keccak SHA-3 submission. Submission to NIST (Round 3), 2011
+ * by Guido Bertoni, Joan Daemen, Michaël Peeters and Gilles Van Assche
+ *
+ * portions derived from RHash/sha3.c
+ *
+ * Copyright (c) 2013, Aleksey Kravchenko <rhash.admin@gmail.com>
+ * Copyright (c) 2019, Michael Clark <michaeljclark@mac.com>
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#include "git-compat-util.h"
+#include "sha3.h"
+
+/*
+ * macro to expand Keccak 7-term GF(2) round constant:
+ *
+ * (ax^63 + bx^31 + cx^15 + dx^7 + ex^3 + fx + g)
+ *
+ * K(c) -> forall (b in 0...6) |= c[b] << (1 << b) ;
+ */
+#define T(c,b) 0b##c##ull>>b<<63>>(64-(1 << b))
+#define K(c) T(c,0)|T(c,1)|T(c,2)|T(c,3)|T(c,4)|T(c,5)|T(c,6)
+
+/*
+ * expand SHA3 (Keccak) constants for 24 rounds
+ */
+static uint64_t keccak_round_constants[24] = {
+	K(0000001), K(0011010), K(1011110), K(1110000),
+	K(0011111), K(0100001), K(1111001), K(1010101),
+	K(0001110), K(0001100), K(0110101), K(0100110),
+	K(0111111), K(1001111), K(1011101), K(1010011),
+	K(1010010), K(1001000), K(0010110), K(1100110),
+	K(1111001), K(1011000), K(0100001), K(1110100),
+};
+
+static inline uint64_t rol(uint64_t x, int d)
+{
+	return (x << d) | (x >> (64-d));
+}
+
+/* Keccak theta() transformation */
+static void keccak_theta(uint64_t A[25])
+{
+	uint64_t C[5] = {
+		A[0] ^ A[5] ^ A[10] ^ A[15] ^ A[20],
+		A[1] ^ A[6] ^ A[11] ^ A[16] ^ A[21],
+		A[2] ^ A[7] ^ A[12] ^ A[17] ^ A[22],
+		A[3] ^ A[8] ^ A[13] ^ A[18] ^ A[23],
+		A[4] ^ A[9] ^ A[14] ^ A[19] ^ A[24]
+	};
+
+	uint64_t D[5] = {
+		rol(C[1], 1) ^ C[4],
+		rol(C[2], 1) ^ C[0],
+		rol(C[3], 1) ^ C[1],
+		rol(C[4], 1) ^ C[2],
+		rol(C[0], 1) ^ C[3]
+	};
+
+	for (size_t i = 0; i < 25; i += 5) {
+		A[i + 0] ^= D[0];
+		A[i + 1] ^= D[1];
+		A[i + 2] ^= D[2];
+		A[i + 3] ^= D[3];
+		A[i + 4] ^= D[4];
+	}
+}
+
+/* Keccak pi() transformation */
+static void keccak_pi(uint64_t A[25])
+{
+	uint64_t A1;
+	A1 = A[1];
+	A[ 1] = A[ 6];
+	A[ 6] = A[ 9];
+	A[ 9] = A[22];
+	A[22] = A[14];
+	A[14] = A[20];
+	A[20] = A[ 2];
+	A[ 2] = A[12];
+	A[12] = A[13];
+	A[13] = A[19];
+	A[19] = A[23];
+	A[23] = A[15];
+	A[15] = A[ 4];
+	A[ 4] = A[24];
+	A[24] = A[21];
+	A[21] = A[ 8];
+	A[ 8] = A[16];
+	A[16] = A[ 5];
+	A[ 5] = A[ 3];
+	A[ 3] = A[18];
+	A[18] = A[17];
+	A[17] = A[11];
+	A[11] = A[ 7];
+	A[ 7] = A[10];
+	A[10] = A1;
+	/* note: A[ 0] is left as is */
+}
+
+static inline void ChiStep(uint64_t A[25], size_t i)
+{
+	uint64_t C[5];
+	C[0] = A[0 + i] ^ ~A[1 + i] & A[2 + i];
+	C[1] = A[1 + i] ^ ~A[2 + i] & A[3 + i];
+	C[2] = A[2 + i] ^ ~A[3 + i] & A[4 + i];
+	C[3] = A[3 + i] ^ ~A[4 + i] & A[0 + i];
+	C[4] = A[4 + i] ^ ~A[0 + i] & A[1 + i];
+	A[0 + i] = C[0];
+	A[1 + i] = C[1];
+	A[2 + i] = C[2];
+	A[3 + i] = C[3];
+	A[4 + i] = C[4];
+}
+
+/* Keccak chi() transformation */
+static void keccak_chi(uint64_t A[25])
+{
+	ChiStep(A,0);
+	ChiStep(A,5);
+	ChiStep(A,10);
+	ChiStep(A,15);
+	ChiStep(A,20);
+}
+
+static void keccak_rho(uint64_t A[25])
+{
+	/* apply Keccak rho() transformation */
+	A[ 1] = rol(A[ 1],  1);
+	A[ 2] = rol(A[ 2], 62);
+	A[ 3] = rol(A[ 3], 28);
+	A[ 4] = rol(A[ 4], 27);
+	A[ 5] = rol(A[ 5], 36);
+	A[ 6] = rol(A[ 6], 44);
+	A[ 7] = rol(A[ 7],  6);
+	A[ 8] = rol(A[ 8], 55);
+	A[ 9] = rol(A[ 9], 20);
+	A[10] = rol(A[10],  3);
+	A[11] = rol(A[11], 10);
+	A[12] = rol(A[12], 43);
+	A[13] = rol(A[13], 25);
+	A[14] = rol(A[14], 39);
+	A[15] = rol(A[15], 41);
+	A[16] = rol(A[16], 45);
+	A[17] = rol(A[17], 15);
+	A[18] = rol(A[18], 21);
+	A[19] = rol(A[19],  8);
+	A[20] = rol(A[20], 18);
+	A[21] = rol(A[21],  2);
+	A[22] = rol(A[22], 61);
+	A[23] = rol(A[23], 56);
+	A[24] = rol(A[24], 14);
+}
+
+static void keccak_iota(uint64_t A[25], size_t round)
+{
+	/* apply iota(state, round) */
+	A[0] ^= keccak_round_constants[round];
+}
+
+static void keccak_permutation(uint64_t A[25])
+{
+	for (size_t round = 0; round < 24; round++)
+	{
+		keccak_theta(A);
+		keccak_rho(A);
+		keccak_pi(A);
+		keccak_chi(A);
+		keccak_iota(A, round);
+	}
+}
+
+static void blk_SHA3_Transform(blk_SHA3_CTX* ctx, const unsigned char *buf)
+{
+	size_t block_size = ctx->block_size;
+	for (size_t i = 0; i < block_size/8; i++)
+	{
+		ctx->state[i] ^= le64toh(((uint64_t*)buf)[i]);
+	}
+	keccak_permutation(ctx->state);
+}
+
+static void blk_SHA3_Init(blk_SHA3_CTX* ctx, unsigned bits)
+{
+	/* NB: The Keccak capacity parameter = bits * 2 */
+	unsigned rate = 1600 - bits * 2;
+
+	memset(ctx, 0, sizeof(blk_SHA3_CTX));
+	ctx->block_size = rate / 8;
+	assert(rate <= 1600 && (rate % 64) == 0);
+}
+
+void blk_SHA3_224_Init(blk_SHA3_CTX* ctx) { blk_SHA3_Init(ctx, 224); }
+void blk_SHA3_256_Init(blk_SHA3_CTX* ctx) { blk_SHA3_Init(ctx, 256); }
+void blk_SHA3_384_Init(blk_SHA3_CTX* ctx) { blk_SHA3_Init(ctx, 384); }
+void blk_SHA3_512_Init(blk_SHA3_CTX* ctx) { blk_SHA3_Init(ctx, 512); }
+
+void blk_SHA3_Update(blk_SHA3_CTX* ctx, const void *data, size_t len)
+{
+	unsigned int block_size = ctx->block_size;
+	unsigned int len_buf = ctx->size % block_size;
+
+	ctx->size += len;
+
+	/* Read the data into buf and process blocks as they get full */
+	if (len_buf) {
+		unsigned int left = block_size - len_buf;
+		if (len < left)
+			left = len;
+		memcpy(len_buf + ctx->buf, data, left);
+		len_buf = (len_buf + left) % block_size;
+		len -= left;
+		data = ((const char *)data + left);
+		if (len_buf)
+			return;
+		blk_SHA3_Transform(ctx, ctx->buf);
+	}
+	while (len >= block_size) {
+		blk_SHA3_Transform(ctx, data);
+		data = ((const char *)data + block_size);
+		len -= block_size;
+	}
+	if (len)
+		memcpy(ctx->buf, data, len);
+}
+
+static inline void put_le64(void *ptr, uint64_t value)
+{
+	unsigned char *p = ptr;
+	p[0] = value >>  0;
+	p[1] = value >>  8;
+	p[2] = value >> 16;
+	p[3] = value >> 24;
+	p[4] = value >> 32;
+	p[5] = value >> 40;
+	p[6] = value >> 48;
+	p[7] = value >> 56;
+}
+
+void blk_SHA3_Final(unsigned char* digest, blk_SHA3_CTX* ctx)
+{
+	unsigned int digest_length = 100 - ctx->block_size / 2;
+	unsigned int block_size = ctx->block_size;
+	unsigned int len = ctx->size % block_size, i;
+
+	/* Pad with 0x06, then zeroes, then 0x80 */
+	memset((char*)ctx->buf + len, 0, block_size - len);
+	((char*)ctx->buf)[len] |= 0x06;
+	((char*)ctx->buf)[block_size - 1] |= 0x80;
+
+	/* process final block */
+	blk_SHA3_Transform(ctx, ctx->buf);
+
+	/* copy output */
+	for (i = 0; i < (digest_length+7)/8; i++, digest += sizeof(uint64_t))
+		put_le64(digest, ctx->state[i]);
+}
diff --git a/sha/sha3/sha3.h b/sha/sha3/sha3.h
new file mode 100644
index 000000000000..eb974d69d2b8
--- /dev/null
+++ b/sha/sha3/sha3.h
@@ -0,0 +1,34 @@
+#ifndef SHA3_BLOCK_H
+#define SHA3_BLOCK_H
+
+#define blk_SHA3_224_hash_size 28
+#define blk_SHA3_256_hash_size 32
+#define blk_SHA3_384_hash_size 48
+#define blk_SHA3_512_hash_size 64
+#define blk_SHA3_max_permutation_size 200
+
+typedef struct blk_SHA3_CTX
+{
+	uint64_t state[blk_SHA3_max_permutation_size];
+	uint64_t size;
+	uint64_t block_size;
+	uint8_t buf[blk_SHA3_max_permutation_size];
+} blk_SHA3_CTX;
+
+void blk_SHA3_224_Init(blk_SHA3_CTX* ctx);
+void blk_SHA3_256_Init(blk_SHA3_CTX* ctx);
+void blk_SHA3_384_Init(blk_SHA3_CTX* ctx);
+void blk_SHA3_512_Init(blk_SHA3_CTX* ctx);
+void blk_SHA3_Update(blk_SHA3_CTX* ctx, const void *data, size_t len);
+void blk_SHA3_Final(unsigned char* digest, blk_SHA3_CTX* ctx);
+
+#define platform_SHA3_CTX blk_SHA3_CTX
+#define platform_SHA3_Init blk_SHA3_Init
+#define platform_SHA3_224_Init blk_SHA3_224_Init
+#define platform_SHA3_256_Init blk_SHA3_256_Init
+#define platform_SHA3_384_Init blk_SHA3_384_Init
+#define platform_SHA3_512_Init blk_SHA3_512_Init
+#define platform_SHA3_Update blk_SHA3_Update
+#define platform_SHA3_Final blk_SHA3_Final
+
+#endif
\ No newline at end of file
diff --git a/t/helper/test-sha3.c b/t/helper/test-sha3.c
new file mode 100644
index 000000000000..323936d1bc2e
--- /dev/null
+++ b/t/helper/test-sha3.c
@@ -0,0 +1,22 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__sha3_224(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA3_224);
+}
+
+int cmd__sha3_256(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA3_256);
+}
+
+int cmd__sha3_384(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA3_384);
+}
+
+int cmd__sha3_512(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA3_512);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 47deff9c6ef4..7acae78e9b87 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -60,6 +60,10 @@ static struct test_cmd cmds[] = {
 	{ "sha512", cmd__sha512 },
 	{ "sha512-224", cmd__sha512_224 },
 	{ "sha512-256", cmd__sha512_256 },
+	{ "sha3-224", cmd__sha3_224 },
+	{ "sha3-256", cmd__sha3_256 },
+	{ "sha3-384", cmd__sha3_384 },
+	{ "sha3-512", cmd__sha3_512 },
 	{ "sigchain", cmd__sigchain },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 927540dff7dd..8aa5cee7710b 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -50,6 +50,10 @@ int cmd__sha256(int argc, const char **argv);
 int cmd__sha512(int argc, const char **argv);
 int cmd__sha512_224(int argc, const char **argv);
 int cmd__sha512_256(int argc, const char **argv);
+int cmd__sha3_224(int argc, const char **argv);
+int cmd__sha3_256(int argc, const char **argv);
+int cmd__sha3_384(int argc, const char **argv);
+int cmd__sha3_512(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
diff --git a/t/t0015-hash.sh b/t/t0015-hash.sh
index 4735befe1c72..c68a9ef2145c 100755
--- a/t/t0015-hash.sh
+++ b/t/t0015-hash.sh
@@ -132,4 +132,112 @@ test_expect_success 'test basic SHA-512 hash values' '
 
 '
 
+test_expect_success 'test basic SHA3-224 hash values' '
+	test-tool sha3-224 </dev/null >actual &&
+	grep 6b4e03423667dbb73b6e15454f0eb1abd4597f9a1b078e3f5b5a6bc7 actual &&
+	printf "a" | test-tool sha3-224 >actual &&
+	grep 9e86ff69557ca95f405f081269685b38e3a819b309ee942f482b6a8b actual &&
+	printf "abc" | test-tool sha3-224 >actual &&
+	grep e642824c3f8cf24ad09234ee7d3c766fc9a3a5168d0c94ad73b46fdf actual &&
+	printf "message digest" | test-tool sha3-224 >actual &&
+	grep 18768bb4c48eb7fc88e5ddb17efcf2964abd7798a39d86a4b4a1e4c8 actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha3-224 >actual &&
+	grep 5cdeca81e123f87cad96b9cba999f16f6d41549608d4e0f4681b8239 actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha3-224 >actual &&
+	grep d69335b93325192e516a912e6d19a15cb51c6ed5c15243e7a7fd653c actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha3-224 >actual &&
+	grep 165efebf793f03c7610d6d5e79462c5f9b7fbcb903f4448038eb35a2 actual &&
+	printf "blob 0\0" | test-tool sha3-224 >actual &&
+	grep f1e72935ac5c52d5c09b408842e207c42e5434424007364fdb468063 actual &&
+	printf "blob 3\0abc" | test-tool sha3-224 >actual &&
+	grep f83c608c9d424b858f66ec80a67ab42409bdc1aae8d7867e6b595e2a actual &&
+	printf "tree 0\0" | test-tool sha3-224 >actual &&
+	grep 1e04f23de0b2b7d1b85e6768fa997a99bd0119dec8158ae0ad07e183 actual
+
+'
+
+test_expect_success 'test basic SHA3-256 hash values' '
+	test-tool sha3-256 </dev/null >actual &&
+	grep a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a actual &&
+	printf "a" | test-tool sha3-256 >actual &&
+	grep 80084bf2fba02475726feb2cab2d8215eab14bc6bdd8bfb2c8151257032ecd8b actual &&
+	printf "abc" | test-tool sha3-256 >actual &&
+	grep 3a985da74fe225b2045c172d6bd390bd855f086e3e9d525b46bfe24511431532 actual &&
+	printf "message digest" | test-tool sha3-256 >actual &&
+	grep edcdb2069366e75243860c18c3a11465eca34bce6143d30c8665cefcfd32bffd actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha3-256 >actual &&
+	grep 7cab2dc765e21b241dbc1c255ce620b29f527c6d5e7f5f843e56288f0d707521 actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha3-256 >actual &&
+	grep 5c8875ae474a3634ba4fd55ec85bffd661f32aca75c6d699d0cdcb6c115891c1 actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha3-256 >actual &&
+	grep 529a361bd6ebbb28deea5a78db2fd714c5b415499d608e37123c4ca130770e6d actual &&
+	printf "blob 0\0" | test-tool sha3-256 >actual &&
+	grep 5aadde7d8ca5b9b352c250ce9b799f5d818893fe89dc52b49f438c8a9ba0a545 actual &&
+	printf "blob 3\0abc" | test-tool sha3-256 >actual &&
+	grep 1a6437dda2a94af5c38246520fd1461886dc46b97ced88b04d43537c603cde6d actual &&
+	printf "tree 0\0" | test-tool sha3-256 >actual &&
+	grep 30211ed485c912e5bc285bd0bd8959ddbfb5875cafb0ae28e0abfa1077b2b214 actual
+
+'
+
+test_expect_success 'test basic SHA3-384 hash values' '
+	test-tool sha3-384 </dev/null >actual &&
+	grep 0c63a75b845e4f7d01107d852e4c2485c51a50aaaa94fc61995e71bbee983a2ac3713831264adb47fb6bd1e058d5f004 actual &&
+	printf "a" | test-tool sha3-384 >actual &&
+	grep 1815f774f320491b48569efec794d249eeb59aae46d22bf77dafe25c5edc28d7ea44f93ee1234aa88f61c91912a4ccd9 actual &&
+	printf "abc" | test-tool sha3-384 >actual &&
+	grep ec01498288516fc926459f58e2c6ad8df9b473cb0fc08c2596da7cf0e49be4b298d88cea927ac7f539f1edf228376d25 actual &&
+	printf "message digest" | test-tool sha3-384 >actual &&
+	grep d9519709f44af73e2c8e291109a979de3d61dc02bf69def7fbffdfffe662751513f19ad57e17d4b93ba1e484fc1980d5 actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha3-384 >actual &&
+	grep fed399d2217aaf4c717ad0c5102c15589e1c990cc2b9a5029056a7f7485888d6ab65db2370077a5cadb53fc9280d278f actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha3-384 >actual &&
+	grep eee9e24d78c1855337983451df97c8ad9eedf256c6334f8e948d252d5e0e76847aa0774ddb90a842190d2c558b4b8340 actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha3-384 >actual &&
+	grep 62c16d1d4366dd40a4c6995168c1e7b35e8e8103403274151a34c5838845a0f3d1a192dadbb0964af7d6941c50f0eb97 actual &&
+	printf "blob 0\0" | test-tool sha3-384 >actual &&
+	grep a53e088abe908d8c9458a8ba955690c417f768031ecf156a1662441faeda502e838f2660164b61a78b15ac75e0f8ded4 actual &&
+	printf "blob 3\0abc" | test-tool sha3-384 >actual &&
+	grep ba0eda34a4b47f9ec8ed996a260efadeb576e4f682b7d0d7d84b4781a210771da519e48f2542431882499fbd21d16935 actual &&
+	printf "tree 0\0" | test-tool sha3-384 >actual &&
+	grep 92e99ae9281a89dc332c9ce8f2831db50ecc54784d51c3ebd5c1151e8fd603fb408abbbb9dcf5713ed21566789ce8059 actual
+
+'
+
+test_expect_success 'test basic SHA3-512 hash values' '
+	test-tool sha3-512 </dev/null >actual &&
+	grep a69f73cca23a9ac5c8b567dc185a756e97c982164fe25859e0d1dcc1475c80a615b2123af1f5f94c11e3e9402c3ac558f500199d95b6d3e301758586281dcd26 actual &&
+	printf "a" | test-tool sha3-512 >actual &&
+	grep 697f2d856172cb8309d6b8b97dac4de344b549d4dee61edfb4962d8698b7fa803f4f93ff24393586e28b5b957ac3d1d369420ce53332712f997bd336d09ab02a actual &&
+	printf "abc" | test-tool sha3-512 >actual &&
+	grep b751850b1a57168a5693cd924b6b096e08f621827444f70d884f5d0240d2712e10e116e9192af3c91a7ec57647e3934057340b4cf408d5a56592f8274eec53f0 actual &&
+	printf "message digest" | test-tool sha3-512 >actual &&
+	grep 3444e155881fa15511f57726c7d7cfe80302a7433067b29d59a71415ca9dd141ac892d310bc4d78128c98fda839d18d7f0556f2fe7acb3c0cda4bff3a25f5f59 actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha3-512 >actual &&
+	grep af328d17fa28753a3c9f5cb72e376b90440b96f0289e5703b729324a975ab384eda565fc92aaded143669900d761861687acdc0a5ffa358bd0571aaad80aca68 actual &&
+	# Try to exercise the chunking code by turning autoflush on.
+	perl -e "$| = 1; print q{aaaaaaaaaa} for 1..100000;" | \
+		test-tool sha3-512 >actual &&
+	grep 3c3a876da14034ab60627c077bb98f7e120a2a5370212dffb3385a18d4f38859ed311d0a9d5141ce9cc5c66ee689b266a8aa18ace8282a0e0db596c90b0a7b87 actual &&
+	perl -e "$| = 1; print q{abcdefghijklmnopqrstuvwxyz} for 1..100000;" | \
+		test-tool sha3-512 >actual &&
+	grep 06b2e52cc7595712651351cdc6726acdebba682844c7983f66089158433975e4d2caf6c0efc4c7018cd2da73df53047f19a79935941025db4aaf1bd876c49ad6 actual &&
+	printf "blob 0\0" | test-tool sha3-512 >actual &&
+	grep 4353a50d0d3d8edd231763fb0102116286aa6d760a772133e32c124a998a19467d789064dd763e57b547ff3a31882da3d2031378cfe0fa5774c12eea51055a51 actual &&
+	printf "blob 3\0abc" | test-tool sha3-512 >actual &&
+	grep 89de02c66a3beca3411b5a72699fe8389d574b7d59ca17d42cba7a83cd03423388b1c4248cd8a3cce73a0768948fe1a800c155c24378334f6ae2bb8c5bf48284 actual &&
+	printf "tree 0\0" | test-tool sha3-512 >actual &&
+	grep 8f86cb67ce0a8bc865b300733c27dade0ea8fe66299b4bc6368ec84f53134c367c66f0e3376261ab5a86d722ad0d98391a3c1c472d6791da464a7836006de12c actual
+
+'
+
 test_done
-- 
2.20.1

