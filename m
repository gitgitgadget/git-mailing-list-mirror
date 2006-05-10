From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] fix diff-delta bad memory access
Date: Wed, 10 May 2006 13:27:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605101311020.24505@localhost.localdomain>
References: <Pine.LNX.4.64.0605101216360.24505@localhost.localdomain>
 <Pine.LNX.4.64.0605100953090.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 10 19:28:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdsTK-0005C3-1F
	for gcvg-git@gmane.org; Wed, 10 May 2006 19:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWEJR12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 13:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWEJR12
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 13:27:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13475 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965019AbWEJR11
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 13:27:27 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZ200LM08HQD2E0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 May 2006 13:27:26 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0605100953090.3718@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19891>

On Wed, 10 May 2006, Linus Torvalds wrote:

> On Wed, 10 May 2006, Nicolas Pitre wrote:
> >
> > It cannot be assumed that the given buffer will never be moved when 
> > shrinking the allocated memory size with realloc().  So let's ignore 
> > that optimization for now.
> 
> Yeah, that was totally bogus. It would re-allocate _part_ of an 
> allocation, but that allocation contained not just the index, but all the 
> hashes and the hash entries too!

Yep.

> This has nothing to do with moving a buffer - it has everything to do with 
> the fact that you shrunk a buffer that still contained all the other 
> buffers: you shrunk the "mem" allocation to fit just the first part of it, 
> and entirely ignored the "hash" and "entry" parts of it.

No.

The initial allocation assumes a perfectly even distribution of entries 
in which case the entry array would be all populated.

When there are repeated bytes then consecutive blocks will have the same 
hash, and in that case keeping only the first one is useful.

Which means that the entry pointer won't get to the end of the allocated 
space for all entries and I naively assumed that using realloc would 
only mark the allocated memory as smaller than it originally was without 
actually copying any of the remaining data, which is what happened in 
most cases but evidently not always.

But if the buffer moves the hash array containing _pointers_ to hash 
entries gets totally screwed.

> Btw, I think that whole "allocate everything in one allocation" thing is 
> potentially bogus even the way it is now, if the alignment constraints of 
> "index", "hash" and "entry" are different.

Yeah...  I might just do a separate allocation for hash entries as well.

Or maybe even drop the hash chaining altogether (now that the code does 
backward matching that might be worth the code simplification).


Nicolas
