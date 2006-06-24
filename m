From: linux@horizon.com
Subject: Re: x86 asm SHA1 (draft)
Date: 24 Jun 2006 05:20:26 -0400
Message-ID: <20060624092026.31029.qmail@science.horizon.com>
References: <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
Cc: linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Jun 24 15:02:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu7mL-0006d6-Ry
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 15:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFXNCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 09:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWFXNCQ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 09:02:16 -0400
Received: from science.horizon.com ([192.35.100.1]:2862 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750737AbWFXNCP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 09:02:15 -0400
Received: (qmail 31030 invoked by uid 1000); 24 Jun 2006 05:20:26 -0400
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22514>

> OK.  I somehow got an impression that your two versions had
> quite different performance characteristics on G4 and G5 and
> there was a real choice.  If they are between a few per-cent,
> then I agree it is not worth doing at all.

My apologies for being unclear.

The place where a noticeable (if not disastrous) difference can appear
is x86, which has a lot more models with "interesting" performance
characteristics.  In particular, Intel is fond of building CPUs with a
very small "sweet spot".

The openssl SHA1 code had to be reworked to not suck on a P4, with the
resultant performance change:

#               compared with original  compared with Intel cc
#               assembler impl.         generated code
# Pentium       -16%                    +48%
# PIII/AMD      +8%                     +16%
# P4            +85%(!)                 +45%

The original code had the most popular round (what I call
ROUND_MIX(F2,...))) implemented as follows, with single-uop
instructions (no load+op) scheduled for the Pentium pipeline:
(A..E are working variables, S and T are temps)

	movl    16(%esp),S	U  \
        movl    24(%esp),T	 V  \
        xorl    S,T		U    \
        movl    48(%esp),S	 V    > "MIX", pentium-optimized
        xorl    S,T		U    /
        movl    4(%esp),S	 V  /
        xorl    S,T		U  /
        movl	B,S		 V
	roll	$1,T		U	Rotate of mix (SHA0 -> SHA1 fix)
	xor	C,S		 V
	mov	T,16(%esp)	U	Store back W[i]
	xor	D,S		 V	Finish computing F(B,C,D) = B^C^D
	lea	K(T,E),E	U	Add K and W[i] to E
	mov	A,T		 V
	roll	$5,T		UV
	rorl	$1,B		U
	add	S,E		 V
	rorl	$1,B		U
	add	T,E		 V

While the P4-optimized version goes:
	movl	B,S
	movl	16(%esp),T
	rorl	$2,B
	xorl	24(%esp),T
	xorl	C,S
	xorl	48(%esp),T
	xorl	D,S		This is F(B,C,D) = B^C^D
	xorl	4(%esp),T
	roll	$1,T		Rotate of mix (SHA0 -> SHA1 fix)
	addl	S,E
	movl	T,16(%esp)
	movl	A,S
	roll	$5,S
	lea	K(E,T),E
	add	S,E

(The original code actually rotates the working variables around 6
registers, not 5, but I've rearranged the last couple of instructions
to rotate around 5.)
