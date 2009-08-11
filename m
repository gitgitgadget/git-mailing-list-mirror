From: Nicolas Pitre <nico@cam.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 14:00:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908111254290.10633@xanadu.home>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain>
 <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
 <alpine.LFD.2.01.0908110758160.3417@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 20:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaveQ-0000Qk-4F
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 20:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbZHKSAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 14:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbZHKSAg
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 14:00:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45523 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbZHKSAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 14:00:35 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO8007KS4O9AWN0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Aug 2009 14:00:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908110758160.3417@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125585>

On Tue, 11 Aug 2009, Linus Torvalds wrote:

> On Tue, 11 Aug 2009, Nicolas Pitre wrote:
> > 
> > #define SHA_SRC(t) \
> >   ({ unsigned char *__d = (unsigned char *)&data[t]; \
> >      (__d[0] << 24) | (__d[1] << 16) | (__d[2] << 8) | (__d[3] << 0); })
> > 
> > And this provides the exact same performance as the ntohl() based 
> > version (4.980s) except that this now cope with unaligned buffers too.
> 
> Is it better to do a (conditional) memcpy up front? Or is the byte-based 
> one better just because you always end up doing the shifting anyway due to 
> most ARM situations being little-endian?

The vast majority of ARM processors where git might be run are using a 
LE environment.

> I _suspect_ that most large SHA1 calls from git are pre-aligned. The big 
> SHA1 calls are for pack-file verification in fsck, which should all be 
> aligned. Same goes for index file integrity checking.
> 
> The actual object SHA1 calculations are likely not aligned (we do that 
> object header thing), and if you can't do the htonl() any better way I 
> guess the byte-based thing is the way to go..

Let's see.  The default ntohl() provided by glibc generates this code:

        ldr     r3, [r0, #0]
        mov     r0, r3, lsr #24
        and     r2, r3, #0x00ff0000
        orr     r0, r0, r3, asl #24
        orr     r0, r0, r2, lsr #8
        and     r3, r3, #0x0000ff00
        orr     r0, r0, r3, asl #8

Ignoring the load result delay that gcc should properly schedule anyway, 
that makes for 7 cycles.

Using the smarter ARM swab32 implementation from Linux we get:

        ldr     r3, [r0, #0]
        eor     r0, r3, r3, ror #16
        bic     r0, r0, #0x00ff0000
        mov     r0, r0, lsr #8
        eor     r0, r0, r3, ror #8

So we're down to 5 cycles.  And the SHA1 test is a bit faster too: 
4.570s down from 4.980s.  However this is still using purely aligned 
buffers.

Adding your patch using memcpy() to align the data in the unaligned case 
gives me wild results.  Sometimes it is 4.930s, sometimes it is 5.560s.  
I suspect the icache starts to get tight and sometimes the SHA1 code 
and/or the special unaligned memcpy path get evicted sometimes.

Using the byte access version we get:

        ldrb    r3, [r0, #3]
        ldrb    r2, [r0, #0]
        ldrb    r1, [r0, #1]
        orr     r3, r3, r2, asl #24
        ldrb    r0, [r0, #2]
        orr     r3, r3, r1, asl #16
        orr     r0, r3, r0, asl #8

Again 7 cycles, like the ntohl() based version, which is coherent with 
the fact that they both make for 4.980s..  However this time any buffer 
alignment is supported.  And in fact the extra 2 cycles over the 
swab32() version should actually be less overhead per word than the 
unaligned memcpy which is around 4 cycles per word.


Nicolas
