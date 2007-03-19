From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Limit the size of the new delta_base_cache
Date: Mon, 19 Mar 2007 14:08:36 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191332240.18328@xanadu.home>
References: <20070319051437.GA22494@spearce.org>
 <Pine.LNX.4.64.0703190906320.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703191218190.18328@xanadu.home>
 <Pine.LNX.4.64.0703191004560.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703191008400.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 19:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTMHs-0006lF-Ni
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 19:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbXCSSIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 14:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbXCSSIn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 14:08:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52710 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030469AbXCSSIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 14:08:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF500HTHX2C5NK0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 14:08:36 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703191008400.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42649>


First this is Shawn's patch not mine.  But I still don't think it is 
that bad even as is, and it was already merged by Junio.  I believe it 
can be made better without segregating big objects though.

On Mon, 19 Mar 2007, Linus Torvalds wrote:

> And no, I don't have any "hard numbers" to back this up, but if you want 
> another argument, realize that delta chains are limited to a depth of ten, 
> and if a *single* chain can overflow the delta-chain cache, then the cache 
> ends up being 100% *in*effective.

No.  You forget what I said about delta direction.

Deltas are meant to be ordered so a newer object should be a base for an 
older objects.  And we usually parse objects from newer to older ones 
too.

So let's suppose that the cache has only two entries.  If there was only 
one delta chain in the pack and it is ideally laid out so the delta 
chain is effectively going deeper with older objects as we currently 
mean it to, then the cache would still be perfectly effective because, 
as we move further back in history, objects deeper in the delta chain 
will be requested, and the delta base a single level up will be there to 
be used just before being evicted.  And so on all through the delta 
chain.

> And do the math: if the object size is 
> 10-20% of the total allowed cache size, how many objects in the chain are 
> you going to fit in the cache?

Only 5 objects in the 20% case.  But as I say you could effectively have 
only _one_ entry in the cache and it would still be 100% effective in 
the single perfect delta chain I described above.

Of course in practice there is more than a single delta chain, and the 
delta direction might be the other way around.  But on _average_ it 
should work fine pretty well.

And notice how blobs are the first victims for cache eviction.  So for a 
mixed tree+blob usage case, if big blobs are to trash the cache, then 
with LRU eviction performance should auto-regulate itself quite fine.  
Of course a single blob might clear the cache entirely in the worst 
case.  But there is a possibility that this big blob could be the base 
for the next delta.  Adding a size treshold simply throw that 
possibility away in which case your performance will suffer _anyway_ 
because you'll experience the O(n**2) behavior with that delta chain of 
big blobs.  Compared to that the lost cache of small objects won't even 
be on the radar.  But if you let large objects reach the cache then 
there is at least some possibility that those large objects might be the 
next wanted delta base effectively saving big time on performance 
especially if that base was itself a deep delta object.

So to resume:

 - the issue concerns only operations needing blob parsing

 - if large deltified blobs are denied the cache you will _always_ have
   a sudden and drastic performance degradation when the size treshold 
   is crossed as the O(n**2) behavior on those big blob deltas will 
   dominate the profile

 - if you instead don't impose any treshold then performance will 
   degrade smoothly with object size down to the absolute worst case of 
   a single object in the cache, and for some cases it might even be 
   quite effective!

I think it is therefore best to let the cache regulate itself with LRU 
eviction than using arbitrary size treshold to segregate objects.  The 
cache will quickly repopulate itself if the big blob happens to be  an 
odd ball in a repository anyway.


Nicolas
