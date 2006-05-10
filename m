From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix diff-delta bad memory access
Date: Wed, 10 May 2006 15:43:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605101515420.24505@localhost.localdomain>
References: <Pine.LNX.4.64.0605101216360.24505@localhost.localdomain>
 <Pine.LNX.4.64.0605100953090.3718@g5.osdl.org>
 <Pine.LNX.4.64.0605101311020.24505@localhost.localdomain>
 <Pine.LNX.4.64.0605101159160.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 10 21:43:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fduaw-0006ql-M9
	for gcvg-git@gmane.org; Wed, 10 May 2006 21:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWEJTng (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 15:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWEJTng
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 15:43:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40749 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751229AbWEJTnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 15:43:35 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZ2005W9ESMUS00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 May 2006 15:43:34 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0605101159160.3718@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19894>

On Wed, 10 May 2006, Linus Torvalds wrote:

> 
> 
> Btw, Nico, that rabin hash code is _extremely_ confusing.

Possible.

> The hash entry pointers point to "data + RABIN_WINDOW", and then to make 
> things even _more_ confusing, the hash calculation code is actually offset 
> by one, so it will have computed the hash with
> 
> 	val = ((val << 8) | data[i]) ^ T[val >> RABIN_SHIFT];
> 
> where "i" goes from _1_ to RABIN_WINDOW instead of 0..WINDOW-1.
> 
> So, if I read that correctly, the "entry->ptr" actually points not to the 
> beginning of the data that was hashed, or even the end, but literally to 
> the last byte of the data that was hashed in that window.
> 
> Isn't that just _really_ confusing?
> 
> Or is there some sense to this?

Yes, ptr points to the last byte of the window for given hash value.

This is so because in the matching loop the window is scrolled byte by 
byte and the new hash value is always made of ROBIN_WINDOW-1 bytes which 
already have been processed (most probably added as literal bytes in the 
delta buffer) plus one new byte.  So it makes sense to start forward 
byte matching only from that last byte to find the longest source area 
to match, especially since all the other bytes in the window are likely 
to be identical already and comparing them repeatedly for entries with 
the same hash would be wasteful in most cases.

Further down, once the best offset with the longest match in the source 
buffer has been found, backward matching is performed to remove as much 
literal bytes that were added to the delta output as possible, which is 
most likely to catch the whole Robin window that hasn't been compared 
previously, but in that case the window content is compared only once.

And the reason why the reference hash is computed with an offset of 1 to 
RABIN_WINDOW inclusive in create_delta_index() is to allow for quick 
initialization of the Rabin window _outside_ of the main loop in 
create_delta().  There is a comment to that effect near the top of 
create_delta_index but probably a small reminder should be added in the 
index loop as well.


Nicolas
