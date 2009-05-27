From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 15:07:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
 <20090527215314.GA10362@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 00:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9RIw-00054a-S9
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 00:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbZE0WIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 18:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756523AbZE0WIu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 18:08:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57113 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756373AbZE0WIt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 18:08:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4RM7o75023665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 May 2009 15:07:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4RM7nfs011576;
	Wed, 27 May 2009 15:07:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090527215314.GA10362@coredump.intra.peff.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120112>



On Wed, 27 May 2009, Jeff King wrote:
>
> Linus' "split into multiple objects" approach means you could perhaps
> split intelligently into metadata and "uninteresting data" sections
> based on the file type.

I suspect you wouldn't even need to. A regular delta algorithm would just 
work fairly well to find the common parts.

Sure, if the offset of the data changes a lot, then you'd miss all the 
deltas between two (large) objects that now have data that traverses 
object boundaries, but especially if the split size is pretty large (ie 
several tens of MB, possibly something like 256M), that's still going to 
be a pretty rare event.

IOW, imagine that you have a big file that is 2GB in size, and you prepend 
100kB of data to it (that's why it's so big - you keep prepending data to 
it as some kind of odd ChangeLog file). What happens? It would still delta 
fairly well, even if the delta's would now be:

 - 100kB of new data
 - 256M - 100kB of old data as a small delta entry

and the _next_ chunk woul be:

 - 100kB of "new" data (old data from the previous chunk)
 - 256M - 100kB of old data as a small delta entry

.. and so on for each chunk. So if the whole file is 2GB, it would be 
roughly 8 256MB chunks, and it would delta perfectly well: except for the 
overlap, that would now be 8x 100kB "slop" deltas.

So even a totally unmodified delta algorithm would shrink down the two 
copies of a ~2GB file to one copy + 900kB of extra delta.

Sure, a perfect xdelta thing that would have treated it as one huge file 
would have had just 100kB of delta data, but 900kB would still be a *big* 
saving over duplicating the whole 2GB.

> That would make things like rename detection very fast. Of course it has 
> the downside that you are cementing whatever split you made into history 
> for all time. And it means that two people adding the same content might 
> end up with different trees. Both things that git tries to avoid.

It's the "I can no longer see that the files are the same by comparing 
SHA1's" that I personally dislike.

So my "fixed chunk" approach would be nice in that if you have this kind 
of "chunkblob" entry, in the tree (and index) it would literally be one 
entry, and look like that:

   100644 chunkblob <sha1>

so you could compare two trees that have the same chunkblob entry, and 
just see that they are the same without ever looking at the (humongous) 
data.

The <chunkblob> type itself would then look like just an array of SHA1's, 
ie it would literally be an object that only points to other blobs. Kind 
of a "simplified tree object", if you will.

I think it would fit very well in the git model. But it's a nontrivial 
amount of changes.

			Linus
