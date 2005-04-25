From: linux@horizon.com
Subject: Revised PPC assembly implementation
Date: 25 Apr 2005 03:13:37 -0000
Message-ID: <20050425031337.16605.qmail@science.horizon.com>
References: <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Apr 25 05:12:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPu0h-0004I8-C9
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 05:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVDYDQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 23:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVDYDQd
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 23:16:33 -0400
Received: from science.horizon.com ([192.35.100.1]:19503 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262502AbVDYDNj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 23:13:39 -0400
Received: (qmail 16606 invoked by uid 1000); 25 Apr 2005 03:13:37 -0000
To: paulus@samba.org
In-Reply-To: <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Three changes:
- Added stack frame as per your description.
- Found two bugs.  (Cutting & pasting too fast.)  Fixed.
- Minor scheduling improvements.  More to come.

Which lead to three questions:
- Is the stack set properly now?
- Does it produce the right answer now?
- Is it any faster?

Thanks for your help!


/*
 * SHA-1 implementation for PowerPC.
 *
 * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
 */

/*
 * We roll the registers for A, B, C, D, E around on each
 * iteration; E on iteration t is D on iteration t+1, and so on.
 * We use registers 6 - 10 for this.  (Registers 27 - 31 hold
 * the previous values.)
 */
#define RA(t)	((((t)+4)%5)+6)
#define RB(t)	((((t)+3)%5)+6)
#define RC(t)	((((t)+2)%5)+6)
#define RD(t)	((((t)+1)%5)+6)
#define RE(t)	((((t)+0)%5)+6)

/* We use registers 11 - 26 for the W values */
#define W(t)	(((t)%16)+11)

/* Register 5 is used for the constant k */

/*
 * Note that, in the previous step, RC was rotated, and RA was computed.
 * So try to postpone using them, *especially* the latter.
 */

/* f(b,c,d) = "bitwise b ? c : d" = (b & c) + (~b & d) */
#define STEPD0(t)				\
	andc	%r0,RD(t),RB(t);		\
	add	%r0,%r0,W(t)
	add	RE(t),RE(t),%r0;		\
	and	%r0,RC(t),RB(t);		\
	add	%r0,%r0,%r5
	add	RE(t),RE(t),%r0;		\
	rotlwi	%r0,RA(t),5;			\
	rotlwi	RB(t),RB(t),30;			\
	add	RE(t),RE(t),%r0;

/* f(b,c,d) = b ^ c ^ d */
#define STEPD1(t)				\
	xor	%r0,RD(t),RB(t);		\
	xor	%r0,%r0,RC(t);			\
	add	%r0,%r0,W(t)
	add	RE(t),RE(t),%r0;		\
	rotlwi	%r0,RA(t),5;			\
	add	%r0,%r0,%r5
	rotlwi	RB(t),RB(t),30;			\
	add	RE(t),RE(t),%r0;

/* f(b,c,d) = majority(b,c,d) = (b & d) + (c & (b ^ d)) */
#define STEPD2(t)				\
	and	%r0,RD(t),RB(t);		\
	add	%r0,%r0,W(t)
	add	RE(t),RE(t),%r0;		\
	xor	%r0,RD(t),RB(t);		\
	and	%r0,%r0,RC(t);			\
	add	RE(t),RE(t),%r0;		\
	rotlwi	%r0,RA(t),5;			\
	add	%r0,%r0,%r5
	rotlwi	RB(t),RB(t),30;			\
	add	RE(t),RE(t),%r0;

#define LOADW(t)				\
	lwz	W(t),(t)*4(%r4)

#define UPDATEW(t)				\
	xor	%r0,W((t)-3),W((t)-8);		\
	xor	W(t),W((t)-16),W((t)-14);	\
	xor	W(t),W(t),%r0;			\
	rotlwi	W(t),W(t),1

#define STEP0LD4(t)				\
	STEPD0(t);     LOADW((t)+4);		\
	STEPD0((t)+1); LOADW((t)+5);		\
	STEPD0((t)+2); LOADW((t)+6);		\
	STEPD0((t)+3); LOADW((t)+7)

#define STEPUP4(t, fn)				\
	STEP##fn(t);     UPDATEW((t)+4);	\
	STEP##fn((t)+1); UPDATEW((t)+5);	\
	STEP##fn((t)+2); UPDATEW((t)+6);	\
	STEP##fn((t)+3); UPDATEW((t)+7)

#define STEPUP20(t, fn)				\
	STEPUP4(t, fn);				\
	STEPUP4((t)+4, fn);			\
	STEPUP4((t)+8, fn);			\
	STEPUP4((t)+12, fn);			\
	STEPUP4((t)+16, fn)

	.globl	sha1_core
sha1_core:
	stwu	%r1,-80(%r1)
	stmw	%r13,4(%r1)

	/* Load up A - E */
	lmw	%r27,0(%r3)

	mtctr	%r5

1:	mr	RA(0),%r27
	LOADW(0)
	mr	RB(0),%r28
	LOADW(1)
	mr	RC(0),%r29
	LOADW(2)
	mr	RD(0),%r30
	LOADW(3)
	mr	RE(0),%r31

	lis	%r5,0x5a82	/* K0-19 */
	ori	%r5,%r5,0x7999
	STEP0LD4(0)
	STEP0LD4(4)
	STEP0LD4(8)
	STEPUP4(12, D0)
	STEPUP4(16, D0)

	lis	%r5,0x6ed9	/* K20-39 */
	ori	%r5,%r5,0xeba1
	STEPUP20(20, D1)

	lis	%r5,0x8f1b	/* K40-59 */
	ori	%r5,%r5,0xbcdc
	STEPUP20(40, D2)

	lis	%r5,0xca62	/* K60-79 */
	ori	%r5,%r5,0xc1d6
	STEPUP4(60, D1)
	STEPUP4(64, D1)
	STEPUP4(68, D1)
	STEPUP4(72, D1)
	STEPD1(76)
	STEPD1(77)
	STEPD1(78)
	STEPD1(79)

	/* Add results to original values */
	add	%r27,%r27,RA(0)
	add	%r28,%r28,RB(0)
	add	%r29,%r29,RC(0)
	add	%r30,%r30,RD(0)
	add	%r31,%r31,RE(0)

	addi	%r4,%r4,64
	bdnz	1b

	/* Save final hash, restore registers, and return */
	stmw	%r27,0(%r3)
	lmw	%r13,4(%r1)
	addi	%r1,%r1,80
	blr
