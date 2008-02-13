From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Wed, 13 Feb 2008 02:42:09 -0500
Message-ID: <20080213074209.GG24004@spearce.org>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Feb 13 08:43:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCGj-0003QG-Oj
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 08:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbYBMHm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 02:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbYBMHm1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 02:42:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49028 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467AbYBMHm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 02:42:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPCFu-0003BN-T8; Wed, 13 Feb 2008 02:42:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 586D620FBAE; Wed, 13 Feb 2008 02:42:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802120937330.2732@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73748>

Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 11 Feb 2008, Martin Koegler wrote:
> > 
> > But lots of code in git assums that the object content is welformd.
> > 
> > Having such objects somewhere reachable in your repository will
> > disturb cloning (In the best case you get a error messages, in the
> > worst a child process of upload-pack segfaults), gitweb, ... . To fix
> > it, you will need a person with native access to the repository in the
> > worst case. 

We have *waaaay* overthought this.  The solution is a lot simpler
than Martin's patches make it out to be, and we can do it without
changing our current memory footprint.

> I think this is a good idea to always have some sanity checks on any 
> incoming objects so to make sure they're well formed and valid before 
> giving them a SHA1 value, and bail out as soon as any error is found.  

When we get the raw data for an object so we can compute its SHA-1
and/or write its loose object to disk we should first verify its
content is sane, then do the SHA-1/store loose.

Blobs - always assume sane.  Remember that these make up the largest
percentage in terms of raw bytes of any project's packfiles and we
don't need to do any additional processing to them.  Yay us.

Tags - stack allocate a temporary struct tag and pass it's address
into parse_tag_buffer().  The only thing it tries to allocate is
the item->tagged.  Throw an extra argument into parse_tag_buffer()
to bypass this lookup block.  Now there's no extra memory used for
tags, just a bit more CPU.  Tags aren't frequent.

Commits - do like tags, but use parse_commit_buffer().  Avoid
looking up the tree object and the parents, and allocating the
parent references via a new argument.  Also check !item->date like
fsck does.  Other than that I think the validation code in fsck is
redundant with what parse_commit_buffer() is doing already.

Trees - just run init_tree_desc() and tree_entry() loop like in
track_tree_refs() (and a ton of other places) to iterate over the
buffer.  All we care about is sane entry names (no '/'), sane modes,
and correct sorting.

In short, we ignore reachability, but get fsck, and we can completely
avoid additional malloc activity as well as any sort of heap increase
in index-pack and unpack-objects.  Its not hard.

Its a small amount of refactoring for the parse functions we
already have, and maybe expose a function or two from builtin-fsck
(in particular a bulk of fsck_tree should be reused).

Yea, its a tad more CPU time, but it shouldn't be that costly here.
The huge cost in fsck is redoing the SHA-1 checksums, and inflating
the deltas.  We've already got the delta inflated, and we're about
to compute the SHA-1 checksum for the first time.  So those major
costs of fsck drop to 0.

> As to making sure those objects are well connected... well this is a 
> technically different issue entirely, and I wonder if a special mode to 
> fsck might not be a better solution.

Nah, just do what quickfetch does in builtin-fetch.c, but run it
in receive-pack, between unpack() and execute_commands():

	rev-list --quiet --objects $new... --not --all

If it aborts, reachability testing failed and the push is rejected
without updating any refs.  Yes your repository now has objects
that are missing things, but none of those are considered to be
reachable, so this isn't a big deal.  They will get cleaned up on
the next `gc --prune`, whenever that is.

In this configuration (--quiet) rev-list tries to be pretty low
on its memory usage, it doesn't save buffers, etc.  Further since
everything that is already considered reachable is not interesting,
we are only doing a walk over the objects that we just received,
not our entire ODB.  Its also after index-pack exited, so we just
freed up a good chunk of memory.

Rememeber we are talking about receive-pack here.  The cost on
the to perform the rev-list is lower than the cost will be to pack
these objects for distribution back to just one client.  Since this
is a server of some sorts (otherwise why did you push here?), odds
are its going to be doing a lot of packing requests for clients to
receive these newly uploaded objects by the native git protocol.
This new rev-list is nothing compared to that already existing load.
And if your OS is any good the just created .idx and .pack is still
in OS buffer cache, so there shouldn't be any additional disk IO.

Yes, we could make this optional in receive-pack, but really I don't
see a reason to.  Just run it.  The client shouldn't be giving us
unreachable crap.

-- 
Shawn.
