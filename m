From: linux@horizon.com
Subject: Re: [PATCH] PPC assembly implementation of SHA1
Date: 25 Apr 2005 00:16:56 -0000
Message-ID: <20050425001656.2740.qmail@science.horizon.com>
References: <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Mon Apr 25 02:12:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPrD0-00072z-4c
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 02:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVDYARE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 20:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVDYARE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 20:17:04 -0400
Received: from science.horizon.com ([192.35.100.1]:60200 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262375AbVDYAQ5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 20:16:57 -0400
Received: (qmail 2741 invoked by uid 1000); 25 Apr 2005 00:16:56 -0000
To: paulus@samba.org
In-Reply-To: <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Yes. :)  In previous experiments (in the context of trying different
> ways to do memcpy) I found that doing unaligned word loads is faster
> than doing aligned loads plus extra rotate and mask instructions to
> get the bytes you want together.

The PPC970, at least, supports unaligned loads within one cache line
(64 bytes for L1 hit; 32 bytes for L1 miss) directly.  If the load
crosses the line, the processor backs up and re-issues it as two
loads and a merge.

Multiple-word loads can really suffer from this, as when the fault
hits, the *entire instruction* is aborted and re-issued as a series
of aligned loads and merges.

But for a single load, it's probably cheaper on average to use the
hardware 15 times out of 16 and take the retry the 16th.

> But I came up with a few additional refinements:
> 
>> - You are using three temporaries (%r0, %r6, and RT(x)) for your
>>   round functions.  You only need one temporary (%r0) for all the functions.
>>   (Plus %r15 for k)

> The reason I used more than one temporary is that I was trying to put
> dependent instructions as far apart as reasonably possible, to
> minimize the chances of pipeline stalls.  Given that the 970 does
> register renaming and out-of-order execution, I don't know how
> essential that is, but it can't hurt.

It's a good general idea, but the PPC970 only has two integer ALUs, so
it can't get too clever.

>> All are three logical instrunctions on PPC.  The second form
>> lets you add it into the accumulator e in two pieces:

> A sequence of adds into a single register is going to incur the
> 2-cycle latency between generation and use of a value; i.e. the adds
> will only issue on every second cycle.  I think we are better off
> making the dataflow more like a tree than a linear chain where
> possible.

Grumble, complain... you're right.  I didn't know it had a 2-cycle
dependency.  Time to reschedule those inner loops.  Still, the multi-input
sum representation gives you a lot of scheduling flexibility.

Given this, it has to be scheduled 4-wide, which is a lot trickier.
The steps are 9, 8, and 10 instructions long (plus 4 instructions
for UPDATEW on most of them), and there's a 5- or 6-input sum to
compute in that time.

I'll stare at the dependency graph a bit and see if I can do better.

>> - You don't need to decrement %r1 before saving registers.
>>   The PPC calling convention defines a "red zone" below the
>>   current stack pointer that is guaranteed never to be touched
>>   by signal handlers or the like.  This is specifically for
>>   leaf procedure optimization, and is at least 224 bytes.

> Not in the ppc32 ELF ABI - you are not supposed to touch memory below
> the stack pointer.  The kernel is more forgiving than that, and in
> fact you can currently use the red zone without anything bad
> happening, but you really shouldn't.

Oh!  I didn't know that!  Thank you for enlightening me!

>> - Is that many stw/lwz instructions faster than stmw/lmw?
>>   The latter is at least more cache-friendly.

> I believe the stw/lwz and the stmw/lmw will actually execute at the
> same speed on the 970, but I have seen lwz/stw go faster than lmw/stmw
> on other machines.  In any case we aren't executing the prolog and
> epilog as often as the instructions in the main loop, hopefully.

Yes, and reducing the I-cache footprint seems useful.

>> With all of the above changes, your sha1ppc.S file turns into:

> I added a stwu and an addi to make a stack frame, and changed %r15 to
> %r5 as you mentioned in another message.  I tried it in a little test
> program I have that calls SHA1_Update 256,000 times with a buffer of
> 4096 zero bytes, i.e. it processes 1000MB.  Your version seems to be
> about 2% faster; it took 4.53 seconds compared to 4.62 for mine.  But
> it also gives the wrong answer; I haven't investigated why.

Grumble, damn.  The standard document has all the register values for
every round. so if you set up the same plaintext they use and step
through the code with that at your side, the problem should jump
out at you.

Anyway, now that I know the pipeline issues better, I'll try to
reschedule it and see if I can improve the situation.  I may have
to understand the dispatch group issues pretty thoroughly, too.

http://www.alphaworks.ibm.com/tech/simppc
might be of interest.

I'll try to find the bug while I'm at it.  Would you be willing to
benchmark some code for me?

Thanks!
