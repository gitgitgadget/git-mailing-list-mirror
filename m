From: David Roundy <droundy@abridgegame.org>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 08:17:16 -0400
Message-ID: <20050417121712.GA22772@abridgegame.org>
References: <20050416132231.GJ2551@abridgegame.org> <Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Sun Apr 17 14:18:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN8jT-0006V5-6C
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 14:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVDQMWR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 08:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVDQMWQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 08:22:16 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:18489 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261306AbVDQMWI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 08:22:08 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DN8iD-00066e-2s; Sun, 17 Apr 2005 08:17:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	darcs-devel@darcs.net
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2005 at 03:43:02PM -0700, Linus Torvalds wrote:
> On Sat, 16 Apr 2005, David Roundy wrote:
> > 1) Would this actually be a good idea? It seems good to me, but there may
> > be other considerations that I haven't thought of.
> 
> I really don't know how well the git index file will work with darcs, and
> the main issue is that the index file names the "stable copy" using the
> sha1 hash. If darcs uses something else (and I imagine it does) you'd
> need to do a fair amount of surgery, and I suspect merging changes won't
> be very easy.

Oh, I'm starting to see (having just browsed the git code for another half
hour or so)... I had been under the (false) impression that the index file
stored the contents of the files themselves, which in retrospect doesn't
make any sense.  So when you run update-cache --add, the file data itself
immediately goes into its final hashed location, and only the sha1 info
goes into the index.

That's all right.  Darcs would only access the cached data through a
git-caching layer, and we've already got an abstraction layer over the
pristine cache.  As long as the git layer can quickly retrieve the contents
of a given file, we should be fine.

The sha1 file and tree hashing isn't direcly useful for darcs, but people
will want to interoperate with git, and for that it would be nice to be
able to know what the hash of a given version is.  I imagine something like

darcs tag --git

which would tag the current version with its git hash.  Of course, to
implement that we only need to reproduce your algorithm for hashing trees,
which probably would be easier to do ourselves without using any git
code... but it would be far faster to recompute with the git backend, since
git stores the hashes of all the unmodified files, and since I also imagine

darcs record --git

which would record a change, and then tag the resulting tree with a git
hash, we might be recomputing the git hashes reasonably often, and we
certainly don't want to rehash the entire kernel each time! :)

> So it might well make sense to wait a bit, until the git thing has calmed
> down some more. For example, I made some rather large changes
> (conceptually, if not in layout of the physical file) to the index file
> just yesterday, since git now uses it for merging too.
> 
> In git, the index file isn't just a speedup, it's the "work" file _and_
> the merge entity. It's not just a floor wax, it's a dessert topping too!

I think that sounds like a pretty reasonable match.  In darcs, there are
internally two main datatypes.  One is the Patch (as you might imagine),
and the other is called a "Slurpy", which is basically a tree lazily
"slurped" into memory.

The pristine cache is then just a way of storing the tree and so we can
"slurp" it again later to retrieve the current state.  So in a sense we'd
be using only one side of the index file interface, the "working directory"
side, where you check files out and add files in--treating it as an
fast filesystem with a few extra-fancy features (like storing inodes of the
files in the working directory).

> I think libgit might make sense, but again, not quite yet. Maybe the new
> merge model was my last smart thought even on the subject of SCM's (I kind
> of hope so), but maybe it's not.
> 
> My gut _feel_ is that the basic git low-level architecture is done, and
> you can certainly start looking around and see if it matches darcs at all. 

Sounds good.  That's sort of the feel I had gotten from other people's
responses as well.  We'll definitely look into how we can use (and
interface with) git.
-- 
David Roundy
http://www.darcs.net
