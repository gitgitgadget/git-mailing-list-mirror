From: "George Spelvin" <linux@horizon.com>
Subject: Request for benchmarking: x86 SHA1 code
Date: 31 Jul 2009 06:46:02 -0400
Message-ID: <20090731104602.15375.qmail@science.horizon.com>
References: <20090726232154.29594.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWpdr-0000u5-AK
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbZGaKqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbZGaKqH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:46:07 -0400
Received: from science.horizon.com ([71.41.210.146]:40298 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751605AbZGaKqF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 06:46:05 -0400
Received: (qmail 15376 invoked by uid 1000); 31 Jul 2009 06:46:02 -0400
In-Reply-To: <20090726232154.29594.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124540>

After studying Andy Polyakov's optimized x86 SHA-1 in OpenSSL, I've
got a version that's 1.6% slower on a P4 and 15% faster on a Phenom.
I'm curious about the performance on other CPUs I don't have access to,
particularly Core 2 duo and i7.

Could someone do some benchmarking for me?  Old (486/Pentium/P2/P3)
machines are also interesting, but I'm optimizing for newer ones.

I haven't packaged this nicely, but it's not that complicated.
- Download Andy's original code from
  http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz
- Unpack and cd to the cryptogams-0/x86 directory
- "patch < this_email" to create "sha1test.c", "sha1-586.h", "Makefile",
   and "sha1-x86.pl".
- "make" 
- Run ./586test (before) and ./x86test (after) and note the timings.

Thank you!

--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ Makefile	2009-07-31 06:22:42.000000000 -0400
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
+++ sha1test.c	2009-07-28 09:24:09.000000000 -0400
@@ -0,0 +1,67 @@
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
+	char *p = malloc(SIZE);
+	struct timeval tv0, tv1;
+
+	if (!p) {
+		perror("malloc");
+		return 1;
+	}
+
+	sha1_block_data_order(iv, testbuf, 1);
+	printf("Result:  %08x %08x %08x %08x %08x\n"
+	       "Expected:%08x %08x %08x %08x %08x\n",
+		iv[0], iv[1], iv[2], iv[3], iv[4], expected[0],
+		expected[1], expected[2], expected[3], expected[4]);
+	for (i = 0; i < 5; i++)
+		if (iv[i] != expected[i])
+			printf("MISMATCH in word %u\n", i);
+
+	if (gettimeofday(&tv0, NULL) < 0) {
+		perror("gettimeofday");
+		return 1;
+	}
+	for (i = 0; i < 500; i++)
+		sha1_block_data_order(iv, p, SIZE/64);
+	if (gettimeofday(&tv1, NULL) < 0) {
+		perror("gettimeofday");
+		return 1;
+	}
+	tv1.tv_sec -= tv0.tv_sec;
+	tv1.tv_usec -= tv0.tv_usec;
+	if (tv1.tv_usec < 0) {
+		tv1.tv_sec--;
+		tv1.tv_usec += 1000000;
+	}
+	printf("%u bytes: %u.%06u s\n", i * SIZE, (unsigned)tv1.tv_sec,
+		(unsigned)tv1.tv_usec);
+	return 0;
+}
--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ sha1-586.h	2009-07-27 09:34:03.000000000 -0400
@@ -0,0 +1,3 @@
+#include <stdint.h>
+
+void sha1_block_data_order(uint32_t iv[5], void const *in, unsigned len);
--- /dev/null	2009-05-12 02:55:38.579106460 -0400
+++ sha1-x86.pl	2009-07-31 06:10:18.000000000 -0400
@@ -0,0 +1,398 @@
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
+$S="esi";
+$T="edi";
+
+# The round constants
+use constant K1 => 0x5a827999;
+use constant K2 => 0x6ED9EBA1;
+use constant K3 => 0x8F1BBCDC;
+use constant K4 => 0xCA62C1D6;
+
+@V=($A,$B,$C,$D,$E);
+
+# Given unlimited registers and functional units, it would be
+# possible to compute SHA-1 at two cycles per round, using 7
+# operations per round.  Remember, each round computes a new
+# value for E, which is used as A in the following round and B
+# in the round after that.  There are two critical paths:
+# - A must be rotated and added to the output E
+# - B must go through two boolean operations before being added
+#   to the result E.  Since this latter addition can't be done
+#   in the same-cycle as the critical addition of a<<<5, this is
+#   a total of 2+1+1 = 4 cycles.
+# Additionally, if you want to avoid copying B, you have to
+# rotate it soon after use in this round so it is ready for use
+# as the following round's C.
+
+# f = (a <<< 5) + e + K + in[i] + (d^(b&(c^d)))		(0..19)
+# f = (a <<< 5) + e + K + in[i] + (b^c^d)		(20..39, 60..79)
+# f = (a <<< 5) + e + K + in[i] + (c&d) + (b&(c^d))	(40..59)
+# The hard part is doing this with only two temporary registers.
+# Let's divide it into 4 parts.  These can be executed in a 7-cycle
+# loop, assuming triple (quadruple counting xor separately) issue:
+#
+#	in[i]		F1(c,d)		F2(b,c,d)	a<<<5
+#	mov in[i],T			(addl S,A)	(movl B,S)
+#	xor in[i+1],T					(rorl 5,S)
+#	xor in[i+2],T	movl D,S			(addl S,A)
+#	xor in[i+3],T	andl C,S
+#	rotl 1,T	addl S,E	movl D,S
+#	(movl T,in[i])                  xorl C,S
+#	addl T+K,E			andl B,S	rorl 2,B	//
+#	(mov in[i],T)			addl S,E	movl A,S
+#	(xor in[i+1],T)					rorl 5,S
+#	(xor in[i+2],T)	(movl C,S)			addl S,E
+#
+# (The last 3 rounds can omit the store of T.)
+# The "addl T+K,E" line is actually implemented using the lea instruction,
+# which (on a Pentium) requires that neither T not K was modified on the
+# previous cycle.
+#
+# The other two rounds are a bit simpler, and can therefore be "pulled in"
+# one cycle, to 6.  The bit-select function (0..19):
+#	in[i]		F(b,c,d)	a<<<5
+#	mov in[i],T	(xorl E,S)			(addl T+K,A)
+#	xor in[i+1],T	(addl S,A)	(movl A,S)
+#	xor in[i+2],T	(rorl 2,C)	(roll 5,S)
+#	xor in[i+3],T	movl D,S	(addl S,A)
+#	roll 1,T	xorl C,S
+#	movl T,in[i]	andl B,S			rorl 2,B
+#	addl T+K,E	xorl D,S		//	(mov in[i],T)
+#	(xor in[i+1],T)	addl S,E	movl A,S
+#	(xor in[i+2],T)			roll 5,S
+#	(xor in[i+3],T)	(movl C,S)	addl S,E
+#
+# And the XOR function (also 6, limited by the in[i] forming) used in
+# rounds 20..39 and 60..79:
+#	in[i]		F(b,c,d)	a<<<5
+#	mov in[i],T	(xorl C,S)			(addl T+K,A)
+#	xor in[i+1],T	(addl S,A)	(movl A,S)
+#	xor in[i+2],T			(roll 5,S)	
+#	xor in[i+3],T			(addl S,A)
+#	roll 1,T	movl D,S
+#	movl T,in[i]	xorl B,S			rorl 2,B
+#	addl T+K,E	xorl C,S		//	(mov in[i],T)
+#	(xor in[i+1],T)	addl S,E	movl A,S
+#	(xor in[i+2],T)			roll 5,S
+#	(xor in[i+3],T)			addl S,E
+#
+# The first 16 rounds don't need to form the in[i] equation, letting
+# us pull it in another 2 cycles, to 4, after some reassignment of
+# temporaries:
+#	in[i]		F(b,c,d)	a<<<5
+#			movl D,S	(roll 5,T)	(addl S,A)
+#	mov in[i],T	xorl C,S	(addl T,A)
+#			andl B,S			rorl 2,B
+#	addl T+K,E	xorl D,S	movl A,T
+#			addl S,E	roll 5,T	(movl C,S)
+#	(mov in[i],T)	(xorl B,S)	addl T,E
+#
+
+# The transition between rounds 15 and 16 will be a bit tricky... the best
+# thing to do is to delay the computation of a<<<5 one cycle and move it back
+# to the S register.  That way, T is free as early as possible.
+#	in[i]		F(b,c,d)	a<<<5
+#	(addl T+K,A)	(xorl E,S)	(movl A,T)
+#			movl D,S	(roll 5,T)	(addl S,A)
+#	mov in[i],T	xorl C,S	(addl T,A)
+#			andl B,S			rorl 2,B
+#	addl T+K,E	xorl D,S			(movl in[1],T)
+#	(xor in[i+1],T)	addl S,E	movl A,S
+#	(xor in[i+2],T)	rorl 2,B	roll 5,S
+#	(xor in[i+3],T)	(movl C,S)	addl S,E
+
+
+
+
+
+# This expects the first copy of D to S to have been done already
+#			movl D,S	(roll 5,T)	(addl S,A)	//
+#	mov in[i],T	xorl C,S	(addl T,A)
+#			andl B,S			rorl 2,B
+#	addl T+K,E	xorl D,S	movl A,T
+#			addl S,E	roll 5,T	(movl C,S)	//
+#	(mov in[i],T)	(xorl B,S)	addl T,E	
+
+sub BODY_00_15
+{
+	local($n,$a,$b,$c,$d,$e)=@_;
+
+	&comment("00_15 $n");
+		&mov($S,$d) if ($n == 0);
+	&mov($T,&swtmp($n%16));		# Load Xi.
+		&xor($S,$c);		# Continue computing F() = d^(b&(c^d))
+		&and($S,$b);
+			&rotr($b,2);
+	&lea($e,&DWP(K1,$e,$T));	# Add Xi and K
+    if ($n < 15) {
+			&mov($T,$a);
+		&xor($S,$d);
+			&rotl($T,5);
+		&add($e,$S);
+		&mov($S,$c);		# Start of NEXT round's F()
+			&add($e,$T);
+    } else {
+	# This version provides the correct start for BODY_20_39
+	&mov($T,&swtmp(($n+1)%16));	# Start computing mext Xi.
+		&xor($S,$d);
+	&xor($T,&swtmp(($n+3)%16));
+		&add($e,$S);		# Add F()
+			&mov($S,$a);	# Start computing a<<<5
+	&xor($T,&swtmp(($n+9)%16));
+			&rotl($S,5);
+    }
+
+}
+
+# The transition between rounds 15 and 16 will be a bit tricky... the best
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
+
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
+	&comment("16_20 $n");
+
+	&xor($T,&swtmp(($n+13)%16));
+			&add($a,$S);	# End of previous round
+		&mov($S,$d);		# Start current round's F()
+	&rotl($T,1);
+		&xor($S,$c);
+	&mov(&swtmp($n%16),$T);		# Store computed Xi.
+		&and($S,$b);
+		&rotr($b,2);
+	&lea($e,&DWP(K1,$e,$T));	# Add Xi and K
+	&mov($T,&swtmp(($n+1)%16));	# Start computing mext Xi.
+		&xor($S,$d);
+	&xor($T,&swtmp(($n+3)%16));
+		&add($e,$S);		# Add F()
+			&mov($S,$a);	# Start computing a<<<5
+	&xor($T,&swtmp(($n+9)%16));
+			&rotl($S,5);
+}
+
+# This is just like BODY_16_19, but computes a different F() = b^c^d
+#
+#	in[i]		F(b,c,d)	a<<<5
+#	mov in[i],T	(xorl E,S)			(addl T+K,A)
+#	xor in[i+1],T	(addl S,A)	(movl B,S)
+#	xor in[i+2],T			(roll 5,S)	//
+#	xor in[i+3],T 			(addl S,A)
+#	roll 1,T	movl C,S
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
+	&comment("21_30 $n");
+
+	&xor($T,&swtmp(($n+13)%16));
+			&add($a,$S);	# End of previous round
+		&mov($S,$d)
+	&rotl($T,1);
+		&mov($S,$d);		# Start current round's F()
+	&mov(&swtmp($n%16),$T) if ($n < 77);	# Store computed Xi.
+		&xor($S,$b);
+		&rotr($b,2);
+	&lea($e,&DWP($K,$e,$T));	# Add Xi and K
+	&mov($T,&swtmp(($n+1)%16)) if ($n < 79); # Start computing next Xi.
+		&xor($S,$c);
+	&xor($T,&swtmp(($n+3)%16)) if ($n < 79);
+		&add($e,$S);		# Add F1()
+			&mov($S,$a);	# Start computing a<<<5
+	&xor($T,&swtmp(($n+9)%16)) if ($n < 79);
+			&rotl($S,5);
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
+#	(movl T,in[i])                  xorl C,S
+#	addl T+K,E			andl B,S	rorl 2,B
+#	(mov in[i],T)			addl S,E	movl A,S
+#	(xor in[i+1],T)					rorl 5,S
+#	(xor in[i+2],T)	// (movl C,S)			addl S,E
+
+sub BODY_40_59
+{
+	local($n,$a,$b,$c,$d,$e)=@_;
+
+	&comment("41_59 $n");
+
+			&add($a,$S);	# End of previous round
+		&mov($S,$d);		# Start current round's F(1)
+	&xor($T,&swtmp(($n+13)%16));
+		&and($S,$c);
+	&rotl($T,1);
+		&add($e,$S);		# Add F1()
+		&mov($S,$d);		# Start current round's F2()
+	&mov(&swtmp($n%16),$T);		# Store computed Xi.
+		&xor($S,$c);
+	&lea($e,&DWP(K3,$e,$T));
+		&and($S,$b);
+		&rotr($b,2);
+	&mov($T,&swtmp(($n+1)%16));	# Start computing next Xi.
+		&add($e,$S);		# Add F2()
+		&mov($S,$a);		# Start computing a<<<5
+	&xor($T,&swtmp(($n+3)%16));
+			&rotl($S,5);
+	&xor($T,&swtmp(($n+9)%16));
+}
+
+&function_begin("sha1_block_data_order",16);
+	&mov($S,&wparam(0));	# SHA_CTX *c
+	&mov($T,&wparam(1));	# const void *input
+	&mov($A,&wparam(2));	# size_t num
+	&stack_push(16);	# allocate X[16]
+	&shl($A,6);
+	&add($A,$T);
+	&mov(&wparam(2),$A);	# pointer beyond the end of input
+	&mov($E,&DWP(16,$S));# pre-load E
+
+	&set_label("loop",16);
+
+	# copy input chunk to X, but reversing byte order!
+	for ($i=0; $i<16; $i+=4)
+		{
+		&mov($A,&DWP(4*($i+0),$T));
+		&mov($B,&DWP(4*($i+1),$T));
+		&mov($C,&DWP(4*($i+2),$T));
+		&mov($D,&DWP(4*($i+3),$T));
+		&bswap($A);
+		&bswap($B);
+		&bswap($C);
+		&bswap($D);
+		&mov(&swtmp($i+0),$A);
+		&mov(&swtmp($i+1),$B);
+		&mov(&swtmp($i+2),$C);
+		&mov(&swtmp($i+3),$D);
+		}
+	&mov(&wparam(1),$T);	# redundant in 1st spin
+
+	&mov($A,&DWP(0,$S));	# load SHA_CTX
+	&mov($B,&DWP(4,$S));
+	&mov($C,&DWP(8,$S));
+	&mov($D,&DWP(12,$S));
+	# E is pre-loaded
+
+	for($i=0;$i<16;$i++)	{ &BODY_00_15($i,@V); unshift(@V,pop(@V)); }
+	for(;$i<16;$i++)	{ &BODY_15($i,@V);    unshift(@V,pop(@V)); }
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
+	&add($A,&DWP(0,$S));	# E is last "A"...
+	&add($B,&DWP(4,$S));
+	&add($C,&DWP(8,$S));
+	&add($D,&DWP(12,$S));
+	&add($E,&DWP(16,$S));
+
+	&mov(&DWP(0,$S),$A);	# update SHA_CTX
+	 &add($T,64);		# advance input pointer
+	&mov(&DWP(4,$S),$B);
+	 &cmp($T,&wparam(2));	# have we reached the end yet?
+	&mov(&DWP(8,$S),$C);
+	&mov(&DWP(12,$S),$D);
+	&mov(&DWP(16,$S),$E);
+	&jb(&label("loop"));
+
+	&stack_pop(16);
+&function_end("sha1_block_data_order");
+&asciz("SHA1 block transform for x86, CRYPTOGAMS by <appro\@openssl.org>");
+
+&asm_finish();
