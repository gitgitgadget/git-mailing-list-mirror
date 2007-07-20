From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Idea for git-fast-import
Date: Fri, 20 Jul 2007 03:28:24 -0400
Message-ID: <20070720072824.GP32566@spearce.org>
References: <46A05D4B.1050208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 20 09:28:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBmug-0005ij-Vh
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 09:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759143AbXGTH2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759423AbXGTH2b
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 03:28:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53075 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758293AbXGTH2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 03:28:30 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBmuY-0006cN-J3; Fri, 20 Jul 2007 03:28:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DC8FE20FBAE; Fri, 20 Jul 2007 03:28:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46A05D4B.1050208@alum.mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53067>

Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I'm working on a git backend for cvs2svn and had an idea for
> git-fast-import that would make life a tiny bit easier:

Cool!
 
> Currently, git-fast-import marks are positive integers.  But they are
> used for two things: marking single-file blobs, and marking commits.
> 
> This is a tiny bit awkward, because cvs2svn assigns small integer IDs to
> these things too, but uses distinct (overlapping) integer series for the
> two concepts.  If it would be trivial to split the marks into two
> "namespaces" (one for single-file blobs and one for commits), that would
> make things a little bit more natural.  I don't think commit marks can
> be used interchangeably with blob marks anyway, so it wouldn't be a
> backwards incompatibility.

That's true, they aren't interchangeable.  fast-import pukes
and dies if you try to use the wrong type at the wrong location.
It has been requested before that the two namespaces be split,
and I just have been too lazy to do it.

> Without this feature, I will have to assign a new "mark" integer series
> that is unrelated to cvs2svn's IDs, which is no big deal at all but will
> make debugging a little bit harder.  So only add this feature if it is
> really easy for you.

Its not that much code reorg, but there is some reorg required to
make it work.  Maybe only a few hundred line diff, so probably well
within reason.  I'll look into it later.
 
> Also, is there a big cost to using "not-quite-consecutive" integers as
> marks?  cvs2svn's CVSRevision IDs are intermingled with IDs for
> CVSBranches and CVSTags, so the CVSRevisions alone probably only pack
> the ID space 5%-50% full.

Marks cost exactly 1 pointer (4 or 8 bytes) as they are actually just
a pointer to the already-in-memory object metadata that fast-import
uses for bookkeeping related to packfile generation.  Gaps in the
marks sequence also cost exactly 1 pointer, as they are just NULL.

But the marks table is actually a sparse array, using 1024 entries
per block.  So if you assign a mark at :5, then another at say
:1047000 you have only allocated 3 blocks and 12 KiB of memory
(a root directory block at 4 KiB, two leafs at 4 KiB each).  A far
cry from 4 MiB.

Its not a binary tree, its a sparse digital index.  So going
really far out in the namespace with huge gaps will cost you some
index nodes.  Staying reasonably dense is actually quite efficient,
with pretty low directory overheads.

> In fact, if there is a big cost to "not-quite-consecutive" integers,
> then I withdraw my request for separate mark namespaces, since I would
> have to reallocate mark numbers anyway :-)

See above.  5% full is really bad, because you are probably going to
allocate nearly every block in the directory, and only fill each leaf
block at 5% full.  50% full is actually reasonable, as it means marks
are only costing you about 2 pointers on average (8 or 16 bytes).

I went with the sparse array/digital index approach because it is
fairly compact code, quick store and lookup operations, and I figured
most frontends could get at least 50% full on their mark allocation.
On really dense allocations (>60%) the very low overhead per mark
makes it insanely efficient, even for a very large number of marks.

Jon Smirl was dumping marks sequentially from his hacked cvs2svn,
thereby getting the marks table at 100% full.  Other recent import
attempts with fast-import have also managed to keep their mark
allocations pretty close (if not dead on) at 100% full.

I can see how it might be convenient to have a very sparsely filled
mark namespace.  Its also convenient to have a mark namespace that
uses arbitrary strings.  Unfortunately I chose not to support
those very well (or at all!) for the sake of trying to keep the
fast-import code more compact internally, and to simplify its
internal memory management.  You might be able to talk me into
improving on that however.  ;-)
 
> Another thing that might help with debugging would be a "comment"
> command, which git-fast-import should ignore.  One could put text about
> the source of a chunk of git-fast-import stream to relate it back to the
> front-end concepts when debugging the stream contents by hand.

This is an awesome idea, especially when combined with having a
buffer of the last few commands that fast-import saw right before
it crashed.  I'll see what I can do.
 
-- 
Shawn.
