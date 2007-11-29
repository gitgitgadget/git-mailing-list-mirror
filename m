From: Nicolas Pitre <nico@cam.org>
Subject: Re: Some git performance measurements..
Date: Wed, 28 Nov 2007 22:59:37 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 04:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxaZC-0005lr-Fh
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 04:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbXK2D7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 22:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756145AbXK2D7j
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 22:59:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10162 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637AbXK2D7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 22:59:38 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JS9001701RDTSN0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 28 Nov 2007 22:59:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66500>

On Wed, 28 Nov 2007, Linus Torvalds wrote:

>  - the index accesses are much more "random": the initial 256-way fan-out 
>    followed by the binary search causes the access patterns to look very 
>    different:
> 
> 	0: 28367707
> 	136: 18867574
> 	140: 221280
> 	141: 745890
> 	142: 284427
> 	143: 338
> 	381: 9787459
> 	377: 394
> 	375: 255
> 	376: 248
> 	3344: 29885989
> 	3347: 334
> 	3346: 255
> 	3684: 7251911
> 	1055: 12954064
> 	1052: 386
> 	1050: 251
> 	1049: 240
> 	1947: 10501455
> 	1944: 382
> 	1946: 262
> 
>    where it doesn't even read-ahead at all in the beginning (because it 
>    looks entirely random), but the kernel eventually *does* actually go 
>    into read-ahead mode pretty soon simply because once it gets into the 
>    binary search thing, the data entries are close enough to be in 
>    adjacent pages, and it all looks ok.

Did you try with version 2 of the pack index?  Because it should have 
somewhat better locality as the object SHA1 and their offset are split 
into separate tables.

> That said, I think there's something subtly wrong in our pack-file 
> sorting, and it should be more contiguous when we just do tree object 
> accesses on the top commit. I was really hoping that all the top-level 
> trees should be written entirely together, but I wonder if the "write out 
> deltas first" thing causes us to have those big gaps in between.

Tree objects aren't all together.  Related blob objects are interlaced 
with those tree objects.  But for a checkout that should actually 
correspond to a nice linear access.

And deltas aren't written first, but rather their base object.  And 
because deltas are based on newer objects, in theory the top commit 
shouldn't have any delta at all, and the second commit should have all 
the base objects for its deltas already written out a part of the first 
commit.  At least that's what a perfect data set would produce.  Last 
time I checked, there was about 20% of the deltas that happened to be in 
the other direction, i.e. the deltified object was younger than its base 
object, most probably because the new version of the file shrunk instead 
of growing which is against the assumption in the delta search 
object sort.  But again, because the base object is needed to resolve 
the delta, it will be read anyway.


Nicolas
