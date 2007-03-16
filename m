From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 10:51:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703161026220.3816@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703161236180.5518@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 18:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSGb7-0002Kn-Ly
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 18:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965783AbXCPRwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 13:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965795AbXCPRwK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 13:52:10 -0400
Received: from smtp.osdl.org ([65.172.181.24]:56712 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965783AbXCPRwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 13:52:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2GHpQcD031557
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 10:51:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2GHpOFE018077;
	Fri, 16 Mar 2007 09:51:24 -0800
In-Reply-To: <alpine.LFD.0.83.0703161236180.5518@xanadu.home>
X-Spam-Status: No, hits=-0.481 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42387>



On Fri, 16 Mar 2007, Nicolas Pitre wrote:

> On Fri, 16 Mar 2007, Linus Torvalds wrote:
> 
> > The most performance-critical objects for uncompression are commits and 
> > trees. At least for the kernel, the average size of a tree object is 678
> > bytes. And that's ignoring the fact that most of them are then deltified, 
> > so about 80% of them are likely just a ~60-byte delta.
> 
> This is why in pack v4 there will be an alternate tree object 
> representation which is not deflated at all.

Well, the thing is, for things that really don't compress, zlib shouldn't 
add much of an overhead on uncompression. It *should* just end up being a 
single "memcpy()" after you've done:
 - check the header for size and mode ("plain data")
 - check the adler checksum (which is *really* nice - we've found real 
   corruption this way!).

The adler32 checksumming may sound unnecessary when you already have the 
SHA1 checksum, but the thing is, we normally don't actually *check* the 
SHA1 except when doing a full fsck. So I actually like the fact that 
object unpacking always checks at least the adler32 checksum at each 
stage, which you get "for free" when you use zlib.

So not using compression at all actually not only gets rid of the 
compression, it gets rid of a good safety valve - something that may not 
be immediately obvious when you don't think about what all zlib entails. 

People think of zlib as just compressing, but I think the checksumming is 
almost as important, which is why it isn't an obviously good thing to not 
compress small objects just because you don't win on size!

Remember: stability and safety of the data is *the* #1 objective here. The 
git SHA1 checksums guarantees that we can find any corruption, but in 
every-day git usage, the adler32 checksum is the one that generally would 
*notice* the corruption and cause us to say "uhhuh, need to fsck".

Everything else is totally secondary to the goal of "your data is secure". 
Yes, performance is a primary goal too, but it's always "performance with 
correctness guarantees"!

But I just traced through a simple 60-byte incompressible zlib thing. It's 
painful. This should be *the* simplest case, and it should really just be 
the memcpy and the adler32 check. But:

	[torvalds@woody ~]$ grep '<inflate' trace | wc -l
	460
	[torvalds@woody ~]$ grep '<adler32' trace | wc -l
	403
	[torvalds@woody ~]$ grep '<memcpy' trace | wc -l
	59

ie we spend *more* instructions on just the stupid setup in "inflate()" 
than we spend on the adler32 (or, obviously, on the actual 60-byte memcpy 
of the actual incompressible data)

I dunno. I don't mind the adler32 that much. The rest seems to be 
pretty annoying, though.

		Linus
