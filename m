From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Sat, 25 Feb 2006 00:10:54 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602242326381.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
 <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 06:11:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCrhu-0002TV-E1
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 06:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWBYFK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 00:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030184AbWBYFK4
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 00:10:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49830 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030181AbWBYFKz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 00:10:55 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV800A4Z926MA60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 25 Feb 2006 00:10:55 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0602241952140.22647@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16754>

On Fri, 24 Feb 2006, Linus Torvalds wrote:

> 
> 
> On Fri, 24 Feb 2006, Nicolas Pitre wrote:
> > 
> > Well, that's the compromize to make.  By default the version with 
> > adler32 used 16 byte blocks to index the reference buffer.  That means 
> > you can match target data against the reference only if whole 16 byte 
> > blocks match.  Then, if you fix a typo in the target buffer then you'll 
> > inevitably need 16 literal bytes in the delta instead of only 
> > one because you won't be able to resynchronize with the reference buffer 
> > until the next 16 byte block.
> 
> That shouldn't be true. Once you find a 16-byte match, you can search 
> forward (in theory you should be able to search backwards too, but by that 
> time we've already expanded the non-matching previous bytes, I think).

Obviously, but that's not my point.  What I mean is that small changes 
will kind of sabotage the match since you'll have to scan forward 
(adding literal bytes to the delta output in the mean time) until you 
find another 16 byte block that matches.  This is harder to find than a 
3 byte block.  Hence you'll end up adding more literal bytes (up to 16 
of them) until you can match the reference buffer again even if you only 
flipped one byte in the target buffer.  In some cases that makes up for 
deltas that are twice as large.

> > What I've made in my last delta patch is to reduce that 16 byte block to 
> > only 3 bytes.  Why 3 bytes? Because less than that produces smaller 
> > delta data if done with literal bytes directly, and 3 bytes provided 
> > enough bits to hash.
> 
> On the other hand, the cost is that your lookups _are_ going to be more 
> expensive. Regardless of how good the hash is, basically you have 16/3 
> more hash-entries to look up, so you've made compression more expensive in 
> footprint, at least (I assume you've made the hash appropriately larger).

Yes, the hash is larger.  There is a cost in memory usage but not really 
in CPU cycles.

> Also, at 3 bytes, insertion is at least equally dense (three bytes of data 
> vs three bytes of offset into the source), and can be worse (the offset 
> might be 5 bytes, no?). So it would seem like you'd be better off with 4+ 
> bytes, at which point the delta should be a win.

The code already discriminate the space of a block copy notation given 
the offset and size vs the space for the equivalent literal bytes.  So 
the optimal encoding is always chosen already.

In fact, if you want to copy up to 15 bytes from offset 0 that will be 
encoded with only 2 bytes in the delta.  The only case that is 
suboptimal is when you want to copy only two bytes from offset 0 (2 
delta bytes) but only two bytes is mever matched by the hash lookup 
since the hash is computed with 3 bytes.  In that case 2 literal bytes 
will be added to the delta plus opcode = 3 bytes.  I considered that 
special case not worth it.  However copying a block of 3 bytes that gets 
encoded into 3 bytes of delta is quite common (that'd take 4 bytes of 
delta if they were literals).

As for using more bytes for block hashing, that increase thenumber of 
cycles to compute the hash.  The adler32 version reads 16 bytes for 
every byte offset in the target file while my latest version only reads 
3 bytes for every byte offset.  So in effect my target hash computation 
is faster than the adler32 one.  However there is potentially more 
entries in the same hash bucket to validate especially with repetitive 
data.

> Have you tried some half-way point, like ~8 bytes?

Yes, and while the needed cycles tend to remain the same on average, the 
resulting pack gets larger.

> > Now the problem comes when indexing a reference file full of:
> > 
> >         0x46f8, 0x000b, 0x42fe, 0x0000, 0xffc0, 0x0001, 0xff00, 0x0008,
> ...
> > 
> > There is a bunch of ", 0x" that get hashed to the same thing.
> 
> You'll find a lot of that in any file: three or four bytes of similarity 
> just doesn't sound worthwhile to go digging after. 

Well after having experimented a lot with multiple parameters I think 
they are worth it after all.  Not only they provide for optimal deltas, 
but their hash is faster to compute than larger blocks which seems to 
counter balance for the cost of increased hash list.

> > The adler32 made that particular example a non issue since the 
> > likelyhood of many 16 byte blocks to be the same is pretty low in this 
> > case.  But the flaw remains if for example there is lots of similar 16 
> > byte blocks, like a binary file with lots of zeroes for example.  In 
> > fact, the performance problem Carl is having does use the diff-delta 
> > version still using adler32.
> 
> Agreed. I think limiting the hash length is a fine idea regardless, I just 
> think it sounds dangerous with the three-byte thing where a lot of matches 
> should be expected (never mind ", 0x", just things like newlines and tabs 
> in source code).

They are usually less than the number of lines.  Yet if you have a 1000 
line source file and let's suppose that we keep only 50 hashed "\n\t\t" 
this is sufficient to provide enough opportunities for matching that 
plus common patterns like a following "if (" for example.

> Only considering 16-byte sequences of similarities is a trade-off of 
> packing cost vs win.. Not saying other block-sizes aren't worth testing, 
> but I suspect trying too hard is going to be too costly.

I of course looked at the time to pack vs the size reduction in my 
tests.  And really like I said above the cost is well balanced.  The 
only issue is that smaller blocks are more likely to trap into 
patological data sets.  But that problem does exist with larger blocks 
too, to a lesser degree of course but still.  For example, using a 16 
block size with adler32, computing a delta between two files 

> Especially as deltas compress _worse_ the smaller they are. Bigger 
> "insert" chunks probably compress a lot better than a copy chunk. 

Yes, but given that we favor deltas from larger to smaller already those 
inserts are already not making much differences.  They have to be quite 
large to effectively provide better zlib compression.

> Have you looked at the delta size vs compression?

That's certainly an additional test worth adding to try_delta(). 
max_size should be smaller than the original object deflated size making 
sure we won't store deltas that might end up larger than the undeltified 
object.


Nicolas
