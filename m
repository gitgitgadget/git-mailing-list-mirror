From: linux@horizon.com
Subject: x86 asm SHA1 (draft)
Date: 23 Jun 2006 13:18:09 -0400
Message-ID: <20060623171809.5689.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Fri Jun 23 20:45:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtqeX-00086W-4s
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 20:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWFWSo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 14:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWFWSoD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 14:44:03 -0400
Received: from science.horizon.com ([192.35.100.1]:8268 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751939AbWFWSnr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 14:43:47 -0400
Received: (qmail 5690 invoked by uid 1000); 23 Jun 2006 13:18:09 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22435>

As long as I was hacking on PowerPC asm, I figured I might as well take
a crack at the openssl dependency, too.  This is a draft x86 SHA1 that
is a little over 2x faster than the C version on a Pentium M.  I haven't
yet started competing with the OpenSSL code.

This might be useful for the folks who are careful about licensing and
don't like to get mixed up in the OpenSSL/GPL license tangle.

Work in progress, but it functions.  Public domain.


--- /dev/null	2006-04-13 05:29:14.000000000 -0400
+++ sha1x86.S	2006-06-23 09:14:21.000000000 -0400
@@ -0,0 +1,233 @@
+	.text
+#define K1 0x5a827999
+#define K2 0x6ed9eba1
+#define K3 0x8f1bbcdc
+#define K4 0xca62c1d6
+
+#define A %edi
+#define B %ebx
+#define C %ecx
+#define D %edx
+#define E %ebp
+
+#define T %eax
+
+#define MIX(base) \
+	movl	60-base(%esp),T;	\
+	xorl	52-base(%esp),T;	\
+	xorl	28-base(%esp),T;	\
+	xorl	8-base(%esp),T;		\
+	roll	$1,T
+
+/*
+ *In these choice functions, C is the value most recently modified
+ * (It was the B that was rotated in the previous round), so schedule its
+ * use as late as possible.
+ */
+
+/* Choice function: bitwise b ? c : d = ((d ^ c) & b) ^ d */
+#define F1(b,c,d,e) \
+	movl	d,T;	\
+	xorl	c,T;	\
+	andl	b,T;	\
+	roll	$30,b;	\
+	xorl	d,T;	\
+	addl	T,e
+
+/* Parity function: b ^ c ^ d = (b ^ d) ^ c */
+#define F2(b,c,d,e) \
+	movl	b,T;	\
+	roll	$30,b;	\
+	xorl	d,T;	\
+	xorl	c,T;	\
+	addl	T,e
+
+/* Majority function: (b&c) | (c&d) | (d&b) = (b&d) + ((b^d)&c) */
+#define F3(b,c,d,e) \
+	movl	b,T;	\
+	andl	d,T;	\
+	addl	T,e;	\
+	movl	b,T;	\
+	roll	$30,b;	\
+	xorl	d,T;	\
+	andl	c,T;	\
+	addl	T,e
+
+/*
+ * Register assignments:
+ * %eax - temp
+ * %esi - Pointer to input data
+ * %edi, %ebx, %ecx, %edx, %ebp - A..E
+ */
+
+ /*
+  * The basic round:
+  * e += ROTL(e,5) + F(b,c,d) + W[i] + 0x5a827999
+  */
+
+/* This version fetches (and swaps) data from %esi */
+#define ROUND_LOAD(F,a,b,c,d,e,K) \
+	lodsl;		\
+	addl	$K,e;	\
+	bswap	T;	\
+	addl	T,e;	\
+	pushl	T;	\
+	F(b,c,d,e);	\
+	movl	a,T;	\
+	roll	$5,T;	\
+	addl	T,e
+
+/* The standard round: compute the new W value and push it on the stack */
+#define ROUND_MIX(F,a,b,c,d,e,K) \
+	MIX(0);		\
+	addl	$K,e;	\
+	addl	T,e;	\
+	pushl	T;	\
+	F(b,c,d,e);	\
+	movl	a,T;	\
+	roll	$5,T;	\
+	addl	T,e
+
+/* Mix the W[] value, but do NOT push it, as it's never used */
+#define ROUND_LAST(F,a,b,c,d,e,K,base) \
+	MIX(base);	\
+	addl	$K,e;	\
+	addl	T,e;	\
+	F(b,c,d,e);	\
+	movl	a,T;	\
+	roll	$5,T;	\
+	addl	T,e
+
+/* Args are context (A..E, then a W[] array), then input data */
+.globl shaHashBlock
+	.type	shaHashBlock, @function
+shaHashBlock:
+	pushl	%ebp
+	pushl	%ebx
+	pushl	%esi
+	pushl	%edi
+/* Args now start at 20(%esp) */
+
+	movl	20(%esp),T
+	movl	24(%esp),%esi
+
+	movl	  (T),A
+	movl	 4(T),B
+	movl	 8(T),C
+	movl	12(T),D
+	movl	16(T),E
+
+	ROUND_LOAD(F1, A,B,C,D,E, K1);
+	ROUND_LOAD(F1, E,A,B,C,D, K1);
+	ROUND_LOAD(F1, D,E,A,B,C, K1);
+	ROUND_LOAD(F1, C,D,E,A,B, K1);
+	ROUND_LOAD(F1, B,C,D,E,A, K1);
+
+	ROUND_LOAD(F1, A,B,C,D,E, K1);
+	ROUND_LOAD(F1, E,A,B,C,D, K1);
+	ROUND_LOAD(F1, D,E,A,B,C, K1);
+	ROUND_LOAD(F1, C,D,E,A,B, K1);
+	ROUND_LOAD(F1, B,C,D,E,A, K1);
+
+	ROUND_LOAD(F1, A,B,C,D,E, K1);
+	ROUND_LOAD(F1, E,A,B,C,D, K1);
+	ROUND_LOAD(F1, D,E,A,B,C, K1);
+	ROUND_LOAD(F1, C,D,E,A,B, K1);
+	ROUND_LOAD(F1, B,C,D,E,A, K1);
+
+	ROUND_LOAD(F1, A,B,C,D,E, K1);
+	ROUND_MIX(F1, E,A,B,C,D, K1);
+	ROUND_MIX(F1, D,E,A,B,C, K1);
+	ROUND_MIX(F1, C,D,E,A,B, K1);
+	ROUND_MIX(F1, B,C,D,E,A, K1);
+
+	ROUND_MIX(F2, A,B,C,D,E, K2);
+	ROUND_MIX(F2, E,A,B,C,D, K2);
+	ROUND_MIX(F2, D,E,A,B,C, K2);
+	ROUND_MIX(F2, C,D,E,A,B, K2);
+	ROUND_MIX(F2, B,C,D,E,A, K2);
+
+	ROUND_MIX(F2, A,B,C,D,E, K2);
+	ROUND_MIX(F2, E,A,B,C,D, K2);
+	ROUND_MIX(F2, D,E,A,B,C, K2);
+	ROUND_MIX(F2, C,D,E,A,B, K2);
+	ROUND_MIX(F2, B,C,D,E,A, K2);
+
+	ROUND_MIX(F2, A,B,C,D,E, K2);
+	ROUND_MIX(F2, E,A,B,C,D, K2);
+	ROUND_MIX(F2, D,E,A,B,C, K2);
+	ROUND_MIX(F2, C,D,E,A,B, K2);
+	ROUND_MIX(F2, B,C,D,E,A, K2);
+
+	ROUND_MIX(F2, A,B,C,D,E, K2);
+	ROUND_MIX(F2, E,A,B,C,D, K2);
+	ROUND_MIX(F2, D,E,A,B,C, K2);
+	ROUND_MIX(F2, C,D,E,A,B, K2);
+	ROUND_MIX(F2, B,C,D,E,A, K2);
+
+	ROUND_MIX(F3, A,B,C,D,E, K3);
+	ROUND_MIX(F3, E,A,B,C,D, K3);
+	ROUND_MIX(F3, D,E,A,B,C, K3);
+	ROUND_MIX(F3, C,D,E,A,B, K3);
+	ROUND_MIX(F3, B,C,D,E,A, K3);
+
+	ROUND_MIX(F3, A,B,C,D,E, K3);
+	ROUND_MIX(F3, E,A,B,C,D, K3);
+	ROUND_MIX(F3, D,E,A,B,C, K3);
+	ROUND_MIX(F3, C,D,E,A,B, K3);
+	ROUND_MIX(F3, B,C,D,E,A, K3);
+
+	ROUND_MIX(F3, A,B,C,D,E, K3);
+	ROUND_MIX(F3, E,A,B,C,D, K3);
+	ROUND_MIX(F3, D,E,A,B,C, K3);
+	ROUND_MIX(F3, C,D,E,A,B, K3);
+	ROUND_MIX(F3, B,C,D,E,A, K3);
+
+	ROUND_MIX(F3, A,B,C,D,E, K3);
+	ROUND_MIX(F3, E,A,B,C,D, K3);
+	ROUND_MIX(F3, D,E,A,B,C, K3);
+	ROUND_MIX(F3, C,D,E,A,B, K3);
+	ROUND_MIX(F3, B,C,D,E,A, K3);
+
+	ROUND_MIX(F2, A,B,C,D,E, K4);
+	ROUND_MIX(F2, E,A,B,C,D, K4);
+	ROUND_MIX(F2, D,E,A,B,C, K4);
+	ROUND_MIX(F2, C,D,E,A,B, K4);
+	ROUND_MIX(F2, B,C,D,E,A, K4);
+
+	ROUND_MIX(F2, A,B,C,D,E, K4);
+	ROUND_MIX(F2, E,A,B,C,D, K4);
+	ROUND_MIX(F2, D,E,A,B,C, K4);
+	ROUND_MIX(F2, C,D,E,A,B, K4);
+	ROUND_MIX(F2, B,C,D,E,A, K4);
+
+	ROUND_MIX(F2, A,B,C,D,E, K4);
+	ROUND_MIX(F2, E,A,B,C,D, K4);
+	ROUND_MIX(F2, D,E,A,B,C, K4);
+	ROUND_MIX(F2, C,D,E,A,B, K4);
+	ROUND_MIX(F2, B,C,D,E,A, K4);
+
+	ROUND_MIX(F2, A,B,C,D,E, K4);
+	ROUND_MIX(F2, E,A,B,C,D, K4);
+	ROUND_LAST(F2, D,E,A,B,C, K4, 0);
+	ROUND_LAST(F2, C,D,E,A,B, K4, 4);
+	ROUND_LAST(F2, B,C,D,E,A, K4, 8);
+
+	addl	$77*4,%esp
+
+	movl	20(%esp),T
+
+	addl	A,  (T)
+	addl	B, 4(T)
+	addl	C, 8(T)
+	addl	D,12(T)
+	addl	E,16(T)
+
+	popl	%edi
+	popl	%esi
+	popl	%ebx
+	popl	%ebp
+
+	ret
+
+	.size	shaHashBlock, .-shaHashBlock
--- /dev/null	2006-04-13 05:29:14.000000000 -0400
+++ sha1asm.h	2006-06-23 10:24:35.578683250 -0400
@@ -0,0 +1,12 @@
+#include <stdint.h>
+#include <stddef.h>	/* For size_t */
+
+typedef struct sha_ctx {
+  uint32_t hash[5];
+  uint32_t data[16];
+  uint32_t sizeL, sizeH;
+} SHA_CTX;
+
+void SHA1_Init(SHA_CTX *ctx);
+void SHA1_Update(SHA_CTX *ctx, const void *dataIn, size_t len);
+void SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx);
--- /dev/null	2006-04-13 05:29:14.000000000 -0400
+++ sha1asm.c	2006-06-23 10:25:26.798757250 -0400
@@ -0,0 +1,163 @@
+
+#include <string.h>	/* For memcpy */
+#include <arpa/inet.h>	/* For htonl */
+
+#include "sha1asm.h"
+
+#if ASM
+extern void shaHashBlock(SHA_CTX *ctx, uint32_t const *input);
+#else
+
+/* 
+ * This chunk of this file are subject to the Mozilla Public
+ * License Version 1.1 (the "License"); you may not use this file
+ * except in compliance with the License. You may obtain a copy of
+ * the License at http://www.mozilla.org/MPL/
+ * 
+ * Software distributed under the License is distributed on an "AS
+ * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+ * implied. See the License for the specific language governing
+ * rights and limitations under the License.
+ * 
+ * The Original Code is SHA 180-1 Reference Implementation (Compact version)
+ * 
+ * The Initial Developer of the Original Code is Paul Kocher of
+ * Cryptography Research.  Portions created by Paul Kocher are 
+ * Copyright (C) 1995-9 by Cryptography Research, Inc.  All
+ * Rights Reserved.
+ * 
+ * Contributor(s):
+ *
+ *     Paul Kocher
+ * 
+ * Alternatively, this portion of this file may be used under the
+ * terms of the GNU General Public License Version 2 or later (the
+ * "GPL"), in which case the provisions of the GPL are applicable 
+ * instead of those above.  If you wish to allow use of your 
+ * version of this file only under the terms of the GPL and not to
+ * allow others to use your version of this file under the MPL,
+ * indicate your decision by deleting the provisions above and
+ * replace them with the notice and other provisions required by
+ * the GPL.  If you do not delete the provisions above, a recipient
+ * may use your version of this file under either the MPL or the
+ * GPL.
+ */
+
+#define ROTL(X,n) (((X) << (n)) | ((X) >> (32-(n))))
+
+static void
+shaHashBlock(SHA_CTX *ctx, uint32_t const *input)
+{
+	int i;
+	uint32_t A,B,C,D,E,T;
+	uint32_t W[80];
+
+	for (i = 0; i < 16; i++)
+		W[i] = ntohl(input[i]);
+	for (i = 16; i < 80; i++) {
+		T = W[i-3] ^ W[i-8] ^ W[i-14] ^ W[i-16];
+		W[i] = ROTL(T, 1);
+	}
+
+	A = ctx->hash[0];
+	B = ctx->hash[1];
+	C = ctx->hash[2];
+	D = ctx->hash[3];
+	E = ctx->hash[4];
+
+	for (i = 0; i < 20; i++) {
+		T = ROTL(A,5) + (((C^D)&B)^D)     + E + W[i] + 0x5a827999;
+		E = D; D = C; C = ROTL(B, 30); B = A; A = T;
+	}
+	for (i = 20; i < 40; i++) {
+		T = ROTL(A,5) + (B^C^D)           + E + W[i] + 0x6ed9eba1;
+		E = D; D = C; C = ROTL(B, 30); B = A; A = T;
+	}
+	for (i = 40; i < 60; i++) {
+		T = ROTL(A,5) + (B&C) + (D&(B^C)) + E + W[i] + 0x8f1bbcdc;
+		E = D; D = C; C = ROTL(B, 30); B = A; A = T;
+	}
+	for (i = 60; i < 80; i++) {
+		T = ROTL(A,5) + (B^C^D)           + E + W[i] + 0xca62c1d6;
+		E = D; D = C; C = ROTL(B, 30); B = A; A = T;
+	}
+
+	ctx->hash[0] += A;
+	ctx->hash[1] += B;
+	ctx->hash[2] += C;
+	ctx->hash[3] += D;
+	ctx->hash[4] += E;
+}
+#endif
+
+/*
+ * The following part of the file is NOT subject to the above license, and is
+ * instead placed in the public domain.
+ */
+
+void
+SHA1_Init(SHA_CTX *ctx)
+{
+  /* Initialize H with the magic constants (see FIPS180 for constants)
+   */
+  ctx->hash[0] = 0x67452301;
+  ctx->hash[1] = 0xefcdab89;
+  ctx->hash[2] = 0x98badcfe;
+  ctx->hash[3] = 0x10325476;
+  ctx->hash[4] = 0xc3d2e1f0;
+
+  ctx->sizeH = ctx->sizeL = 0;
+}
+
+void
+SHA1_Update(SHA_CTX *ctx, const void *data, size_t len)
+{
+	unsigned pos = ctx->sizeL % 64;
+
+	ctx->sizeL += len;
+	ctx->sizeH += (ctx->sizeL < (uint32_t)len);
+	ctx->sizeH += len >> 16 >> 16;	/* In case size_t is 64 bits */
+
+	/* Leading partial block */
+	if (pos) {
+		unsigned avail = 64 - pos;
+		if (avail > len)
+			goto end;
+		memcpy((char *)ctx->data + pos, data, avail);
+		data = (char const *)data + avail;
+		len -= avail;
+		shaHashBlock(ctx, ctx->data);
+	}
+	/* Full blocks */
+	while (len >= 64) {
+		shaHashBlock(ctx, data);
+		data = (char const *)data + 64;
+		len -= 64;
+	}
+	pos = 0;
+end:
+	/* Buffer trailing partial block */
+	memcpy((char *)ctx->data + pos, data, len);
+}
+
+void
+SHA1_Final(unsigned char hashout[20], SHA_CTX *ctx)
+{
+  static unsigned char const padding[64] = { 0x80, 0 /* more zeros */ };
+  uint32_t sizeL = ctx->sizeL;
+  uint32_t sizeH = ctx->sizeH;
+  int i;
+
+  /* Append final padding, leaving 8 bytes free */
+  SHA1_Update(ctx, padding, 64 - ((sizeL + 8) % 64));
+  ctx->data[14] = htonl(sizeH << 3 | sizeL >> 29);
+  ctx->data[15] = htonl(sizeL << 3);
+
+  shaHashBlock(ctx, ctx->data);
+
+  for (i = 0; i < 5; i++)
+  	((uint32_t *)hashout)[i] = htonl(ctx->hash[i]);
+
+   memset(ctx, 0, sizeof *ctx);
+}
+
