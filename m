From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sat, 19 Nov 2005 14:16:56 +0100
Message-ID: <20051119131656.GB3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <200511181654.21052.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 14:16:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdSZL-0002IQ-6k
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 14:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVKSNPf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 08:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKSNPf
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 08:15:35 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:59354 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751103AbVKSNPe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 08:15:34 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id F0BC53FF6C;
	Sat, 19 Nov 2005 14:15:27 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EdSaO-00079T-JQ; Sat, 19 Nov 2005 14:16:56 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200511181654.21052.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12336>

On Fri, Nov 18, 2005 at 04:54:20PM +0100, Josef Weidendorfer wrote:
> On Friday 18 November 2005 00:07, Yann Dirson wrote:
> > Current commit objects refer to a child tree, but to parent _commits_.
> > Whereas it seems necessary to walk through the history line, and
> > easily get a changelog, it is semantically quite not right: the
> > changes we record with a commit indeed come from modification of
> > trees, not of commits.
> 
> Yes. The change to a tree (which is equalent to 2 trees - new old and
> the new one; or for merges multiple old ones and the new one) does not
> depend on any history. Unfortunately, we have no separate object to
> specify the "the change to a tree". We include this information into
> the commit object, and thus, bind it to the history.
> 
> This could be changed in git, i.e. put the tree relationship into a
> separate object; even comments could be split up in change related and
> history related. The question is: is this useful, is there any
> important usage scenario that rectifies such a change?

The scenario I have it mind is "archeological work" - see my post
under "info/grafts file" for details.  With luck for future work
vendors will switch to git and give access to their git history (or
use quilt or stgit and provide detailed patch stacks), so the need
could well disappear, but I would not could on it, as there are still
many firms working on a 2.4 base and only exporting monolithic
patches.


> > That is, the resulting tree does not depend on 
> > the history of the parent trees, but on the parent trees themselves.
> 
> No, the resulting tree is an independent object, it is the tree ;-)
> Do not confuse this with the commit pointing to the tree.

Right, that was a wrong wording.  I meant the resulting tree results
from the change and and the parent trees themselves, not from the
change and the previous history.


> But tags for commit objects are equally useful, especially signed ones:
> they include a fixed history which can not be changed. Eg. they include
> all the people which attributed code to the project, and this is important
> for license questions. This is the reason that "grafting" should stay
> a local workaround.

This, and chaining commits is also useful to prevent loops, as said in
another part of this thread.  But I wouldn't let such considerations
stop exploration first.  If we cannot find a reasonable and useful way
of applying those ideas without taking these 2 points into account as
a first approximation, there would be no point in adding these 2
constraints right away :).  It can be sufficient for now to be aware
of those and add them later.


> > Indeed that emphasizes that the history lines are on living on a
> > higher level of abstraction that commits.
> 
> Hmm.. If you only have tree changes, there is no history. The history
> specifies an order of the changes. The changes themselve do not include
> any such order.

Right, but that does not mean we cannot reconstruct history from those
changes.  It came to my mind during the last day, that if we had
commits only reference trees, we could construct from them the
equivalent of today's commit objects (which I'll call "history
objects" for clarity), but we could look at those generated "history
objects" as "cached" objects.  Together with a cache of tree->commit
reverse-mapping objects as Stephan mentionned, we could generate them
on-the-fly at commit time.

Remember that in a first approach, I'll only consider those history
objects as a means to get a history log or similar.

That would give us low-intrusion grafts: we can regenerate the
relevant part of the "history object" cache when a commit gets added
or replaced, similarly to what would be done at commit-creation time.
But we would not need to regenerate all subsequent commit objects, so
that all refs/tags pointing to those subsequent commits would not need
to be messed with.

Since we would then have history objects looking like current commits,
we could even get a similar safeguard against history loops.


And if we want to get the "signed tag certifies history" stuff, we
could envision making some of these history objects permanent.  But if
we allow history object to refer to tree parents as well, we do not
_need_to_ certify on every such tag the entire history plus changes
since the previous tag: a chain of "history objects" could stop on a
tree, thus making the tag a certificate of an incremental patch (ie,
what we get from signed patches in pub/linux/kernel, with the added
bonus of signing the invididual bits making up this patch).


> > However, I must admit that at this point, I have not found a
> > reasonable solution to this problem.
> > 
> > Any genius with a solution out there ? :)
> 
> What is the difficult problem here?

Getting a pure superset of the functionnality we currently have (while
not impairing git use in term of computing time).  But finally that
may not be as hard as I expected :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
