From: Jeff King <peff@peff.net>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 16:00:39 -0400
Message-ID: <20090528200039.GI13499@coredump.intra.peff.net>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home> <20090527215314.GA10362@coredump.intra.peff.net> <alpine.LFD.2.00.0905271834280.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 28 22:01:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9lmb-0004PC-3t
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751AbZE1UAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbZE1UAs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:00:48 -0400
Received: from peff.net ([208.65.91.99]:46762 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755366AbZE1UAr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:00:47 -0400
Received: (qmail 22753 invoked by uid 107); 28 May 2009 20:00:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 16:00:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 16:00:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905271834280.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120220>

On Wed, May 27, 2009 at 07:29:02PM -0400, Nicolas Pitre wrote:

> > What about large files that have a short metadata section that may
> > change? Versions with only the metadata changed delta well, and with a
> > custom diff driver, can produce useful diffs. And I don't think that is
> > an impractical or unlikely example; large files can often be tagged
> > media.
> 
> Sure... but what is the actual data pattern currently used out there?

I'm not sure what you mean by "out there", but I just exactly described
the data pattern of a repo I have (a few thousand 5 megapixel JPEGs and
short (a few dozens of megabytes) AVIs, frequent additions, infrequently
changing photo contents, and moderately changing metadata). I don't know
how that matches other peoples' needs.

Game designers have been mentioned before in large media checkins, and I
think they focus less on metadata changes. Media is either there to
stay, or it is replaced as a whole.

> What does P4 or CVS or SVN do with multiple versions of almost identical 
> 2GB+ files?

I only ever tried this with CVS, which just stored the entire binary
version as a whole. And of course running "diff" was useless, but then
it was also useless on text files. ;) I suspect CVS would simply choke
on a 2G file.

But I don't want to do as well as those other tools. I want to be able
to do all of the useful things git can do but with large files.

> My point is, if the tool people are already using with gigantic 
> repositories is not bothering with delta compression then we don't lose 
> much in making git usable with those repositories by doing the same.
> And this can be achieved pretty easily with fairly minor changes. Plus, 
> my proposal doesn't introduce any incompatibility in the git repository 
> format while not denying possible future enhancements.

Right. I think in some ways we are perhaps talking about two different
problems. I am really interested in moderately large files (a few
megabytes up to a few dozens or even a hundred megabytes), but I want
git to be _fast_ at dealing with them, and doing useful operations on
them (like rename detection, diffing, etc).

A smart splitter would probably want to mark part of the split as "this
section is large and uninteresting for compression, deltas, diffing, and
renames".  And that half may be stored in the way that you are proposing
(in a separate single-object pack, no compression, no delta, etc). So in
a sense I think what I am talking about would built on top of what you
want to do.

> > very fast. Of course it has the downside that you are cementing whatever
> > split you made into history for all time. And it means that two people
> > adding the same content might end up with different trees. Both things
> > that git tries to avoid.
> 
> Exact.  And honnestly I don't think that would be worth trying to do 
> inexact rename detection for huge files anyway.  It is rarely the case 
> that moving/renaming a movie file needs to change its content in some 
> way.

I should have been more clear in my other email: I think splitting that
is represented in the actual git trees is not going to be worth the
hassle.

But I do think we can get some of the benefits by maintaining a split
cache for viewers. And again, maybe my use case is crazy, but in my repo
I have renames and metadata content changes together.

> Unless there are real world scenarios where diffing (as we know it) two 
> huge files is a common and useful operation, I don't think we should 
> even try to consider that problem.  What people are doing with huge 
> files is storing them and retrieving them, so we probably should only 
> limit ourselves to making those operations work for now.

Again, this is motivated by a real use case that I have.

> And to that effect I don't think it would be wise to introduce 
> artificial segmentations in the object structure that would make both 
> the code and the git model more complex.  We could just as well limit 
> the complexity to the code for dealing with blobs without having to load 
> them all in memory at once instead and keep the git repository model 
> simple.

I do agree with this; I don't want to make any changes to the repository
model.

> So if we want to do the real thing and deal with huge blobs, there is 
> only a small set of operations that need to be considered:

I think everything you say here is sensible; I just want more operations
for my use case.

-Peff
