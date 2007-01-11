From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Thu, 11 Jan 2007 08:38:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> 
 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> 
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>  <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
  <20070107163112.GA9336@steel.home>  <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
  <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com> 
 <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
 <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 17:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H52xM-0003ot-9U
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 17:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXAKQi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 11:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXAKQi6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 11:38:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45533 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbXAKQi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 11:38:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BGcqWi028789
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 08:38:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BGcpwI029252;
	Thu, 11 Jan 2007 08:38:51 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com>
X-Spam-Status: No, hits=-2.665 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36597>



On Thu, 11 Jan 2007, Alex Riesen wrote:
> On 1/11/07, Linus Torvalds <torvalds@osdl.org> wrote:
> > >
> > > Yep. Tried the monster merge on it: 1m15sec on that small laptop.
> > 
> > Is that supposed to be good? That still sounds really slow to me. What
> > kind of nasty project are you doing? Is this the 44k file project, and
> > under cygwin? Or is it that bad even under Linux?
> 
> It is that "bad" on a 384Mb linux laptop and 1.2GHz Celeron.
> Yes, it is that 44k files project. The previous code finishes
> that merge on that laptop in about 20 minutes, so it's defnitely
> an improvement. My cygwin machine has a lot more memory (2Gb),
> so I can't really compare them here.

Ok. Junio, I'd suggest putting it into 1.5.0, then - it's a fairly simple 
thing, after all, and if it's the difference between 20 minutes and just 
over one minute, it clearly matters.

With 384MB of memory, and 44 thousand files, I bet the problem is just 
that the working set doesn't fit entirely in RAM. It probably caches 
*most* of it, but with inodes and directories being spread out on disk 
(and I assume there are more files in the actual working tree), so writing 
out a 6MB index file (or whatever) and then reading it back several times 
just ends up generating IO simply because 6MB is actually a noticeable 
chunk of memory in that situation.

(It also generates a ton of tree objects early, so the effect at run-time 
is probably much more than 6MB).

That said, I think we actually have another problem entirely:

Look at "write_cache()", Junio: isn't it leaking memory like mad?

Shouldn't we have something like this?

It's entirely possible that the _real_ problem with the "flush the index 
all the time" was that it just caused this bug: tons and tons of lost 
memory, causing git-merge-recursive to grow explosively (~6MB per 
cache flush, and a _lot_ of cache flushes), which on a 384MB machine 
quickly uses up memory and causes totally unnecessary swapping.

Of course, it's also entirely possible that I'm a complete retard, and 
just didn't see where the data buffer is still used or freed.

"Linus - complete retard or hero in shining armor? You decide!"

		Linus

---
diff --git a/read-cache.c b/read-cache.c
index 8ecd826..c54a611 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1010,7 +1010,7 @@ int write_cache(int newfd, struct cache_entry **cache, int entries)
 		if (data &&
 		    !write_index_ext_header(&c, newfd, CACHE_EXT_TREE, sz) &&
 		    !ce_write(&c, newfd, data, sz))
-			;
+			free(data);
 		else {
 			free(data);
 			return -1;
