From: linux@horizon.com
Subject: Re: Broken PPC sha1.. (Re: Figured out how to get Mozilla into git)
Date: 19 Jun 2006 04:41:35 -0400
Message-ID: <20060619084135.18632.qmail@science.horizon.com>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Jun 19 10:42:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsFKG-0006L3-AV
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 10:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWFSIlh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 04:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFSIlh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 04:41:37 -0400
Received: from science.horizon.com ([192.35.100.1]:64569 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751217AbWFSIlg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 04:41:36 -0400
Received: (qmail 18633 invoked by uid 1000); 19 Jun 2006 04:41:35 -0400
To: git@vger.kernel.org, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22121>

By the way, if anyone's still interested, I tried to produce a
better-scheduled PowerPC sha1 core last year.  Unfortunately, I don't have
access to a PowerPC machine to test on, so debugging is a little painful.

The latest version is appended, if anyone with a PowerPC machine wants to
try it out.  It should drop in for ppc/sha1ppc.S.  Hopefully the comments
explain the general idea.

Notes I should add to the comments:
- When reading the assembly code, note that PPC assembly permits a bare
  number (no %r prefix) as a register number, and further that number can
  be an expression!  It makes the register renaming nice and simple.

- Also for folks unfamiliar, it's dest,src,src operand order.

- For a reminder, the PowerPC calling convention is:
  %r0 - Temp.  Always reads as zero in some contexts.
  %r1 - stack pointer
  %r2 - Confusing.  Different documents say different things.
  %r3..%r10 - Incoming arguments.  Volatile across function calls.
  %r11..%r12 - Have some special uses not relevant here.  Volatile.
  %r13..%r31 - Callee-save registers.
  %lr, %ctr - Volatile.  %lr holds return address on input.

  And the way registers are used in this function are:
  %r0 - Temp.
  %r1 - Stack pointer.  Used only for register saving.
  %r2 - Not used.
  %r3 - Points to hash accumulator A..E in memory.
  %r4 - Points to data being hashed.
  %r5 - Incoming loop count.  Holds round constant K in body of loop.
  %r6..%r10 - Working copies of A..E
  %r11..%r26 - The W[] array of 16 input words being hashed
  %r27..%r31 - Start-of-round copies of A..E.
  %ctr - Holds loop count, copied from incoming %r5
  %lr - Holds return address.  Not modified.

- While I try to use the load/store multiple instructions where
  appropriate, they have a severe penalty for unaligned operands
  (they're microcoded optimistically, so do a full failing aligned
  load before being re-issued as a slow-but-safe unaligned sequence),
  and thanks to git's object type prefix, the source data is generally
  unaligned, so they're deliberately NOT used to load the 16 words of
  data hashed each iteration.

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
#define RA(t)	(((t)+4)%5+6)
#define RB(t)	(((t)+3)%5+6)
#define RC(t)	(((t)+2)%5+6)
#define RD(t)	(((t)+1)%5+6)
#define RE(t)	(((t)+0)%5+6)

/* We use registers 11 - 26 for the W values */
#define W(t)	((t)%16+11)

/* Register 5 is used for the constant k */

/*
 * There are three F functions, used four groups of 20:
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
 * Therefore, we have 6 different round functions:
 * STEPD0_LOAD(t,s) - Perform round t and load W(s).  s < 16
 * STEPD0_UPDATE(t,s) - Perform round t and compute W(s).  s >= 16.
 * STEPD1_UPDATE(t,s)
 * STEPD2_UPDATE(t,s)
 * STEPD1(t) - Perform round t with no load or update.
 * 
 * The G5 is more fully out-of-order, and can find the parallelism
 * by itself.  The big limit is that it has a 2-cycle ALU latency, so
 * even though it's 2-way, the code has to be scheduled as if it's
 * 4-way, which can be a limit.  To help it, we try to schedule the
 * read of RA(t) as late as possible so it doesn't stall waiting for
 * the previous round's RE(t-1), and we try to rotate RB(t) as early
 * as possible while reading RC(t) (= RB(t-1)) as late as possible.
 */


/* the initial loads. */
#define LOADW(s) \
	lwz	W(s),(s)*4(%r4)

/*
 * This is actually 13 instructions, which is an awkward fit,
 * and uses W(s) as a temporary before loading it.
 */
#define STEPD0_LOAD(t,s) \
add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t);  /* spare slot */        \
add RE(t),RE(t),%r0;  and    W(s),RC(t),RB(t); rotlwi %r0,RA(t),5;     \
add RE(t),RE(t),W(s); add    %r0,%r0,%r5;      rotlwi RB(t),RB(t),30;  \
add RE(t),RE(t),%r0;  lwz    W(s),(s)*4(%r4);

/*
 * This can execute starting with 2 out of 3 possible moduli, so it
 * does 2 rounds in 9 cycles, 4.5 cycles/round.
 */
#define STEPD0_UPDATE(t,s) \
add RE(t),RE(t),W(t); andc   %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
add RE(t),RE(t),%r0;  and    %r0,RC(t),RB(t); xor    W(s),W(s),W((s)-8);      \
add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
add RE(t),RE(t),%r5;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;             \
add RE(t),RE(t),%r0;

/* Nicely optimal.  Conveniently, also the most common. */
#define STEPD1_UPDATE(t,s) \
add RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
add RE(t),RE(t),%r5;  xor    %r0,%r0,RC(t);   xor    W(s),W(s),W((s)-8);      \
add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     xor    W(s),W(s),W((s)-14);     \
add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;  rotlwi W(s),W(s),1;

/*
 * The naked version, no UPDATE, for the last 4 rounds.  3 cycles per.
 * We could use W(s) as a temp register, but we don't need it.
 */
#define STEPD1(t) \
/* spare slot */        add   RE(t),RE(t),W(t); xor    %r0,RD(t),RB(t); \
rotlwi RB(t),RB(t),30;  add   RE(t),RE(t),%r5;  xor    %r0,%r0,RC(t);   \
add    RE(t),RE(t),%r0; rotlwi %r0,RA(t),5;     /* idle */              \
add    RE(t),RE(t),%r0;

/* 5 cycles per */
#define STEPD2_UPDATE(t,s) \
add RE(t),RE(t),W(t); and    %r0,RD(t),RB(t); xor    W(s),W((s)-16),W((s)-3); \
add RE(t),RE(t),%r0;  xor    %r0,RD(t),RB(t); xor    W(s),W(s),W((s)-8);      \
add RE(t),RE(t),%r5;  and    %r0,%r0,RC(t);   xor    W(s),W(s),W((s)-14);     \
add RE(t),RE(t),%r0;  rotlwi %r0,RA(t),5;     rotlwi W(s),W(s),1;             \
add RE(t),RE(t),%r0;  rotlwi RB(t),RB(t),30;

#define STEP0_LOAD4(t,s)		\
	STEPD0_LOAD(t,s);		\
	STEPD0_LOAD((t+1),(s)+1);	\
	STEPD0_LOAD((t)+2,(s)+2);	\
	STEPD0_LOAD((t)+3,(s)+3);

#define STEPUP4(fn, t, s)		\
	STEP##fn##_UPDATE(t,s);		\
	STEP##fn##_UPDATE((t)+1,(s)+1);	\
	STEP##fn##_UPDATE((t)+2,(s)+2);	\
	STEP##fn##_UPDATE((t)+3,(s)+3);	\

#define STEPUP20(fn, t, s)		\
	STEPUP4(fn, t, s);		\
	STEPUP4(fn, (t)+4, (s)+4);	\
	STEPUP4(fn, (t)+8, (s)+8);	\
	STEPUP4(fn, (t)+12, (s)+12);	\
	STEPUP4(fn, (t)+16, (s)+16)

	.globl	sha1_core
sha1_core:
	stwu	%r1,-80(%r1)
	stmw	%r13,4(%r1)

	/* Load up A - E */
	lmw	%r27,0(%r3)

	mtctr	%r5

1:
	lis	%r5,0x5a82	/* K0-19 */
	mr	RA(0),%r27
	LOADW(0)
	mr	RB(0),%r28
	LOADW(1)
	mr	RC(0),%r29
	LOADW(2)
	ori	%r5,%r5,0x7999
	mr	RD(0),%r30
	LOADW(3)
	mr	RE(0),%r31

	STEP0_LOAD4(0, 4)
	STEP0_LOAD4(4, 8)
	STEP0_LOAD4(8, 12)
	STEPUP4(D0, 12, 16)
	STEPUP4(D0, 16, 20)

	lis	%r5,0x6ed9	/* K20-39 */
	ori	%r5,%r5,0xeba1
	STEPUP20(D1, 20, 24)

	lis	%r5,0x8f1b	/* K40-59 */
	ori	%r5,%r5,0xbcdc
	STEPUP20(D2, 40, 44)

	lis	%r5,0xca62	/* K60-79 */
	ori	%r5,%r5,0xc1d6
	STEPUP4(D1, 60, 64)
	STEPUP4(D1, 64, 68)
	STEPUP4(D1, 68, 72)
	STEPUP4(D1, 72, 76)
	STEPD1(76)
	STEPD1(77)
	STEPD1(78)
	STEPD1(79)

	/* Add results to original values */
	add	%r31,%r31,RE(0)
	add	%r30,%r30,RD(0)
	add	%r29,%r29,RC(0)
	add	%r28,%r28,RB(0)
	add	%r27,%r27,RA(0)

	addi	%r4,%r4,64
	bdnz	1b

	/* Save final hash, restore registers, and return */
	stmw	%r27,0(%r3)
	lmw	%r13,4(%r1)
	addi	%r1,%r1,80
	blr
