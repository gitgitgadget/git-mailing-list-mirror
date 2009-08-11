From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 16:14:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908111602020.28882@localhost.localdomain>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain> <alpine.LFD.2.00.0908102246210.10633@xanadu.home> <alpine.LFD.2.01.0908110810410.3417@localhost.localdomain> <alpine.LFD.2.00.0908111437160.10633@xanadu.home>
 <alpine.LFD.2.01.0908111550470.28882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 01:14:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb0YF-0006tF-3o
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 01:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbZHKXOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 19:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbZHKXOe
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 19:14:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39611 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753430AbZHKXOd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 19:14:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BNEJPS024489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Aug 2009 16:14:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7BNEJuL003512;
	Tue, 11 Aug 2009 16:14:19 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908111550470.28882@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125619>



On Tue, 11 Aug 2009, Linus Torvalds wrote:

> 
> 
> On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> > 
> > Well... gcc is really strange in this case (and similar other ones) with 
> > ARM compilation.  A good indicator of the quality of the code is the 
> > size of the stack frame.  When using the "+m" then gcc creates a 816 
> > byte stack frame, the generated binary grows by approx 3000 bytes, and 
> > performances is almost halved (7.600s).  Looking at the assembly result 
> > I just can't figure out all the crazy moves taking place.  Even the 
> > version with no barrier what so ever produces better assembly with a 
> > stack frame of 560 bytes.
> 
> Ok, that's just crazy. That function has a required stack size of exactly 
> 64 bytes, and anything more than that is just spilling. And if you end up 
> with a stack frame of 560 bytes, that means that gcc is doing some _crazy_ 
> spilling.

Btw, what I think happens is:

 - gcc turns all those array accesses into pseudo's 

   So now the 'array[16]' is seen as just another 16 variables rather than 
   an array.

 - gcc then turns it into SSA, where each assignment basically creates a 
   new variable. So the 16 array variables (and 5 regular variables) are 
   now expanded to 80 SSA asignments (one array assignment per SHA1 round) 
   plus an additional 2 assignments to the "regular" variables per round 
   (B and E are changed each round). So in SSA form, you actually end up 
   having 240 pseudo's associated with the actual variables. Plus all 
   the temporaries of course.

 - the thing then goes crazy and tries to generate great code from that 
   internal SSA model. And since there are never more than ~25 things 
   _live_ at any particular point, it works fine with lots of registers, 
   but on small-register machines gcc just goes crazy and has to spill. 
   And it doesn't spill 'array[x]' entries - it spills the _pseudo's_ it 
   has created - hundreds of them.

 - End result: if the spill code doesn't share slots, it's going to create 
   a totally unholy mess of crap.

That's what the whole 'volatile unsigned int *' game tried to avoid. But 
it really sounds like it's not working too well for you. And the _big_ 
memory barrier ends up helping just because with that in place, you end up 
being almost entirely unable to schedule _anything_ between the different 
SHA rounds, so you end up with only six or seven variables "live" in 
between those barriers, and the stupid register allocator/spill logic 
doesn't break down too badly.

The thing is, if you do full memory barriers, then you're probably better 
off making both the loads and the stores be "volatile". That should have 
similar effects.

The downside with that is that it really limits the loads. So (like the 
full memory barrier) it's a big hammer approach. But it probably generates 
better code for you, because it avoids the mental breakdown of gcc 
spilling its pseudo's.

			Linus
