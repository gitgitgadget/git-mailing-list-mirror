From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Thu, 4 Jan 2007 13:12:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701041300410.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> 
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
 <204011cb0701041124g40440fd4udf1088ab1341c031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 22:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Zsw-0000XB-06
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 22:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbXADVMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbXADVMX
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 16:12:23 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:53383 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030191AbXADVMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 16:12:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l04LCJWi031699
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 4 Jan 2007 13:12:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l04LCISu031407;
	Thu, 4 Jan 2007 13:12:19 -0800
To: Chris Lee <chris133@gmail.com>
In-Reply-To: <204011cb0701041124g40440fd4udf1088ab1341c031@mail.gmail.com>
X-Spam-Status: No, hits=-0.672 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35956>



On Thu, 4 Jan 2007, Chris Lee wrote:
> 
> Seems like *something* was definitely lost there. The 'used' number
> didn't go down at all when I started doing other things; it went up as
> the new programs started

The 'used' number basically _never_ goes down as long as there is memory 
free. The kernel simply doesn't have any reason to free any of its caches, 
even if those caches end up not being very useful.

What happened is almost certainly that with your big unpacked repository, 
the kernel ended up using a lot of memory on filename caching. In other 
words, I'd have expected that if you were to do 

	cat /proc/slabinfo

you'd have seen a _lot_ of memory being used for dentries ("dentry_cache") 
and inodes ("ext3_inode_cache" assuming you're an ext3 user).

The kernel can easily drop those caches on demand, but "free" isn't quite 
smart enough to know about them as being caches, so they will just show up 
as "used".

That said, since you didn't want them, dropping them by hand with sysctl 
certainly didn't hurt. Manual control can often be better than automatic 
heuristics..

So the reason why repacking is so useful is that it gets rid of all these 
millions of individual files. They all take up space on the disk, but they 
also do end up having a lot of caches associated with them.

Btw, you may find that despite your 4GB of RAM, you might still be 
better off with a swapfile. It gives the kernel a certain amount of 
freedom in choosing how to allocate memory, and perhaps more importantly, 
even when the kernel doesn't actively use it, it means that IF the kernel 
runs out of totally free memory (because it has decided to keep a lot of 
stuff in the dentry cache), it gives the kernel choices, and a certain 
"buffer" for making the right decision.

What often happens is that the memory management heuristics don't make the 
"perfect" choice (partly because it's theoretically impossible anyway, but 
largely just because it's just a damn hard problem to even get all that 
*close* to perfect), and having a swap partition or even a swap file just 
allows the kernel to make some mistakes without it hitting a hard wall of 
"oh, I can't do anything at all about this particular page".

So that buffer zone can be helpful in avoiding bad situations, but it can 
actually also end up improving performance - it doesn't sound like the 
case in this particular situation, but in some other loads there really 
are a lot of dirty pages that aren't all that useful and where the memory 
really could be better used for other things if the largely unused dirty 
page could just be written to disk.

			Linus
