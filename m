From: Nicolas Pitre <nico@cam.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 14:09:13 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703161358010.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org>
 <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703161236180.5518@xanadu.home>
 <Pine.LNX.4.64.0703161026220.3816@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 19:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSGrp-00022Y-VZ
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 19:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965808AbXCPSJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 14:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965814AbXCPSJP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 14:09:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15242 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965808AbXCPSJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 14:09:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF000A8MD3DEWI0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 14:09:13 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703161026220.3816@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42388>

On Fri, 16 Mar 2007, Linus Torvalds wrote:

> On Fri, 16 Mar 2007, Nicolas Pitre wrote:
> 
> > This is why in pack v4 there will be an alternate tree object 
> > representation which is not deflated at all.
> 
> Well, the thing is, for things that really don't compress, zlib shouldn't 
> add much of an overhead on uncompression. It *should* just end up being a 
> single "memcpy()" after you've done:
>  - check the header for size and mode ("plain data")
>  - check the adler checksum (which is *really* nice - we've found real 
>    corruption this way!).

But the thing is that with tree objects which records are 6 fairly 
random bytes we already know that compression will never be worth it 
size wise, so it is not worth it even if the header overhead was zero.  
In that case it is preferable to do without compression entirely.

> The adler32 checksumming may sound unnecessary when you already have the 
> SHA1 checksum, but the thing is, we normally don't actually *check* the 
> SHA1 except when doing a full fsck. So I actually like the fact that 
> object unpacking always checks at least the adler32 checksum at each 
> stage, which you get "for free" when you use zlib.

We still can perform adler32 on undeflated objects directly though.  But 
they need no be stored in the pack.  I'd store the adler32 checksum for 
each object in the pack index as it can be recomputed by index-pack 
(which will do the full SHA1 validation anyway).


Nicolas
