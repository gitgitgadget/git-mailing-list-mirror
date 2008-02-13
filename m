From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Wed, 13 Feb 2008 01:20:15 -0500
Message-ID: <20080213062015.GF24004@spearce.org>
References: <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080212190411.GA23837@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121507310.2732@xanadu.home> <20080212213858.GA29151@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121645121.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 07:21:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPAzc-0001mS-3d
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 07:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbYBMGUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 01:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbYBMGUi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 01:20:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33343 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631AbYBMGUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 01:20:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPAye-0005uQ-Sr; Wed, 13 Feb 2008 01:20:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 09E1D20FBAE; Wed, 13 Feb 2008 01:20:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802121645121.2732@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73744>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 12 Feb 2008, Martin Koegler wrote:
> 
> > Many validations are in parse_XXX_buffer, which are also used by
> > fsck. This returns a struct commit/tree/tag/blob.
> > 
> > I have not found any code in git to free them. 

Yea, there isn't a way to free the struct commit/tree/tag/blob
currently.  Once allocated its inside the hash, cannot be removed,
and cannot be recycled.

A while back I had worked up a patch that allowed us to reset the
entire hash and recycle the all of the objects, but that isn't
really what we need here.
 
> Maybe we should add it then.  Especially in the usual case where we want 
> incoming objects to be validated.

Releasing a single object back shouldn't be too difficult, so long as
you release everything after each parse.  Remember parsing a commit
loads the parent list with struct commit*s.  Those are in the object
hash and a later parse_commit_buffer() may attempt to reuse those
if the same commit was a parent for more than one descendent.  :-\

Basically I think you want a smaller case of what I had done earlier
in my attempt to fix an error in git-fetch; release everything in
the object pool after each object has been parsed and validated.
We should only have a couple of objects allocated in the blocks
(one blob, one tree, one tag, handful of commits) and just reset
the blocks and hash between each.
 
> > Same for pack-objects, e.g. add_objects_in_unpacked_packs allocates
> > many struct object via lookup_unknown_object. As far as I understand
> > the code, they are never freed, even if they are not needed later.
> 
> Hmmm, that's bad.

You can't free them.  We're using their o->flags field to store
OBJECT_ADDED state so we don't pack the same object twice in our
output, even if it appears in multiple input packfiles.

This isn't a leak.  Its behaving as designed.  It is however
overallocating the object, because we are allocating an unknown
object rather than a specific object type.  We don't know what the
heck that SHA-1 is just from looking at the index.  If it is an
OBJ_{REF,OFS}_DELTA its too expensive to acquire the exact type
during this method.

Which makes me wonder, would it make sense to store the object type
code inside of the .idx?

There's a few places in Git (4 lookup_unknown_objects, 19 possible
sha1_object_infos) where we may be able to benefit from having fast
access to the base type for an object, without needing to walk its
delta chain to acquire that information.  It certainly would help
in this spot of pack-objects that Martin has pointed out.

But I really don't think it is worth the disk storage space
necessary.  We only need 3 bits, but there isn't a place to steal
them from in the index v2 file format.  So we're adding a full byte
per object.  Further we only make this lookup_unknown_object call
in 3 locations:

  http-push.c/walker.c:

    We're fetching objects, but we don't know what we are getting.
    I think these are only triggered during the loose object
    upload/download, which should be only a fraction of the total
    objects transferred, and are only for cases where the object
    isn't local so we can't check its type before allocation.

    No big deal.


  tree.c:

    This is inside track_tree_refs and its a file mode we do
    not recognize.  We spit out a warning, but try to lookup
    the unknown object anyway, even though we're looking at what
    should be a bogus tree.  This occurs only in parse_tree_buffer,
    only if track_objects_refs is on, and only if we see a tree
    that is actually not understood by this version of Git.  Hmm,
    shouldn't happen unless the tree itself is corrupt.

    This code looked fishy enough to me to dig up the blame history
    for it:

      commit e2ac7cb5fbcf1407003aa07cdcd14141527ea2e3
      Author: Sam Vilain <sam.vilain@catalyst.net.nz>
      Date: Wed Jun  6 06:25:17 2007

      Don't assume tree entries that are not dirs are blobs

      When scanning the trees in track_tree_refs() there is a "lazy" test
      that assumes that entries are either directories or files.  Don't do
      that.

    Sounds like it was around the time of S_ISGITLINK being
    introduced.  Looking at this code again I have to wonder, why
    the hell are we looking up and tracking an object inside of a
    tree when we don't understand the mode?

    Lets say a new form of S_ISGITLINK gets introduced in the future.
    By this I mean the mode says "hey, this SHA-1 isn't really in my
    object pool".  We're going to cram a dummy object into the refs
    table for this tree.  Why?  We don't do this for S_ISGITLINK.

    Lets say its a new object type (not tree/tag/commit/blob) but
    it is in our storage pool.  If this Git doesn't know the mode,
    it sure as heck won't know what the hell the loose object header
    (or pack header!) says about that object.

    One of the key places where you might expect tracking an unknown
    (but referenced by a tree) SHA-1 type would be in reachability,
    rev-list --objects, packfile generation.  But the process_tree()
    function in reachable.c doesn't have Sam's change above, so it
    will assume anything new looking is a blob.
    
    Oh, and what a rabbit hole I just fell down.  The only caller
    that seems to set "track_object_refs = 1" (and thus get into this
    odd lookup_unknown_object() call) is fsck.  Everyone else sets
    it to 0, including its default declaration.

    So we've got this nice baggage, and differing implementation,
    so fsck can be happy how?  We've also got a whole lot of apps
    setting "track_object_refs = 0", which is what it defaults to,
    unless you managed to run fsck first.  Hmmph.

    Is it just me or is track_object_refs perhaps outlived its
    usefulness?

  pack-objects:

    Here we are packing everything in an existing packfile, as we
    are doing something like a "git repack -A" and need to carry
    it all with us.

    We probably could be smarter than allocating an unknown object,
    but I'm not sure its worth it.  If you really are paying a
    high price here it means you are carrying a *huge* amount of
    unreachable garbage with you from packfile to packfile.

    Try running "git gc --prune" every few months.
  
-- 
Shawn.
