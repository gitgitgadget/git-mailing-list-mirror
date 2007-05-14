From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Optimize diff-delta.c
Date: Mon, 14 May 2007 12:34:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705141130480.24220@xanadu.home>
References: <1179089413753-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon May 14 18:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HndV7-0007Df-K0
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbXENQeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbXENQeQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:34:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:26728 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbXENQeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 12:34:15 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JI100IZQI0W3295@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 May 2007 12:34:08 -0400 (EDT)
In-reply-to: <1179089413753-git-send-email-mkoegler@auto.tuwien.ac.at>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47268>

On Sun, 13 May 2007, Martin Koegler wrote:

> ---
> On Fri, 04 May 2007, Nicolas Pitre wrote:
> > On Fri, 4 May 2007, Martin Koegler wrote:
> > > On 2007-05-01 16:05:24, Nicolas Pitre wrote:
> > > In the long term, I think, that the delta generation code needs to get
> > > tunable.
> > 
> > No.  It should be self-tunable certainly, but there are way too many 
> > config options already, and another one for the inner working of the 
> > delta algorithm would be a bit too esoteric for most users and they 
> > won't get advantage of it.  This thing really has to self tune itself.
> 
> I would like that too, but that will probably not the case for
> everybody. 
> 
> Why does git has options to control the zlib compression?  
> 
> Why are patches like "Custom compression levels for objects and packs"
> (http://www.spinics.net/lists/git/msg30244.html) sent to the mailing
> list?

Because there is no nice ways to auto-tune them given the current zlib 
interface.

> > > > > I tried to speed up the delta generation by searching for a common 
> > > > > prefix, as my blobs are mostly append only. I tested it with about 
> > > > > less than 1000 big blobs. The time for finding the deltas decreased 
> > > > > from 17 to 14 minutes cpu time.
> > > > 
> > > > I'm surprised that your patch makes so much of a difference.  Normally 
> > > > the first window should always match in the case you're trying to 
> > > > optimize and the current code should already perform more or less the 
> > > > same as your common prefix match does.
> > > 
> > > A block is limited to 64k. If the file has some hundred MBs, it has to
> > > match many blocks.
> > 
> > Only if the first match is smaller than 64K.  If the first match is 64K 
> > in size then the rest of the file is not considered at all.
> 
> If I read the code correctly, the currect code does a new hash table
> search after writing a block.

Right.

> As my original patch is not considering other and possibly better
> matches, I rewrote the patch. The new version matches block of
> unlimited length (stopping after finding a match >=64kB). If the block
> it bigger than 64kB, it writes block of 64kB in a loop.

I like this idea a lot.

> The patch recomputes the hash of 16 bytes after writing a block, as I
> haven't had time to correct the hash update code for blocks < 16
> bytes. (By the way, is this code path necessary?)

It certainly helps in those cases where the block match is smaller than 
a Rabin window size, although I don't know how much.  Sliding the window 
over 8 bytes might be approximately the same cost as computing the 
hash from scratch over 16 bytes since in the sliding case there are 
twice the amount of pointer dereferences.  So the test should probably 
be "if (msize >= RABIN_WINDOW/2) ..." for the full reinitialization.

> I did some tests on differenent machines:
> 
> Repacking a test repository with big blobs:
> 
> - original version:
>    Total 6452 (delta 4582), reused 1522 (delta 0)
>    11752.26user 4256.21system 4:26:52elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
>    0inputs+0outputs (576major+1042499851minor)pagefaults 0swaps
>    =>92 MB pack size
> - your patch (stop at 4096 bytes block size):
>    Total 6452 (delta 4582), reused 1522 (delta 0)
>    11587.41user 4064.73system 4:20:54elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
>    0inputs+0outputs (0major+1042500427minor)pagefaults 0swaps
>    =>92 MB pack size
> - my first patch
>    Total 6452 (delta 4706), reused 1450 (delta 0)
>    10316.93user 4220.67system 4:02:20elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
>    0inputs+0outputs (0major+1045003394minor)pagefaults 0swaps
>    =>92 MB pack size
> - attached patch
>    Total 6452 (delta 4581), reused 1522 (delta 0)
>    11354.38user 5451.60system 4:40:09elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
>    0inputs+0outputs (0major+1371504762minor)pagefaults 0swaps
>    =>75 MB pack size

This is quite weird.  I wonder what might cause such a large difference 
in pack size.

Your first patch is probably faster due to the use of memcmp() which is 
certainly highly optimized, more than the comparison loop we have.  It 
is unfortunate that there is no library function to find the number of 
identical bytes between two buffers.  Or is there some?

But the size difference?  That has certainly something to do with your 
data set since your patch makes no significant difference on the git.git 
nor the Linux kernel repos.  Would it be possible for me to have a copy 
of your repo for further analysis?


Nicolas
