From: Nicolas Pitre <nico@cam.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 16:03:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908111437160.10633@xanadu.home>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain>
 <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
 <alpine.LFD.2.01.0908110810410.3417@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:04:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaxaF-0003W0-5x
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbZHKUEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 16:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZHKUEY
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:04:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41563 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbZHKUEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 16:04:23 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO800FTYAEMHVG1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Aug 2009 16:03:59 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908110810410.3417@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125587>

On Tue, 11 Aug 2009, Linus Torvalds wrote:

> On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> > 
> > BLK_SHA1:	 5.280s		[original]
> > BLK_SHA1:	 7.410s		[with SMALL_REGISTER_SET defined]
> > BLK_SHA1:	 7.480s		[with 'W(x)=(val);asm("":"+m" (W(x)))']
> > BLK_SHA1:	 4.980s		[with 'W(x)=(val);asm("":::"memory")']
> > 
> > At this point the generated assembly is pretty slick.  I bet the full 
> > memory barrier might help on x86 as well.
> 
> No, I had tested that earlier - single-word memory barrier for some reason 
> gets _much_ better numbers at least on x86-64. We're talking
> 
> 	linus            1.46       418.2
> vs
> 	linus           2.004       304.6
> 
> kind of differences. With the "+m" it outperforms openssl (375-380MB/s).
> 
> The "volatile unsigned int *" cast looks pretty much like the "+m" version 
> to me, but Arthur got a speedup from whatever gcc code generation 
> differences on his P4.

The volatile pointer forces a write to memory but the cached value in 
the processor's register remains valid, whereas the "+m" forces gcc to 
assume the register copy is not valid anymore.  That certainly gives the 
compiler a different clue about register availability, etc.

> The really fundamental and basic problem with gcc on this code is that gcc 
> does not see _any_ difference what-so-ever between the five variables 
> declared with
> 
> 	unsigned int A, B, C, D, E;
> 
> and the sixteen variables declared with
> 
> 	unsigned int array[16];
> 
> and considers those all to be 21 local variables. It really seems to think 
> that they are all 100% equivalent, and gcc totally ignores me doing things 
> like adding "register" to the A-E ones etc.
> 
> And if you are a compiler, and think that the routine has 21 equal 
> register variables, you're going to do crazy reload sh*t when you have 
> only 7 (or 15) GP registers. So doing that full memory barrier seems to 
> just take that random situation, and force some random variable to be 
> spilled (this is all from looking at the generated code, not from looking 
> at gcc).
> 
> In contrast, with the _targeted_ thing ("you'd better write back into 
> array[]") we force gcc to spill the array[16] values, and not the A-E 
> ones, and that's why it seems to make such a big difference.
> 
> And no, I'm not sure why ARM apparently doesn't show the same behavior. Or 
> maybe it does, but with an in-order core it doesn't matter as much which 
> registers you keep reloading - you'll be serialized all the time _anyway_. 

Well... gcc is really strange in this case (and similar other ones) with 
ARM compilation.  A good indicator of the quality of the code is the 
size of the stack frame.  When using the "+m" then gcc creates a 816 
byte stack frame, the generated binary grows by approx 3000 bytes, and 
performances is almost halved (7.600s).  Looking at the assembly result 
I just can't figure out all the crazy moves taking place.  Even the 
version with no barrier what so ever produces better assembly with a 
stack frame of 560 bytes.

The volatile version is second to worst with a 808 byte stack frame with 
similar bad performances.

With the full "memory" the stack frame shrinks to 280 bytes and best 
performances so far is obtained.  And none of the A B C D E or data 
variables are ever spilled onto the stack either, only the array[16] 
gets allocated stack slots, and the TEMP variable.


Nicolas
