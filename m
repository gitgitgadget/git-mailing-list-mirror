From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some git performance measurements..
Date: Wed, 28 Nov 2007 19:14:50 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 04:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxZsN-00050x-B9
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 04:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757378AbXK2DPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 22:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757308AbXK2DPX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 22:15:23 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49211 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754839AbXK2DPW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 22:15:22 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAT3EpTa029220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 19:14:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAT3EoCn000715
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 19:14:50 -0800
In-Reply-To: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.569 required=5 tests=AWL,BAYES_00,SARE_MILLIONSOF
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66495>



On Wed, 28 Nov 2007, Linus Torvalds wrote:
> 
> Sadly, one big reason for performance downsides is actually hard to 
> measure: since we mmap() all the really critical data structures (the 
> pack-file index and data), it doesn't show up really well in any of the 
> otherwise really useful performance tools (eg strace and ltrace), because 
> the bulk of the time is actually spent not in libraries or in system 
> calls, but simply on regular instructions that take a page fault.

Side note: while the ".gitignore" issue actually overshadowed everything 
else for things like "git checkout" and "git merge", I do have some traces 
for page faults too. They're kind of interesting, but actually show that 
we do reasonably well in this area - certainly much better than if we 
tried to keep things in multiple independent files.

The pack-files (both index and data) are accessed somewhat randomly, but 
there is still enough locality that doing read-ahead and clustering really 
does help.

So while "git checkout" actually end up reading a lot of git "tree" 
objects (as many tree objects as there are .gitignore files that we try to 
open unnecessarily!), we actually spend a *lot* less time on the pack-file 
operations than we do on trying to do the futile ".gitignore" opens in 
every directory. 

If somebody cares, I do have the page fault traces on those things for the 
same "git checkout" that had the horrid .gitignore behaviour. What's 
interesting is:

 - the pack-file really does get accessed in nice increasing patterns for 
   the top-of-tree. So the fact that we sort objects "topologically" does 
   actually seem to work pretty well (yeah, it was obvious, but it's nice 
   to have a real page fault trace that shows the effect!)

   The accesses seemed to be *totally* ordered. There were obvously gaps 
   (ie they weren't *dense*, since we only looked at one version of the 
   trees in "git checkout"), but at the same time, it certainly wasn't 
   random or causing any horrible seeking back-and-forth.

 - we're *reasonably* dense in pack-file accesses. Not wonderful, but not 
   horrible. That in turn means that read-ahead kicks in and works ok. The 
   pattern for the pack-file hat I caught looks like this (the format is 
   "pageindex: cycles-to-fill-in-kernel"):

	6810: 15202545
	6811: 353
	6812: 267
	6813: 476
	6814: 559
	6826: 1086510
	6878: 13948057
	6894: 9756446
	6896: 300
	6899: 307
	6903: 319
	6907: 293
	6910: 666120
	6912: 401
	6913: 330
	6916: 401
	6918: 303
	6919: 330
	6931: 784373
	6943: 405
	6944: 187
	6945: 315
	...

   and here you can see that read-ahead works fine about 60% of the time,
   with most pages taking just 300-500 CPU cycles (no actual IO, of 
   course!) to find/lookup, but then when there are discontinuities we 
   have the cost of the real IO, and the cost for those obviously then 
   jumps into the tens of millions of cycles (ie we're talking 
   several milliseconds).

 - the index accesses are much more "random": the initial 256-way fan-out 
   followed by the binary search causes the access patterns to look very 
   different:

	0: 28367707
	136: 18867574
	140: 221280
	141: 745890
	142: 284427
	143: 338
	381: 9787459
	377: 394
	375: 255
	376: 248
	3344: 29885989
	3347: 334
	3346: 255
	3684: 7251911
	1055: 12954064
	1052: 386
	1050: 251
	1049: 240
	1947: 10501455
	1944: 382
	1946: 262

   where it doesn't even read-ahead at all in the beginning (because it 
   looks entirely random), but the kernel eventually *does* actually go 
   into read-ahead mode pretty soon simply because once it gets into the 
   binary search thing, the data entries are close enough to be in 
   adjacent pages, and it all looks ok.

   As a result, by the end of the run, all the index file pages have been 
   cached, and we're getting uniformly low numbers (ie in the hundreds of 
   cycles, not millions):

	...
	490: 810
	489: 352
	488: 334
	2254: 907
	91: 484
	3580: 776
	962: 806
	522: 761
	2494: 514
	805: 653
	177: 495
	176: 375
	2861: 439
	649: 660
	648: 518
	...

   so the pack index file access patterns are much less predictable, but 
   since the pack index is so dense and relatively small, that doesn't end 
   up being a problem in the long run, and only in the beginning do we pay 
   a highish cost for having to read it into memory.

In other words: we do ok. I think we could do better (and an SSD would 
certainly help, since we're never going to do long and 100% contiguous 
IO), but I was expecting to see *big* trouble, and it really wasn't that 
horrid.

That said, I think there's something subtly wrong in our pack-file 
sorting, and it should be more contiguous when we just do tree object 
accesses on the top commit. I was really hoping that all the top-level 
trees should be written entirely together, but I wonder if the "write out 
deltas first" thing causes us to have those big gaps in between.

			Linus
