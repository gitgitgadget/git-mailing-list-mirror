From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] ARM optimized SHA1 implementation
Date: Tue, 20 Sep 2005 12:27:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509201149150.18381@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 18:30:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHkyS-0003Q4-C7
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 18:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVITQ13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 12:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVITQ13
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 12:27:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52906 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932665AbVITQ12
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 12:27:28 -0400
Received: from xanadu.home ([24.202.136.67]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IN400G8OJ1DG770@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Sep 2005 12:27:14 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9006>

This is my ARM assembly SHA1 implementation for GIT. It is approximately 
50% faster than the generic C version. On an XScale processor running at 
400MHz:

	generic C version:	9.8 MB/s
	my version:		14.5 MB/s

It's not that I expect a lot of big GIT users on ARM, but I stillknow 
about one important ARM user that might benefit from it, and writing 
that code was fun.

I also reworked the makefile a bit so any optimized SHA1 implementations 
is used regardless of whether NO_OPENSSL is defined or not.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/arm/sha1.c b/arm/sha1.c
new file mode 100644
--- /dev/null
+++ b/arm/sha1.c
@@ -0,0 +1,82 @@
+/*
+ * SHA-1 implementation optimized for ARM
+ *
+ * Copyright:   (C) 2005 by Nicolas Pitre <nico@cam.org>
+ * Created:     September 17, 2005
+ */
+
+#include <string.h>
+#include "sha1.h"
+
+extern void sha_transform(uint32_t *hash, const unsigned char *data, uint32_t *W);
+
+void SHA1_Init(SHA_CTX *c)
+{
+	c->len = 0;
+	c->hash[0] = 0x67452301;
+	c->hash[1] = 0xefcdab89;
+	c->hash[2] = 0x98badcfe;
+	c->hash[3] = 0x10325476;
+	c->hash[4] = 0xc3d2e1f0;
+}
+
+void SHA1_Update(SHA_CTX *c, const void *p, unsigned long n)
+{
+	uint32_t workspace[80];
+	unsigned int partial;
+	unsigned long done;
+
+	partial = c->len & 0x3f;
+	c->len += n;
+	if ((partial + n) >= 64) {
+		if (partial) {
+			done = 64 - partial;
+			memcpy(c->buffer + partial, p, done);
+			sha_transform(c->hash, c->buffer, workspace);
+			partial = 0;
+		} else
+			done = 0;
+		while (n >= done + 64) {
+			sha_transform(c->hash, p + done, workspace);
+			done += 64;
+		}
+	} else
+		done = 0;
+	if (n - done)
+		memcpy(c->buffer + partial, p + done, n - done);
+}
+
+void SHA1_Final(unsigned char *hash, SHA_CTX *c)
+{
+	uint64_t bitlen;
+	uint32_t bitlen_hi, bitlen_lo; 
+	unsigned int i, offset, padlen;
+	unsigned char bits[8];
+	static const unsigned char padding[64] = { 0x80, };
+
+	bitlen = c->len << 3;
+	offset = c->len & 0x3f;
+	padlen = ((offset < 56) ? 56 : (64 + 56)) - offset;
+	SHA1_Update(c, padding, padlen);
+
+	bitlen_hi = bitlen >> 32;
+	bitlen_lo = bitlen & 0xffffffff;
+	bits[0] = bitlen_hi >> 24;
+	bits[1] = bitlen_hi >> 16;
+	bits[2] = bitlen_hi >> 8;
+	bits[3] = bitlen_hi;
+	bits[4] = bitlen_lo >> 24;
+	bits[5] = bitlen_lo >> 16;
+	bits[6] = bitlen_lo >> 8;
+	bits[7] = bitlen_lo;
+	SHA1_Update(c, bits, 8); 
+
+	for (i = 0; i < 5; i++) {
+		uint32_t v = c->hash[i];
+		hash[0] = v >> 24;
+		hash[1] = v >> 16;
+		hash[2] = v >> 8;
+		hash[3] = v;
+		hash += 4;
+	}
+}
diff --git a/arm/sha1.h b/arm/sha1.h
new file mode 100644
--- /dev/null
+++ b/arm/sha1.h
@@ -0,0 +1,18 @@
+/*
+ * SHA-1 implementation optimized for ARM
+ *
+ * Copyright:	(C) 2005 by Nicolas Pitre <nico@cam.org>
+ * Created:	September 17, 2005
+ */
+
+#include <stdint.h>
+
+typedef struct sha_context {
+	uint64_t len;
+	uint32_t hash[5];
+	unsigned char buffer[64];
+} SHA_CTX;
+
+void SHA1_Init(SHA_CTX *c);
+void SHA1_Update(SHA_CTX *c, const void *p, unsigned long n);
+void SHA1_Final(unsigned char *hash, SHA_CTX *c);
diff --git a/arm/sha1_arm.S b/arm/sha1_arm.S
new file mode 100644
--- /dev/null
+++ b/arm/sha1_arm.S
@@ -0,0 +1,184 @@
+/*
+ *  SHA transform optimized for ARM
+ *
+ *  Copyright:	(C) 2005 by Nicolas Pitre <nico@cam.org>
+ *  Created:	September 17, 2005
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+	.text
+	.globl	sha_transform
+
+/*
+ * void sha_transform(uint32_t *hash, const unsigned char *data, uint32_t *W);
+ *
+ * note: the "data" pointer may be unaligned.
+ */
+
+sha_transform:
+
+	stmfd	sp!, {r4 - r8, lr}
+
+	@ for (i = 0; i < 16; i++)
+	@         W[i] = ntohl(((uint32_t *)data)[i]); */
+
+#ifdef __ARMEB__
+	mov	r4, r0
+	mov	r0, r2
+	mov	r2, #64
+	bl	memcpy
+	mov	r2, r0
+	mov	r0, r4
+#else
+	mov	r3, r2
+	mov	lr, #16
+1:	ldrb	r4, [r1], #1
+	ldrb	r5, [r1], #1
+	ldrb	r6, [r1], #1
+	ldrb	r7, [r1], #1
+	subs	lr, lr, #1
+	orr	r5, r5, r4, lsl #8
+	orr	r6, r6, r5, lsl #8
+	orr	r7, r7, r6, lsl #8
+	str	r7, [r3], #4
+	bne	1b
+#endif
+
+	@ for (i = 0; i < 64; i++)
+	@         W[i+16] = ror(W[i+13] ^ W[i+8] ^ W[i+2] ^ W[i], 31);
+
+	sub	r3, r2, #4
+	mov	lr, #64
+2:	ldr	r4, [r3, #4]!
+	subs	lr, lr, #1
+	ldr	r5, [r3, #8]
+	ldr	r6, [r3, #32]
+	ldr	r7, [r3, #52]
+	eor	r4, r4, r5
+	eor	r4, r4, r6
+	eor	r4, r4, r7
+	mov	r4, r4, ror #31
+	str	r4, [r3, #64]
+	bne	2b
+
+	/*
+	 * The SHA functions are:
+	 *
+	 * f1(B,C,D) = (D ^ (B & (C ^ D)))
+	 * f2(B,C,D) = (B ^ C ^ D)
+	 * f3(B,C,D) = ((B & C) | (D & (B | C)))
+	 *
+	 * Then the sub-blocks are processed as follows:
+	 *
+	 * A' = ror(A, 27) + f(B,C,D) + E + K + *W++
+	 * B' = A
+	 * C' = ror(B, 2)
+	 * D' = C
+	 * E' = D
+	 *
+	 * We therefore unroll each loop 5 times to avoid register shuffling.
+	 * Also the ror for C (and also D and E which are successivelyderived
+	 * from it) is applied in place to cut on an additional mov insn for
+	 * each round.
+	 */
+
+	.macro	sha_f1, A, B, C, D, E
+	ldr	r3, [r2], #4
+	eor	ip, \C, \D
+	add	\E, r1, \E, ror #2
+	and	ip, \B, ip, ror #2
+	add	\E, \E, \A, ror #27
+	eor	ip, ip, \D, ror #2
+	add	\E, \E, r3
+	add	\E, \E, ip
+	.endm
+
+	.macro	sha_f2, A, B, C, D, E
+	ldr	r3, [r2], #4
+	add	\E, r1, \E, ror #2
+	eor	ip, \B, \C, ror #2
+	add	\E, \E, \A, ror #27
+	eor	ip, ip, \D, ror #2
+	add	\E, \E, r3
+	add	\E, \E, ip
+	.endm
+
+	.macro	sha_f3, A, B, C, D, E
+	ldr	r3, [r2], #4
+	add	\E, r1, \E, ror #2
+	orr	ip, \B, \C, ror #2
+	add	\E, \E, \A, ror #27
+	and	ip, ip, \D, ror #2
+	add	\E, \E, r3
+	and	r3, \B, \C, ror #2
+	orr	ip, ip, r3
+	add	\E, \E, ip
+	.endm
+
+	ldmia	r0, {r4 - r8}
+
+	mov	lr, #4
+	ldr	r1, .L_sha_K + 0
+
+	/* adjust initial values */
+	mov	r6, r6, ror #30
+	mov	r7, r7, ror #30
+	mov	r8, r8, ror #30
+
+3:	subs	lr, lr, #1
+	sha_f1	r4, r5, r6, r7, r8
+	sha_f1	r8, r4, r5, r6, r7
+	sha_f1	r7, r8, r4, r5, r6
+	sha_f1	r6, r7, r8, r4, r5
+	sha_f1	r5, r6, r7, r8, r4
+	bne	3b
+
+	ldr	r1, .L_sha_K + 4
+	mov	lr, #4
+
+4:	subs	lr, lr, #1
+	sha_f2	r4, r5, r6, r7, r8
+	sha_f2	r8, r4, r5, r6, r7
+	sha_f2	r7, r8, r4, r5, r6
+	sha_f2	r6, r7, r8, r4, r5
+	sha_f2	r5, r6, r7, r8, r4
+	bne	4b
+
+	ldr	r1, .L_sha_K + 8
+	mov	lr, #4
+
+5:	subs	lr, lr, #1
+	sha_f3	r4, r5, r6, r7, r8
+	sha_f3	r8, r4, r5, r6, r7
+	sha_f3	r7, r8, r4, r5, r6
+	sha_f3	r6, r7, r8, r4, r5
+	sha_f3	r5, r6, r7, r8, r4
+	bne	5b
+
+	ldr	r1, .L_sha_K + 12
+	mov	lr, #4
+
+6:	subs	lr, lr, #1
+	sha_f2	r4, r5, r6, r7, r8
+	sha_f2	r8, r4, r5, r6, r7
+	sha_f2	r7, r8, r4, r5, r6
+	sha_f2	r6, r7, r8, r4, r5
+	sha_f2	r5, r6, r7, r8, r4
+	bne	6b
+
+	ldmia	r0, {r1, r2, r3, ip, lr}
+	add	r4, r1, r4
+	add	r5, r2, r5
+	add	r6, r3, r6, ror #2
+	add	r7, ip, r7, ror #2
+	add	r8, lr, r8, ror #2
+	stmia	r0, {r4 - r8}
+
+	ldmfd	sp!, {r4 - r8, pc}
+
+.L_sha_K:
+	.word	0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6
+
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -12,6 +12,9 @@
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define ARM_SHA1 environment variable when running make to make use of
+# a bundled SHA1 routine optimized for ARM.
+#
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
@@ -155,6 +158,10 @@ ifeq ($(shell uname -s),SunOS)
 	PLATFORM_DEFINES += -D__EXTENSIONS__
 endif
 
+ifneq (,$(findstring arm,$(shell uname -m)))
+	ARM_SHA1 = YesPlease
+endif
+
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
 endif
@@ -183,18 +190,6 @@ ifdef NEEDS_LIBICONV
 else
 	LIB_4_ICONV =
 endif
-ifdef MOZILLA_SHA1
-	SHA1_HEADER = "mozilla-sha1/sha1.h"
-	LIB_OBJS += mozilla-sha1/sha1.o
-else
-	ifdef PPC_SHA1
-		SHA1_HEADER = "ppc/sha1.h"
-		LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
-	else
-		SHA1_HEADER = <openssl/sha.h>
-		LIBS += $(LIB_4_CRYPTO)
-	endif
-endif
 ifdef NEEDS_SOCKET
 	LIBS += -lsocket
 	SIMPLE_LIB += -lsocket
@@ -204,6 +199,24 @@ ifdef NEEDS_NSL
 	SIMPLE_LIB += -lnsl
 endif
 
+ifdef PPC_SHA1
+	SHA1_HEADER = "ppc/sha1.h"
+	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
+else
+ifdef ARM_SHA1
+	SHA1_HEADER = "arm/sha1.h"
+	LIB_OBJS += arm/sha1.o arm/sha1_arm.o
+else
+ifdef MOZILLA_SHA1
+	SHA1_HEADER = "mozilla-sha1/sha1.h"
+	LIB_OBJS += mozilla-sha1/sha1.o
+else
+	SHA1_HEADER = <openssl/sha.h>
+	LIBS += $(LIB_4_CRYPTO)
+endif
+endif
+endif
+
 DEFINES += '-DSHA1_HEADER=$(SHA1_HEADER)'
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
