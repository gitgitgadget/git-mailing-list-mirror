From: linux@horizon.com
Subject: Re: Fixed PPC SHA1
Date: 22 Jun 2006 20:54:56 -0400
Message-ID: <20060623005456.21460.qmail@science.horizon.com>
References: <20060623000908.9370.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jun 23 05:04:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftby0-00061P-0k
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 05:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWFWDER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 23:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWFWDER
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 23:04:17 -0400
Received: from science.horizon.com ([192.35.100.1]:61517 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751015AbWFWDEQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 23:04:16 -0400
Received: (qmail 21461 invoked by uid 1000); 22 Jun 2006 20:54:56 -0400
To: git@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060623000908.9370.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22396>

Here's the lwsi-based version that's slightly faster on a G5, but slightly
slower on a G4.

/*
 * SHA-1 implementation for PowerPC.
 *
 * Copyright (C) 2005 Paul Mackerras <paulus@samba.org>
 */

/*
 * PowerPC calling convention:
 * %r0 - volatile temp
 * %r1 - stack pointer.
 * %r2 - reserved
 * %r3-%r12 - Incoming arguments & return values; volatile.
 * %r13-%r31 - Callee-save registers
 * %lr - Return address, volatile
 * %ctr - volatile
 *
 * Register usage in this routine:
 * %r0 - temp
 * %r3 - argument (pointer to 5 words of SHA state)
 * %r4 - argument (pointer to data to hash)
 * %r5-%r20 - Data being hashed W[]. (%r5 is initially count of blocks)
 * %r21 - Contant K in SHA round
 * %r22-%r26 - Working copies of SHA variables A..E (actually E..A order) 
 * %r27-%r31 - Previous copies of A..E, for final add back.
 * %ctr - loop count (copied from %r5 argument)
 *
 * It's also worth mentioning that PPC assembly accept a bare
 * number as a register specifier; the "%r" prefix is actually optional.
 * And that number cna be an expression!  That simplifies the
 * loop unrolling significantly.
 */

/*
 * We roll the registers for A, B, C, D, E around on each
 * iteration; E on iteration t is D on iteration t+1, and so on.
 * We use registers 22 - 26 for this.  (Registers 27 - 31 hold
 * the previous values.)
 */
#define RA(t)	(((t)+4)%5+22)
#define RB(t)	(((t)+3)%5+22)
#define RC(t)	(((t)+2)%5+22)
#define RD(t)	(((t)+1)%5+22)
#define RE(t)	(((t)+0)%5+22)

/* Register 21 is used for the constant k */

/* We use registers 5 - 20 for the W values */
#define W(t)	((t)%16+5)

/*
 * The basic SHA-1 round function is:
 * E += ROTL(A,5) + F(B,C,D) + W[i] + K;  B = ROTL(B,30)
 * Then the variables are renamed: (A,B,C,D,E) = (E,A,B,C,D).
 *
 * Every 20 rounds, the function F() and the contant K changes:
 * - 20 rounds of f0(b,c,d) = "bit wise b ? c : d" =  (^b & d) + (b & c)
 * - 20 rounds of f1(b,c,d) = b^c^d = (b^d)^c
 * - 20 rounds of f2(b,c,d) = majority(b,c,d) = (b&d) + ((b^d)&c)
 * - 20 more rounds of f1(b,c,d)
 *
 * These are all scheduled for near-optimal performance on a G4.
 * The G4 is a 3-issue out-of-order machine with 3 ALUs, but it can only
 * *consider* starting the oldest 3 instructions per cycle.  So to get
 * maximum performace out of it, you have to treat it as an in-order
 * machine.  Which means interleaving the computation round t with the
 * computation of W[t+4].
 *
 * The first 16 rounds use W values loaded directly from memory, while the
 * remianing 64 use values computed from those first 16.  We preload
 * 4 values before starting, so there are three kinds of rounds:
 * - The first 12 (all f0) also load the W values from memory.
 * - The next 64 compute W(i+4) in parallel. 8*f0, 20*f1, 20*f2, 16*f1.
 * - The last 4 (all f1) do not do anything with W.
 *
 * Therefore, we have 5 different round functions:
 * STEPD0(t,s) - Perform round t
 * STEPD0_UPDATE(t,s) - Perform round t and compute W(s).  s >= 16.
 * STEPD1_UPDATE(t,s)
 * STEPD2_UPDATE(t,s)
 * STEPD1(t) - Perform round t with no load or update.
 *
 * There's also provision for inserting an instruction to start loading
 * the new K value after it's last used in the given step.
 * 
 * The G5 is more fully out-of-order, and can find the parallelism
 * by itself.  The big limit is that it has a 2-cycle ALU latency, so
 * even though it's 2-way, the code has to be scheduled as if it's
 * 4-way, which can be a limit.  To help it, we try to schedule the
 * read of RA(t) as late as possible so it doesn't stall waiting for
 * the previous round's RE(t-1), and we try to rotate RB(t) as early
 * as possible while reading RC(t) (= RB(t-1)) as late as possible.
 */

/*
 * Okay, we need a naked version of STEPD0.  It's 9 instructions.
 * Can that be done in 3 cycles, WITHOUT using W(s) as a temp?
 * NO.  So we need W(s) as a temp.  That can be arranged with some
 * clever scheduling.
 */
#define STEPD0(t,s) \
/* spare slot */      add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); \
add RE(t),RE(t),%r0;  and W(s),RC(t),RB(t); rotlwi %r0,RA(t),5;     \
add RE(t),RE(t),W(s); add %r0,%r0,%r21;     rotlwi RB(t),RB(t),30;  \
add RE(t),RE(t),%r0;

/*
 * This can execute starting with 2 out of 3 possible moduli, so it
 * does 2 rounds in 9 cycles, 4.5 cycles/round.
 */
#define STEPD0_UPDATE(t,s,loadk...) \
add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
add RE(t),RE(t),%r0;  and    %r0,RC(t),RB(t); xor    W(s),W(s),W((s)-8);      \
add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
add RE(t),RE(t),%r21; loadk; rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;     \
add RE(t),RE(t),%r0

/* Nicely optimal.  Conveniently, also the most common. */
#define STEPD1_UPDATE(t,s,loadk...) \
add RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
add RE(t),RE(t),%r21; loadk; xor %r0,%r0,RC(t);  xor W(s),W(s),W((s)-8);      \
add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1

/*
 * The naked version, no UPDATE, for the last 4 rounds.  3 cycles per.
 * We could use W(s) as a temp register, but we don't need it.
 */
#define STEPD1(t) \
                      add   RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); \
add RE(t),RE(t),%r21; xor    %r0,%r0,RC(t);   rotlwi RB(t),RB(t),30;  \
add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     /* spare slot */        \
add RE(t),RE(t),%r0

/* 5 cycles per */
#define STEPD2_UPDATE(t,s,loadk...) \
add RE(t),RE(t),W(t); and    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
add RE(t),RE(t),%r0;  xor    %r0,RD(t),RB(t); xor    W(s),W(s),W((s)-8);      \
add RE(t),RE(t),%r21; loadk; and %r0,%r0,RC(t);  xor W(s),W(s),W((s)-14);     \
add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     rotlwi W(s),W(s),1;             \
add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30

#define STEP0_LOAD4(t,s)		\
	STEPD0_LOAD(t,s);		\
	STEPD0_LOAD((t+1),(s)+1);	\
	STEPD0_LOAD((t)+2,(s)+2);	\
	STEPD0_LOAD((t)+3,(s)+3);

#define STEP0_4(t,s)		\
	STEPD0(t,s);		\
	STEPD0((t+1),(s)+1);	\
	STEPD0((t)+2,(s)+2);	\
	STEPD0((t)+3,(s)+3);

#define STEP1_4(t)		\
	STEPD1(t);		\
	STEPD1((t+1));		\
	STEPD1((t)+2);		\
	STEPD1((t)+3);

#define STEPUP4(fn, t, s, loadk...)		\
	STEP##fn##_UPDATE(t,s,);		\
	STEP##fn##_UPDATE((t)+1,(s)+1,);	\
	STEP##fn##_UPDATE((t)+2,(s)+2,);	\
	STEP##fn##_UPDATE((t)+3,(s)+3,loadk)

#define STEPUP20(fn, t, s, loadk...)	\
	STEPUP4(fn, t, s,);		\
	STEPUP4(fn, (t)+4, (s)+4,);	\
	STEPUP4(fn, (t)+8, (s)+8,);	\
	STEPUP4(fn, (t)+12, (s)+12,);	\
	STEPUP4(fn, (t)+16, (s)+16, loadk)

	.globl	sha1_core
sha1_core:
	stwu	%r1,-80(%r1)
	stmw	%r13,4(%r1)

	/* Load up A - E */
	lmw	%r27,0(%r3)

	mtctr	%r5

1:
	lswi	W(0),%r4,32
	lis	%r21,0x5a82
	addi	%r4,%r4,32
	mr	RE(0),%r31
	mr	RD(0),%r30
	mr	RC(0),%r29
	ori	%r21,%r21,0x7999	/* K0-19 */
	mr	RB(0),%r28
	mr	RA(0),%r27

	STEP0_4(0, 8)
	STEP0_4(4, 12)
	lswi	W(8),%r4,32
	STEPUP4(D0, 8, 16,)
	STEPUP4(D0, 12, 20,)
	STEPUP4(D0, 16, 24, lis %r21,0x6ed9)

	ori	%r21,%r21,0xeba1	/* K20-39 */
	STEPUP20(D1, 20, 28, lis %r21,0x8f1b)

	ori	%r21,%r21,0xbcdc	/* K40-59 */
	STEPUP20(D2, 40, 48, lis %r21,0xca62)

	ori	%r21,%r21,0xc1d6	/* K60-79 */
	STEPUP4(D1, 60, 68,)
	STEPUP4(D1, 64, 72,)
	STEPUP4(D1, 68, 76,)
	addi	%r4,%r4,32
	STEP1_4(72);
	STEP1_4(76);

	/* Add results to original values */
	add	%r31,%r31,RE(0)
	add	%r30,%r30,RD(0)
	add	%r29,%r29,RC(0)
	add	%r28,%r28,RB(0)
	add	%r27,%r27,RA(0)

	bdnz	1b

	/* Save final hash, restore registers, and return */
	stmw	%r27,0(%r3)
	lmw	%r13,4(%r1)
	addi	%r1,%r1,80
	blr
