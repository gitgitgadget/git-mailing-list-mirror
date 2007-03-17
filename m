From: Nicolas Pitre <nico@cam.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 23:28:33 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org>
 <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 04:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSPax-0003GU-V3
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 04:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133AbXCQD2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 23:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933958AbXCQD2g
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 23:28:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45551 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933133AbXCQD2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 23:28:35 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF1001L12ZLPWG1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 16 Mar 2007 23:28:34 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42419>

On Fri, 16 Mar 2007, Linus Torvalds wrote:

> The way we unpack delta chains is that we do
> 
>  - find a delta
>  - we apply it to "recursively unpack the thing it's a delta to"
> 
> which sounds totally obvious and straightforward, right?
> 
> EXCEPT it's actually O(n**2) in the delta depth, because we never save the 
> intermediate results, so when we have a delta depth of 10 (our default), 
> and we decode a lot of these things, we basically will look up the base 
> object 10 times, apply the first delta 9 times, apply the second delta 8 
> times, etc etc.. 

In the worst case, yes.  And if you're walking history then the 
probability of hitting the worst case eventually is rather high.

> I also didn't worry about it, because I felt that if it became a problem, 
> it would be easy to just add a cache of base objects (we probably do *not* 
> want to keep the whole unpacked object info in memory all the time just 
> because of memory pressure issues, so "cache of base objects" is better). 
> However, the "pack file + offset" thing makes it harder to do, since we 
> now don't even have the SHA1 of the base object before we unpack it.
> 
> But I guess we could just index this by a <packfile, offset> tuple.

Right.  Should be really trivial to hook into unpack_delta_entry() 
actually replacing the call to unpack_entry() with a wrapper function 
that returns cached data, or populates the cache with unpack_entry() 
when no match is found.

Then it would only be a matter of coming up with a clever cache 
eviction algorithm.

> Anyway, I bet that this is a much bigger issue than the pack format 
> itself (and is largely independent).

Well, I think the pack format issue is significant too.  But because 
those are independent issues the gain in performance will be additive.


Nicolas
