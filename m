From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 08:44:30 -0800
Message-ID: <20090210164430.GN30949@spearce.org>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <20090210121833.GC15491@coredump.intra.peff.net> <alpine.DEB.1.00.0902101357140.10279@pacific.mpi-cbg.de> <20090210131029.GC17305@coredump.intra.peff.net> <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, gitster@pobox.com, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 17:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWvkF-0006pj-De
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 17:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZBJQod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 11:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZBJQoc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 11:44:32 -0500
Received: from george.spearce.org ([209.20.77.23]:33793 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZBJQob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 11:44:31 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C160438210; Tue, 10 Feb 2009 16:44:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101427490.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109271>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> [Junio: seems like both Peff and me would like to hold the notes out of 
> 1.6.2, would you mind?]

Sorry I'm getting involved in this notes thing so late.  I was way
too focused on Gerrit2 and just didn't pay much attention to what
was on the git ML recently.  Like Dscho and Peff, I think we may
want to hold notes out of 1.6.2.
 
> On Tue, 10 Feb 2009, Jeff King wrote:
> > On Tue, Feb 10, 2009 at 01:59:06PM +0100, Johannes Schindelin wrote:
> 
> The thing is: Shawn is correct when he says that a tree object to hold the 
> notes of all commits (which is not an unlikely scenario if you are 
> thinking about corporate processes) would be huge.

A notes tree entry requires 6+1+40+1+20=68 bytes per entry.  If I
use it for what I want in Gerrit, which is to annotate every commit,
on a project like git.git with 17,491 commits we're talking about
a tree that is 1.13 MB.

That tree grows at a rate of 276 KB/year.

I'm not sure I want to think about the cost to unpack that tree,
just so I can look at "git log --since=1.week.ago".

My fear here is that over time we will be spending a lot of CPU
time unpacking and indexing the tree in memory, only to then pull
out a handful of recent commits, and then see the pager abort and
kill the revision walk.
 
> The point you raised earlier, that there would be a lot of ambiguity if 
> we allow both flat and fan-out directory structures, is a valid point, 
> though.

Yup.  The flat vs. fan-out is a problem.  In a slightly unrelated
thread offlist I have been talking with Sam Vilain about using Git
as a database backend for tuple storage.  There is a related issue
there about making the tree structure consistent, but never stored
in a way that we wind up with these massive multi-megabyte objects.

We've only started to kick it around, but I think we are both in
agreement that a "database tree" is owned by the database code
and must not be twiddled manually.  Not unless you can honor the
formatting rules.  Just like you shouldn't use "git hash-object"
to create a tree, unless you can honor the basic formatting rules
for trees.

This also means that the "database trees" probably are not going
to be mergeable with a basic merge-recursive sort of algorithm,
but instead need specialized handling to perform the combination.

I think we're leaning in a direction of something more like this
for trees:

- Tuples are stored under a path constructed from their primary key.
  The analog here is, the commit SHA-1 the note is annotating.

- Trees are capped at some reasonable size limit.  For sake of
  argument lets call that MAX_TREE.  My feeling is this would be
  closer to the 16 KB side of the spectrum then to the 1 MB side.

- Initially the database tree starts out as a single root tree that
  is empty.

- Records are inserted, creating new tree entries, until MAX_TREE
  is reached for the root level tree.  Up until this point it is
  a flat tree structure, like the current notes design.

- Once MAX_TREE is reached the root is split, and ranges are used
  to point to the subtrees, which are now flat, and approximately
  are MAX_TREE/2 in size.

Etc.

This would make the git-notes.sh code a *lot* more complex, as you
can't just toss everything into an index file and then update it with
a single update-index call.  Doing a tree split is much more work and
requires removing and adding back all of the affected path names.
(Its also perhaps unreasonable anyway to load 17,491 paths into a
temporary index just to twiddle a note for the latest commit.)


Notes on commits though are a hell of a problem.  SHA-1 is just so
uniform at distributing the commits around the namespace that even
with just the 200 most recent commits we wind up with a commit in
almost every "bucket", assuming a two hex digit fan-out bucket like
the loose object directory.

For the "git database" thing above, I've been contemplating the
idea of an index stored external from the Git object database.
Sam thinks indexes should be in the object database tree, but
I'm considering storing them outside entirely because we can
make the indexes more easily searched by a hash or binary search,
like pack-*.idx.  Whenever the "database ref" gets moved we'd need
to run a "sync" utility to bring these external indexes current.
But they could also be more efficiently scanned.

E.g. in the case of commit notes, we could just mmap() the index into
memory and perform our lookups through the mmap.  Thus we wouldn't
pay massive penalities to index all 17,491 names just to access 200.
Though we may wind up paging in a good part of the index due to
the random access nature, but we can't really do anything about that.

Keeping the indexes current would perhaps mean teaching "git fetch"
to run something after the fetch is complete.  Rather trivial in
the grand scheme of things.  I also liken the external index to the
pack-*.idx, in that its derived from the real sources in the object
database, and can always be generated client side.  So making fetch
do it is really no different then making fetch run index-pack.

Eh.  That wound up being a lot longer than I wanted it to be.


Sam and I may be putting some effort into this "git as a database"
thing, and it could be used as an efficient notes store.  Its just
a very complex notes store.  Much more complex to implement than
the simple notes currently slated for 1.6.2.

-- 
Shawn.
