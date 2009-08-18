From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH v2] remove ARM and Mozilla SHA1 implementations
Date: Mon, 17 Aug 2009 20:09:56 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908172007590.6044@xanadu.home>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:10:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCHI-0007Km-AF
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758218AbZHRAKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 20:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755510AbZHRAKF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:10:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12040 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbZHRAKC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:10:02 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOJ00EKZP9XRA30@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Aug 2009 19:58:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126324>

They are both slower than the new BLK_SHA1 implementation, so it is
pointless to keep them around.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

One reference to mozilla/sha1.c was missing in the initial patch.

 Makefile            |   26 +------
 arm/sha1.c          |   82 --------------------
 arm/sha1.h          |   23 ------
 arm/sha1_arm.S      |  183 ---------------------------------------------
 block-sha1/sha1.c   |    6 +-
 block-sha1/sha1.h   |    6 +-
 configure.ac        |   10 +--
 mozilla-sha1/sha1.c |  151 -------------------------------------
 mozilla-sha1/sha1.h |   50 ------------
 9 files changed, 11 insertions(+), 526 deletions(-)

diff --git a/Makefile b/Makefile
index f94fe05..4190a5d 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,7 @@ all::
 # when attempting to read from an fopen'ed directory.
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies MOZILLA_SHA1.
+# This also implies BLK_SHA1.
 #
 # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
@@ -91,14 +91,6 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
-# Define ARM_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for ARM.
-#
-# Define MOZILLA_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
-# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
-# choice) has very fast version optimized for i586.
-#
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
@@ -930,10 +922,6 @@ else
 	NO_PTHREADS = YesPlease
 endif
 endif
-ifneq (,$(findstring arm,$(uname_M)))
-	ARM_SHA1 = YesPlease
-	NO_MKSTEMPS = YesPlease
-endif
 
 -include config.mak.autogen
 -include config.mak
@@ -1025,7 +1013,7 @@ ifndef NO_OPENSSL
 	endif
 else
 	BASIC_CFLAGS += -DNO_OPENSSL
-	MOZILLA_SHA1 = 1
+	BLK_SHA1 = 1
 	OPENSSL_LIBSSL =
 endif
 ifdef NEEDS_SSL_WITH_CRYPTO
@@ -1182,20 +1170,10 @@ ifdef PPC_SHA1
 	SHA1_HEADER = "ppc/sha1.h"
 	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
 else
-ifdef ARM_SHA1
-	SHA1_HEADER = "arm/sha1.h"
-	LIB_OBJS += arm/sha1.o arm/sha1_arm.o
-else
-ifdef MOZILLA_SHA1
-	SHA1_HEADER = "mozilla-sha1/sha1.h"
-	LIB_OBJS += mozilla-sha1/sha1.o
-else
 	SHA1_HEADER = <openssl/sha.h>
 	EXTLIBS += $(LIB_4_CRYPTO)
 endif
 endif
-endif
-endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/arm/sha1.c b/arm/sha1.c
deleted file mode 100644
index c61ad4a..0000000
--- a/arm/sha1.c
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * SHA-1 implementation optimized for ARM
- *
- * Copyright:   (C) 2005 by Nicolas Pitre <nico@cam.org>
- * Created:     September 17, 2005
- */
-
-#include <string.h>
-#include "sha1.h"
-
-extern void arm_sha_transform(uint32_t *hash, const unsigned char *data, uint32_t *W);
-
-void arm_SHA1_Init(arm_SHA_CTX *c)
-{
-	c->len = 0;
-	c->hash[0] = 0x67452301;
-	c->hash[1] = 0xefcdab89;
-	c->hash[2] = 0x98badcfe;
-	c->hash[3] = 0x10325476;
-	c->hash[4] = 0xc3d2e1f0;
-}
-
-void arm_SHA1_Update(arm_SHA_CTX *c, const void *p, unsigned long n)
-{
-	uint32_t workspace[80];
-	unsigned int partial;
-	unsigned long done;
-
-	partial = c->len & 0x3f;
-	c->len += n;
-	if ((partial + n) >= 64) {
-		if (partial) {
-			done = 64 - partial;
-			memcpy(c->buffer + partial, p, done);
-			arm_sha_transform(c->hash, c->buffer, workspace);
-			partial = 0;
-		} else
-			done = 0;
-		while (n >= done + 64) {
-			arm_sha_transform(c->hash, p + done, workspace);
-			done += 64;
-		}
-	} else
-		done = 0;
-	if (n - done)
-		memcpy(c->buffer + partial, p + done, n - done);
-}
-
-void arm_SHA1_Final(unsigned char *hash, arm_SHA_CTX *c)
-{
-	uint64_t bitlen;
-	uint32_t bitlen_hi, bitlen_lo;
-	unsigned int i, offset, padlen;
-	unsigned char bits[8];
-	static const unsigned char padding[64] = { 0x80, };
-
-	bitlen = c->len << 3;
-	offset = c->len & 0x3f;
-	padlen = ((offset < 56) ? 56 : (64 + 56)) - offset;
-	arm_SHA1_Update(c, padding, padlen);
-
-	bitlen_hi = bitlen >> 32;
-	bitlen_lo = bitlen & 0xffffffff;
-	bits[0] = bitlen_hi >> 24;
-	bits[1] = bitlen_hi >> 16;
-	bits[2] = bitlen_hi >> 8;
-	bits[3] = bitlen_hi;
-	bits[4] = bitlen_lo >> 24;
-	bits[5] = bitlen_lo >> 16;
-	bits[6] = bitlen_lo >> 8;
-	bits[7] = bitlen_lo;
-	arm_SHA1_Update(c, bits, 8);
-
-	for (i = 0; i < 5; i++) {
-		uint32_t v = c->hash[i];
-		hash[0] = v >> 24;
-		hash[1] = v >> 16;
-		hash[2] = v >> 8;
-		hash[3] = v;
-		hash += 4;
-	}
-}
diff --git a/arm/sha1.h b/arm/sha1.h
deleted file mode 100644
index b61b618..0000000
--- a/arm/sha1.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * SHA-1 implementation optimized for ARM
- *
- * Copyright:	(C) 2005 by Nicolas Pitre <nico@cam.org>
- * Created:	September 17, 2005
- */
-
-#include <stdint.h>
-
-typedef struct {
-	uint64_t len;
-	uint32_t hash[5];
-	unsigned char buffer[64];
-} arm_SHA_CTX;
-
-void arm_SHA1_Init(arm_SHA_CTX *c);
-void arm_SHA1_Update(arm_SHA_CTX *c, const void *p, unsigned long n);
-void arm_SHA1_Final(unsigned char *hash, arm_SHA_CTX *c);
-
-#define git_SHA_CTX	arm_SHA_CTX
-#define git_SHA1_Init	arm_SHA1_Init
-#define git_SHA1_Update	arm_SHA1_Update
-#define git_SHA1_Final	arm_SHA1_Final
diff --git a/arm/sha1_arm.S b/arm/sha1_arm.S
deleted file mode 100644
index 41e9263..0000000
--- a/arm/sha1_arm.S
+++ /dev/null
@@ -1,183 +0,0 @@
-/*
- *  SHA transform optimized for ARM
- *
- *  Copyright:	(C) 2005 by Nicolas Pitre <nico@cam.org>
- *  Created:	September 17, 2005
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-	.text
-	.globl	arm_sha_transform
-
-/*
- * void sha_transform(uint32_t *hash, const unsigned char *data, uint32_t *W);
- *
- * note: the "data" pointer may be unaligned.
- */
-
-arm_sha_transform:
-
-	stmfd	sp!, {r4 - r8, lr}
-
-	@ for (i = 0; i < 16; i++)
-	@         W[i] = ntohl(((uint32_t *)data)[i]);
-
-#ifdef __ARMEB__
-	mov	r4, r0
-	mov	r0, r2
-	mov	r2, #64
-	bl	memcpy
-	mov	r2, r0
-	mov	r0, r4
-#else
-	mov	r3, r2
-	mov	lr, #16
-1:	ldrb	r4, [r1], #1
-	ldrb	r5, [r1], #1
-	ldrb	r6, [r1], #1
-	ldrb	r7, [r1], #1
-	subs	lr, lr, #1
-	orr	r5, r5, r4, lsl #8
-	orr	r6, r6, r5, lsl #8
-	orr	r7, r7, r6, lsl #8
-	str	r7, [r3], #4
-	bne	1b
-#endif
-
-	@ for (i = 0; i < 64; i++)
-	@         W[i+16] = ror(W[i+13] ^ W[i+8] ^ W[i+2] ^ W[i], 31);
-
-	sub	r3, r2, #4
-	mov	lr, #64
-2:	ldr	r4, [r3, #4]!
-	subs	lr, lr, #1
-	ldr	r5, [r3, #8]
-	ldr	r6, [r3, #32]
-	ldr	r7, [r3, #52]
-	eor	r4, r4, r5
-	eor	r4, r4, r6
-	eor	r4, r4, r7
-	mov	r4, r4, ror #31
-	str	r4, [r3, #64]
-	bne	2b
-
-	/*
-	 * The SHA functions are:
-	 *
-	 * f1(B,C,D) = (D ^ (B & (C ^ D)))
-	 * f2(B,C,D) = (B ^ C ^ D)
-	 * f3(B,C,D) = ((B & C) | (D & (B | C)))
-	 *
-	 * Then the sub-blocks are processed as follows:
-	 *
-	 * A' = ror(A, 27) + f(B,C,D) + E + K + *W++
-	 * B' = A
-	 * C' = ror(B, 2)
-	 * D' = C
-	 * E' = D
-	 *
-	 * We therefore unroll each loop 5 times to avoid register shuffling.
-	 * Also the ror for C (and also D and E which are successivelyderived
-	 * from it) is applied in place to cut on an additional mov insn for
-	 * each round.
-	 */
-
-	.macro	sha_f1, A, B, C, D, E
-	ldr	r3, [r2], #4
-	eor	ip, \C, \D
-	add	\E, r1, \E, ror #2
-	and	ip, \B, ip, ror #2
-	add	\E, \E, \A, ror #27
-	eor	ip, ip, \D, ror #2
-	add	\E, \E, r3
-	add	\E, \E, ip
-	.endm
-
-	.macro	sha_f2, A, B, C, D, E
-	ldr	r3, [r2], #4
-	add	\E, r1, \E, ror #2
-	eor	ip, \B, \C, ror #2
-	add	\E, \E, \A, ror #27
-	eor	ip, ip, \D, ror #2
-	add	\E, \E, r3
-	add	\E, \E, ip
-	.endm
-
-	.macro	sha_f3, A, B, C, D, E
-	ldr	r3, [r2], #4
-	add	\E, r1, \E, ror #2
-	orr	ip, \B, \C, ror #2
-	add	\E, \E, \A, ror #27
-	and	ip, ip, \D, ror #2
-	add	\E, \E, r3
-	and	r3, \B, \C, ror #2
-	orr	ip, ip, r3
-	add	\E, \E, ip
-	.endm
-
-	ldmia	r0, {r4 - r8}
-
-	mov	lr, #4
-	ldr	r1, .L_sha_K + 0
-
-	/* adjust initial values */
-	mov	r6, r6, ror #30
-	mov	r7, r7, ror #30
-	mov	r8, r8, ror #30
-
-3:	subs	lr, lr, #1
-	sha_f1	r4, r5, r6, r7, r8
-	sha_f1	r8, r4, r5, r6, r7
-	sha_f1	r7, r8, r4, r5, r6
-	sha_f1	r6, r7, r8, r4, r5
-	sha_f1	r5, r6, r7, r8, r4
-	bne	3b
-
-	ldr	r1, .L_sha_K + 4
-	mov	lr, #4
-
-4:	subs	lr, lr, #1
-	sha_f2	r4, r5, r6, r7, r8
-	sha_f2	r8, r4, r5, r6, r7
-	sha_f2	r7, r8, r4, r5, r6
-	sha_f2	r6, r7, r8, r4, r5
-	sha_f2	r5, r6, r7, r8, r4
-	bne	4b
-
-	ldr	r1, .L_sha_K + 8
-	mov	lr, #4
-
-5:	subs	lr, lr, #1
-	sha_f3	r4, r5, r6, r7, r8
-	sha_f3	r8, r4, r5, r6, r7
-	sha_f3	r7, r8, r4, r5, r6
-	sha_f3	r6, r7, r8, r4, r5
-	sha_f3	r5, r6, r7, r8, r4
-	bne	5b
-
-	ldr	r1, .L_sha_K + 12
-	mov	lr, #4
-
-6:	subs	lr, lr, #1
-	sha_f2	r4, r5, r6, r7, r8
-	sha_f2	r8, r4, r5, r6, r7
-	sha_f2	r7, r8, r4, r5, r6
-	sha_f2	r6, r7, r8, r4, r5
-	sha_f2	r5, r6, r7, r8, r4
-	bne	6b
-
-	ldmia	r0, {r1, r2, r3, ip, lr}
-	add	r4, r1, r4
-	add	r5, r2, r5
-	add	r6, r3, r6, ror #2
-	add	r7, ip, r7, ror #2
-	add	r8, lr, r8, ror #2
-	stmia	r0, {r4 - r8}
-
-	ldmfd	sp!, {r4 - r8, pc}
-
-.L_sha_K:
-	.word	0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 464cb25..a1228cf 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -1,7 +1,9 @@
 /*
- * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.c),
- * optimized to do word accesses rather than byte accesses,
+ * SHA1 routine optimized to do word accesses rather than byte accesses,
  * and to avoid unnecessary copies into the context array.
+ *
+ * This was initially based on the Mozilla SHA1 implementation, although
+ * none of the original Mozilla code remains.
  */
 
 #include <string.h>
diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index c1ae74d..6ff59b2 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -1,7 +1,9 @@
 /*
- * Based on the Mozilla SHA1 (see mozilla-sha1/sha1.h),
- * optimized to do word accesses rather than byte accesses,
+ * SHA1 routine optimized to do word accesses rather than byte accesses,
  * and to avoid unnecessary copies into the context array.
+ *
+ * This was initially based on the Mozilla SHA1 implementation, although
+ * none of the original Mozilla code remains.
  */
 
 typedef struct {
diff --git a/configure.ac b/configure.ac
index 3f1922d..b09b8e4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -156,19 +156,11 @@ AC_MSG_NOTICE([CHECKS for site configuration])
 # tests.  These tests take up a significant amount of the total test time
 # but are not needed unless you plan to talk to SVN repos.
 #
-# Define MOZILLA_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine coming from Mozilla. It is GPL'd and should be fast
-# on non-x86 architectures (e.g. PowerPC), while the OpenSSL version (default
-# choice) has very fast version optimized for i586.
-#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
-# Define ARM_SHA1 environment variable when running make to make use of
-# a bundled SHA1 routine optimized for ARM.
-#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
-# This also implies MOZILLA_SHA1.
+# This also implies BLK_SHA1.
 #
 # Define OPENSSLDIR=/foo/bar if your openssl header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
diff --git a/mozilla-sha1/sha1.c b/mozilla-sha1/sha1.c
deleted file mode 100644
index 95a4ebf..0000000
--- a/mozilla-sha1/sha1.c
+++ /dev/null
@@ -1,151 +0,0 @@
-/*
- * The contents of this file are subject to the Mozilla Public
- * License Version 1.1 (the "License"); you may not use this file
- * except in compliance with the License. You may obtain a copy of
- * the License at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS
- * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
- * implied. See the License for the specific language governing
- * rights and limitations under the License.
- *
- * The Original Code is SHA 180-1 Reference Implementation (Compact version)
- *
- * The Initial Developer of the Original Code is Paul Kocher of
- * Cryptography Research.  Portions created by Paul Kocher are
- * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
- * Rights Reserved.
- *
- * Contributor(s):
- *
- *     Paul Kocher
- *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License Version 2 or later (the
- * "GPL"), in which case the provisions of the GPL are applicable
- * instead of those above.  If you wish to allow use of your
- * version of this file only under the terms of the GPL and not to
- * allow others to use your version of this file under the MPL,
- * indicate your decision by deleting the provisions above and
- * replace them with the notice and other provisions required by
- * the GPL.  If you do not delete the provisions above, a recipient
- * may use your version of this file under either the MPL or the
- * GPL.
- */
-
-#include "sha1.h"
-
-static void shaHashBlock(moz_SHA_CTX *ctx);
-
-void moz_SHA1_Init(moz_SHA_CTX *ctx) {
-  int i;
-
-  ctx->lenW = 0;
-  ctx->sizeHi = ctx->sizeLo = 0;
-
-  /* Initialize H with the magic constants (see FIPS180 for constants)
-   */
-  ctx->H[0] = 0x67452301;
-  ctx->H[1] = 0xefcdab89;
-  ctx->H[2] = 0x98badcfe;
-  ctx->H[3] = 0x10325476;
-  ctx->H[4] = 0xc3d2e1f0;
-
-  for (i = 0; i < 80; i++)
-    ctx->W[i] = 0;
-}
-
-
-void moz_SHA1_Update(moz_SHA_CTX *ctx, const void *_dataIn, int len) {
-  const unsigned char *dataIn = _dataIn;
-  int i;
-
-  /* Read the data into W and process blocks as they get full
-   */
-  for (i = 0; i < len; i++) {
-    ctx->W[ctx->lenW / 4] <<= 8;
-    ctx->W[ctx->lenW / 4] |= (unsigned int)dataIn[i];
-    if ((++ctx->lenW) % 64 == 0) {
-      shaHashBlock(ctx);
-      ctx->lenW = 0;
-    }
-    ctx->sizeLo += 8;
-    ctx->sizeHi += (ctx->sizeLo < 8);
-  }
-}
-
-
-void moz_SHA1_Final(unsigned char hashout[20], moz_SHA_CTX *ctx) {
-  unsigned char pad0x80 = 0x80;
-  unsigned char pad0x00 = 0x00;
-  unsigned char padlen[8];
-  int i;
-
-  /* Pad with a binary 1 (e.g. 0x80), then zeroes, then length
-   */
-  padlen[0] = (unsigned char)((ctx->sizeHi >> 24) & 255);
-  padlen[1] = (unsigned char)((ctx->sizeHi >> 16) & 255);
-  padlen[2] = (unsigned char)((ctx->sizeHi >> 8) & 255);
-  padlen[3] = (unsigned char)((ctx->sizeHi >> 0) & 255);
-  padlen[4] = (unsigned char)((ctx->sizeLo >> 24) & 255);
-  padlen[5] = (unsigned char)((ctx->sizeLo >> 16) & 255);
-  padlen[6] = (unsigned char)((ctx->sizeLo >> 8) & 255);
-  padlen[7] = (unsigned char)((ctx->sizeLo >> 0) & 255);
-  moz_SHA1_Update(ctx, &pad0x80, 1);
-  while (ctx->lenW != 56)
-    moz_SHA1_Update(ctx, &pad0x00, 1);
-  moz_SHA1_Update(ctx, padlen, 8);
-
-  /* Output hash
-   */
-  for (i = 0; i < 20; i++) {
-    hashout[i] = (unsigned char)(ctx->H[i / 4] >> 24);
-    ctx->H[i / 4] <<= 8;
-  }
-
-  /*
-   *  Re-initialize the context (also zeroizes contents)
-   */
-  moz_SHA1_Init(ctx);
-}
-
-
-#define SHA_ROT(X,n) (((X) << (n)) | ((X) >> (32-(n))))
-
-static void shaHashBlock(moz_SHA_CTX *ctx) {
-  int t;
-  unsigned int A,B,C,D,E,TEMP;
-
-  for (t = 16; t <= 79; t++)
-    ctx->W[t] =
-      SHA_ROT(ctx->W[t-3] ^ ctx->W[t-8] ^ ctx->W[t-14] ^ ctx->W[t-16], 1);
-
-  A = ctx->H[0];
-  B = ctx->H[1];
-  C = ctx->H[2];
-  D = ctx->H[3];
-  E = ctx->H[4];
-
-  for (t = 0; t <= 19; t++) {
-    TEMP = SHA_ROT(A,5) + (((C^D)&B)^D)     + E + ctx->W[t] + 0x5a827999;
-    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
-  }
-  for (t = 20; t <= 39; t++) {
-    TEMP = SHA_ROT(A,5) + (B^C^D)           + E + ctx->W[t] + 0x6ed9eba1;
-    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
-  }
-  for (t = 40; t <= 59; t++) {
-    TEMP = SHA_ROT(A,5) + ((B&C)|(D&(B|C))) + E + ctx->W[t] + 0x8f1bbcdc;
-    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
-  }
-  for (t = 60; t <= 79; t++) {
-    TEMP = SHA_ROT(A,5) + (B^C^D)           + E + ctx->W[t] + 0xca62c1d6;
-    E = D; D = C; C = SHA_ROT(B, 30); B = A; A = TEMP;
-  }
-
-  ctx->H[0] += A;
-  ctx->H[1] += B;
-  ctx->H[2] += C;
-  ctx->H[3] += D;
-  ctx->H[4] += E;
-}
diff --git a/mozilla-sha1/sha1.h b/mozilla-sha1/sha1.h
deleted file mode 100644
index aa48a46..0000000
--- a/mozilla-sha1/sha1.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * The contents of this file are subject to the Mozilla Public
- * License Version 1.1 (the "License"); you may not use this file
- * except in compliance with the License. You may obtain a copy of
- * the License at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS
- * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
- * implied. See the License for the specific language governing
- * rights and limitations under the License.
- *
- * The Original Code is SHA 180-1 Header File
- *
- * The Initial Developer of the Original Code is Paul Kocher of
- * Cryptography Research.  Portions created by Paul Kocher are
- * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
- * Rights Reserved.
- *
- * Contributor(s):
- *
- *     Paul Kocher
- *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License Version 2 or later (the
- * "GPL"), in which case the provisions of the GPL are applicable
- * instead of those above.  If you wish to allow use of your
- * version of this file only under the terms of the GPL and not to
- * allow others to use your version of this file under the MPL,
- * indicate your decision by deleting the provisions above and
- * replace them with the notice and other provisions required by
- * the GPL.  If you do not delete the provisions above, a recipient
- * may use your version of this file under either the MPL or the
- * GPL.
- */
-
-typedef struct {
-  unsigned int H[5];
-  unsigned int W[80];
-  int lenW;
-  unsigned int sizeHi,sizeLo;
-} moz_SHA_CTX;
-
-void moz_SHA1_Init(moz_SHA_CTX *ctx);
-void moz_SHA1_Update(moz_SHA_CTX *ctx, const void *dataIn, int len);
-void moz_SHA1_Final(unsigned char hashout[20], moz_SHA_CTX *ctx);
-
-#define git_SHA_CTX	moz_SHA_CTX
-#define git_SHA1_Init	moz_SHA1_Init
-#define git_SHA1_Update	moz_SHA1_Update
-#define git_SHA1_Final	moz_SHA1_Final
