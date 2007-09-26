From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: History over-simplification
Date: Wed, 26 Sep 2007 11:55:29 -0400
Message-ID: <20070926155529.GM3099@spearce.org>
References: <20070923044628.GA3099@spearce.org> <7v4phi4b9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 17:55:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaZEv-0006tf-Ay
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 17:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbXIZPzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbXIZPzk
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 11:55:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55865 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbXIZPzj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 11:55:39 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IaZET-0003gm-E0; Wed, 26 Sep 2007 11:55:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 69AAA20FBAE; Wed, 26 Sep 2007 11:55:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4phi4b9t.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59235>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > I don't really like the patch to revision.c because it winds up
> > showing trivial merges too.  What I really want is to have the
> > "--full-history" option include a merge if either of the following
> > is true:
> >
> >  a) The resulting path does not match _any_ of the parents.  We
> >     already handle this case correctly in revision.c and correctly
> >     show the "evil" merge.
> >
> >  b) The resulting path matches one of the parents but not one of
> >     the others.  In such a case the merge should still be output if
> >     a 3-way read-tree would not have chosen this result by default.
> 
> I am not sure (b) is useful in general.  Merging two branches
> that fix the same issue but in different ways (think: 'maint'
> and 'master' have different infrastructure and a fix initially
> made on 'master' was backported to 'maint', and then later
> 'maint' needed to be merged to 'master' to carry forward other
> fixes) is a norm, and in such cases taking the version from the
> merged-to branch is almost always what happens.

(b) is useful, even in the case you just described.  Try doing the
above backport today.  Run `git log maint -- foo.c` and find the
backported commit B.  Now try to see if that commit is in master in
foo.c with `git log master -- foo.c`.  B won't appear as the merge
of maint into master chose master's revision and maint's history
is pruned away.

Now if the backported change was logically the same but was rewritten
considerably it might take you a while to figure out why a merge
discarded the change B.  The merge commit might actually describe
why in its message, but you can't find that particular merge commit
today, even with --full-history.  Not without my one-line patch.

Unfortunately my one-line patch causes all of the merges that the
path is involved in to be output.  That can be quite a lot of them.
 
> Also it sounds to me by "if read-tree would not have chosen this
> result by default" you mean this feature would not just need to
> run merge-base but also recursive merge-base synthesis, and also
> recreate the structural merge (aka "rename detection") there as
> well.  Even if (b) is useful, it sounds like a very expensive
> option, and the current merge-recursive code is structured in
> such a way to be easily reused for this purpose.

I think you meant here that it is *not* structured in a way to be
easily reused for this purpose.  That code relies heavily on the
index to allow it to create that synthetic merge base.  Making it
callable from within the revision walker would not be a small change.

But as you say, running merge-recursive here would be a very
expensive option.  Which is why I was saying the 3-way read-tree
result as that is cheaper to compute.  However the read-tree result
can be different from the merge-recursive result (think renames)
and yet both are still "trivial" resolutions that the user was
never involved in.

Of course other kinds of trivial merges (where changes from the
two branches are in the same file but far enough part it can be
easily merged as a 3-way file merge) appear to the path limiter
as though they were an evil merge, and such merges are output.

So maybe having --full-history output all merges that affected
that path really is the right choice.

-- 
Shawn.
