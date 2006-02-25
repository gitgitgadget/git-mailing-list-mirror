From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 22:07:29 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602242130030.31162@localhost.localdomain>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 04:08:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCpmQ-00066W-IW
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 04:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWBYDHb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 22:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWBYDHb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 22:07:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61641 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932591AbWBYDHb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 22:07:31 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV800D583CHR8I0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 22:07:30 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0602241637480.22647@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16751>

On Fri, 24 Feb 2006, Linus Torvalds wrote:

> 
> 
> On Fri, 24 Feb 2006, Nicolas Pitre wrote:
> > 
> > Currently, diff-delta takes blocks of data in the reference file and 
> > hash them.  When the target file is scanned, it uses the hash to match 
> > blocks from the target file with the reference file.
> > 
> > If blocks are hashed evenly the cost of  producing a delta is at most 
> > O(n+m) where n and m are the size of the reference and target files 
> > respectively.  In other words, with good data set the cost is linear.
> 
> Assuming the hash is good, of course.
> 
> I think this was the problem with you trying something simpler than 
> adler32..

Well, that's the compromize to make.  By default the version with 
adler32 used 16 byte blocks to index the reference buffer.  That means 
you can match target data against the reference only if whole 16 byte 
blocks match.  Then, if you fix a typo in the target buffer then you'll 
inevitably need 16 literal bytes in the delta instead of only 
one because you won't be able to resynchronize with the reference buffer 
until the next 16 byte block.

What I've made in my last delta patch is to reduce that 16 byte block to 
only 3 bytes.  Why 3 bytes? Because less than that produces smaller 
delta data if done with literal bytes directly, and 3 bytes provided 
enough bits to hash.  I also made those 3 byte blocks overlap so 
indexing would start at any offset with byte precision.  This really 
allows for optimal deltas so that they cannot be smaller.

Now the problem comes when indexing a reference file full of:

        0x46f8, 0x000b, 0x42fe, 0x0000, 0xffc0, 0x0001, 0xff00, 0x0008,
        0x03e0, 0x0009, 0x0f01, 0x0003, 0x8072, 0x0000, 0x0400, 0x0000,
        0x0046, 0x0003, 0x9180, 0x0001, 0x0003, 0x0008, 0x02eb, 0x0003,
        0x8072, 0x0000, 0x0400, 0x0000, 0x8010, 0x0008, 0x0010, 0x0000,
        0x0361, 0x0003, 0x037e, 0x0004, 0x3941, 0x0002, 0x0b0f, 0x0003,
        0x8072, 0x0000, 0x0400, 0x0000, 0x000a, 0x000b, 0x0346, 0x000c,
        0x11fe, 0x0000, 0x3717, 0x0003, 0x8072, 0x0000, 0x0400, 0x0000,
        0x8010, 0x0008, 0x000e, 0x0000, 0x0361, 0x0003, 0x8060, 0x0000,

There is a bunch of ", 0x" that get hashed to the same thing.  And when 
the second phase i.e. trying to find the best match into the reference 
buffer for each occurrence of the same many ", 0x" in the target buffer 
you get a conbinatorial explosion.

The adler32 made that particular example a non issue since the 
likelyhood of many 16 byte blocks to be the same is pretty low in this 
case.  But the flaw remains if for example there is lots of similar 16 
byte blocks, like a binary file with lots of zeroes for example.  In 
fact, the performance problem Carl is having does use the diff-delta 
version still using adler32.

> > But if many blocks from the reference buffer do hash to the same bucket 
> > then for each block in the target file many blocks from the reference 
> > buffer have to be tested against, making it tend towards O(n^m) which is 
> > pretty highly exponential.
> > 
> > The solution I'm investigating is to put a limit on the number of 
> > entries in the same hash bucket so to bring the cost back to something 
> > more linear.  That means the delta might miss on better matches that 
> > have not been hashed but still benefit from a limited set.
> 
> Sounds fair enough.

Testing appear to show that this is a worthwhile safety valve.  And in 
most case that safety valve should not be activated at all.

> However, you migt also want to consider another approach..
> 
> One of the biggest costs for the xdelta algorithm is probably just the 
> "delta_prepare()", but at the same time, that is constant wrt the source 
> buffer.

Actually it is not that costly.  Much much less than computing the sha1 
of the same buffer for example.

> Now, the sad part is that when I wrote pack-objects, I didn't really 
> understand the diff-delta algorithm, I just plugged it in. Which means 
> that when I did it, I made the (obvious and simple) decision to keep the 
> _result_ that we are looking at constant, and try to delta against 
> different sources.
> 
> HOWEVER.
> 
> I suspect you already see where this is going..
> 
> We _could_ switch the "pack-objects" window handling around, and instead 
> of looking at the object we want to pack, and looking at the ten (or 
> "window") previous objects to delta against, we could do it the other way 
> around: keep the object we delta against constant, and see what deltas we 
> could prepare for the ten next objects.
> 
> And since the source would now be constant, you'd need to do the 
> "delta_prepare()" just _once_ per window, instead of every single time.

Might be worth trying.  Actually, this can be tested without even 
changing the window handling just yet, since diff-delta() could return 
the index data instead of freeing it, and pack-objects can store it 
along side with the object data it tries to delta against.  That 
wouldn't be memory efficient, but at least that would give an idea of 
the magnitude of the saving on CPU time.  But I really doubt that'll 
save more than a few percent.





> 
> Now, I haven't done any profiling on the diff-delta code, and maybe my 
> guess that delta_prepare() is a pretty expensive part is wrong, and maybe 
> it wouldn't help to switch the window probing around. But I thought I'd 
> mention it as one thing to explore..

Just to give you an idea, the bulk of my current "prepare" code looks 
like this:

        /* then populate the index */
        data = buf + bufsize - 2;
        while (data > buf) {
                entry->ptr = --data;
                i = (data[0] << hshift) ^ data[1];
                i ^= (i << hshift) ^ data[2];
                entry->next = hash[i];
                hash[i] = entry++;
        }

As you can see it is pretty lightweight.

But that would probably be a worthwhile optimization to have even if it 
saves 10% of CPU time.


Nicolas
