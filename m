From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sun, 30 Apr 2006 17:50:02 -0700
Message-ID: <7v8xpmva9x.fsf@assigned-by-dhcp.cox.net>
References: <20060429165151.2570.qmail@science.horizon.com>
	<e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>
	<e30k0n$ij5$1@sea.gmane.org> <e32kkf$amc$1@sea.gmane.org>
	<7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 02:50:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaMc5-0001sn-27
	for gcvg-git@gmane.org; Mon, 01 May 2006 02:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWEAAuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 20:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWEAAuF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 20:50:05 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17390 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751244AbWEAAuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 20:50:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501005003.NOAW19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 20:50:03 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 30 Apr 2006 16:19:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19366>

Junio C Hamano <junkio@cox.net> writes:

> We can fast-forward if (1) you pulled from "pu" the last time,
> and (2) you haven't added anything on top of it on your own, and
> (3) you pull from "pu" again, if the previous "pu" (i.e. your
> "pu") is a parent of the updated "pu".  We do not need "prior"
> for that.  The old "pu" being _one_ _of_ the parents, not even
> necessarily be the first one, would do just fine.

This part may want a bit more elaboration.  

Often, we see in the Linus kernel tree a fast forward of his tip
from a recent commit Linus made to bunch of networking commits
made by David S Miller.  For example, Linus fast forwarded to
18118c from David's tree before making this commit:

    commit 454ac778459bc70f0a9818a6a8fd974ced11de66
    Merge: 18118cd... 301dc3e...
    Author:     Linus Torvalds <torvalds@g5.osdl.org>
    AuthorDate: Mon Apr 24 20:08:08 2006 -0700
    Commit:     Linus Torvalds <torvalds@g5.osdl.org>
    CommitDate: Mon Apr 24 20:08:08 2006 -0700

The first parent of this commit is one not made by Linus; that
is how we can tell he fast forwarded.  We cannot easily tell
where the tip of Linus tree was before he made this fast forward
(it is not recorded anywhere), but if we look at 18118c commit:

    commit 18118cdbfd1f855e09ee511d764d6c9df3d4f952
    Author:     Patrick McHardy <kaber@trash.net>
    AuthorDate: Mon Apr 24 17:18:59 2006 -0700
    Commit:     David S. Miller <davem@sunset.davemloft.net>
    CommitDate: Mon Apr 24 17:27:34 2006 -0700

        [NETFILTER]: ipt action: use xt_check_target for basic verification

we could sort-of make a guess, by looking at merge-base of
18118c and 301dc3.  By looking at

	gitk 6b426e..18118c 454ac7

we can tell that David "forked" from Linus at 6b426e commit.

What does it mean for Linus to fast-forward to the tip of David?
Earlier I said that each branch has a purpose, and replacing the
current tip commit of the branch with another commit is a
statement by the repository owner that the new commit suits the
purpose of the branch better.

To David, the commits he has in the chain between 6b426e to
18118c obviously suited the purpose of his tree better, and that
was why these commits were made.  And the fact Linus fast
forwarded to the tip of David is an implicit statement by Linus
that that results suits the purpose of Linus tree better as well
compared to his old tip, presumably 6b426e.

Earlier I suggested (or at least may have sounded as if I was
suggesting) that not recording that statement in fast-forward
situation was a bad thing, but that is not necessarily so.
Having 18118c commit as part of the history that leads to the
tip is enough as such a statement by Linus.

Now, David's tree has a tendency to be extra clean (no merges
but straight commits on top of then-current tip of Linus), but
if he had his own merge from Linus's tree, such a commit would
have had a commit from Linus tree as its second parent.  If
Linus tip remained at that "second parent" commit until David is
done and asked Linus to pull, it would result in a fast forward
via non-first-parent ancestry.  But even if that happened, the
above discussion still applies.
