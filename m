From: Yann Dirson <ydirson@free.fr>
Subject: Re: rebase parents, or tracking upstream but removing
 non-distributable bits
Date: Thu, 30 Dec 2010 23:52:34 +0100
Message-ID: <20101230225234.GC6639@home.lan>
References: <ord3ojb0yy.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Alexandre Oliva <lxoliva@fsfla.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 23:52:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYRMW-00051W-He
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 23:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab0L3Wwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 17:52:43 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:56053 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967Ab0L3Wwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 17:52:43 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A277DD48018;
	Thu, 30 Dec 2010 23:52:35 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PYRMI-0004gD-Bg; Thu, 30 Dec 2010 23:52:34 +0100
Content-Disposition: inline
In-Reply-To: <ord3ojb0yy.fsf@livre.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164371>

On Thu, Dec 30, 2010 at 03:54:29PM -0200, Alexandre Oliva wrote:
> Given this problem statement, I started looking for solutions that
> didn't require modifying git.

This is a problem I have come to think a bit about already.  Although
I do not have a proper solution either, let's share those ideas.

> I first looked into rewriting history, removing the unwanted bits and
> replaying subsequent changes, but quickly discarded it, for it would
> make my local repository incompatible with upstream both ways: I
> wouldn't be able to pull from it; upstream wouldn't be able to pull to
> it; third parties would run into ugly situations trying to carry patches
> from either one to the other.
> 
> Now, it looks like I might be able to pull from upstream if I maintain
> manually a graft file that named each upstream commit as an additional
> parent of the corresponding local rebase commit that brought it into my
> rewritten tree.  Workable, maybe, but this wouldn't help third parties
> that used my public repository.

As a side note: I fear grafts won't scale very nicely performance-wise
if you graft every commit.

My use-case was similar to yours, about "how could Debian distribute a
git tree of the kernel ?", but my focus was on distributing
well-defined snapshots, and I ended up with the idea of grafting only
the set of successive revisions that get published - and not
necessarily have a mirror of all upstream revisions in the filtered
tree: such grafts do represent points in history where we would merge
from upstream, and without the grafts the filtered tree would look
like successive imports of well-defined revisions (notably makes it
realistic to adhere to the "all commits have been tested" paradigm).


> Besides, I'm concerned that pushing from the local repository (with the
> graft file) to the public repository would end up publishing the changes
> I'm not supposed to distribute, because they'd be taken as parents of
> the local commits.

Grafts cannot be pushed/pulled.  For this, as Jonathan suggests in
another reply, "git replace" looks like a better choice, esp. in that
by default the replacement commits don't get pulled: you need to
explicitely request fetching refs/replace/commits (note: you may need
to handle merges there when needed).  OTOH, those replacement commits
would pull the whole upstream history, so they cannot be part of the
filtered repository: it must come from an unfiltered kernel repo, that
may be a real problem if you cannot redistribute some upstream parts.

OTOH, a grafts file can be distributed out-of-band, and would only
pull the problematic contents when put in place, so it might indeed be
more adequate.


> Are there any other ways to support the desired features with git as-is?
> AFAICT, there isn't, so I've been thinking of how to introduce this.  I
> suppose the simplest way to accomplish this is to introduce the notion
> of a ???weak parent???: one that is taken into account for purposes of
> checking whether a commit is present in a branch being merged- or
> rebased into, but that is not transmitted over pushes, and that is not
> retained over purges, and not complained about when missing.

That sounds like heavy surgery with too many implications I can think
of.

When it comes to "modifying commit metadata", it rings "git notes" in
my ear - but then, you cannot add/change commit metadata from a note,
maybe that could be a better direction to dig into, so we can add
parents when a specific notes namespace is activated ?  But then we
would get back to the problem I mentionned for refs/replace/


> I'm under the impression that this could not just work, but also make
> rebasing in general (especially the hard case) far less problematic, for
> git would be able to relate a rebased commit with an original commit.

I suppose that by "hard case" you mean forking off a branch that gets
rebased later ?  Note that "git pull" seems to be able to cope with
this using reflogs already (although I did not test that feature).  A
less volatile place than reflogs could again using notes, without a
need for core changes.


> I'm not sure this would enable upstream to easily integrate
> my changes.  Or would it?

This problem suggests a more generic one: how to "merge back" most
changes from a branch while still not merging some specific changes ?
It would also help when a maint branch gets some short-term
workarounds that we don't want in the master branch, but the very idea
has a serious flaw: it implies that the "merge back" commit contains
also the commits we don't want (here, the "filtering commits").  So I
guess cherry-pick will be the way here.  Anyway, I doubt Linus would
like the idea of merging from such a filtered repo, sending patches is
probably prefered.

Best regards,
-- 
Yann
