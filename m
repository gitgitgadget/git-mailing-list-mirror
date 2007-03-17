From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: cleaner/better zlib sources?
Date: Sat, 17 Mar 2007 01:19:21 -0400
Message-ID: <20070317051921.GA5731@spearce.org>
References: <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org> <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org> <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org> <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 06:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSRKI-0007hU-DP
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 06:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933312AbXCQFTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 01:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933345AbXCQFTb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 01:19:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48352 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933312AbXCQFTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 01:19:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HSRK7-0000ZB-R3; Sat, 17 Mar 2007 01:19:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C2B7520FBAE; Sat, 17 Mar 2007 01:19:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42423>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 16 Mar 2007, Linus Torvalds wrote:
> > I also didn't worry about it, because I felt that if it became a problem, 
> > it would be easy to just add a cache of base objects (we probably do *not* 
> > want to keep the whole unpacked object info in memory all the time just 
> > because of memory pressure issues, so "cache of base objects" is better). 
> > However, the "pack file + offset" thing makes it harder to do, since we 
> > now don't even have the SHA1 of the base object before we unpack it.
> > 
> > But I guess we could just index this by a <packfile, offset> tuple.
...
> Then it would only be a matter of coming up with a clever cache 
> eviction algorithm.

Yes.  Linus above seems to imply (at least to me) that we wouldn't
want to cache the original object requested by read_sha1_file(), as
its not the delta base.  But given our packing rules, we should be
(in general anyway) first asking for the most recent revision of
a file, which is stored whole, then for an older revision, which
will be a delta of the more recent revision we just saw.

Hence we probably would want to cache an object.  Well, at least
anything that had been packed as a delta.  Caching a deflated
OBJ_BLOB may not be worth it.
 
> > Anyway, I bet that this is a much bigger issue than the pack format 
> > itself (and is largely independent).
> 
> Well, I think the pack format issue is significant too.  But because 
> those are independent issues the gain in performance will be additive.

I'm torn there.

There's two places that we do lots of unpacks of objects where we
run into this difficult case of unpacking the same base object many
times: git-blame and a rev-list with a path limiter.

Now the git-blame case is obvious: we are constantly unpacking
various revisions of the same file, and these are probably delta'd
against each other, so the unpacking gets really brutal after a
while.  A blob cache here would probably *really* help out git-blame.

What's slightly less obvious about git-blame is we are probably also
traversing the different versions of the same trees over and over, as
we resolve the path to the correct blob in each commit we traverse.
So again here we are hitting lots of the same trees multiple times.

That last part about git-blame also obviously applies to the rev-list
with a path limiter.

But most other operations don't seem like they would benefit from a
base object cache; actually they might slow down from having such
a cache present!

Commits tend not to delta well; if they delta it is a very rare
occurrance.  So we aren't getting huge unpacking benefits there
by caching them.  Scratch any benefit of the cache for any sort of
rev-list operation that doesn't require tree access.

As for the other common operations (diff, read-tree, checkout-index,
merge-recursive): I don't think these will benefit from a cache
either.  Their data access patterns are pretty spread out over
the tree.  With the exception of rename detection we hit everything
only once.  After touching a path, we tend to not go back to it.
So unless we are really lucky and one blob acts as a base object
for many others at different paths (possible, but I suspect not
very likely) its not worth caching the base.

If we do hit something twice, its probably because we are doing two
distinct passes over the data.  In this case the passes are probably
because we either don't want to hold all of the data in memory (too
big of a set for some projects) or because we tried one algorithm,
failed, and are now trying a different one (internal read-tree
in merge-recursive).

Caching in merge-recursive may help, but just making the dirty
cache (index) that resulted from the internal read-tree available
for the remainder of the merge-recursive process might be faster;
especially if we only have one base and don't need to recursively
merge multiple bases.


So where does that leave us?  The only places I see a base object
cache really helping is in git-blame for blob access, repeated
tree access (git-blame and path limiting), and maybe we could do
better with the common cases in merge-recursive by being smarter
with the cache.

But with pack v4 I don't think I need a tree object cache.
With a 6 byte fixed record format, a strict ordering requirement,
a finite delta depth within a packfile, a stricter tree-specific
delta encoder, and a minor API change to tree-walk.h, I think we
can unpack the delta at the same time that we are walking the tree.
No upfront unpack required.  Hence no reason to cache.


So yea, a base object cache may help us today.  It will most
definately help in git-blame.  But I doubt it will help with trees
in pack v4, and I think it will just hurt in most cases.  So maybe
it should be local to git-blame only.

-- 
Shawn.
