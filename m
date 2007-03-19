From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Limit the size of the new delta_base_cache
Date: Mon, 19 Mar 2007 12:41:10 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191218190.18328@xanadu.home>
References: <20070319051437.GA22494@spearce.org>
 <Pine.LNX.4.64.0703190906320.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:41:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKvR-0006qt-K1
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbXCSQlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbXCSQlN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:41:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51904 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030368AbXCSQlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:41:12 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF500KFHT0M5UA0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 12:41:10 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703190906320.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42640>

On Mon, 19 Mar 2007, Linus Torvalds wrote:

> 
> 
> On Mon, 19 Mar 2007, Shawn O. Pearce wrote:
> >
> > Round two, based on comments on IRC from Junio:
> 
> One more change: please don't even *add* objects to the cache that are 
> bigger than 10-20% of the cache limit!
> 
> If you start adding big objects, and you have some cache limit, that will 
> make the cache seriously less useful by causing eviction of potentially 
> much more interesting objects, and also obviously causing the cache code 
> itself to spend much more time picking objects (since it's enough to have 
> just a few big objects to make the cache eviction decide it needs to 
> evict).
> 
> Limiting by size is also effective since anything that is more than a 
> megabyte is likely to be a blob anyway, and thus much less useful for 
> caching in the first place. So there are just tons of reasons to say 
> "don't even add it in the first place" if you decide to go with any limit 
> at all.

On the other hand......

Either you parse blobs or you don't.  If you only do logs with path 
limiting then you won't add blobs to the cache anyway.

If you do end up adding blobs to the cache that means you have blob 
deltas to resolve, and even that operation should benefit from the cache 
regardless of the object size.

In fact, the bigger is the object, the more effective will be the cache.  
Because you certainly don't want to have a complete breakdown in 
performance just because a blob just crossed the 20% treshold.

And because we usually walk objects from newest to oldest, and because 
deltas are usually oriented in the same direction, we only need to tweak 
the current eviction loop a bit so on average the oldest objects are 
evicted first so next time around the current base will still be there 
for the next delta depth.  Given the nature of the hash containing the 
object's offset that means starting the loop at the next entry index 
instead of zero which should do the trick pretty well.

Of course if you end up in a condition where you have to prune the cache 
continuously, you'll spend more cycles picking up the object to evict, 
but it is likely to be so much less work than reintering that O(n!) 
behavior with deflate we had without the cache, and even worse since we 
mean big objects in this case.

So I wouldn't add any rule of that sort unless it is actually proven to 
be bad.


Nicolas
