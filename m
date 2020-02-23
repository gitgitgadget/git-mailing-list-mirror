Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2297AC35670
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 23:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B3220880
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 23:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgBWXRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:17:45 -0500
Received: from vuizook.err.no ([178.255.151.162]:51138 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgBWXRp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 18:17:45 -0500
X-Greylist: delayed 2333 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 18:17:43 EST
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1j5ztc-0003Bg-Ey; Sun, 23 Feb 2020 22:38:47 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <glandium@goemon>)
        id 1j5ztV-000VTS-1X; Mon, 24 Feb 2020 07:38:37 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Remove non-SHA1dc sha1 implementations
Date:   Mon, 24 Feb 2020 07:37:58 +0900
Message-Id: <20200223223758.120941-1-mh@glandium.org>
X-Mailer: git-send-email 2.24.0.424.g559c6fc317.dirty
In-Reply-To: <xmqqk14rtonu.fsf@gitster-ct.c.googlers.com>
References: <xmqqk14rtonu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is 2020, and with the weakening of SHA1 security-wise, there doesn't
seem to be a reason to support anything else than SHA1dc, with collision
detection.

Signed-off-by: Mike Hommey <mh@glandium.org>
---

Note: I only tested building on Linux.

 INSTALL           |   5 -
 Makefile          |  67 ++-----------
 block-sha1/sha1.c | 251 ----------------------------------------------
 block-sha1/sha1.h |  22 ----
 config.mak.uname  |   1 -
 configure.ac      |   3 -
 hash.h            |  24 -----
 ppc/sha1.c        |  72 -------------
 ppc/sha1.h        |  25 -----
 ppc/sha1ppc.S     | 224 -----------------------------------------
 10 files changed, 6 insertions(+), 688 deletions(-)
 delete mode 100644 block-sha1/sha1.c
 delete mode 100644 block-sha1/sha1.h
 delete mode 100644 ppc/sha1.c
 delete mode 100644 ppc/sha1.h
 delete mode 100644 ppc/sha1ppc.S

diff --git a/INSTALL b/INSTALL
index 22c364f34f..91d649f99e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -133,11 +133,6 @@ Issues of note:
 	  you are using libcurl older than 7.34.0.  Otherwise you can use
 	  NO_OPENSSL without losing git-imap-send.
 
-	  By default, git uses OpenSSL for SHA1 but it will use its own
-	  library (inspired by Mozilla's) with either NO_OPENSSL or
-	  BLK_SHA1.  Also included is a version optimized for PowerPC
-	  (PPC_SHA1).
-
 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
 	  the curl version >= 7.34.0, for git-imap-send.  You might also
 	  want the "curl" executable for debugging purposes. If you do not
diff --git a/Makefile b/Makefile
index b7d7374dac..5b4307d332 100644
--- a/Makefile
+++ b/Makefile
@@ -149,37 +149,15 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
-# Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
-# and do not want to use Apple's CommonCrypto library.  This allows you
-# to provide your own OpenSSL library, for example from MacPorts.
-#
-# Define BLK_SHA1 environment variable to make use of the bundled
-# optimized C SHA1 routine.
-#
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
-#
-# Define DC_SHA1 to unconditionally enable the collision-detecting sha1
-# algorithm. This is slower, but may detect attempted collision attacks.
-# Takes priority over other *_SHA1 knobs.
-#
-# Define DC_SHA1_EXTERNAL in addition to DC_SHA1 if you want to build / link
-# git with the external SHA1 collision-detect library.
+# Define DC_SHA1_EXTERNAL if you want to build / link git with the
+# external SHA1 collision-detect library.
 # Without this option, i.e. the default behavior is to build git with its
 # own built-in code (or submodule).
 #
-# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
-# sha1collisiondetection shipped as a submodule instead of the
-# non-submodule copy in sha1dc/. This is an experimental option used
-# by the git project to migrate to using sha1collisiondetection as a
-# submodule.
-#
-# Define OPENSSL_SHA1 environment variable when running make to link
-# with the SHA1 routine from openssl library.
-#
-# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
-# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
-# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
+# Define DC_SHA1_SUBMODULE to use the sha1collisiondetection shipped
+# as a submodule instead of the non-submodule copy in sha1dc/. This is
+# an experimental option used by the git project to migrate to using
+# sha1collisiondetection as a submodule.
 #
 # Define BLK_SHA256 to use the built-in SHA-256 routines.
 #
@@ -1296,11 +1274,6 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
-	ifndef NO_APPLE_COMMON_CRYPTO
-		NO_OPENSSL = YesPlease
-		APPLE_COMMON_CRYPTO = YesPlease
-		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
-	endif
 	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
@@ -1430,9 +1403,6 @@ ifdef NEEDS_SSL_WITH_CRYPTO
 else
 	LIB_4_CRYPTO = $(OPENSSL_LINK) -lcrypto
 endif
-ifdef APPLE_COMMON_CRYPTO
-	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
-endif
 endif
 ifndef NO_ICONV
 	ifdef NEEDS_LIBICONV
@@ -1647,27 +1617,6 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
-ifdef APPLE_COMMON_CRYPTO
-	# Apple CommonCrypto requires chunking
-	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
-endif
-
-ifdef OPENSSL_SHA1
-	EXTLIBS += $(LIB_4_CRYPTO)
-	BASIC_CFLAGS += -DSHA1_OPENSSL
-else
-ifdef BLK_SHA1
-	LIB_OBJS += block-sha1/sha1.o
-	BASIC_CFLAGS += -DSHA1_BLK
-else
-ifdef PPC_SHA1
-	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
-	BASIC_CFLAGS += -DSHA1_PPC
-else
-ifdef APPLE_COMMON_CRYPTO
-	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
-	BASIC_CFLAGS += -DSHA1_APPLE
-else
 	DC_SHA1 := YesPlease
 	BASIC_CFLAGS += -DSHA1_DC
 	LIB_OBJS += sha1dc_git.o
@@ -1694,10 +1643,6 @@ endif
 		-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" \
 		-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
 endif
-endif
-endif
-endif
-endif
 
 ifdef OPENSSL_SHA256
 	EXTLIBS += $(LIB_4_CRYPTO)
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
deleted file mode 100644
index 22b125cf8c..0000000000
--- a/block-sha1/sha1.c
+++ /dev/null
@@ -1,251 +0,0 @@
-/*
- * SHA1 routine optimized to do word accesses rather than byte accesses,
- * and to avoid unnecessary copies into the context array.
- *
- * This was initially based on the Mozilla SHA1 implementation, although
- * none of the original Mozilla code remains.
- */
-
-/* this is only to get definitions for memcpy(), ntohl() and htonl() */
-#include "../git-compat-util.h"
-
-#include "sha1.h"
-
-#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
-
-/*
- * Force usage of rol or ror by selecting the one with the smaller constant.
- * It _can_ generate slightly smaller code (a constant of 1 is special), but
- * perhaps more importantly it's possibly faster on any uarch that does a
- * rotate with a loop.
- */
-
-#define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
-#define SHA_ROL(x,n)	SHA_ASM("rol", x, n)
-#define SHA_ROR(x,n)	SHA_ASM("ror", x, n)
-
-#else
-
-#define SHA_ROT(X,l,r)	(((X) << (l)) | ((X) >> (r)))
-#define SHA_ROL(X,n)	SHA_ROT(X,n,32-(n))
-#define SHA_ROR(X,n)	SHA_ROT(X,32-(n),n)
-
-#endif
-
-/*
- * If you have 32 registers or more, the compiler can (and should)
- * try to change the array[] accesses into registers. However, on
- * machines with less than ~25 registers, that won't really work,
- * and at least gcc will make an unholy mess of it.
- *
- * So to avoid that mess which just slows things down, we force
- * the stores to memory to actually happen (we might be better off
- * with a 'W(t)=(val);asm("":"+m" (W(t))' there instead, as
- * suggested by Artur Skawina - that will also make gcc unable to
- * try to do the silly "optimize away loads" part because it won't
- * see what the value will be).
- *
- * Ben Herrenschmidt reports that on PPC, the C version comes close
- * to the optimized asm with this (ie on PPC you don't want that
- * 'volatile', since there are lots of registers).
- *
- * On ARM we get the best code generation by forcing a full memory barrier
- * between each SHA_ROUND, otherwise gcc happily get wild with spilling and
- * the stack frame size simply explode and performance goes down the drain.
- */
-
-#if defined(__i386__) || defined(__x86_64__)
-  #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
-#elif defined(__GNUC__) && defined(__arm__)
-  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
-#else
-  #define setW(x, val) (W(x) = (val))
-#endif
-
-/* This "rolls" over the 512-bit array */
-#define W(x) (array[(x)&15])
-
-/*
- * Where do we get the source from? The first 16 iterations get it from
- * the input data, the next mix it from the 512-bit array.
- */
-#define SHA_SRC(t) get_be32((unsigned char *) block + (t)*4)
-#define SHA_MIX(t) SHA_ROL(W((t)+13) ^ W((t)+8) ^ W((t)+2) ^ W(t), 1);
-
-#define SHA_ROUND(t, input, fn, constant, A, B, C, D, E) do { \
-	unsigned int TEMP = input(t); setW(t, TEMP); \
-	E += TEMP + SHA_ROL(A,5) + (fn) + (constant); \
-	B = SHA_ROR(B, 2); } while (0)
-
-#define T_0_15(t, A, B, C, D, E)  SHA_ROUND(t, SHA_SRC, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
-#define T_16_19(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (((C^D)&B)^D) , 0x5a827999, A, B, C, D, E )
-#define T_20_39(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) , 0x6ed9eba1, A, B, C, D, E )
-#define T_40_59(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, ((B&C)+(D&(B^C))) , 0x8f1bbcdc, A, B, C, D, E )
-#define T_60_79(t, A, B, C, D, E) SHA_ROUND(t, SHA_MIX, (B^C^D) ,  0xca62c1d6, A, B, C, D, E )
-
-static void blk_SHA1_Block(blk_SHA_CTX *ctx, const void *block)
-{
-	unsigned int A,B,C,D,E;
-	unsigned int array[16];
-
-	A = ctx->H[0];
-	B = ctx->H[1];
-	C = ctx->H[2];
-	D = ctx->H[3];
-	E = ctx->H[4];
-
-	/* Round 1 - iterations 0-16 take their input from 'block' */
-	T_0_15( 0, A, B, C, D, E);
-	T_0_15( 1, E, A, B, C, D);
-	T_0_15( 2, D, E, A, B, C);
-	T_0_15( 3, C, D, E, A, B);
-	T_0_15( 4, B, C, D, E, A);
-	T_0_15( 5, A, B, C, D, E);
-	T_0_15( 6, E, A, B, C, D);
-	T_0_15( 7, D, E, A, B, C);
-	T_0_15( 8, C, D, E, A, B);
-	T_0_15( 9, B, C, D, E, A);
-	T_0_15(10, A, B, C, D, E);
-	T_0_15(11, E, A, B, C, D);
-	T_0_15(12, D, E, A, B, C);
-	T_0_15(13, C, D, E, A, B);
-	T_0_15(14, B, C, D, E, A);
-	T_0_15(15, A, B, C, D, E);
-
-	/* Round 1 - tail. Input from 512-bit mixing array */
-	T_16_19(16, E, A, B, C, D);
-	T_16_19(17, D, E, A, B, C);
-	T_16_19(18, C, D, E, A, B);
-	T_16_19(19, B, C, D, E, A);
-
-	/* Round 2 */
-	T_20_39(20, A, B, C, D, E);
-	T_20_39(21, E, A, B, C, D);
-	T_20_39(22, D, E, A, B, C);
-	T_20_39(23, C, D, E, A, B);
-	T_20_39(24, B, C, D, E, A);
-	T_20_39(25, A, B, C, D, E);
-	T_20_39(26, E, A, B, C, D);
-	T_20_39(27, D, E, A, B, C);
-	T_20_39(28, C, D, E, A, B);
-	T_20_39(29, B, C, D, E, A);
-	T_20_39(30, A, B, C, D, E);
-	T_20_39(31, E, A, B, C, D);
-	T_20_39(32, D, E, A, B, C);
-	T_20_39(33, C, D, E, A, B);
-	T_20_39(34, B, C, D, E, A);
-	T_20_39(35, A, B, C, D, E);
-	T_20_39(36, E, A, B, C, D);
-	T_20_39(37, D, E, A, B, C);
-	T_20_39(38, C, D, E, A, B);
-	T_20_39(39, B, C, D, E, A);
-
-	/* Round 3 */
-	T_40_59(40, A, B, C, D, E);
-	T_40_59(41, E, A, B, C, D);
-	T_40_59(42, D, E, A, B, C);
-	T_40_59(43, C, D, E, A, B);
-	T_40_59(44, B, C, D, E, A);
-	T_40_59(45, A, B, C, D, E);
-	T_40_59(46, E, A, B, C, D);
-	T_40_59(47, D, E, A, B, C);
-	T_40_59(48, C, D, E, A, B);
-	T_40_59(49, B, C, D, E, A);
-	T_40_59(50, A, B, C, D, E);
-	T_40_59(51, E, A, B, C, D);
-	T_40_59(52, D, E, A, B, C);
-	T_40_59(53, C, D, E, A, B);
-	T_40_59(54, B, C, D, E, A);
-	T_40_59(55, A, B, C, D, E);
-	T_40_59(56, E, A, B, C, D);
-	T_40_59(57, D, E, A, B, C);
-	T_40_59(58, C, D, E, A, B);
-	T_40_59(59, B, C, D, E, A);
-
-	/* Round 4 */
-	T_60_79(60, A, B, C, D, E);
-	T_60_79(61, E, A, B, C, D);
-	T_60_79(62, D, E, A, B, C);
-	T_60_79(63, C, D, E, A, B);
-	T_60_79(64, B, C, D, E, A);
-	T_60_79(65, A, B, C, D, E);
-	T_60_79(66, E, A, B, C, D);
-	T_60_79(67, D, E, A, B, C);
-	T_60_79(68, C, D, E, A, B);
-	T_60_79(69, B, C, D, E, A);
-	T_60_79(70, A, B, C, D, E);
-	T_60_79(71, E, A, B, C, D);
-	T_60_79(72, D, E, A, B, C);
-	T_60_79(73, C, D, E, A, B);
-	T_60_79(74, B, C, D, E, A);
-	T_60_79(75, A, B, C, D, E);
-	T_60_79(76, E, A, B, C, D);
-	T_60_79(77, D, E, A, B, C);
-	T_60_79(78, C, D, E, A, B);
-	T_60_79(79, B, C, D, E, A);
-
-	ctx->H[0] += A;
-	ctx->H[1] += B;
-	ctx->H[2] += C;
-	ctx->H[3] += D;
-	ctx->H[4] += E;
-}
-
-void blk_SHA1_Init(blk_SHA_CTX *ctx)
-{
-	ctx->size = 0;
-
-	/* Initialize H with the magic constants (see FIPS180 for constants) */
-	ctx->H[0] = 0x67452301;
-	ctx->H[1] = 0xefcdab89;
-	ctx->H[2] = 0x98badcfe;
-	ctx->H[3] = 0x10325476;
-	ctx->H[4] = 0xc3d2e1f0;
-}
-
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
-{
-	unsigned int lenW = ctx->size & 63;
-
-	ctx->size += len;
-
-	/* Read the data into W and process blocks as they get full */
-	if (lenW) {
-		unsigned int left = 64 - lenW;
-		if (len < left)
-			left = len;
-		memcpy(lenW + (char *)ctx->W, data, left);
-		lenW = (lenW + left) & 63;
-		len -= left;
-		data = ((const char *)data + left);
-		if (lenW)
-			return;
-		blk_SHA1_Block(ctx, ctx->W);
-	}
-	while (len >= 64) {
-		blk_SHA1_Block(ctx, data);
-		data = ((const char *)data + 64);
-		len -= 64;
-	}
-	if (len)
-		memcpy(ctx->W, data, len);
-}
-
-void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
-{
-	static const unsigned char pad[64] = { 0x80 };
-	unsigned int padlen[2];
-	int i;
-
-	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
-	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
-	padlen[1] = htonl((uint32_t)(ctx->size << 3));
-
-	i = ctx->size & 63;
-	blk_SHA1_Update(ctx, pad, 1 + (63 & (55 - i)));
-	blk_SHA1_Update(ctx, padlen, 8);
-
-	/* Output hash */
-	for (i = 0; i < 5; i++)
-		put_be32(hashout + i * 4, ctx->H[i]);
-}
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
deleted file mode 100644
index 4df6747752..0000000000
--- a/block-sha1/sha1.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * SHA1 routine optimized to do word accesses rather than byte accesses,
- * and to avoid unnecessary copies into the context array.
- *
- * This was initially based on the Mozilla SHA1 implementation, although
- * none of the original Mozilla code remains.
- */
-
-typedef struct {
-	unsigned long long size;
-	unsigned int H[5];
-	unsigned int W[16];
-} blk_SHA_CTX;
-
-void blk_SHA1_Init(blk_SHA_CTX *ctx);
-void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
-void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
-
-#define platform_SHA_CTX	blk_SHA_CTX
-#define platform_SHA1_Init	blk_SHA1_Init
-#define platform_SHA1_Update	blk_SHA1_Update
-#define platform_SHA1_Final	blk_SHA1_Final
diff --git a/config.mak.uname b/config.mak.uname
index cc8efd95b1..785b9265c3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -116,7 +116,6 @@ ifeq ($(uname_S),Darwin)
 	# i.e. "begins with [15678] and a dot" means "10.4.* or older".
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV = UnfortunatelyYes
-		NO_APPLE_COMMON_CRYPTO = YesPlease
 	endif
 	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY = YesPlease
diff --git a/configure.ac b/configure.ac
index 66aedb9288..dd39b7ecdb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -237,9 +237,6 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
 #
-# Define PPC_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for PowerPC.
-#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 #
 # Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
diff --git a/hash.h b/hash.h
index 52a4f1a3f4..e1a3d00b13 100644
--- a/hash.h
+++ b/hash.h
@@ -3,17 +3,7 @@
 
 #include "git-compat-util.h"
 
-#if defined(SHA1_PPC)
-#include "ppc/sha1.h"
-#elif defined(SHA1_APPLE)
-#include <CommonCrypto/CommonDigest.h>
-#elif defined(SHA1_OPENSSL)
-#include <openssl/sha.h>
-#elif defined(SHA1_DC)
 #include "sha1dc_git.h"
-#else /* SHA1_BLK */
-#include "block-sha1/sha1.h"
-#endif
 
 #if defined(SHA256_GCRYPT)
 #include "sha256/gcrypt.h"
@@ -23,20 +13,6 @@
 #include "sha256/block/sha256.h"
 #endif
 
-#ifndef platform_SHA_CTX
-/*
- * platform's underlying implementation of SHA-1; could be OpenSSL,
- * blk_SHA, Apple CommonCrypto, etc...  Note that the relevant
- * SHA-1 header may have already defined platform_SHA_CTX for our
- * own implementations like block-sha1 and ppc-sha1, so we list
- * the default for OpenSSL compatible SHA-1 implementations here.
- */
-#define platform_SHA_CTX	SHA_CTX
-#define platform_SHA1_Init	SHA1_Init
-#define platform_SHA1_Update	SHA1_Update
-#define platform_SHA1_Final    	SHA1_Final
-#endif
-
 #define git_SHA_CTX		platform_SHA_CTX
 #define git_SHA1_Init		platform_SHA1_Init
 #define git_SHA1_Update		platform_SHA1_Update
diff --git a/ppc/sha1.c b/ppc/sha1.c
deleted file mode 100644
index 1b705cee1f..0000000000
--- a/ppc/sha1.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * SHA-1 implementation.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- *
- * This version assumes we are running on a big-endian machine.
- * It calls an external sha1_core() to process blocks of 64 bytes.
- */
-#include <stdio.h>
-#include <string.h>
-#include "sha1.h"
-
-void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
-		   unsigned int nblocks);
-
-int ppc_SHA1_Init(ppc_SHA_CTX *c)
-{
-	c->hash[0] = 0x67452301;
-	c->hash[1] = 0xEFCDAB89;
-	c->hash[2] = 0x98BADCFE;
-	c->hash[3] = 0x10325476;
-	c->hash[4] = 0xC3D2E1F0;
-	c->len = 0;
-	c->cnt = 0;
-	return 0;
-}
-
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *ptr, unsigned long n)
-{
-	unsigned long nb;
-	const unsigned char *p = ptr;
-
-	c->len += (uint64_t) n << 3;
-	while (n != 0) {
-		if (c->cnt || n < 64) {
-			nb = 64 - c->cnt;
-			if (nb > n)
-				nb = n;
-			memcpy(&c->buf.b[c->cnt], p, nb);
-			if ((c->cnt += nb) == 64) {
-				ppc_sha1_core(c->hash, c->buf.b, 1);
-				c->cnt = 0;
-			}
-		} else {
-			nb = n >> 6;
-			ppc_sha1_core(c->hash, p, nb);
-			nb <<= 6;
-		}
-		n -= nb;
-		p += nb;
-	}
-	return 0;
-}
-
-int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c)
-{
-	unsigned int cnt = c->cnt;
-
-	c->buf.b[cnt++] = 0x80;
-	if (cnt > 56) {
-		if (cnt < 64)
-			memset(&c->buf.b[cnt], 0, 64 - cnt);
-		ppc_sha1_core(c->hash, c->buf.b, 1);
-		cnt = 0;
-	}
-	if (cnt < 56)
-		memset(&c->buf.b[cnt], 0, 56 - cnt);
-	c->buf.l[7] = c->len;
-	ppc_sha1_core(c->hash, c->buf.b, 1);
-	memcpy(hash, c->hash, 20);
-	return 0;
-}
diff --git a/ppc/sha1.h b/ppc/sha1.h
deleted file mode 100644
index 9b24b32615..0000000000
--- a/ppc/sha1.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * SHA-1 implementation.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- */
-#include <stdint.h>
-
-typedef struct {
-	uint32_t hash[5];
-	uint32_t cnt;
-	uint64_t len;
-	union {
-		unsigned char b[64];
-		uint64_t l[8];
-	} buf;
-} ppc_SHA_CTX;
-
-int ppc_SHA1_Init(ppc_SHA_CTX *c);
-int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, unsigned long n);
-int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c);
-
-#define platform_SHA_CTX	ppc_SHA_CTX
-#define platform_SHA1_Init	ppc_SHA1_Init
-#define platform_SHA1_Update	ppc_SHA1_Update
-#define platform_SHA1_Final	ppc_SHA1_Final
diff --git a/ppc/sha1ppc.S b/ppc/sha1ppc.S
deleted file mode 100644
index 1711eef6e7..0000000000
--- a/ppc/sha1ppc.S
+++ /dev/null
@@ -1,224 +0,0 @@
-/*
- * SHA-1 implementation for PowerPC.
- *
- * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
- */
-
-/*
- * PowerPC calling convention:
- * %r0 - volatile temp
- * %r1 - stack pointer.
- * %r2 - reserved
- * %r3-%r12 - Incoming arguments & return values; volatile.
- * %r13-%r31 - Callee-save registers
- * %lr - Return address, volatile
- * %ctr - volatile
- *
- * Register usage in this routine:
- * %r0 - temp
- * %r3 - argument (pointer to 5 words of SHA state)
- * %r4 - argument (pointer to data to hash)
- * %r5 - Constant K in SHA round (initially number of blocks to hash)
- * %r6-%r10 - Working copies of SHA variables A..E (actually E..A order)
- * %r11-%r26 - Data being hashed W[].
- * %r27-%r31 - Previous copies of A..E, for final add back.
- * %ctr - loop count
- */
-
-
-/*
- * We roll the registers for A, B, C, D, E around on each
- * iteration; E on iteration t is D on iteration t+1, and so on.
- * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
- * the previous values.)
- */
-#define RA(t)	(((t)+4)%5+6)
-#define RB(t)	(((t)+3)%5+6)
-#define RC(t)	(((t)+2)%5+6)
-#define RD(t)	(((t)+1)%5+6)
-#define RE(t)	(((t)+0)%5+6)
-
-/* We use registers 11 - 26 for the W values */
-#define W(t)	((t)%16+11)
-
-/* Register 5 is used for the constant k */
-
-/*
- * The basic SHA-1 round function is:
- * E += ROTL(A,5) + F(B,C,D) + W[i] + K;  B = ROTL(B,30)
- * Then the variables are renamed: (A,B,C,D,E) = (E,A,B,C,D).
- *
- * Every 20 rounds, the function F() and the constant K changes:
- * - 20 rounds of f0(b,c,d) = "bit wise b ? c : d" =  (^b & d) + (b & c)
- * - 20 rounds of f1(b,c,d) = b^c^d = (b^d)^c
- * - 20 rounds of f2(b,c,d) = majority(b,c,d) = (b&d) + ((b^d)&c)
- * - 20 more rounds of f1(b,c,d)
- *
- * These are all scheduled for near-optimal performance on a G4.
- * The G4 is a 3-issue out-of-order machine with 3 ALUs, but it can only
- * *consider* starting the oldest 3 instructions per cycle.  So to get
- * maximum performance out of it, you have to treat it as an in-order
- * machine.  Which means interleaving the computation round t with the
- * computation of W[t+4].
- *
- * The first 16 rounds use W values loaded directly from memory, while the
- * remaining 64 use values computed from those first 16.  We preload
- * 4 values before starting, so there are three kinds of rounds:
- * - The first 12 (all f0) also load the W values from memory.
- * - The next 64 compute W(i+4) in parallel. 8*f0, 20*f1, 20*f2, 16*f1.
- * - The last 4 (all f1) do not do anything with W.
- *
- * Therefore, we have 6 different round functions:
- * STEPD0_LOAD(t,s) - Perform round t and load W(s).  s < 16
- * STEPD0_UPDATE(t,s) - Perform round t and compute W(s).  s >= 16.
- * STEPD1_UPDATE(t,s)
- * STEPD2_UPDATE(t,s)
- * STEPD1(t) - Perform round t with no load or update.
- *
- * The G5 is more fully out-of-order, and can find the parallelism
- * by itself.  The big limit is that it has a 2-cycle ALU latency, so
- * even though it's 2-way, the code has to be scheduled as if it's
- * 4-way, which can be a limit.  To help it, we try to schedule the
- * read of RA(t) as late as possible so it doesn't stall waiting for
- * the previous round's RE(t-1), and we try to rotate RB(t) as early
- * as possible while reading RC(t) (= RB(t-1)) as late as possible.
- */
-
-/* the initial loads. */
-#define LOADW(s) \
-	lwz	W(s),(s)*4(%r4)
-
-/*
- * Perform a step with F0, and load W(s).  Uses W(s) as a temporary
- * before loading it.
- * This is actually 10 instructions, which is an awkward fit.
- * It can execute grouped as listed, or delayed one instruction.
- * (If delayed two instructions, there is a stall before the start of the
- * second line.)  Thus, two iterations take 7 cycles, 3.5 cycles per round.
- */
-#define STEPD0_LOAD(t,s) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t);  and    W(s),RC(t),RB(t); \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;      rotlwi RB(t),RB(t),30;   \
-add RE(t),RE(t),W(s); add    %r0,%r0,%r5;      lwz    W(s),(s)*4(%r4);  \
-add RE(t),RE(t),%r0
-
-/*
- * This is likewise awkward, 13 instructions.  However, it can also
- * execute starting with 2 out of 3 possible moduli, so it does 2 rounds
- * in 9 cycles, 4.5 cycles/round.
- */
-#define STEPD0_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  and    %r0,RC(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r5;  loadk; rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;     \
-add RE(t),RE(t),%r0
-
-/* Nicely optimal.  Conveniently, also the most common. */
-#define STEPD1_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r5;  loadk; xor %r0,%r0,RC(t);  xor W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1
-
-/*
- * The naked version, no UPDATE, for the last 4 rounds.  3 cycles per.
- * We could use W(s) as a temp register, but we don't need it.
- */
-#define STEPD1(t) \
-                        add   RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); \
-rotlwi RB(t),RB(t),30;  add   RE(t),RE(t),%r5;  xor    %r0,%r0,RC(t);   \
-add    RE(t),RE(t),%r0; rotlwi %r0,RA(t),5;     /* spare slot */        \
-add    RE(t),RE(t),%r0
-
-/*
- * 14 instructions, 5 cycles per.  The majority function is a bit
- * awkward to compute.  This can execute with a 1-instruction delay,
- * but it causes a 2-instruction delay, which triggers a stall.
- */
-#define STEPD2_UPDATE(t,s,loadk...) \
-add RE(t),RE(t),W(t); and    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
-add RE(t),RE(t),%r0;  xor    %r0,RD(t),RB(t); xor    W(s),W(s),W((s)-8);      \
-add RE(t),RE(t),%r5;  loadk; and %r0,%r0,RC(t);  xor W(s),W(s),W((s)-14);     \
-add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     rotlwi W(s),W(s),1;             \
-add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30
-
-#define STEP0_LOAD4(t,s)		\
-	STEPD0_LOAD(t,s);		\
-	STEPD0_LOAD((t+1),(s)+1);	\
-	STEPD0_LOAD((t)+2,(s)+2);	\
-	STEPD0_LOAD((t)+3,(s)+3)
-
-#define STEPUP4(fn, t, s, loadk...)		\
-	STEP##fn##_UPDATE(t,s,);		\
-	STEP##fn##_UPDATE((t)+1,(s)+1,);	\
-	STEP##fn##_UPDATE((t)+2,(s)+2,);	\
-	STEP##fn##_UPDATE((t)+3,(s)+3,loadk)
-
-#define STEPUP20(fn, t, s, loadk...)	\
-	STEPUP4(fn, t, s,);		\
-	STEPUP4(fn, (t)+4, (s)+4,);	\
-	STEPUP4(fn, (t)+8, (s)+8,);	\
-	STEPUP4(fn, (t)+12, (s)+12,);	\
-	STEPUP4(fn, (t)+16, (s)+16, loadk)
-
-	.globl	ppc_sha1_core
-ppc_sha1_core:
-	stwu	%r1,-80(%r1)
-	stmw	%r13,4(%r1)
-
-	/* Load up A - E */
-	lmw	%r27,0(%r3)
-
-	mtctr	%r5
-
-1:
-	LOADW(0)
-	lis	%r5,0x5a82
-	mr	RE(0),%r31
-	LOADW(1)
-	mr	RD(0),%r30
-	mr	RC(0),%r29
-	LOADW(2)
-	ori	%r5,%r5,0x7999	/* K0-19 */
-	mr	RB(0),%r28
-	LOADW(3)
-	mr	RA(0),%r27
-
-	STEP0_LOAD4(0, 4)
-	STEP0_LOAD4(4, 8)
-	STEP0_LOAD4(8, 12)
-	STEPUP4(D0, 12, 16,)
-	STEPUP4(D0, 16, 20, lis %r5,0x6ed9)
-
-	ori	%r5,%r5,0xeba1	/* K20-39 */
-	STEPUP20(D1, 20, 24, lis %r5,0x8f1b)
-
-	ori	%r5,%r5,0xbcdc	/* K40-59 */
-	STEPUP20(D2, 40, 44, lis %r5,0xca62)
-
-	ori	%r5,%r5,0xc1d6	/* K60-79 */
-	STEPUP4(D1, 60, 64,)
-	STEPUP4(D1, 64, 68,)
-	STEPUP4(D1, 68, 72,)
-	STEPUP4(D1, 72, 76,)
-	addi	%r4,%r4,64
-	STEPD1(76)
-	STEPD1(77)
-	STEPD1(78)
-	STEPD1(79)
-
-	/* Add results to original values */
-	add	%r31,%r31,RE(0)
-	add	%r30,%r30,RD(0)
-	add	%r29,%r29,RC(0)
-	add	%r28,%r28,RB(0)
-	add	%r27,%r27,RA(0)
-
-	bdnz	1b
-
-	/* Save final hash, restore registers, and return */
-	stmw	%r27,0(%r3)
-	lmw	%r13,4(%r1)
-	addi	%r1,%r1,80
-	blr
-- 
2.24.0.424.g559c6fc317.dirty

