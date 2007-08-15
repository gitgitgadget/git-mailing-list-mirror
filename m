From: Nicolas Pitre <nico@cam.org>
Subject: Re: performance on repack
Date: Wed, 15 Aug 2007 17:05:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708151650270.5415@xanadu.home>
References: <9e4733910708111412t48c1beaahfbaa2c68a02f64f1@mail.gmail.com>
 <20070812103338.GA7763@auto.tuwien.ac.at>
 <9e4733910708120649g5a5e0f48pa71bd983f2bc2945@mail.gmail.com>
 <20070814031236.GC27913@spearce.org>
 <alpine.LFD.0.999.0708141634160.5415@xanadu.home>
 <20070815053231.GJ27913@spearce.org>
 <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQ3t-0004qg-HY
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761188AbXHOVFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbXHOVFu
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:05:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23553 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760855AbXHOVFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 17:05:49 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JMU004P02LO2PC0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Aug 2007 17:05:48 -0400 (EDT)
In-reply-to: <9e4733910708150808x39241071j1a4012f16cd26ef8@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55947>

On Wed, 15 Aug 2007, Jon Smirl wrote:

> You can avoid making all the low level calls thread safe by using the
> main thread to get everything into RAM before starting to search for
> the deltas. The worker threads would only deal with things completely
> in memory. You may need to ref count these in-memory objects if they
> are shared between worker threads. For simplicity the in-memory input
> objects should be read only by the threads. The worker threads create
> new structures to hand their results back to the main thread for
> writing to disk.
> 
> A typical solution is to use a queue protected by locks. Main thread
> faults in all the needed objects to cache. Main thread builds a queue
> entry and increments reference count on all referenced objects. Main
> thread uses locks to add entry to queue, while queue is locked it
> removes any finished jobs. Main thread writes finished results to
> disks, decrements ref counts. Cache logic can then take over about
> when objects are actually deleted.
> 
> Worker threads wait on the queue. When something is placed in the
> queue a waiting worker thread removes it, processes it, puts the
> results in RAM, and places the object back on the finished queue. Then
> waits for another object. It doesn't call into the main body of code.

Way too complex and rather unpractical with the current algorithms.

Currently, information on objects is gathered (the "Counting objects" 
phase) and that hardly can be paralleled.

Once objects are known then a sorted list is created so deltification of 
object x might be optimally attempted on objects x-1 through to x-10.  
Creating that list cannot be paralleled either, but it is quick 
anyway.

Then comes the actual deltification phase where the huge cost is. The 
problem simply has to be partitioned into a few threads, where thread 1 
deals with object 1 to 100000 from that sorted list, thread 2 has 
objects 100001 to 200000, etc. etc.  This is now a partitioning problem 
where the thread synchronization is dealt with from a higher and non 
performance critical level.


Nicolas
