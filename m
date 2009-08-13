From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: more good unaligned memory access candidates
Date: Thu, 13 Aug 2009 17:28:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908131651110.10633@xanadu.home>
References: <20090813201542.25431.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com,
	torvalds@linux-foundation.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 23:29:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbhr9-0000ID-Qs
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZHMV21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbZHMV20
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:28:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26899 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515AbZHMV2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:28:25 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOC00BQI3N6W480@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Aug 2009 17:28:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090813201542.25431.qmail@science.horizon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125878>

On Thu, 13 Aug 2009, George Spelvin wrote:

> > Wow.  Is it now faster than the arm/ and ppc/ hand-tweaked assembly?
> 
> It's probably faster than the ARM, which was tuned for size rather
> than speed, but if you want to rework the assembly for speed, the ARM's
> rotate-and-add operations allow tricks which I doubt GCC can pick up on.
> (You have to notice that the F(b,c,d) function is bitwise, so you can
> do it on rotated data and do the rotate when you add the result to e.)

gcc is not too bad at merging ALU and shift/rotate operations into the 
same instruction.  However, to make a really optimal ARM version, some 
custom SHA_ROUND macros with inline assembly could be made.  I suspect 
that wouldn't gain much though, as the pure shift/rotate mov 
instructions really aren't that many in the generated code.

> I'd be surprised if it were faster than PPC code, especially on the
> in-order G3 and G4 cores where careful scheduling really pays off.
> But maybe I just get to be surprised...

Given that PPC has enough register to hold the entire state, it is then 
only a matter of proper instruction scheduling which modern gcc ought to 
do right.  If not then this is a good test case for gcc people to fix 
the PPC machine pipeline description.

> For automatic assembly tuning, I was thinking of having a .c file that
> has a bunch of #ifdef __PPC__ statements that gets run through $(CC) -E.
> That should be a fairly portable way to 

??

> The other question about unaligned access is whether it's beneficial
> to make the fetch loop work like this:
> 
> 	char const *in;
> 	uint32_t *out
> 	unsigned lsb = (unsigned)p & 3;
> 	uint32_t const *p32 = (uint32_t const *)(in - lsb);
> 	uint32_t t = ntohl(*p32);
> 
> 	switch (lsb) {
> 
> 	case 0:
> 		*out++ = t;
> 		for (i = 1; i < 16; i++)
> 			*out++ = ntohl(*++p32);
> 		break;
> 	case 1:
> 		for (i = 0; i < 16; i++) {
> 			uint32_t s = t << 8;
> 			t = ntohl(*++p32);
> 			*out++ = s | t >> 24;
> 		}
> 		break;
> 	case 1:
> 		for (i = 0; i < 16; i++) {
> 			uint32_t s = t << 16;
> 			t = ntohl(*++p32);
> 			*out++ = s | t >> 16;
> 		}
> 		break;
> 	case 1:
> 		for (i = 0; i < 16; i++) {
> 			uint32_t s = t << 24;
> 			t = ntohl(*++p32);
> 			*out++ = s | t >> 8;
> 		}
> 		break;
> 	}
> 
> On the ARM, at least, ntohl() isn't particularly cheap, so loading 4
> bytes and assembling them turns out to be cheaper.  But it's a thought.

Well, that would have to be tested.  This could possibly only be a gain 
if you have a fast ntohl() though.

And the other question is also to decide when this is good enough for a 
generic version.  Gaining 5% speedup on raw SHA1 throughput with ugly 
code might not be worth the maintenance hassle.  At that point you might 
as well go back to a purely asm version if you really want to get the 
extra edge.


Nicolas
