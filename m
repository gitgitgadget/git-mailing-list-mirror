From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] optimized SHA1 for powerpc
Date: Fri, 22 Apr 2005 15:52:25 +1000
Message-ID: <17000.37145.799151.390802@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, anton@samba.org
X-From: git-owner@vger.kernel.org Fri Apr 22 07:49:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOr2M-0005K5-5V
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 07:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVDVFxj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 01:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVDVFxj
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 01:53:39 -0400
Received: from ozlabs.org ([203.10.76.45]:41895 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261982AbVDVFwy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 01:52:54 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9D3E467AC7; Fri, 22 Apr 2005 15:52:52 +1000 (EST)
To: torvalds@osdl.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

Just for fun, I wrote a ppc-assembly SHA1 routine.  It appears to be
about 2.5x faster than the generic version.  It reduces the time for a
fsck-cache on a linux-2.6 tree from ~6.8 seconds to ~6.0 seconds on my
G4 powerbook.

Paul.

diff -urN git.orig/Makefile git/Makefile
--- git.orig/Makefile	2005-04-22 15:21:10.000000000 +1000
+++ git/Makefile	2005-04-22 15:11:28.000000000 +1000
@@ -25,7 +25,12 @@
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h
+LIB_H=cache.h object.h sha1.h
+
+arch := $(shell uname -m | tr -d 0-9)
+ifeq ($(arch),ppc)
+LIB_OBJS += sha1.o sha1ppc.o
+endif
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
diff -urN git.orig/cache.h git/cache.h
--- git.orig/cache.h	2005-04-22 15:21:10.000000000 +1000
+++ git/cache.h	2005-04-22 13:57:36.000000000 +1000
@@ -12,7 +12,7 @@
 #include <sys/mman.h>
 #include <netinet/in.h>
 
-#include <openssl/sha.h>
+#include "sha1.h"
 #include <zlib.h>
 
 /*
diff -urN git.orig/sha1.c git/sha1.c
--- /dev/null	2005-04-04 12:56:19.000000000 +1000
+++ git/sha1.c	2005-04-22 15:17:27.000000000 +1000
@@ -0,0 +1,72 @@
+/*
+ * SHA-1 implementation.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ *
+ * This version assumes we are running on a big-endian machine.
+ * It calls an external sha1_core() to process blocks of 64 bytes.
+ */
+#include <stdio.h>
+#include <string.h>
+#include "sha1.h"
+
+extern void sha1_core(uint32_t *hash, const unsigned char *p,
+		      unsigned int nblocks);
+
+int SHA1_Init(SHA_CTX *c)
+{
+	c->hash[0] = 0x67452301;
+	c->hash[1] = 0xEFCDAB89;
+	c->hash[2] = 0x98BADCFE;
+	c->hash[3] = 0x10325476;
+	c->hash[4] = 0xC3D2E1F0;
+	c->len = 0;
+	c->cnt = 0;
+	return 0;
+}
+
+int SHA1_Update(SHA_CTX *c, const void *ptr, unsigned long n)
+{
+	unsigned long nb;
+	const unsigned char *p = ptr;
+
+	c->len += n << 3;
+	while (n != 0) {
+		if (c->cnt || n < 64) {
+			nb = 64 - c->cnt;
+			if (nb > n)
+				nb = n;
+			memcpy(&c->buf.b[c->cnt], p, nb);
+			if ((c->cnt += nb) == 64) {
+				sha1_core(c->hash, c->buf.b, 1);
+				c->cnt = 0;
+			}
+		} else {
+			nb = n >> 6;
+			sha1_core(c->hash, p, nb);
+			nb <<= 6;
+		}
+		n -= nb;
+		p += nb;
+	}
+	return 0;
+}	
+
+int SHA1_Final(unsigned char *hash, SHA_CTX *c)
+{
+	unsigned int cnt = c->cnt;
+
+	c->buf.b[cnt++] = 0x80;
+	if (cnt > 56) {
+		if (cnt < 64)
+			memset(&c->buf.b[cnt], 0, 64 - cnt);
+		sha1_core(c->hash, c->buf.b, 1);
+		cnt = 0;
+	}
+	if (cnt < 56)
+		memset(&c->buf.b[cnt], 0, 56 - cnt);
+	c->buf.l[7] = c->len;
+	sha1_core(c->hash, c->buf.b, 1);
+	memcpy(hash, c->hash, 20);
+	return 0;
+}
diff -urN git.orig/sha1.h git/sha1.h
--- /dev/null	2005-04-04 12:56:19.000000000 +1000
+++ git/sha1.h	2005-04-22 15:06:53.000000000 +1000
@@ -0,0 +1,19 @@
+#ifndef __powerpc__
+#include <openssl/sha.h>
+#else
+#include <stdint.h>
+
+typedef struct sha_context {
+	uint32_t hash[5];
+	uint32_t cnt;
+	uint64_t len;
+	union {
+		unsigned char b[64];
+		uint64_t l[8];
+	} buf;
+} SHA_CTX;
+
+int SHA1_Init(SHA_CTX *c);
+int SHA1_Update(SHA_CTX *c, const void *p, unsigned long n);
+int SHA1_Final(unsigned char *hash, SHA_CTX *c);
+#endif
diff -urN git.orig/sha1ppc.S git/sha1ppc.S
--- /dev/null	2005-04-04 12:56:19.000000000 +1000
+++ git/sha1ppc.S	2005-04-22 15:18:19.000000000 +1000
@@ -0,0 +1,185 @@
+/*
+ * SHA-1 implementation for PowerPC.
+ *
+ * Copyright (C) 2005 Paul Mackerras.
+ */
+#define FS	80
+
+/*
+ * We roll the registers for T, A, B, C, D, E around on each
+ * iteration; T on iteration t is A on iteration t+1, and so on.
+ * We use registers 7 - 12 for this.
+ */
+#define RT(t)	((((t)+5)%6)+7)
+#define RA(t)	((((t)+4)%6)+7)
+#define RB(t)	((((t)+3)%6)+7)
+#define RC(t)	((((t)+2)%6)+7)
+#define RD(t)	((((t)+1)%6)+7)
+#define RE(t)	((((t)+0)%6)+7)
+
+/* We use registers 16 - 31 for the W values */
+#define W(t)	(((t)%16)+16)
+
+#define STEPD0(t)				\
+	and	%r6,RB(t),RC(t);		\
+	andc	%r0,RD(t),RB(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	or	%r6,%r6,%r0;			\
+	add	%r0,RE(t),%r15;			\
+	add	RT(t),RT(t),%r6;		\
+	add	%r0,%r0,W(t);			\
+	add	RT(t),RT(t),%r0
+
+#define STEPD1(t)				\
+	xor	%r6,RB(t),RC(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	xor	%r6,%r6,RD(t);			\
+	add	%r0,RE(t),%r15;			\
+	add	RT(t),RT(t),%r6;		\
+	add	%r0,%r0,W(t);			\
+	add	RT(t),RT(t),%r0
+
+#define STEPD2(t)				\
+	and	%r6,RB(t),RC(t);		\
+	and	%r0,RB(t),RD(t);		\
+	rotlwi	RT(t),RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	or	%r6,%r6,%r0;			\
+	and	%r0,RC(t),RD(t);		\
+	or	%r6,%r6,%r0;			\
+	add	%r0,RE(t),%r15;			\
+	add	RT(t),RT(t),%r6;		\
+	add	%r0,%r0,W(t);			\
+	add	RT(t),RT(t),%r0
+
+#define LOADW(t)				\
+	lwz	W(t),(t)*4(%r4)
+
+#define UPDATEW(t)				\
+	xor	%r0,W((t)-3),W((t)-8);		\
+	xor	W(t),W((t)-16),W((t)-14);	\
+	xor	W(t),W(t),%r0;			\
+	rotlwi	W(t),W(t),1
+
+#define STEP0LD4(t)				\
+	STEPD0(t);   LOADW((t)+4);		\
+	STEPD0((t)+1); LOADW((t)+5);		\
+	STEPD0((t)+2); LOADW((t)+6);		\
+	STEPD0((t)+3); LOADW((t)+7)
+
+#define STEPUP4(t, fn)				\
+	STEP##fn(t);   UPDATEW((t)+4);		\
+	STEP##fn((t)+1); UPDATEW((t)+5);	\
+	STEP##fn((t)+2); UPDATEW((t)+6);	\
+	STEP##fn((t)+3); UPDATEW((t)+7)
+
+#define STEPUP20(t, fn)				\
+	STEPUP4(t, fn);				\
+	STEPUP4((t)+4, fn);			\
+	STEPUP4((t)+8, fn);			\
+	STEPUP4((t)+12, fn);			\
+	STEPUP4((t)+16, fn)
+
+	.globl	sha1_core
+sha1_core:
+	stwu	%r1,-FS(%r1)
+	stw	%r15,FS-68(%r1)
+	stw	%r16,FS-64(%r1)
+	stw	%r17,FS-60(%r1)
+	stw	%r18,FS-56(%r1)
+	stw	%r19,FS-52(%r1)
+	stw	%r20,FS-48(%r1)
+	stw	%r21,FS-44(%r1)
+	stw	%r22,FS-40(%r1)
+	stw	%r23,FS-36(%r1)
+	stw	%r24,FS-32(%r1)
+	stw	%r25,FS-28(%r1)
+	stw	%r26,FS-24(%r1)
+	stw	%r27,FS-20(%r1)
+	stw	%r28,FS-16(%r1)
+	stw	%r29,FS-12(%r1)
+	stw	%r30,FS-8(%r1)
+	stw	%r31,FS-4(%r1)
+
+	/* Load up A - E */
+	lwz	RA(0),0(%r3)	/* A */
+	lwz	RB(0),4(%r3)	/* B */
+	lwz	RC(0),8(%r3)	/* C */
+	lwz	RD(0),12(%r3)	/* D */
+	lwz	RE(0),16(%r3)	/* E */
+
+	mtctr	%r5
+
+1:	LOADW(0)
+	LOADW(1)
+	LOADW(2)
+	LOADW(3)
+
+	lis	%r15,0x5a82	/* K0-19 */
+	ori	%r15,%r15,0x7999
+	STEP0LD4(0)
+	STEP0LD4(4)
+	STEP0LD4(8)
+	STEPUP4(12, D0)
+	STEPUP4(16, D0)
+
+	lis	%r15,0x6ed9	/* K20-39 */
+	ori	%r15,%r15,0xeba1
+	STEPUP20(20, D1)
+
+	lis	%r15,0x8f1b	/* K40-59 */
+	ori	%r15,%r15,0xbcdc
+	STEPUP20(40, D2)
+
+	lis	%r15,0xca62	/* K60-79 */
+	ori	%r15,%r15,0xc1d6
+	STEPUP4(60, D1)
+	STEPUP4(64, D1)
+	STEPUP4(68, D1)
+	STEPUP4(72, D1)
+	STEPD1(76)
+	STEPD1(77)
+	STEPD1(78)
+	STEPD1(79)
+
+	lwz	%r20,16(%r3)
+	lwz	%r19,12(%r3)
+	lwz	%r18,8(%r3)
+	lwz	%r17,4(%r3)
+	lwz	%r16,0(%r3)
+	add	%r20,RE(80),%r20
+	add	RD(0),RD(80),%r19
+	add	RC(0),RC(80),%r18
+	add	RB(0),RB(80),%r17
+	add	RA(0),RA(80),%r16
+	mr	RE(0),%r20
+	stw	RA(0),0(%r3)
+	stw	RB(0),4(%r3)
+	stw	RC(0),8(%r3)
+	stw	RD(0),12(%r3)
+	stw	RE(0),16(%r3)
+
+	addi	%r4,%r4,64
+	bdnz	1b
+
+	lwz	%r15,FS-68(%r1)
+	lwz	%r16,FS-64(%r1)
+	lwz	%r17,FS-60(%r1)
+	lwz	%r18,FS-56(%r1)
+	lwz	%r19,FS-52(%r1)
+	lwz	%r20,FS-48(%r1)
+	lwz	%r21,FS-44(%r1)
+	lwz	%r22,FS-40(%r1)
+	lwz	%r23,FS-36(%r1)
+	lwz	%r24,FS-32(%r1)
+	lwz	%r25,FS-28(%r1)
+	lwz	%r26,FS-24(%r1)
+	lwz	%r27,FS-20(%r1)
+	lwz	%r28,FS-16(%r1)
+	lwz	%r29,FS-12(%r1)
+	lwz	%r30,FS-8(%r1)
+	lwz	%r31,FS-4(%r1)
+	addi	%r1,%r1,FS
+	blr
