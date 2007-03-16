From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 09:51:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703160946060.3816@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <45FAC75B.3030902@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 17:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSFek-0006b6-1i
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 17:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965624AbXCPQvv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965635AbXCPQvv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 12:51:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:51813 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965624AbXCPQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 12:51:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2GGpIcD029389
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 09:51:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2GGpEWO016779;
	Fri, 16 Mar 2007 08:51:16 -0800
In-Reply-To: <45FAC75B.3030902@garzik.org>
X-Spam-Status: No, hits=-0.482 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42378>



On Fri, 16 Mar 2007, Jeff Garzik wrote:
>
> Although it sounds like zlib could indeed be optimized to reduce its startup
> and shutdown overhead, I wonder if switching compression algorithms to a pure
> Huffman or even RLE compression (with associated lower startup/shutdown costs)
> would perform better in the face of all those small objects.

Well, the thing is, I personally much prefer to have just a single 
compression algorithm and object layout. Most of the performance-critical 
objects from a decompression standpoint during commit traversal are all 
small (especially if you do pathname limiting), but when you do something 
like a "git add ." most objects are actually random blob objects and you 
need to have a compression algorithm that works in the general case too.

Of course, pack-v4 may (likely will) end up using different strategies for 
different objects (delta's in particular), but the "one single object 
compression type" was a big deal for initial implementation.

It's may not be fundamental to git operation (so we can fairly easily 
change it and make it more complex without any higher-level stuff even 
noticing), but it was definitely fundamental to "get something stable and 
working" up and running quickly..

> And another random thought, though it may be useless in this thread:  I bet
> using a pre-built (compiled into git) static zlib dictionary for git commit
> and tree objects might improve things a bit.

That's kind of pack-v4 area. It will happen, but I'd actually like to see 
if we can just avoid stupid performance problems with zlib, independently 
of trying to make more tuned formats.

		Linus
