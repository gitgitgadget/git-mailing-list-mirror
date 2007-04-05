From: Nicolas Pitre <nico@cam.org>
Subject: Re: kde.git is now online
Date: Thu, 05 Apr 2007 18:00:11 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704051703140.28181@xanadu.home>
References: <46152BF5.3050502@zytor.com>
 <Pine.LNX.4.64.0704051029240.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704051334590.28181@xanadu.home>
 <alpine.LFD.0.98.0704051532240.28181@xanadu.home>
 <Pine.LNX.4.64.0704051338290.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Lee <clee@kde.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZa0C-0003d2-4W
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767365AbXDEWAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767367AbXDEWAP
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:00:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43225 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767365AbXDEWAO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:00:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG100IV3P4CZF70@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Apr 2007 18:00:12 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704051338290.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43862>

On Thu, 5 Apr 2007, Linus Torvalds wrote:

> Without "--full", it doesn't actually really do anything much, since it 
> will basically ignore objects that are in the pack.
> 
> With --full, there are certainly things that we could improve upon. We 
> currently tend to walk things a few times for pack contents: 
>  - first we do the SHA1 of the full pack
>  - then we go back, and unpack and fsck each entry in the pack.
> 
> So if the pack-file is too big to fit in memory, we'll basically always 
> read it at least twice (and that's ignoring the fact that delta lookup 
> will obviously seek back and forth, which makes access patterns worse).
> 
> On the other hand, there's a perfectly good reason why we don't actually 
> fsck pack-files by default. They're "stable storage". You don't normally 
> need to. So I'd not worry too much about fsck performance.

Well.... still it certainly can be helped a bit.  I wouldn't mind it 
spending half an hour of CPU if it needs to.  But I just interrupted it
with ^C with the following result so far:

real    75m44.374s
user    2m5.318s
sys     0m54.059s

(I should have used /usr/bin/time to see the number of page faults).

> I suspect you'll find that with 1GB or RAM you'll have other 
> performance problems that are more pressing ("git clone" comes to mind 
> ;)

Well... same issue actually.  git-pack-objects spent about 40 secs 
firmly at 100% CPU usage counting objects.

Then it got stuck on:

	remote: Done counting 4111366 objects.

again spending 3% CPU and the rest waiting for IO with the disk 
definitely trashing.  It didn't allocate more than 47% of memory during 
that phase which lasted a few minutes.

Then, the "Indexing 4111366 objects." message appeared and CPU usage 
went up to 6% CPU with 67% memory for pack-objects and 30% CPU and 7% 
memory for index-pack while the rest was spent waiting for IO.  This 
also took maybe two minutes.

And now it reached the "Resolving 3305158 deltas." phase with only 
index-pack on the radar with approx 10% CPU and 19% memory, and the rest 
of the time waiting for IO again.

It has been probably half an our now and the thing is at:

	  21% (710502/3305158) done

So it will work and eventually complete.  And the good news is that the 
worst part performance wise is on the client side.  But it looks like 
we're definitely trashing the kernel buffer cache.


Nicolas
