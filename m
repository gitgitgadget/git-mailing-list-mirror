From: Nicolas Pitre <nico@cam.org>
Subject: Re: block-sha1: improve code on large-register-set machines
Date: Tue, 11 Aug 2009 02:15:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908102246210.10633@xanadu.home>
References: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 17:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mat5z-00020f-3n
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 17:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbZHKPQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 11:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753345AbZHKPQw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 11:16:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33949 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbZHKPQw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 11:16:52 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KO700K3H82E61A0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Aug 2009 02:15:51 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.01.0908101637440.3417@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125571>

On Mon, 10 Aug 2009, Linus Torvalds wrote:

> 
> For x86 performance (especially in 32-bit mode) I added that hack to write 
> the SHA1 internal temporary hash using a volatile pointer, in order to get 
> gcc to not try to cache the array contents. Because gcc will do all the 
> wrong things, and then spill things in insane random ways.
> 
> But on architectures like PPC, where you have 32 registers, it's actually 
> perfectly reasonable to put the whole temporary array[] into the register 
> set, and gcc can do so.
> 
> So make the 'volatile unsigned int *' cast be dependent on a 
> SMALL_REGISTER_SET preprocessor symbol, and enable it (currently) on just 
> x86 and x86-64.  With that, the routine is fairly reasonable even when 
> compared to the hand-scheduled PPC version. Ben Herrenschmidt reports on 
> a G5:
> 
>  * Paulus asm version:       about 3.67s
>  * Yours with no change:     about 5.74s
>  * Yours without "volatile": about 3.78s
> 
> so with this the C version is within about 3% of the asm one.
> 
> And add a lot of commentary on what the heck is going on.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> I also asked David Miller to test the non-volatile version on Sparc, but I 
> suspect it will have the same pattern. ia64 likewise (but I have not asked 
> anybody to test).
> 
> Of the other architectures, ARM probably would wants SMALL_REGISTER_SET, 
> but I suspect the problem there is the htonl() (on little-endian), and 
> possibly the unaligned loads - at least on older ARM. The latter is 
> something gcc could be taught about, though (the SHA_SRC macro would just 
> need to use a pointer that goes through a packed struct member or 
> something).

The "older" ARM (those that don't perform unaligned accesses in 
hardware) are still the majority by far in the field.

Here some numbers on ARM for 203247018 bytes.

MOZILLA_SHA1:	14.520s
ARM_SHA1:	 5.600s
OPENSSL:	 5.530s

BLK_SHA1:	 5.280s		[original]
BLK_SHA1:	 7.410s		[with SMALL_REGISTER_SET defined]
BLK_SHA1:	 7.480s		[with 'W(x)=(val);asm("":"+m" (W(x)))']
BLK_SHA1:	 4.980s		[with 'W(x)=(val);asm("":::"memory")']

At this point the generated assembly is pretty slick.  I bet the full 
memory barrier might help on x86 as well.

However the above BLK_SHA1 works only for aligned source buffers.  So 
let's define our own SHA_SRC to replace the htonl() (which should 
probably be ntohl() by the way) like this:

#define SHA_SRC(t) \
  ({ unsigned char *__d = (unsigned char *)&data[t]; \
     (__d[0] << 24) | (__d[1] << 16) | (__d[2] << 8) | (__d[3] << 0); })

And this provides the exact same performance as the ntohl() based 
version (4.980s) except that this now cope with unaligned buffers too.

Of course the BLK_SHA1 version is a pig since it is totally unrolled

   text    data     bss     dec     hex filename
   1220       0       0    1220     4c4 mozilla-sha1/sha1.o
    852       0       0     852     354 arm/sha1_arm.o
   6292       0       0    6292    1894 block-sha1/sha1.o

so the speed advantage has a significant (but relative) code size cost.


Nicolas
