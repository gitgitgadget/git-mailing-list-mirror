From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 17:50:18 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
 <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
 <20080813155016.GD3782@spearce.org>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
 <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
 <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 23:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkjC-0000jX-Tm
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbYHNVu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 17:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYHNVu2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:50:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62491 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbYHNVu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:50:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5M00FHS1ZXB7LF@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Aug 2008 17:50:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92408>

On Thu, 14 Aug 2008, Linus Torvalds wrote:

> Here's a hint: the cost of a cache miss is generally about a hundred times 
> the cost of just about anything else. 
> 
> So to make a convincing argument, you'd have to show that the actual 
> memory access patterns are also much better.
> 
> No, zlib isn't perfect, and nope, inflate_fast() is no "memcpy()". And 
> yes, I'm sure a pure memcpy would be much faster. But I seriously suspect 
> that a lot of the cost is literally in bringing in the source data to the 
> CPU. Because we just mmap() the whole pack-file, the first access to the 
> data is going to see the cost of the cache misses.

Possible.  However, the fact that both the "Compressing objects" and the 
"Writing objects" phases during a repack (without -f) together are 
_faster_ than the "Counting objects" phase is a sign that something is 
more significant than cache misses here, especially when tree 
information is a small portion of the total pack data size.

Of course we can do further profiling, say with core.compression set to 
0 and a full repack, or even hacking the pack-objects code to force a 
compression level of 0 for tree objects, and possibly commits too since 
pack v4 intend to deflate only the log text).  Tree objects delta very 
well, but they don't deflate well at all.

OK, so I did, and the quick test for the kernel is:

|nico@xanadu:linux-2.6> time git rev-list --all --objects > /dev/null
|
|real    0m14.737s
|user    0m14.432s
|sys     0m0.296s

That's for 1031404 objects, hence we're now talking around 70k 
objects/sec instead of 48k objects/sec.  _Only_ by removing zlib out of 
the equation despite the fact that the pack is now larger.  So I bet 
that additional improvements from pack v4 could improve things even 
more, including the object lookup avoidance optimization I mentioned 
previously.


Nicolas
