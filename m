From: Wayne Scott <wsc9tt@gmail.com>
Subject: Re: [PATCH] PPC assembly implementation of SHA1
Date: Sun, 24 Apr 2005 07:04:27 -0500
Message-ID: <59a6e583050424050434ae2501@mail.gmail.com>
References: <20050423124246.30071.qmail@science.horizon.com>
	 <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
Reply-To: Wayne Scott <wsc9tt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 14:00:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPfmH-0002aq-4q
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 13:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVDXMEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 08:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVDXMEl
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 08:04:41 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:11013 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262312AbVDXME3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 08:04:29 -0400
Received: by wproxy.gmail.com with SMTP id 68so1285269wri
        for <git@vger.kernel.org>; Sun, 24 Apr 2005 05:04:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TEZEriPwI+Q+z7r6pbuhC5EHk95Daq65veQZb/K+iebGa5Xtfw/+17MZuRRT4RrmhMdFaL+IRLDN5ZySVLZQ4K85ELk6eRcDeUfxaFxKgC49qx0Nzv8cLBp9SXA3GwADjZSxW4zdcNuJBrzukzpbTAhPDrHA1e6g0glE5fxVbUI=
Received: by 10.54.10.56 with SMTP id 56mr1390484wrj;
        Sun, 24 Apr 2005 05:04:27 -0700 (PDT)
Received: by 10.54.36.46 with HTTP; Sun, 24 Apr 2005 05:04:27 -0700 (PDT)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17003.9009.226712.220822@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

_The_ book on expression rewriting tricks like this, especially for
the PPC, is "Hacker's Delight" by Henry Warren.  Great reading!!!
http://www.hackersdelight.org/

-Wayne

On 4/23/05, Paul Mackerras <paulus@samba.org> wrote:
> linux@horizon.com writes:
> 
> > I was working on the same thing, but hindered by lack of access to PPC
> > hardware.  I notice that you also took advantage of the unaligned load
> > support and native byte order to do the hash straight from the source.
> 
> Yes. :)  In previous experiments (in the context of trying different
> ways to do memcpy) I found that doing unaligned word loads is faster
> than doing aligned loads plus extra rotate and mask instructions to
> get the bytes you want together.
> 
> > But I came up with a few additional refinements:
> >
> > - You are using three temporaries (%r0, %r6, and RT(x)) for your
> >   round functions.  You only need one temporary (%r0) for all the functions.
> >   (Plus %r15 for k)
> 
> The reason I used more than one temporary is that I was trying to put
> dependent instructions as far apart as reasonably possible, to
> minimize the chances of pipeline stalls.  Given that the 970 does
> register renaming and out-of-order execution, I don't know how
> essential that is, but it can't hurt.
> 
> > All are three logical instrunctions on PPC.  The second form
> > lets you add it into the accumulator e in two pieces:
> 
> A sequence of adds into a single register is going to incur the
> 2-cycle latency between generation and use of a value; i.e. the adds
> will only issue on every second cycle.  I think we are better off
> making the dataflow more like a tree than a linear chain where
> possible.
> 
> > And the last function, majority(x,y,z), can be written as:
> > f3(x,y,z) = (x & y) | (y & z) | (z & x)
> >           = (x & y) | z & (x | y)
> >           = (x & y) | z & (x ^ y)
> >           = (x & y) + z & (x ^ y)
> 
> That's cute, I hadn't thought of that.
> 
> > - You don't need to decrement %r1 before saving registers.
> >   The PPC calling convention defines a "red zone" below the
> >   current stack pointer that is guaranteed never to be touched
> >   by signal handlers or the like.  This is specifically for
> >   leaf procedure optimization, and is at least 224 bytes.
> 
> Not in the ppc32 ELF ABI - you are not supposed to touch memory below
> the stack pointer.  The kernel is more forgiving than that, and in
> fact you can currently use the red zone without anything bad
> happening, but you really shouldn't.
> 
> > - Is that many stw/lwz instructions faster than stmw/lmw?
> >   The latter is at least more cahce-friendly.
> 
> I believe the stw/lwz and the stmw/lmw will actually execute at the
> same speed on the 970, but I have seen lwz/stw go faster than lmw/stmw
> on other machines.  In any case we aren't executing the prolog and
> epilog as often as the instructions in the main loop, hopefully.
> 
> > - You can avoid saving and restoring %r15 by recycling %r5 for that
> >   purpose; it's not used after the mtctr %r5.
> 
> True.
> 
> > - The above changes actually save enough registers to cache the whole hash[5]
> >   in registers as well, eliminating *all* unnecessary load/store traffic.
> 
> That's cool.
> 
> > With all of the above changes, your sha1ppc.S file turns into:
> 
> I added a stwu and an addi to make a stack frame, and changed %r15 to
> %r5 as you mentioned in another message.  I tried it in a little test
> program I have that calls SHA1_Update 256,000 times with a buffer of
> 4096 zero bytes, i.e. it processes 1000MB.  Your version seems to be
> about 2% faster; it took 4.53 seconds compared to 4.62 for mine.  But
> it also gives the wrong answer; I haven't investigated why.
> 
> Thanks,
> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
