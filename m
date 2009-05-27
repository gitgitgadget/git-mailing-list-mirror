From: Nicolas Pitre <nico@cam.org>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 19:29:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905271834280.3906@xanadu.home>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk>
 <m3y6siboij.fsf@localhost.localdomain>
 <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain>
 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
 <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
 <20090527215314.GA10362@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 01:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Su7-0004Ly-NP
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 01:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbZE0XvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 19:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755545AbZE0XvT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 19:51:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60376 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZE0XvR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 19:51:17 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KKB00BJ2T8E44S1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 May 2009 19:29:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090527215314.GA10362@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120130>

On Wed, 27 May 2009, Jeff King wrote:

> On Wed, May 27, 2009 at 01:37:26PM -0400, Nicolas Pitre wrote:
> 
> > My idea for handling big files is simply to:
> > 
> >  1) Define a new parameter to determine what is considered a big file.
> > 
> >  2) Store any file larger than the treshold defined in (1) directly into 
> >     a pack of their own at "git add" time.
> > 
> >  3) Never attempt to diff nor delta large objects, again according to 
> >     (1) above.  It is typical for large files not to be deltifiable, and 
> >     a diff for files in the thousands of megabytes cannot possibly be 
> >     sane.
> 
> What about large files that have a short metadata section that may
> change? Versions with only the metadata changed delta well, and with a
> custom diff driver, can produce useful diffs. And I don't think that is
> an impractical or unlikely example; large files can often be tagged
> media.

Sure... but what is the actual data pattern currently used out there?
What does P4 or CVS or SVN do with multiple versions of almost identical 
2GB+ files?

My point is, if the tool people are already using with gigantic 
repositories is not bothering with delta compression then we don't lose 
much in making git usable with those repositories by doing the same.  
And this can be achieved pretty easily with fairly minor changes. Plus, 
my proposal doesn't introduce any incompatibility in the git repository 
format while not denying possible future enhancements.

For example, that would be non trivial but still doable to make git work 
on data streams instead of buffers.  The current code for blob 
read/write/delta could be kept for performance, along with another 
version in parallel doing the same but with file descriptors and 
pread/pwrite for big files.

> Linus' "split into multiple objects" approach means you could perhaps
> split intelligently into metadata and "uninteresting data" sections
> based on the file type.  That would make things like rename detection
> very fast. Of course it has the downside that you are cementing whatever
> split you made into history for all time. And it means that two people
> adding the same content might end up with different trees. Both things
> that git tries to avoid.

Exact.  And honnestly I don't think that would be worth trying to do 
inexact rename detection for huge files anyway.  It is rarely the case 
that moving/renaming a movie file needs to change its content in some 
way.

> I wonder if it would be useful to make such a split at _read_ time. That
> is, still refer to the sha-1 of the whole content in the tree objects,
> but have a separate cache that says "hash X splits to the concatenation
> of Y,Z". Thus you can always refer to the "pure" object, both as a user,
> and in the code. So we could avoid retrofitting all of the code -- just
> some parts like diff might want to handle an object in multiple
> segments.

Unless there are real world scenarios where diffing (as we know it) two 
huge files is a common and useful operation, I don't think we should 
even try to consider that problem.  What people are doing with huge 
files is storing them and retrieving them, so we probably should only 
limit ourselves to making those operations work for now.

And to that effect I don't think it would be wise to introduce 
artificial segmentations in the object structure that would make both 
the code and the git model more complex.  We could just as well limit 
the complexity to the code for dealing with blobs without having to load 
them all in memory at once instead and keep the git repository model 
simple.

So if we want to do the real thing and deal with huge blobs, there is 
only a small set of operations that need to be considered:

 - Creation of new blobs (or "git add") for huge files: can be done 
   trivially in chunks.  Open issue is whether or not the SHA1 of the 
   file is computed with a first pass over the file, and if the object 
   doesn't exist then perform a second pass to deflate it if desired, or 
   do both the SHA1 summing and deflate in the same pass and discard the 
   result if the object happens to already exist.  Still trivial to 
   implement.

 - Checkout of huge files: still trivial to perform if non delta.  In 
   the delta case, that _could_ be quite simple if the base objects 
   were not deflated by recursively parsing deltas.  But again that 
   remains to be seen if 1) deflating or even 2) deltifying huge files
   is useful in practice with real world data.

 - repack/fetch/pull: In the pack data reuse case, the code is already 
   fine as it streams small blocks from the source to the destination.  
   Delta compression can be done by using coarse indexing of the source 
   object and loading/discarding portions of the source data while the 
   target object is processed in a streaming fashion.

Other than that, I don't see how git could be useful for huge files.  
The above operations (read/write/delta of huge blobs) would need to be 
done with a separate set of functions, and a configurable size treshold 
would select the regular or the chunked set.  Nothing fundamentally 
difficult in my mind.


Nicolas
