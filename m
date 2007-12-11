From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 12:21:11 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111202470.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
 <alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_/j4ZNUiOmRXB6xzMlvzPQw)"
Cc: Jon Smirl <jonsmirl@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	gcc@gcc.gnu.org, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 18:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J28nt-0004Bp-CT
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 18:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXLKRVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 12:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbXLKRVe
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 12:21:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64945 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbXLKRVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 12:21:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW00223AVCWGM0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 12:21:13 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67886>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_/j4ZNUiOmRXB6xzMlvzPQw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 11 Dec 2007, Linus Torvalds wrote:

> That said, I suspect there are a few things fighting you:
> 
>  - threading is hard. I haven't looked a lot at the changes Nico did to do 
>    a threaded object packer, but what I've seen does not convince me it is 
>    correct. The "trg_entry" accesses are *mostly* protected with 
>    "cache_lock", but nothing else really seems to be, so quite frankly, I 
>    wouldn't trust the threaded version very much. It's off by default, and 
>    for a good reason, I think.

I beg to differ (of course, since I always know precisely what I do, and 
like you, my code never has bugs).

Seriously though, the trg_entry has not to be protected at all.  Why? 
Simply because each thread has its own exclusive set of objects which no 
other threads ever mess with.  They never overlap.

>    For example: the packing code does this:
> 
> 	if (!src->data) {
> 		read_lock();
> 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
> 		read_unlock();
> 		...
> 
>    and that's racy. If two threads come in at roughly the same time and 
>    see a NULL src->data, theÿ́'ll both get the lock, and they'll both 
>    (serially) try to fill it in. It will all *work*, but one of them will 
>    have done unnecessary work, and one of them will have their result 
>    thrown away and leaked.

No.  Once again, it is impossible for two threads to ever see the same 
src->data at all.  The lock is there simply because read_sha1_file() is 
not reentrant.

>    Are you hitting issues like this? I dunno. The object sorting means 
>    that different threads normally shouldn't look at the same objects (not 
>    even the sources), so probably not, but basically, I wouldn't trust the 
>    threading 100%. It needs work, and it needs to stay off by default.

For now it is, but I wouldn't say it really needs significant work at 
this point.  The latest thread patches were more about tuning than 
correctness.

What the threading could be doing, though, is uncovering some other 
bugs, like in the pack mmap windowing code for example.  Although that 
code is serialized by the read lock above, the fact that multiple 
threads are hammering on it in turns means that the mmap window is 
possibly seeking back and forth much more often than otherwise, possibly 
leaking something in the process.

>  - you're working on a problem that isn't really even worth optimizing 
>    that much. The *normal* case is to re-use old deltas, which makes all 
>    of the issues you are fighting basically go away (because you only have 
>    a few _incremental_ objects that need deltaing). 
> 
>    In other words: the _real_ optimizations have already been done, and 
>    are done elsewhere, and are much smarter (the best way to optimize X is 
>    not to make X run fast, but to avoid doing X in the first place!). The 
>    thing you are trying to work with is the one-time-only case where you 
>    explicitly disable that big and important optimization, and then you 
>    complain about the end result being slow!
> 
>    It's like saying that you're compiling with extreme debugging and no
>    optimizations, and then complaining that the end result doesn't run as 
>    fast as if you used -O2. Except this is a hundred times worse, because 
>    you literally asked git to do the really expensive thing that it really 
>    really doesn't want to do ;)

Linus, please pay attention to the _actual_ important issue here.

Sure I've been tuning the threading code in parallel to the attempt to 
debug this memory usage issue.

BUT.  The point is that repacking the gcc repo using "git repack -a -f 
--window=250" has a radically different memory usage profile whether you 
do the repack on the earlier 2.1GB pack or the later 300MB pack.  
_That_ is the issue.  Ironically, it is the 300MB pack that causes the 
repack to blow memory usage out of proportion.

And in both cases, the threading code has to do the same 
work whether or not the original pack was densely packed or not since -f 
throws away every existing deltas anyway.

So something is fishy elsewhere than in the packing code.


Nicolas

--Boundary_(ID_/j4ZNUiOmRXB6xzMlvzPQw)--
