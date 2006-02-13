From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fake linear history in a deterministic manner.
Date: Sun, 12 Feb 2006 21:24:05 -0800
Message-ID: <7vk6bz3k7e.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 06:24:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8WC3-00006m-O2
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 06:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWBMFYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 00:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWBMFYI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 00:24:08 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:11727 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751644AbWBMFYH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 00:24:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060213052412.BRMI25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 00:24:12 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 13 Feb 2006 14:46:38 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16046>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I thought briefly about delaying the decision until I see the merge,
> and pick the leftmost, or rightmost, if there is some bias in
> git-merge or cg-merge on putting whatever origin has on a particular
> side. It'd mean running backwards through history and that the very
> last merge can flip the decision entirely. Hmmm... any strategy I can
> come up with means that each new merge throws the dice again entirely.
>
> Ideas?

When somebody pushes a ref to your existing commit ancestry
graph, you can easily identify which commits are the new ones
you see for the first time.

                A
           o---o
          /
     o---o---o---o---o B

Suppose you started from two branch repo A and B.  Your sqlite
database knows about all of these commits, and say you earlier
have decided to treat A as a side branch, B as trunk.

Then somebody pushed a new B, making the ancestry graph like
this:

                A
           o---o-------*---*---* B-new
          /           /     
     o---o---o---o---o B-old

When the update-hook runs, as you read in receive-pack.c, 
your refs have not been updated yet, so you can identify the
commits marked with * with:

	git rev-list B-new $(git rev-parse --not --all)

I think you have to do this enumeration of new commits anyway,
if you are keeping tabs on all commits in your database.  And
you check the chain * commits form, and work backwards.  The
topologically oldest ones determine what branch others belong
to.

With CVS you cannot express a merge very well, so you now face a
choice.  Which parent to drop from the leftmost * commit in the
above picture?

It has commits known to your sqlite database as its parents, and
one of them, B (old), is on trunk; the other one is a side
branch, so in this case the decision is clear.  You leave the
link from B-old and cut link from A.  But this heuristics would
not work very well if both are branches.  Which one to prefer?

One approach would be to see the world with eyes of the person
who did such a merge.  Both git and cogito place the current
branch as the first parent, so you can tell which one the person
who did the merge had before that merge that way.  Also in
practice, in a normal branch, you would build sequence of small
commits and occasionally merge from elsewhere, so the side with
more difference tends to be a side branch from the point of view
of the person who performs the merge.

However, this would not help much.  There is no inherent
distinction between trunk and branch in the distributed
development.  Although I treat my "next" branch as a side branch
and "master" branch as the trunk, "next" sometimes needs to
merge from "master", and by looking at only that merge, you
cannot tell which one is the trunk.  My merging "master" into
"next" does not make my "next" the trunk.

Since the ordering is completely arbitrary, I think you can give
preference to the ones you have found out about earlier.  That
is, suppose you already had this, and for some reason track B is
the trunk and track A is a branch (say commits on B have 1.XX,
the ones on A have 1.XX.1.YY where XX depends on which commits
on B the branch was forked from).  At this point, if you see a
push to C:

                A
           o---o
          /
     o---o---o---o---o B
              \
               *---* C

you give 1.XX.2.YY to commits on C.

This may or may not match reality, and C may collect a lot of
commits while B might stay dormant -- and you may regret that
you picked B as the trunk.  But the thing is, there is no
inherent trunk or branch in the distributed world, so the cvs
clients of your server needs to live with it.  To you, you saw B
first and people who track the project through your server also
saw B first.  Then you can have total ordering to side
branches.  When you see a merge, you arbitrarily but
consistently pick which side to pick.  The one that has smaller
number at the third place (which I am using as "the branch
number").

Just thinking out aloud again...
