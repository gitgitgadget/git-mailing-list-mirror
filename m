From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: more good unaligned memory access candidates
Date: Thu, 13 Aug 2009 13:23:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908131304520.10633@xanadu.home>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
 <alpine.LFD.2.01.0908130934400.28882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:24:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbe29-0007KC-HF
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbZHMRYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754473AbZHMRYE
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:24:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9150 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbZHMRYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:24:03 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOB00GKVRTCQW11@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 13 Aug 2009 13:12:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908130934400.28882@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125842>

On Thu, 13 Aug 2009, Linus Torvalds wrote:

> 
> 
> On Thu, 13 Aug 2009, Nicolas Pitre wrote:
> >
> > In addition to X86, PowerPC and S390 are capable of unaligned memory 
> > accesses.
> > 
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> Ack on all your patches (1-3 + this). Looks fine to me.
> 
> I do wonder if we should try to do basically "per-architecture hack 
> header-files", and then have for each architecture a small trivial 
> 'hack-x86.h' kind of thing that just does
> 
> 	/* x86 hacks */
> 	#define get_be32(p)	ntohl(*(unsigned int *)(p))
> 	#define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
> 	#define setW(x, val)	(*(volatile unsigned int *)&W(x) = (val))
> 
> 	#define SHA_ASM(op, x, n) ({ unsigned int __res; __asm__(op " %1,%0":"=r" (__res):"i" (n), "0" (x)); __res; })
> 	#define SHA_ROL(x,n)   SHA_ASM("rol", x, n)
> 	#define SHA_ROR(x,n)   SHA_ASM("ror", x, n)
> 
> and then we'd have each architecture separated out. Add a few 
> "generic helpers":
> 
>  - be32-generic.h:
> 
> 	#define get_be32(p)    ( \
> 		(*((unsigned char *)(p) + 0) << 24) | \
> 		(*((unsigned char *)(p) + 1) << 16) | \
> 		(*((unsigned char *)(p) + 2) <<  8) | \
> 		(*((unsigned char *)(p) + 3) <<  0) )
> 
> 	#define put_be32(p, v) do { \
> 		unsigned int __v = (v); \
> 		*((unsigned char *)(p) + 0) = __v >> 24; \
> 		*((unsigned char *)(p) + 1) = __v >> 16; \
> 		*((unsigned char *)(p) + 2) = __v >>  8; \
> 		*((unsigned char *)(p) + 3) = __v >>  0; } while (0)
> 
>  - rotate-generic.h:
> 
> 	#define SHA_ROT(X,l,r)  (((X) << (l)) | ((X) >> (r)))
> 	#define SHA_ROL(X,n)    SHA_ROT(X,n,32-(n))
> 	#define SHA_ROR(X,n)    SHA_ROT(X,32-(n),n)
> 
> that architectures could use when they want to use some particular
> portable version.  Then, add a final "hack-generic.h" with the fallback
> cases that just does
> 
> 	#include "be32-generic.h"
> 	#include "rotate-generic.h"
> 	#define setW(x,val) (W(x) = (val))
> 
> and you'd have all the hacks separated out and fairly easily used by
> different architectures.. (ie the ARM version would just look like
> 
>  - hack-arm.h:
> 
> 	#include "be32-generic.h"  
> 	#include "rotate-generic.h"
> 	#define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
> 
> and you'd be all done.
> 
> Hmm? I don't know if this kind of generalization is strictly needed, so 
> I'm just throwing it out as an idea.

Well... first I don't think there are much else we can do with that 
code, i.e. there is probably not so many more hacks to add if any.  With 
my last patch I consider this ready for general consumption.

And given that the only user is this very sha1 implementation then there 
is not much value in abstracting them in header files.

And the point of patch 2/3 was to move hack variants for the same 
purpose together making it easier to document and understand (and 
possibly modify) them.  Your suggestion would go in the opposite 
direction entirely.

As it is now, I was about to suggest:

	git mv block-sha1/sha1.[ch] .
	rmdir block-sha1
	rm -r mozilla-sha1
	rm -r arm
	rm -r ppc 

and remove support for openssl's SHA1 usage, making this implementation 
unconditional.  After all it is faster, or so close to be faster than 
the alternatives, that we should probably cut on the extra dependency 
and simplify portability issues at the same time.


Nicolas
