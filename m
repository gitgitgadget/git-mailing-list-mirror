From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 03:01:26 -0500
Message-ID: <20070127080126.GC9966@spearce.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 09:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAiVJ-0004CA-UW
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 09:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbXA0IBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 03:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbXA0IBc
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 03:01:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50549 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbXA0IBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 03:01:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAiV5-0002Ec-Va; Sat, 27 Jan 2007 03:01:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C71ED20FBAE; Sat, 27 Jan 2007 03:01:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37929>

Junio C Hamano <junkio@cox.net> wrote:
> What if (I know, this discussion does not belong here until
> 1.5.0 final) we had a "reverse" database that keeps track of
> what tag references which object, and "git rev-list" knows how
> to exploit it?

It'd be useful.  In as many ways as you suggest.  But it also
would be downright difficult to transfer between repositories,
as you have already pointed out in a public forum to yourself. :-)

>  - If a single-path following turns out to be too expensive
>    (there was a longstanding talk about "git log --single-follow
>    $path"; "git blame" also follows a single path although the
>    target it follows can fork into two or more when following
>    cut&pastes) because we need to explode multi-level trees for
>    each commit while traversing commit ancestry, we could define
>    an annotation to a commit that lists the set of paths the
>    commit touches relative to each of its parents (so the object
>    contains N lists of paths), so that pathspec limiting needs
>    to open and read only one object to figure out that the trees
>    do not have to be opened to skip the commit and/or a merge
>    can be simplified.

_THIS_ is worth doing.  I've been having a lot of discussion on
#git with Simon 'corecode' Schubert and Chris Lee about how poorly
git-blame performs compared to its counterpart in Subversion.

Basically Subversion is storing file-level revision ancestry data
within its commit data, allowing it to quickly skip back through
the commits which modified that file.

Git doesn't have this information and must instead traverse the
entire DAG, at least until the file was initially added to the tree.
With 440,000+ revisions and a file which exists in nearly all
of them, getting anything from "git-blame" or "git-log -- foo.c"
takes ages.

Based on some (limited) profiling with Shark it seems we spend about
50% of our CPU time doing zlib decompression of objects and almost
another 14% parsing the tree objects to apply the path limiter.
The only way to speed up blame/log operations is to reduce the number
of decompressions we need to do to the bare minium, and maybe also
reduce the tree parsing overheads.  Do that and we can maybe drop
the running time to 1/4th the current time.


One idea Simon and I were talking about was to store a reverse
file/tree-level DAG in the header of each tree/blob object in the
pack file.  This additional header would be something like a list
of triplets:

  (descendant-commit, ancestor-commit, ancestor-object)

where:

  descendant-commit: the "current" commit being looked at.
  ancestor-commit:   the commit which descendant-commit
                     derives from (directly or indirectly)
  ancestor-object:   prior version (descendant-commit^:path)

This triplet would probably be encoded with descendant-commit using
OBJ_REF, ancestor-commit being an OBJ_OFS style back reference within
the pack (or OBJ_REF if not in this pack) and ancestor-object would
also be an OBJ_REF.  So a triplet probably would wind up costing
~60 bytes.

Triplets would only be stored if ancestor-object != this-object, so
basically only for the commits which changed the path the tree/blob
is occupying in descendant-commit.

Finding the prior revision of a tree or file would be a matter of
finding the triplet which matches the current commit, then jumping
through to the ancestor-* values.  If no triplet matches the current
commit then we peel back the parents of the current commit and try
again with those.  Worst case we do what we do now, which is walk
the DAG.  ;-)

This of course penalizes objects which don't ever change, as we'd
have to walk back a good chunk of the DAG before we find a matching
triplet.  But I would suspect that files which never change are
also not given to log/blame very often either.  And once we do find
a triplet, we can skip through the DAG in time proportional to the
rate of change for the path, rather than to the entire repository.


Thoughts?

-- 
Shawn.
