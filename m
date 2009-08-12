From: Nicolas Pitre <nico@cam.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 22:26:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908112140020.10633@xanadu.home>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain>
 <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
 <alpine.LFD.2.01.0908110810410.3417@localhost.localdomain>
 <alpine.LFD.2.00.0908111437160.10633@xanadu.home>
 <alpine.LFD.2.01.0908111550470.28882@localhost.localdomain>
 <alpine.LFD.2.01.0908111602020.28882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb3ZE-00006t-Ou
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbZHLC1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 22:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755551AbZHLC1K
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:27:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35349 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbZHLC1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:27:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO8007OMRMCBO50@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Aug 2009 22:15:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908111602020.28882@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125643>

On Tue, 11 Aug 2009, Linus Torvalds wrote:

> 
> 
> On Tue, 11 Aug 2009, Linus Torvalds wrote:
> 
> > 
> > 
> > On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> > > 
> > > Well... gcc is really strange in this case (and similar other ones) with 
> > > ARM compilation.  A good indicator of the quality of the code is the 
> > > size of the stack frame.  When using the "+m" then gcc creates a 816 
> > > byte stack frame, the generated binary grows by approx 3000 bytes, and 
> > > performances is almost halved (7.600s).  Looking at the assembly result 
> > > I just can't figure out all the crazy moves taking place.  Even the 
> > > version with no barrier what so ever produces better assembly with a 
> > > stack frame of 560 bytes.
> > 
> > Ok, that's just crazy. That function has a required stack size of exactly 
> > 64 bytes, and anything more than that is just spilling. And if you end up 
> > with a stack frame of 560 bytes, that means that gcc is doing some _crazy_ 
> > spilling.
> 
> Btw, what I think happens is:
> 
>  - gcc turns all those array accesses into pseudo's 
> 
>    So now the 'array[16]' is seen as just another 16 variables rather than 
>    an array.
> 
>  - gcc then turns it into SSA, where each assignment basically creates a 
>    new variable. So the 16 array variables (and 5 regular variables) are 
>    now expanded to 80 SSA asignments (one array assignment per SHA1 round) 
>    plus an additional 2 assignments to the "regular" variables per round 
>    (B and E are changed each round). So in SSA form, you actually end up 
>    having 240 pseudo's associated with the actual variables. Plus all 
>    the temporaries of course.
> 
>  - the thing then goes crazy and tries to generate great code from that 
>    internal SSA model. And since there are never more than ~25 things 
>    _live_ at any particular point, it works fine with lots of registers, 
>    but on small-register machines gcc just goes crazy and has to spill. 
>    And it doesn't spill 'array[x]' entries - it spills the _pseudo's_ it 
>    has created - hundreds of them.
> 
>  - End result: if the spill code doesn't share slots, it's going to create 
>    a totally unholy mess of crap.
> 
> That's what the whole 'volatile unsigned int *' game tried to avoid. But 
> it really sounds like it's not working too well for you. And the _big_ 
> memory barrier ends up helping just because with that in place, you end up 
> being almost entirely unable to schedule _anything_ between the different 
> SHA rounds, so you end up with only six or seven variables "live" in 
> between those barriers, and the stupid register allocator/spill logic 
> doesn't break down too badly.
> 
> The thing is, if you do full memory barriers, then you're probably better 
> off making both the loads and the stores be "volatile". That should have 
> similar effects.

If the loads are volatile then gcc has less flexibility when scheduling 
them.

> The downside with that is that it really limits the loads. So (like the 
> full memory barrier) it's a big hammer approach. But it probably generates 
> better code for you, because it avoids the mental breakdown of gcc 
> spilling its pseudo's.

Actually, all my previous tests were done with gcc-4.3.2.  I now have 
installed Fedora 11 which has gcc-4.4.0.  And now the stack frame is a 
nice 64 bytes.  ;-)

That's with the "memory" though.  With the volatile, stack frame goes up 
to 224 bytes and performance, although not as bad as before, is like 
5.160s instead of 4.410s.  The "+m" version is not much better: 208 byte 
stack frame and similar performance.

The version with no barrier what so ever runs in 4.580s and uses a 88 
byte stack frame.  The generated assembly contains stupid things, but 
this is still the second best version, even better than the "+m" and 
volatile ptr ones.

Conclusion: the full "memory" barrier remains the best choice on ARM.


Nicolas
