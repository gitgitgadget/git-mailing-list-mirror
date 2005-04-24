From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] PPC assembly implementation of SHA1
Date: Sun, 24 Apr 2005 14:40:17 +1000
Message-ID: <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
References: <20050423124246.30071.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 06:36:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPYqx-0006Zj-Sv
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVDXElG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 00:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVDXElG
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 00:41:06 -0400
Received: from ozlabs.org ([203.10.76.45]:44695 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262248AbVDXEk4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 00:40:56 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 16DE467AC6; Sun, 24 Apr 2005 14:40:54 +1000 (EST)
To: linux@horizon.com
In-Reply-To: <20050423124246.30071.qmail@science.horizon.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

linux@horizon.com writes:

> I was working on the same thing, but hindered by lack of access to PPC
> hardware.  I notice that you also took advantage of the unaligned load
> support and native byte order to do the hash straight from the source.

Yes. :)  In previous experiments (in the context of trying different
ways to do memcpy) I found that doing unaligned word loads is faster
than doing aligned loads plus extra rotate and mask instructions to
get the bytes you want together.

> But I came up with a few additional refinements:
> 
> - You are using three temporaries (%r0, %r6, and RT(x)) for your
>   round functions.  You only need one temporary (%r0) for all the functions.
>   (Plus %r15 for k)

The reason I used more than one temporary is that I was trying to put
dependent instructions as far apart as reasonably possible, to
minimize the chances of pipeline stalls.  Given that the 970 does
register renaming and out-of-order execution, I don't know how
essential that is, but it can't hurt.

> All are three logical instrunctions on PPC.  The second form
> lets you add it into the accumulator e in two pieces:

A sequence of adds into a single register is going to incur the
2-cycle latency between generation and use of a value; i.e. the adds
will only issue on every second cycle.  I think we are better off
making the dataflow more like a tree than a linear chain where
possible.

> And the last function, majority(x,y,z), can be written as:
> f3(x,y,z) = (x & y) | (y & z) | (z & x)
>           = (x & y) | z & (x | y)
>           = (x & y) | z & (x ^ y)
>           = (x & y) + z & (x ^ y)

That's cute, I hadn't thought of that.

> - You don't need to decrement %r1 before saving registers.
>   The PPC calling convention defines a "red zone" below the
>   current stack pointer that is guaranteed never to be touched
>   by signal handlers or the like.  This is specifically for
>   leaf procedure optimization, and is at least 224 bytes.

Not in the ppc32 ELF ABI - you are not supposed to touch memory below
the stack pointer.  The kernel is more forgiving than that, and in
fact you can currently use the red zone without anything bad
happening, but you really shouldn't.

> - Is that many stw/lwz instructions faster than stmw/lmw?
>   The latter is at least more cahce-friendly.

I believe the stw/lwz and the stmw/lmw will actually execute at the
same speed on the 970, but I have seen lwz/stw go faster than lmw/stmw
on other machines.  In any case we aren't executing the prolog and
epilog as often as the instructions in the main loop, hopefully.

> - You can avoid saving and restoring %r15 by recycling %r5 for that
>   purpose; it's not used after the mtctr %r5.

True.

> - The above changes actually save enough registers to cache the whole hash[5]
>   in registers as well, eliminating *all* unnecessary load/store traffic.

That's cool.

> With all of the above changes, your sha1ppc.S file turns into:

I added a stwu and an addi to make a stack frame, and changed %r15 to
%r5 as you mentioned in another message.  I tried it in a little test
program I have that calls SHA1_Update 256,000 times with a buffer of
4096 zero bytes, i.e. it processes 1000MB.  Your version seems to be
about 2% faster; it took 4.53 seconds compared to 4.62 for mine.  But
it also gives the wrong answer; I haven't investigated why.

Thanks,
Paul.
