From: "George Spelvin" <linux@horizon.com>
Subject: x86 SHA1: Faster than OpenSSL
Date: 2 Aug 2009 23:47:41 -0400
Message-ID: <20090803034741.23415.qmail@science.horizon.com>
References: <20090731104602.15375.qmail@science.horizon.com>
Cc: appro@fy.chalmers.se, appro@openssl.org, linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 05:48:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXoWr-0001XD-IX
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 05:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbZHCDrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 23:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbZHCDrq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 23:47:46 -0400
Received: from science.horizon.com ([71.41.210.146]:32522 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752019AbZHCDrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 23:47:45 -0400
Received: (qmail 23416 invoked by uid 1000); 2 Aug 2009 23:47:41 -0400
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124681>

(Work in progress, state dump to mailing list archives.)

This started when discussing git startup overhead due to the dynamic
linker.  One big contributor is the openssl library, which is used only
for its optimized x86 SHA-1 implementation.  So I took a look at it,
with an eye to importing the code directly into the git source tree,
and decided that I felt like trying to do better.

The original code was excellent, but it was optimized when the P4 was new.
After a bit of tweaking, I've inflicted a slight (1.4%) slowdown on the
P4, but a small-but-noticeable speedup on a variety of other processors.

Before      After       Gain    Processor
1.585248    1.353314	+17%	2500 MHz Phenom
3.249614    3.295619	-1.4%	1594 MHz P4
1.414512    1.352843	+4.5%	2.66 GHz i7
3.460635    3.284221	+5.4%	1596 MHz Athlon XP
4.077993    3.891826	+4.8%	1144 MHz Athlon
1.912161    1.623212	+17%	2100 MHz Athlon 64 X2
2.956432    2.940210	+0.55%	1794 MHz Mobile Celeron (fam 15 model 2)

(Seconds to hash 500x 1 MB, best of 10 runs in all cases.)

This is based on Andy Polyakov's GPL/BSD licensed cryptogams code, and
(for now) uses the same perl preprocessor.   To test it, do the following:
- Download Andy's original code from
  http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz
- "tar xz cryptogams-0.tar.gz"
- "cd cryptogams-0/x86"
- "patch < this_email" to create "sha1test.c", "sha1-586.h", "Makefile",
   and "sha1-x86.pl".
- "make" 
- Run ./586test (before) and ./x86test (after) and note the timings.

The code is currenty only the core SHA transform.  Adding the appropriate
init/uodate/finish wrappers is straightforward.

An open question is how to add appropriate CPU detection to the git
build scripts.  (Note that `uname -m`, which it currently uses to select
the ARM code, does NOT produce the right answer if you're using a 32-bit
compiler on a 64-bit platform.)

I try to explain it in the comments, but with all the software pipelining
that makes the rounds overlap (and there are at least 4 different kinds
of rounds, which overlap with each other), it's a bit intricate.  If you
feel really masochistic, make commenting suggestions...

--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ Makefile	2009-08-02 06:44:44.000000000 -0400
@@ -0,0 +1,16 @@
+CC := gcc
+CFLAGS := -m32 -W -Wall -Os -g
+ASFLAGS := --32
+
+all: 586test x86test
+
+586test : sha1test.c sha1-586.o
+	$(CC) $(CFLAGS) -o $@ sha1test.c sha1-586.o
+
+x86test : sha1test.c sha1-x86.o
+	$(CC) $(CFLAGS) -o $@ sha1test.c sha1-x86.o
+
+586test x86test : sha1-586.h
+
+%.s : %.pl x86asm.pl x86unix.pl
+	perl $< elf > $@
--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ sha1-586.h	2009-08-02 06:44:17.000000000 -0400
@@ -0,0 +1,3 @@
+#include <stdint.h>
+
+void sha1_block_data_order(uint32_t iv[5], void const *in, unsigned len);
--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ sha1test.c	2009-08-02 08:27:48.449609504 -0400
@@ -0,0 +1,85 @@
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/time.h>
+
+#include "sha1-586.h"
+
+#define SIZE 1000000
+
+#if SIZE % 64
+# error SIZE must be a multiple of 64!
+#endif
+
+static unsigned long
+timing_test(uint32_t iv[5], unsigned iter)
+{
+	unsigned i;
+	struct timeval tv0, tv1;
+	static char *p;	/* Very large buffer */
+
+	if (!p) {
+		p = malloc(SIZE);
+		if (!p) {
+			perror("malloc");
+			exit(1);
+		}
+	}
+
+	if (gettimeofday(&tv0, NULL) < 0) {
+		perror("gettimeofday");
+		exit(1);
+	}
+	for (i = 0; i < iter; i++)
+		sha1_block_data_order(iv, p, SIZE/64);
+	if (gettimeofday(&tv1, NULL) < 0) {
+		perror("gettimeofday");
+		exit(1);
+	}
+	return 1000000ul * (tv1.tv_sec-tv0.tv_sec) + tv1.tv_usec-tv0.tv_usec;
+}
+
+int
+main(void)
+{
+	uint32_t iv[5] = {
+		0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0
+	};
+	/* Simplest known-answer test, "abc" */
+	static uint8_t const testbuf[64] = {
+		'a','b','c', 0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 24
+	};
+	/* Expected: A9993E364706816ABA3E25717850C26C9CD0D89D */
+	static uint32_t const expected[5] = {
+		0xa9993e36, 0x4706816a, 0xba3e2571, 0x7850c26c, 0x9cd0d89d };
+	unsigned i;
+	unsigned long min_usec = -1ul;
+
+	/* quick correct-answer test.  silent unless successful. */
+	sha1_block_data_order(iv, testbuf, 1);
+	for (i = 0; i < 5; i++) {
+		if (iv[i] != expected[i]) {
+			printf("Result:  %08x %08x %08x %08x %08x\n"
+			       "Expected:%08x %08x %08x %08x %08x\n",
+				iv[0], iv[1], iv[2], iv[3], iv[4], expected[0],
+				expected[1], expected[2], expected[3],
+				expected[4]);
+			break;
+		}
+	}
+
+	for (i = 0; i < 10; i++) {
+		unsigned long usec = timing_test(iv, 500);
+		printf("%2u/10: %u.%06u s\n", i+1, (unsigned)(usec/1000000),
+			(unsigned)(usec % 1000000));
+		if (usec < min_usec)
+			min_usec = usec;
+	}
+	printf("Minimum time to hash %u bytes: %u.%06u\n", 
+		500 * SIZE, (unsigned)(min_usec/1000000),
+		(unsigned)(min_usec % 1000000));
+	return 0;
+}
--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ sha1-x86.pl	2009-08-02 08:51:01.069614130 -0400
@@ -0,0 +1,389 @@
+#!/usr/bin/env perl
+
+# ====================================================================
+# [Re]written by Andy Polyakov <appro@fy.chalmers.se> for the OpenSSL
+# project. The module is, however, dual licensed under OpenSSL and
+# CRYPTOGAMS licenses depending on where you obtain it. For further
+# details see http://www.openssl.org/~appro/cryptogams/.
+# ====================================================================
+
+# "[Re]written" was achieved in two major overhauls. In 2004 BODY_*
+# functions were re-implemented to address P4 performance issue [see
+# commentary below], and in 2006 the rest was rewritten in order to
+# gain freedom to liberate licensing terms.
+
+# It was noted that Intel IA-32 C compiler generates code which
+# performs ~30% *faster* on P4 CPU than original *hand-coded*
+# SHA1 assembler implementation. To address this problem (and
+# prove that humans are still better than machines:-), the
+# original code was overhauled, which resulted in following
+# performance changes:
+#
+#		compared with original	compared with Intel cc
+#		assembler impl.		generated code
+# Pentium	-16%			+48%
+# PIII/AMD	+8%			+16%
+# P4		+85%(!)			+45%
+#
+# As you can see Pentium came out as looser:-( Yet I reckoned that
+# improvement on P4 outweights the loss and incorporate this
+# re-tuned code to 0.9.7 and later.
+# ----------------------------------------------------------------
+#					<appro@fy.chalmers.se>
+
+$0 =~ m/(.*[\/\\])[^\/\\]+$/; $dir=$1;
+push(@INC,"${dir}","${dir}../../perlasm");
+require "x86asm.pl";
+
+&asm_init($ARGV[0],"sha1-586.pl",$ARGV[$#ARGV] eq "386");
+
+$A="eax";
+$B="ebx";
+$C="ecx";
+$D="edx";
+$E="ebp";
+
+# Two temporaries
+$S="edi";
+$T="esi";
+
+# The round constants
+use constant K1 => 0x5a827999;
+use constant K2 => 0x6ED9EBA1;
+use constant K3 => 0x8F1BBCDC;
+use constant K4 => 0xCA62C1D6;
+
+# Given unlimited registers and functional units, it would be possible to
+# compute SHA-1 at two cycles per round, using 7 operations per round.
+# Remember, each round computes a new value for E, which is used as A
+# in the following round and B in the round after that.  There are two
+# critical paths:
+# - A must be rotated and added to the output E (2 cycles between rounds)
+# - B must go through two boolean operations before being added to
+#   the result E.  Since this latter addition can't be done in the
+#   same-cycle as the critical addition of a<<<5, this is a total of
+#   2+1+1 = 4 cycles per 2 rounds.
+# Additionally, if you want to avoid copying B, you have to rotate it
+# soon after use in this round so it is ready for use as the following
+# round's C.
+
+# e += (a <<< 5) + K + in[i] + (d^(b&(c^d)))		(0..19)
+# e += (a <<< 5) + K + in[i] + (b^c^d)			(20..39, 60..79)
+# e += (a <<< 5) + K + in[i] + (c&d) + (b&(c^d))	(40..59)
+#
+# The hard part is doing this with only two temporary registers.
+# Taking the most complex F(b,c,d) function, writing it as above
+# breaks it into two parts which can be accumulated into e separately.
+# Let's divide it into 4 parts.  These can be executed in a 7-cycle
+# loop, assuming an in-order triple issue machine
+# (quadruple counting xor-from-memory as 2):
+#
+#	in[i]		F1(c,d)		F2(b,c,d)	a<<<5
+#	mov in[i],T			(addl S,A)	(movl B,S)
+#	xor in[i+1],T					(rorl 5,S)
+#	xor in[i+2],T	movl D,S			(addl S,A)
+#	xor in[i+3],T	andl C,S
+#	rotl 1,T	addl S,E	movl D,S
+#	movl T,in[i]			xorl C,S
+#	addl T+K,E			andl B,S	rorl 2,B	//
+#	(mov in[i],T)			addl S,E	movl A,S
+#	(xor in[i+1],T)					rorl 5,S
+#	(xor in[i+2],T)	(movl C,S)			addl S,E
+#
+# In the above, we routinely read and write a register on the same cycle,
+# overlapping the beginning of one computation with the end of another.
+# I've tried to place the reads to the left of the writes, but some of the
+# overlapping operations from adjacent rounds (given in parentheses)
+# violate that.
+#
+# The "addl T+K,E" line is actually implemented using the lea instruction,
+# which (on a Pentium) requires that neither T not K was modified on the
+# previous cycle.
+#
+# As you can see, in the absence of out-of-order execution, the first
+# column takes a minimum of 6 cycles (fetch, 3 XORs, rotate, add to E),
+# and I reserve a seventh cycle before the add to E so that I can use a
+# Pentium's lea instruction.
+#
+# The other three columns take 3, 4 and 3 cycles, respectively.
+# These can all be overlapped by 1 cycle assuming a superscalar
+# processor, for a total of 2+2+3 = 7 cycles.
+#
+# The other F() functions require 5 and 4 cycles, respectively.
+# overlapped with the 3-cycle a<<<5 computation, that makes a total of 6
+# and 5 cycles, respectively.  If we overlap the beginning and end of the
+# Xi computation, we can get it down to 6 cycles, but below that, we'll
+# just have to waste a cycle.
+#
+# For the first 16 rounds, forming Xi is just a fetch, and the F()
+# function only requires 5 cycles, so the whole round can be pulled in
+# to 4 cycles.
+
+
+# Atom pairing rules (not yet optimized):
+# The Atom has a dial-issue in-order pipeline, similar to the
+# original Pentium.  However, the issue restrictions are different.
+# In particular, all memory source operations must use st use port 0,
+# as must all rotates.
+#
+# Given that a round uses 4 fetches and 3 rotates, that's going to
+# require significant care to pair well.  It may take a completely
+# different implementation.
+#
+# LEA must use port 1, but apparently it has even worse address generation
+# interlock latency than the Pentium.  Oh well, it's still the best way
+# to do a 3-way add with a 32-bit immediate.
+
+
+# The first 16 rounds use s simple simplest F(b,c,d) = d^(b&(c^d)), and
+# don't need to form the in[i] equation, letting us reduce the round to
+# 4 cycles, after some reassignment of temporaries:
+
+#			movl D,S	(roll 5,T)	(addl S,A)	//
+#	mov in[i],T	xorl C,S	(addl T,A)
+#			andl B,S			rorl 2,B
+#	addl T+K,E	xorl D,S	movl A,T
+#			addl S,E	roll 5,T	(movl C,S)	//
+#	(mov in[i],T)	(xorl B,S)	addl T,E	
+
+# The // mark where the round function starts.  Each round expects the
+# first copy of D to S to have been done already.
+
+# The transition between rounds 15 and 16 is a bit tricky... the best
+# thing to do is to delay the computation of a<<<5 one cycle and move it back
+# to the S register.  That way, T is free as early as possible.
+#	in[i]		F(b,c,d)	a<<<5
+#	(addl T+K,A)	(xorl E,S)	(movl B,T)
+#			movl D,S	(roll 5,T)	(addl S,A)	//
+#	mov in[i],T	xorl C,S	(addl T,A)
+#			andl B,S			rorl 2,B
+#	addl T+K,E 	xorl D,S			(movl in[1],T)
+#	(xor in[i+1],T)	addl S,E	movl A,S
+#	(xor in[i+2],T)	rorl 2,B	roll 5,S	//
+#	(xor in[i+3],T)	(movl C,S)	addl S,E
+
+sub BODY_00_15
+{
+	local($n,$a,$b,$c,$d,$e)=@_;
+
+	&comment("00_15 $n");
+		&mov($S,$d) if ($n == 0);
+	&mov($T,&swtmp($n%16));		#  V Load Xi.
+		&xor($S,$c);		# U  Continue F() = d^(b&(c^d))
+		&and($S,$b);		#  V
+			&rotr($b,2);	# NP
+	&lea($e,&DWP(K1,$e,$T));	# U  Add Xi and K
+    if ($n < 15) {
+			&mov($T,$a);	#  V
+		&xor($S,$d);		# U 
+			&rotl($T,5);	# NP
+		&add($e,$S);		# U 
+		&mov($S,$c);		#  V Start of NEXT round's F()
+			&add($e,$T);	# U 
+    } else {
+	# This version provides the correct start for BODY_20_39
+		&xor($S,$d);		#  V
+	&mov($T,&swtmp(($n+1)%16));	# U  Start computing mext Xi.
+		&add($e,$S);		#  V Add F()
+			&mov($S,$a);	# U  Start computing a<<<5
+	&xor($T,&swtmp(($n+3)%16));	#  V
+			&rotl($S,5);	# U 
+	&xor($T,&swtmp(($n+9)%16));	#  V
+    }
+}
+
+
+# A full round using F(b,c,d) = b^c^d.  6 cycles of dependency chain.
+# This starts just before starting to compute F(); the Xi should have XORed
+# the first three values together.  (Break is at //)
+#
+#	in[i]		F(b,c,d)	a<<<5
+#	mov in[i],T	(xorl E,S)			(addl T+K,A)
+#	xor in[i+1],T	(addl S,A)	(movl B,S)
+#	xor in[i+2],T			(roll 5,S)	//
+#	xor in[i+3],T 	movl D,S  	(addl S,A)
+#	roll 1,T	xorl C,S
+#	movl T,in[i]	andl B,S			rorl 2,B
+#	addl T+K,E 	xorl D,S			(mov in[i],T)
+#	(xor in[i+1],T)	addl S,E	movl A,S
+#	(xor in[i+2],T)			roll 5,S	//
+#	(xor in[i+3],T)	(movl C,S)	addl S,E
+
+sub BODY_16_19
+{
+	local($n,$a,$b,$c,$d,$e)=@_;
+
+	&comment("16_19 $n");
+
+	&xor($T,&swtmp(($n+13)%16));	# U 
+			&add($a,$S);	#  V End of previous round
+		&mov($S,$d);		# U  Start current round's F()
+	&rotl($T,1);			#  V
+		&xor($S,$c);		# U 
+	&mov(&swtmp($n%16),$T);		# U Store computed Xi.
+		&and($S,$b);		#  V
+		&rotr($b,2);		# NP
+	&lea($e,&DWP(K1,$e,$T));	# U  Add Xi and K
+	&mov($T,&swtmp(($n+1)%16));	#  V Start computing mext Xi.
+		&xor($S,$d);		# U
+	&xor($T,&swtmp(($n+3)%16));	#  V
+		&add($e,$S);		# U  Add F()
+			&mov($S,$a);	#  V Start computing a<<<5
+	&xor($T,&swtmp(($n+9)%16));	# U
+			&rotl($S,5);	# NP
+}
+
+# This is just like BODY_16_19, but computes a different F() = b^c^d
+#
+#	in[i]		F(b,c,d)	a<<<5
+#	mov in[i],T	(xorl E,S)			(addl T+K,A)
+#	xor in[i+1],T	(addl S,A)	(movl B,S)
+#	xor in[i+2],T			(roll 5,S)	//
+#	xor in[i+3],T 			(addl S,A)
+#	roll 1,T	movl D,S
+#	movl T,in[i]	xorl B,S			rorl 2,B
+#	addl T+K,E 	xorl C,S			(mov in[i],T)
+#	(xor in[i+1],T)	addl S,E	movl A,S
+#	(xor in[i+2],T)			roll 5,S	//
+#	(xor in[i+3],T)	(movl C,S)	addl S,E
+
+sub BODY_20_39	# And 61..79
+{
+	local($n,$a,$b,$c,$d,$e)=@_;
+	local $K=($n<40) ? K2 : K4;
+
+	&comment("20_39 $n");
+
+	&xor($T,&swtmp(($n+13)%16));	# U 
+			&add($a,$S);	#  V End of previous round
+	&rotl($T,1);			# U
+		&mov($S,$d);		#  V Start current round's F()
+	&mov(&swtmp($n%16),$T) if ($n < 77);	# Store computed Xi.
+		&xor($S,$b);		#  V
+		&rotr($b,2);		# NP
+	&lea($e,&DWP($K,$e,$T));	# U  Add Xi and K
+	&mov($T,&swtmp(($n+1)%16)) if ($n < 79); # Start computing next Xi.
+		&xor($S,$c);		# U
+	&xor($T,&swtmp(($n+3)%16)) if ($n < 79);
+		&add($e,$S);		# U  Add F1()
+			&mov($S,$a);	#  V Start computing a<<<5
+	&xor($T,&swtmp(($n+9)%16)) if ($n < 79);
+			&rotl($S,5);	# NP
+
+			&add($e,$S) if ($n == 79);
+}
+
+
+# This starts immediately after the LEA, and expects to need to finish
+# the previous round. (break is at //)
+#
+#	in[i]		F1(c,d)		F2(b,c,d)	a<<<5
+#	(addl T+K,E)			(andl C,S)	(rorl 2,C)
+#	mov in[i],T			(addl S,A)	(movl B,S)
+#	xor in[i+1],T					(rorl 5,S)
+#	xor in[i+2],T /	movl D,S			(addl S,A)
+#	xor in[i+3],T	andl C,S
+#	rotl 1,T	addl S,E	movl D,S
+#	(movl T,in[i])			xorl C,S
+#	addl T+K,E			andl B,S	rorl 2,B
+#	(mov in[i],T)			addl S,E	movl A,S
+#	(xor in[i+1],T)					rorl 5,S
+#	(xor in[i+2],T)	// (movl C,S)			addl S,E
+
+sub BODY_40_59
+{
+	local($n,$a,$b,$c,$d,$e)=@_;
+
+	&comment("40_59 $n");
+
+			&add($a,$S);	#  V End of previous round
+		&mov($S,$d);		# U  Start current round's F(1)
+	&xor($T,&swtmp(($n+13)%16));	#  V
+		&and($S,$c);		# U
+	&rotl($T,1);			# U	XXX Missed pairing
+		&add($e,$S);		#  V Add F1()
+		&mov($S,$d);		# U  Start current round's F2()
+	&mov(&swtmp($n%16),$T);		#  V Store computed Xi.
+		&xor($S,$c);		# U
+	&lea($e,&DWP(K3,$e,$T));	#  V
+		&and($S,$b);		# U	XXX Missed pairing
+		&rotr($b,2);		# NP
+	&mov($T,&swtmp(($n+1)%16));	# U  Start computing next Xi.
+		&add($e,$S);		#  V Add F2()
+		&mov($S,$a);		# U  Start computing a<<<5
+	&xor($T,&swtmp(($n+3)%16));	#  V
+			&rotl($S,5);	# NP
+	&xor($T,&swtmp(($n+9)%16));	# U
+}
+# The above code is NOT optimally paired for the Pentium.  (And thus,
+# presumably, Atom, which has a very similar dual-issue in-order pipeline.)
+# However, attempts to improve it make it slower on Phenom & i7.
+
+&function_begin("sha1_block_data_order",16);
+
+	local @V = ($A,$B,$C,$D,$E);
+	local @W = ($A,$B,$C);
+
+	&mov($S,&wparam(0));	# SHA_CTX *c
+	&mov($T,&wparam(1));	# const void *input
+	&mov($A,&wparam(2));	# size_t num
+	&stack_push(16);	# allocate X[16]
+	&shl($A,6);
+	&add($A,$T);
+	&mov(&wparam(2),$A);	# pointer beyond the end of input
+	&mov($E,&DWP(16,$S));# pre-load E
+	&mov($D,&DWP(12,$S));# pre-load D
+
+	&set_label("loop",16);
+
+	# copy input chunk to X, but reversing byte order!
+	&mov($W[2],&DWP(4*(0),$T));
+	&mov($W[1],&DWP(4*(1),$T));
+	&bswap($W[2]);
+	for ($i=0; $i<14; $i++) {
+		&mov($W[0],&DWP(4*($i+2),$T));
+		&bswap($W[1]);
+		&mov(&swtmp($i+0),$W[2]);
+		unshift(@W,pop(@W));
+	}
+	&bswap($W[1]);
+	&mov(&swtmp($i+0),$W[2]);
+	&mov(&swtmp($i+1),$W[1]);
+
+	&mov(&wparam(1),$T);	# redundant in 1st spin
+
+	# Reload A, B and C, which we use as temporaries in the copying
+	&mov($C,&DWP(8,$S));
+	&mov($B,&DWP(4,$S));
+	&mov($A,&DWP(0,$S));
+
+	for($i=0;$i<16;$i++)	{ &BODY_00_15($i,@V); unshift(@V,pop(@V)); }
+	for(;$i<20;$i++)	{ &BODY_16_19($i,@V); unshift(@V,pop(@V)); }
+	for(;$i<40;$i++)	{ &BODY_20_39($i,@V); unshift(@V,pop(@V)); }
+	for(;$i<60;$i++)	{ &BODY_40_59($i,@V); unshift(@V,pop(@V)); }
+	for(;$i<80;$i++)	{ &BODY_20_39($i,@V); unshift(@V,pop(@V)); }
+
+	(($V[4] eq $E) and ($V[0] eq $A)) or die;	# double-check
+
+	&comment("Loop trailer");
+
+	&mov($S,&wparam(0));	# re-load SHA_CTX*
+	&mov($T,&wparam(1));	# re-load input pointer
+
+	&add($E,&DWP(16,$S));
+	&add($D,&DWP(12,$S));
+	&add(&DWP(8,$S),$C);
+	&add(&DWP(4,$S),$B);
+	 &add($T,64);		# advance input pointer
+	&add(&DWP(0,$S),$A);
+	&mov(&DWP(12,$S),$D);
+	&mov(&DWP(16,$S),$E);
+
+	&cmp($T,&wparam(2));	# have we reached the end yet?
+	&jb(&label("loop"));
+
+	&stack_pop(16);
+&function_end("sha1_block_data_order");
+&asciz("SHA1 block transform for x86, CRYPTOGAMS by <appro\@openssl.org>");
+
+&asm_finish();
