From: Jeff King <peff@peff.net>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 15:43:48 -0400
Message-ID: <20090528194348.GH13499@coredump.intra.peff.net>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home> <20090527215314.GA10362@coredump.intra.peff.net> <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu May 28 21:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9lWG-00019y-Oq
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 21:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757419AbZE1Tn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 15:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757899AbZE1Tn4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 15:43:56 -0400
Received: from peff.net ([208.65.91.99]:50329 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757449AbZE1Tnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 15:43:55 -0400
Received: (qmail 22651 invoked by uid 107); 28 May 2009 19:43:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 15:43:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 15:43:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120217>

On Wed, May 27, 2009 at 03:07:49PM -0700, Linus Torvalds wrote:

> I suspect you wouldn't even need to. A regular delta algorithm would just 
> work fairly well to find the common parts.
> 
> Sure, if the offset of the data changes a lot, then you'd miss all the 
> deltas between two (large) objects that now have data that traverses 
> object boundaries, but especially if the split size is pretty large (ie 
> several tens of MB, possibly something like 256M), that's still going to 
> be a pretty rare event.

I confess that I'm not just interested in the _size_ of the deltas, but
also speeding up deltification and rename detection. And I'm interested
in files where we can benefit from their semantics a bit. So yes, with
some overlap you would end up with pretty reasonable deltas for
arbitrary binary, as you describe.

But I was thinking something more like splitting a JPEG into a small
first chunk that contains EXIF data, and a big secondary chunk that
contains the actual image data. The second half is marked as not
compressible (since it is already lossily compressed), and not
interesting for deltification. When we consider two images for
deltification, either:

  1. they have the same "uninteresting" big part. In that case, you can
     trivially make a delta by just replacing the smaller first part (or
     even finding the optimal delta between the small parts). You never
     even need to look at the second half.

  2. they don't have the same uninteresting part. You can reject them as
     delta candidates, because there is little chance the big parts will
     be related, even for a different version of the same image.

And that extends to rename detection, as well. You can avoid looking at
the big part at all if you assume big parts with differing hashes are
going to be drastically different.

> > That would make things like rename detection very fast. Of course it has 
> > the downside that you are cementing whatever split you made into history 
> > for all time. And it means that two people adding the same content might 
> > end up with different trees. Both things that git tries to avoid.
> 
> It's the "I can no longer see that the files are the same by comparing 
> SHA1's" that I personally dislike.

Right. I don't think splitting in the git data structure itself is worth
it for that reason. But deltification and rename detection keeping a
cache of smart splits that says "You can represent <sha-1> as this
concatenation of <sha-1>s" means they can still get some advantage (over
multiple runs, certainly, but possibly even over a single run: a smart
splitter might not even have to look at the entire file contents).

> So my "fixed chunk" approach would be nice in that if you have this kind 
> of "chunkblob" entry, in the tree (and index) it would literally be one 
> entry, and look like that:
> 
>    100644 chunkblob <sha1>

But if I am understanding you correctly, you _are_ proposing to munge
the git data structure here. Which means that pre-chunkblob trees will
point to the raw blob, and then post-chunkblob trees will point to the
chunked representation. And that means not being able to use the sha-1
to see that they eventually point to the same content.

-Peff
