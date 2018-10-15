Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170A91F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeJOKCa (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:02:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50750 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbeJOKC2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 06:02:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5149261B79;
        Mon, 15 Oct 2018 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539569958;
        bh=s0k7z+853LIPlXuziye44xks90falOwDlBNW3hbsdXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=z2PH/cKZ9WRblmstkw+RWppYEeMa0wPyFx6D3La/7B6suYCNI08/046g6xGo4G/Zy
         FyEUnXgf3lUr0Y6Vg2bGkbjoeuAZt6zbDlPRkZkqlJPAu0Kd4e6tAcu4ePuQD7Q60I
         IbCyenLkgV5sR1GKBWMjuFHqZ15MXVH07V8+Bs8SDrzs2SFLYkzv+m1hS9omIW9XlM
         rC4sbgJRQpO0q38BJHtvlNgxcdhOLQlMQIuACMf+C8lZ/K/rGbI9fACIu7sO6l7Fqa
         ERp+G33bZC22Zl5R77l9sYQ3/mzlTfAbs7sU5q8G+SMqP+Pg2ei7VR9AVSpJ+z/4VD
         MoP12eGUB2Xs+ZYHxyoOM/1htDovvFVw9zGhcEFJP243uwr9QRDWsBQJjBsuFyoMPa
         y0fs4dJh5xzRI0P25ooPQcnujOYAzhYKaaVhNS8ko3QM/WRVojGYlnzoDQJsDlV/Wz
         /qKZe0L5SyLVE3prP04AUc1Z1iuD89SlE5T9mUq/denBwXz6jAz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/13] Add a base implementation of SHA-256 support
Date:   Mon, 15 Oct 2018 02:18:57 +0000
Message-Id: <20181015021900.1030041-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SHA-1 is weak and we need to transition to a new hash function.  For
some time, we have referred to this new function as NewHash.  Recently,
we decided to pick SHA-256 as NewHash.

Add a basic implementation of SHA-256 based off libtomcrypt, which is in
the public domain.  Optimize it and restructure it to meet our coding
standards.  Place it in a directory called "sha256" where it and any
future implementations can live so as to avoid a proliferation of
implementation directories.

Wire up SHA-256 in the list of hash algorithms, and add a test that the
algorithm works correctly.

Note that with this patch, it is still not possible to switch to using
SHA-256 in Git.  Additional patches are needed to prepare the code to
handle a larger hash algorithm and further test fixes are needed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile               |   4 +
 cache.h                |  12 ++-
 hash.h                 |  19 ++++-
 sha1-file.c            |  45 +++++++++++
 sha256/block/sha256.c  | 180 +++++++++++++++++++++++++++++++++++++++++
 sha256/block/sha256.h  |  26 ++++++
 t/helper/test-sha256.c |   7 ++
 t/helper/test-tool.c   |   1 +
 t/helper/test-tool.h   |   1 +
 t/t0014-hash.sh        |  25 ++++++
 10 files changed, 316 insertions(+), 4 deletions(-)
 create mode 100644 sha256/block/sha256.c
 create mode 100644 sha256/block/sha256.h
 create mode 100644 t/helper/test-sha256.c

diff --git a/Makefile b/Makefile
index 1c43bf9aa8..76d378c7ba 100644
--- a/Makefile
+++ b/Makefile
@@ -739,6 +739,7 @@ TEST_BUILTINS_OBJS += test-run-command.o
 TEST_BUILTINS_OBJS += test-scrap-cache-tree.o
 TEST_BUILTINS_OBJS += test-sha1.o
 TEST_BUILTINS_OBJS += test-sha1-array.o
+TEST_BUILTINS_OBJS += test-sha256.o
 TEST_BUILTINS_OBJS += test-sigchain.o
 TEST_BUILTINS_OBJS += test-strcmp-offset.o
 TEST_BUILTINS_OBJS += test-string-list.o
@@ -1633,6 +1634,9 @@ endif
 endif
 endif
 
+LIB_OBJS += sha256/block/sha256.o
+BASIC_CFLAGS += -DSHA256_BLK
+
 ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
diff --git a/cache.h b/cache.h
index 48e736b0d5..81ece0360e 100644
--- a/cache.h
+++ b/cache.h
@@ -48,11 +48,17 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 /* The block size of SHA-1. */
 #define GIT_SHA1_BLKSZ 64
 
+/* The length in bytes and in hex digits of an object name (SHA-256 value). */
+#define GIT_SHA256_RAWSZ 32
+#define GIT_SHA256_HEXSZ (2 * GIT_SHA256_RAWSZ)
+/* The block size of SHA-256. */
+#define GIT_SHA256_BLKSZ 64
+
 /* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
+#define GIT_MAX_RAWSZ GIT_SHA256_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA256_HEXSZ
 /* The largest possible block size for any supported hash. */
-#define GIT_MAX_BLKSZ GIT_SHA1_BLKSZ
+#define GIT_MAX_BLKSZ GIT_SHA256_BLKSZ
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
diff --git a/hash.h b/hash.h
index 46dff69eb3..88d18896d7 100644
--- a/hash.h
+++ b/hash.h
@@ -15,6 +15,8 @@
 #include "block-sha1/sha1.h"
 #endif
 
+#include "sha256/block/sha256.h"
+
 #ifndef platform_SHA_CTX
 /*
  * platform's underlying implementation of SHA-1; could be OpenSSL,
@@ -34,6 +36,18 @@
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
 
+#ifndef platform_SHA256_CTX
+#define platform_SHA256_CTX	SHA256_CTX
+#define platform_SHA256_Init	SHA256_Init
+#define platform_SHA256_Update	SHA256_Update
+#define platform_SHA256_Final	SHA256_Final
+#endif
+
+#define git_SHA256_CTX		platform_SHA256_CTX
+#define git_SHA256_Init		platform_SHA256_Init
+#define git_SHA256_Update	platform_SHA256_Update
+#define git_SHA256_Final	platform_SHA256_Final
+
 #ifdef SHA1_MAX_BLOCK_SIZE
 #include "compat/sha1-chunked.h"
 #undef git_SHA1_Update
@@ -52,12 +66,15 @@
 #define GIT_HASH_UNKNOWN 0
 /* SHA-1 */
 #define GIT_HASH_SHA1 1
+/* SHA-256  */
+#define GIT_HASH_SHA256 2
 /* Number of algorithms supported (including unknown). */
-#define GIT_HASH_NALGOS (GIT_HASH_SHA1 + 1)
+#define GIT_HASH_NALGOS (GIT_HASH_SHA256 + 1)
 
 /* A suitably aligned type for stack allocations of hash contexts. */
 union git_hash_ctx {
 	git_SHA_CTX sha1;
+	git_SHA256_CTX sha256;
 };
 typedef union git_hash_ctx git_hash_ctx;
 
diff --git a/sha1-file.c b/sha1-file.c
index 9aadaf0c8d..66ba3dadb9 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -40,10 +40,20 @@
 #define EMPTY_TREE_SHA1_BIN_LITERAL \
 	 "\x4b\x82\x5d\xc6\x42\xcb\x6e\xb9\xa0\x60" \
 	 "\xe5\x4b\xf8\xd6\x92\x88\xfb\xee\x49\x04"
+#define EMPTY_TREE_SHA256_BIN_LITERAL \
+	"\x6e\xf1\x9b\x41\x22\x5c\x53\x69\xf1\xc1" \
+	"\x04\xd4\x5d\x8d\x85\xef\xa9\xb0\x57\xb5" \
+	"\x3b\x14\xb4\xb9\xb9\x39\xdd\x74\xde\xcc" \
+	"\x53\x21"
 
 #define EMPTY_BLOB_SHA1_BIN_LITERAL \
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
 	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
+#define EMPTY_BLOB_SHA256_BIN_LITERAL \
+	"\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
+	"\x67\xe3\xb1\xe9\xa7\xdc\xda\x11\x85\x43" \
+	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
+	"\x18\x13"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -53,6 +63,12 @@ static const struct object_id empty_tree_oid = {
 static const struct object_id empty_blob_oid = {
 	EMPTY_BLOB_SHA1_BIN_LITERAL
 };
+static const struct object_id empty_tree_oid_sha256 = {
+	EMPTY_TREE_SHA256_BIN_LITERAL
+};
+static const struct object_id empty_blob_oid_sha256 = {
+	EMPTY_BLOB_SHA256_BIN_LITERAL
+};
 
 static void git_hash_sha1_init(git_hash_ctx *ctx)
 {
@@ -69,6 +85,22 @@ static void git_hash_sha1_final(unsigned char *hash, git_hash_ctx *ctx)
 	git_SHA1_Final(hash, &ctx->sha1);
 }
 
+
+static void git_hash_sha256_init(git_hash_ctx *ctx)
+{
+	git_SHA256_Init(&ctx->sha256);
+}
+
+static void git_hash_sha256_update(git_hash_ctx *ctx, const void *data, size_t len)
+{
+	git_SHA256_Update(&ctx->sha256, data, len);
+}
+
+static void git_hash_sha256_final(unsigned char *hash, git_hash_ctx *ctx)
+{
+	git_SHA256_Final(hash, &ctx->sha256);
+}
+
 static void git_hash_unknown_init(git_hash_ctx *ctx)
 {
 	BUG("trying to init unknown hash");
@@ -110,6 +142,19 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		&empty_tree_oid,
 		&empty_blob_oid,
 	},
+	{
+		"sha256",
+		/* "s256", big-endian */
+		0x73323536,
+		GIT_SHA256_RAWSZ,
+		GIT_SHA256_HEXSZ,
+		GIT_SHA256_BLKSZ,
+		git_hash_sha256_init,
+		git_hash_sha256_update,
+		git_hash_sha256_final,
+		&empty_tree_oid_sha256,
+		&empty_blob_oid_sha256,
+	}
 };
 
 const char *empty_tree_oid_hex(void)
diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
new file mode 100644
index 0000000000..18350c161a
--- /dev/null
+++ b/sha256/block/sha256.c
@@ -0,0 +1,180 @@
+#include "git-compat-util.h"
+#include "./sha256.h"
+
+#define BLKSIZE blk_SHA256_BLKSIZE
+
+void blk_SHA256_Init(blk_SHA256_CTX *ctx)
+{
+	ctx->offset = 0;
+	ctx->length = 0;
+	ctx->state[0] = 0x6A09E667UL;
+	ctx->state[1] = 0xBB67AE85UL;
+	ctx->state[2] = 0x3C6EF372UL;
+	ctx->state[3] = 0xA54FF53AUL;
+	ctx->state[4] = 0x510E527FUL;
+	ctx->state[5] = 0x9B05688CUL;
+	ctx->state[6] = 0x1F83D9ABUL;
+	ctx->state[7] = 0x5BE0CD19UL;
+}
+
+static inline uint32_t ror(uint32_t x, unsigned n)
+{
+	return (x >> n) | (x << (32 - n));
+}
+
+#define Ch(x,y,z)       (z ^ (x & (y ^ z)))
+#define Maj(x,y,z)      (((x | y) & z) | (x & y))
+#define S(x, n)         ror((x),(n))
+#define R(x, n)         ((x)>>(n))
+#define Sigma0(x)       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
+#define Sigma1(x)       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
+#define Gamma0(x)       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
+#define Gamma1(x)       (S(x, 17) ^ S(x, 19) ^ R(x, 10))
+
+static void blk_SHA256_Transform(blk_SHA256_CTX *ctx, const unsigned char *buf)
+{
+
+	uint32_t S[8], W[64], t0, t1;
+	int i;
+
+	/* copy state into S */
+	for (i = 0; i < 8; i++) {
+		S[i] = ctx->state[i];
+	}
+
+	/* copy the state into 512-bits into W[0..15] */
+	for (i = 0; i < 16; i++, buf += sizeof(uint32_t)) {
+		W[i] = get_be32(buf);
+	}
+
+	/* fill W[16..63] */
+	for (i = 16; i < 64; i++) {
+		W[i] = Gamma1(W[i - 2]) + W[i - 7] + Gamma0(W[i - 15]) + W[i - 16];
+	}
+
+#define RND(a,b,c,d,e,f,g,h,i,ki)                    \
+	t0 = h + Sigma1(e) + Ch(e, f, g) + ki + W[i];   \
+	t1 = Sigma0(a) + Maj(a, b, c);                  \
+	d += t0;                                        \
+	h  = t0 + t1;
+
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],0,0x428a2f98);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],1,0x71374491);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],2,0xb5c0fbcf);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],3,0xe9b5dba5);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],4,0x3956c25b);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],5,0x59f111f1);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],6,0x923f82a4);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],7,0xab1c5ed5);
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],8,0xd807aa98);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],9,0x12835b01);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],10,0x243185be);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],11,0x550c7dc3);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],12,0x72be5d74);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],13,0x80deb1fe);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],14,0x9bdc06a7);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],15,0xc19bf174);
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],16,0xe49b69c1);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],17,0xefbe4786);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],18,0x0fc19dc6);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],19,0x240ca1cc);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],20,0x2de92c6f);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],21,0x4a7484aa);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],22,0x5cb0a9dc);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],23,0x76f988da);
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],24,0x983e5152);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],25,0xa831c66d);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],26,0xb00327c8);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],27,0xbf597fc7);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],28,0xc6e00bf3);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],29,0xd5a79147);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],30,0x06ca6351);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],31,0x14292967);
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],32,0x27b70a85);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],33,0x2e1b2138);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],34,0x4d2c6dfc);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],35,0x53380d13);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],36,0x650a7354);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],37,0x766a0abb);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],38,0x81c2c92e);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],39,0x92722c85);
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],40,0xa2bfe8a1);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],41,0xa81a664b);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],42,0xc24b8b70);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],43,0xc76c51a3);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],44,0xd192e819);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],45,0xd6990624);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],46,0xf40e3585);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],47,0x106aa070);
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],48,0x19a4c116);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],49,0x1e376c08);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],50,0x2748774c);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],51,0x34b0bcb5);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],52,0x391c0cb3);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],53,0x4ed8aa4a);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],54,0x5b9cca4f);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],55,0x682e6ff3);
+	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],56,0x748f82ee);
+	RND(S[7],S[0],S[1],S[2],S[3],S[4],S[5],S[6],57,0x78a5636f);
+	RND(S[6],S[7],S[0],S[1],S[2],S[3],S[4],S[5],58,0x84c87814);
+	RND(S[5],S[6],S[7],S[0],S[1],S[2],S[3],S[4],59,0x8cc70208);
+	RND(S[4],S[5],S[6],S[7],S[0],S[1],S[2],S[3],60,0x90befffa);
+	RND(S[3],S[4],S[5],S[6],S[7],S[0],S[1],S[2],61,0xa4506ceb);
+	RND(S[2],S[3],S[4],S[5],S[6],S[7],S[0],S[1],62,0xbef9a3f7);
+	RND(S[1],S[2],S[3],S[4],S[5],S[6],S[7],S[0],63,0xc67178f2);
+
+#undef RND
+
+	for (i = 0; i < 8; i++) {
+		ctx->state[i] = ctx->state[i] + S[i];
+	}
+}
+
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
+{
+	const unsigned char *in = data;
+	size_t n;
+	ctx->length += len;
+	while (len > 0) {
+		if (!ctx->offset && len >= BLKSIZE) {
+			blk_SHA256_Transform(ctx, in);
+			in += BLKSIZE;
+			len -= BLKSIZE;
+		} else {
+			n = MIN(len, (BLKSIZE - ctx->offset));
+			memcpy(ctx->buf + ctx->offset, in, n);
+			ctx->offset += n;
+			in += n;
+			len -= n;
+			if (ctx->offset == BLKSIZE) {
+				blk_SHA256_Transform(ctx, ctx->buf);
+				ctx->offset = 0;
+			}
+		}
+	}
+}
+
+void blk_SHA256_Final(unsigned char *digest, blk_SHA256_CTX *ctx)
+{
+	const unsigned trip = BLKSIZE - sizeof(ctx->length);
+	int i;
+
+	ctx->length <<= 3;
+	ctx->buf[ctx->offset++] = 0x80;
+
+	if (ctx->offset > trip) {
+		memset(ctx->buf + ctx->offset, 0, BLKSIZE - ctx->offset);
+		blk_SHA256_Transform(ctx, ctx->buf);
+		ctx->offset = 0;
+	}
+
+	memset(ctx->buf + ctx->offset, 0, BLKSIZE - ctx->offset - sizeof(ctx->length));
+
+	put_be64(ctx->buf + trip, ctx->length);
+	blk_SHA256_Transform(ctx, ctx->buf);
+
+	/* copy output */
+	for (i = 0; i < 8; i++, digest += sizeof(uint32_t))
+		put_be32(digest, ctx->state[i]);
+}
diff --git a/sha256/block/sha256.h b/sha256/block/sha256.h
new file mode 100644
index 0000000000..ad8b178ad3
--- /dev/null
+++ b/sha256/block/sha256.h
@@ -0,0 +1,26 @@
+#ifndef SHA256_BLOCK_SHA256_H
+#define SHA256_BLOCK_SHA256_H
+
+#include "git-compat-util.h"
+
+#define blk_SHA256_BLKSIZE 64
+
+struct blk_SHA256_CTX {
+	uint32_t state[8];
+	uint64_t length;
+	uint32_t offset;
+	uint8_t buf[blk_SHA256_BLKSIZE];
+};
+
+typedef struct blk_SHA256_CTX blk_SHA256_CTX;
+
+void blk_SHA256_Init(blk_SHA256_CTX *ctx);
+void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len);
+void blk_SHA256_Final(unsigned char *digest, blk_SHA256_CTX *ctx);
+
+#define platform_SHA256_CTX blk_SHA256_CTX
+#define platform_SHA256_Init blk_SHA256_Init
+#define platform_SHA256_Update blk_SHA256_Update
+#define platform_SHA256_Final blk_SHA256_Final
+
+#endif
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
new file mode 100644
index 0000000000..0ac6a99d5f
--- /dev/null
+++ b/t/helper/test-sha256.c
@@ -0,0 +1,7 @@
+#include "test-tool.h"
+#include "cache.h"
+
+int cmd__sha256(int ac, const char **av)
+{
+	return cmd_hash_impl(ac, av, GIT_HASH_SHA256);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index e009c8186d..2a65193514 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
 	{ "sha1", cmd__sha1 },
 	{ "sha1-array", cmd__sha1_array },
+	{ "sha256", cmd__sha256 },
 	{ "sigchain", cmd__sigchain },
 	{ "strcmp-offset", cmd__strcmp_offset },
 	{ "string-list", cmd__string_list },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 19a7e8332a..2e66a8e47b 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -39,6 +39,7 @@ int cmd__run_command(int argc, const char **argv);
 int cmd__scrap_cache_tree(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 int cmd__sha1_array(int argc, const char **argv);
+int cmd__sha256(int argc, const char **argv);
 int cmd__sigchain(int argc, const char **argv);
 int cmd__strcmp_offset(int argc, const char **argv);
 int cmd__string_list(int argc, const char **argv);
diff --git a/t/t0014-hash.sh b/t/t0014-hash.sh
index 8e763c2c3d..f8e639743f 100755
--- a/t/t0014-hash.sh
+++ b/t/t0014-hash.sh
@@ -26,4 +26,29 @@ test_expect_success 'test basic SHA-1 hash values' '
 	grep 4b825dc642cb6eb9a060e54bf8d69288fbee4904 actual
 '
 
+test_expect_success 'test basic SHA-256 hash values' '
+	test-tool sha256 </dev/null >actual &&
+	grep e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 actual &&
+	printf "a" | test-tool sha256 >actual &&
+	grep ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb actual &&
+	printf "abc" | test-tool sha256 >actual &&
+	grep ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad actual &&
+	printf "message digest" | test-tool sha256 >actual &&
+	grep f7846f55cf23e14eebeab5b4e1550cad5b509e3348fbc4efa3a1413d393cb650 actual &&
+	printf "abcdefghijklmnopqrstuvwxyz" | test-tool sha256 >actual &&
+	grep 71c480df93d6ae2f1efad1447c66c9525e316218cf51fc8d9ed832f2daf18b73 actual &&
+	perl -E "for (1..100000) { print q{aaaaaaaaaa}; }" | \
+		test-tool sha256 >actual &&
+	grep cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0 actual &&
+	perl -E "for (1..100000) { print q{abcdefghijklmnopqrstuvwxyz}; }" | \
+		test-tool sha256 >actual &&
+	grep e406ba321ca712ad35a698bf0af8d61fc4dc40eca6bdcea4697962724ccbde35 actual &&
+	printf "blob 0\0" | test-tool sha256 >actual &&
+	grep 473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721813 actual &&
+	printf "blob 3\0abc" | test-tool sha256 >actual &&
+	grep c1cf6e465077930e88dc5136641d402f72a229ddd996f627d60e9639eaba35a6 actual &&
+	printf "tree 0\0" | test-tool sha256 >actual &&
+	grep 6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321 actual
+'
+
 test_done
