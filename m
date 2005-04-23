From: linux@horizon.com
Subject: Re: [PATCH] PPC assembly implementation of SHA1
Date: 23 Apr 2005 12:42:46 -0000
Message-ID: <20050423124246.30071.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Apr 23 14:38:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPJtw-0004kS-Hq
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 14:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVDWMm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 08:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDWMm7
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 08:42:59 -0400
Received: from science.horizon.com ([192.35.100.1]:41261 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261561AbVDWMmr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 08:42:47 -0400
Received: (qmail 30072 invoked by uid 1000); 23 Apr 2005 12:42:46 -0000
To: paulus@samba.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I was working on the same thing, but hindered by lack of access to PPC
hardware.  I notice that you also took advantage of the unaligned load
support and native byte order to do the hash straight from the source.

But I came up with a few additional refinements:

- You are using three temporaries (%r0, %r6, and RT(x)) for your
  round functions.  You only need one temporary (%r0) for all the functions.
  (Plus %r15 for k)

  The core round function is

  e += (a <<< 5) + f(b,c,d) + W[i] + K
  b = (b <<< 30)
followed by renaming the registers for the next round:
  d += (e <<< 5) + f(a,b,c) + W[i+1] + K
  a = (a <<< 30)

That can all be computed with one temporary.

There are three possible f() functions:
f1(x,y,z) = "bitwise x ? y : z"
          = (x & y) | (~x & z)
          = (x & y) + (~x & z)
          = z ^ (x & (y ^ z))
All are three logical instrunctions on PPC.  The second form
lets you add it into the accumulator e in two pieces:

+#define STEPD0(t)				\
+	add	%r0,%r15,W(t);			\
+	add	RE(t),RE(t),%r0;		\
+	and	%r0,RC(t),RB(t);		\
+	add	RE(t),RE(t),%r0;		\
+	andc	%r0,RD(t),RB(t);		\
+	add	RE(t),RE(t),%r0;		\
+	rotlwi	%r0,RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	add	RE(t),RE(t),%r0;

The XOR version f2(x,y,z) = x^y^z is of course trivial:

+#define STEPD1(t)				\
+	add	%r0,%r15,W(t);			\
+	add	RE(t),RE(t),%r0;		\
+	xor	%r0,RC(t),RB(t);		\
+	xor	%r0,%r0,RA(t);			\
+	add	RE(t),RE(t),%r0;		\
+	rotlwi	%r0,RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	add	RE(t),RE(t),%r0;

And the last function, majority(x,y,z), can be written as:
f3(x,y,z) = (x & y) | (y & z) | (z & x)
          = (x & y) | z & (x | y)
          = (x & y) | z & (x ^ y)
          = (x & y) + z & (x ^ y)
The last form again allows evaluation with one temporary and
two adds into RE(t):

+#define STEPD2(t)				\
+	add	%r0,%r15,W(t);			\
+	add	RE(t),RE(t),%r0;		\
+	and	%r0,RC(t),RB(t);		\
+	add	RE(t),RE(t),%r0;		\
+	xor	%r0,RC(t),RB(t);		\
+	and	%r0,%r0,RA(t);			\
+	add	RE(t),RE(t),%r0;		\
+	rotlwi	%r0,RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	add	RE(t),RE(t),%r0;

Other notes:
- You don't need to decrement %r1 before saving registers.
  The PPC calling convention defines a "red zone" below the
  current stack pointer that is guaranteed never to be touched
  by signal handlers or the like.  This is specifically for
  leaf procedure optimization, and is at least 224 bytes.
- Is that many stw/lwz instructions faster than stmw/lmw?
  The latter is at least more cahce-friendly.
- You can avoid saving and restoring %r15 by recycling %r5 for that
  purpose; it's not used after the mtctr %r5.
- (Note, by the way, that while the PPC supports unaligned loads, using
  lmw to load unaligned data is SLOW onthe G5; multiple lwz instructions
  are faster in that case.)
- The above changes actually save enough registers to cache the whole hash[5]
  in registers as well, eliminating *all* unnecessary load/store traffic.

With all of the above changes, your sha1ppc.S file turns into:

diff -urN git.orig/ppc/sha1ppc.S git/ppc/sha1ppc.S
--- /dev/null	2005-04-04 12:56:19.000000000 +1000
+++ git/ppc/sha1ppc.S	2005-04-22 16:29:19.000000000 +1000
@@ -0,0 +1,142 @@
+/*
+ * SHA-1 implementation for PowerPC.
+ *
+ * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
+ */
+
+/*
+ * We roll the registers for A, B, C, D, E around on each
+ * iteration; A on iteration t is B on iteration t+1, and so on.
+ * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
+ * the previous values.)
+ */
+#define RA(t)	((((t)+4)%5)+6)
+#define RB(t)	((((t)+3)%5)+6)
+#define RC(t)	((((t)+2)%5)+6)
+#define RD(t)	((((t)+1)%5)+6)
+#define RE(t)	((((t)+0)%5)+6)
+
+/* We use registers 11 - 26 for the W values */
+#define W(t)	(((t)%16)+11)
+
+#define STEPD0(t)				\
+	add	%r0,%r5,W(t);			\
+	add	RE(t),RE(t),%r0;		\
+	and	%r0,RC(t),RB(t);		\
+	add	RE(t),RE(t),%r0;		\
+	andc	%r0,RD(t),RB(t);		\
+	add	RE(t),RE(t),%r0;		\
+	rotlwi	%r0,RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	add	RE(t),RE(t),%r0;
+
+#define STEPD1(t)				\
+	add	%r0,%r5,W(t);			\
+	add	RE(t),RE(t),%r0;		\
+	xor	%r0,RC(t),RB(t);		\
+	xor	%r0,%r0,RA(t);			\
+	add	RE(t),RE(t),%r0;		\
+	rotlwi	%r0,RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	add	RE(t),RE(t),%r0;
+
+#define STEPD2(t)				\
+	add	%r0,%r15,W(t);			\
+	add	RE(t),RE(t),%r0;		\
+	and	%r0,RC(t),RB(t);		\
+	add	RE(t),RE(t),%r0;		\
+	xor	%r0,RC(t),RB(t);		\
+	and	%r0,%r0,RA(t);			\
+	add	RE(t),RE(t),%r0;		\
+	rotlwi	%r0,RA(t),5;			\
+	rotlwi	RB(t),RB(t),30;			\
+	add	RE(t),RE(t),%r0;
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
+	STEPD0(t);     LOADW((t)+4);		\
+	STEPD0((t)+1); LOADW((t)+5);		\
+	STEPD0((t)+2); LOADW((t)+6);		\
+	STEPD0((t)+3); LOADW((t)+7)
+
+#define STEPUP4(t, fn)				\
+	STEP##fn(t);     UPDATEW((t)+4);	\
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
+	stmw	%r13,-76(%r1)
+
+	/* Load up A - E */
+	lmw	%r27,0(%r3)
+
+	mtctr	%r5
+
+1:	mr	RA(0),%r27
+	LOADW(0)
+	mr	RB(0),%r28
+	LOADW(1)
+	mr	RC(0),%r29
+	LOADW(2)
+	mr	RD(0),%r30
+	LOADW(3)
+	mr	RE(0),%r31
+
+	lis	%r5,0x5a82	/* K0-19 */
+	ori	%r5,%r5,0x7999
+	STEP0LD4(0)
+	STEP0LD4(4)
+	STEP0LD4(8)
+	STEPUP4(12, D0)
+	STEPUP4(16, D0)
+
+	lis	%r5,0x6ed9	/* K20-39 */
+	ori	%r5,%r5,0xeba1
+	STEPUP20(20, D1)
+
+	lis	%r5,0x8f1b	/* K40-59 */
+	ori	%r5,%r5,0xbcdc
+	STEPUP20(40, D2)
+
+	lis	%r5,0xca62	/* K60-79 */
+	ori	%r5,%r5,0xc1d6
+	STEPUP4(60, D1)
+	STEPUP4(64, D1)
+	STEPUP4(68, D1)
+	STEPUP4(72, D1)
+	STEPD1(76)
+	STEPD1(77)
+	STEPD1(78)
+	STEPD1(79)
+
+	/* Add results to original values */
+	add	%r27,%r27,RA(0)
+	add	%r28,%r28,RB(0)
+	add	%r29,%r29,RC(0)
+	add	%r30,%r30,RD(0)
+	add	%r31,%r31,RE(0)
+
+	addi	%r4,%r4,64
+	bdnz	1b
+
+	/* Save final hash, restore registers, and return */
+	stmw	%r27,0(%r3)
+	lmw	%r13,-76(%r1)
+	blr

The above changes, if you want them, are placed in the public domain.
It assembles, but I can't test it.  Have fun.

(I might also replace "t" with "i" in the macros, but figured that
would make comparing versions annoying.  Of course, part of the reason
was confusion with the T register, which is now eliminated...)
