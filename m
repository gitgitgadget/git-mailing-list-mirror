From: linux@horizon.com
Subject: Re: Revised PPC assembly implementation
Date: 25 Apr 2005 17:34:30 -0000
Message-ID: <20050425173430.11031.qmail@science.horizon.com>
References: <17004.47876.414.756912@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Apr 25 19:34:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ7S4-0000JY-1P
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 19:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVDYRh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVDYRh1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:37:27 -0400
Received: from science.horizon.com ([192.35.100.1]:16440 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262715AbVDYReb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:34:31 -0400
Received: (qmail 11032 invoked by uid 1000); 25 Apr 2005 17:34:30 -0000
To: paulus@samba.org
In-Reply-To: <17004.47876.414.756912@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>> Which lead to three questions:
>> - Is the stack set properly now?

> Not quite; you are saving 20 registers, so you need a 96-byte stack
> frame, like this:

> 	stwu	%r1,-96(%r1)
> 	stmw	%r13,16(%r1)
> 	...
> 	lmw	%r13,16(%r1)
> 	addi	%r1,%r1,96
> 	blr

Huh?  I'm saving 19 registers, r13..r31, and not saving 13, namely
r0..r12.

The dodgy thing *I'm* thinking of is saving %r2 (the TOC pointer)
and using it as an extra temporary.  (The alternative is spilling
one of the "old" hash values to the stack, which is not
too big a disaster.)

>> - Is it any faster?

> I did 10 repetitions of my program that calls SHA1_Update with a
> 4096-byte block of zeroes 256,000 times.  With my version, the average
> time was 4.6191 seconds with a standard deviation of 0.0157.  With your
> version, the average was 4.6063 and the standard deviation 0.0148.  So
> I would say that your version is probably just a little faster - of the
> order of 0.3% faster.

Damn.  So that's actually *worse* than me earlier version which achieved
an (also piddling) 2% speedup?
As you can see, I tried to make the addition tree bushier, but I guess
it didn't help.  Or the processor isn't out-of-order enough to find
the parallelism I made available.

Damn, I wish I had at that IBM pipeline profiling tool.  If it could
just tell me which cycles didn't have both ALUs busy, I could solve it
in relatively little time.

The place that could really use scheduing help is the G4, which has three
integer ALUs, but can only *think* about executing the bottom three entries
in the reorder queue.  So if one of those instructions isn't ready, it
stalls in the queue and idles the ALU with it.

Especially there, it may be necessary to interleave the EXPANDW code
with the round code to avoid having the (non-critical-path) EXPANDW
code scheduled ahead of critical-path round code.

The two critical-path inter-round dependencies are:
- summing into E to be rotated by 5 and added to D next round.
  (this is the "A<<<5" code in the current round)
- rotating B left for use in the next round's F(a,b,c) function.
  (this is the current round's C input)
Actually, the E variable isn't critical-path at all; it was last
modified several rounds ago.

Maybe I can improve the scheduling some more...
