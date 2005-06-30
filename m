From: Junio C Hamano <junkio@cox.net>
Subject: Re: how about this as a basis for git-annotate?
Date: Thu, 30 Jun 2005 13:20:05 -0700
Message-ID: <7vd5q338cq.fsf@assigned-by-dhcp.cox.net>
References: <BAY22-F40C3079B41F242AEB407E1FFE30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 22:29:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do5eC-0003Um-Hi
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 22:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbVF3Uew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVF3UV3
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 16:21:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12715 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S263075AbVF3UUK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 16:20:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630202005.JKRS8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 16:20:05 -0400
To: "lode leroy" <lode_leroy@hotmail.com>
In-Reply-To: <BAY22-F40C3079B41F242AEB407E1FFE30@phx.gbl> (lode leroy's message of "Thu, 30 Jun 2005 15:55:32 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "ll" == lode leroy <lode_leroy@hotmail.com> writes:

ll> Still the idea should work.

Multiple parents?  Renames?  Total rewrites?

To save some time for you to think, here is an excerpt from my
sloooooow one describing how it works.  The final line-by-line
blame assignment is done exactly the same way as what you did in
your outline, reading from "diff -u0"; but there are other
things you need to worry about.

You will find at http://members.cox.net/junkio/blame.perl the
full implementation.  This is what I have been using to generate
the http://members.cox.net/junkio/Summary.txt file.

I do not need "how about this as a basis" at this point.  Basis
is already there and I have verified that it produces correct
results.  What I would like to see is for somebody to come up
with an implementation that produces the identical results in
1/20th of the time ;-).  That solution might probably involve
not calling diff-tree but instead doing things inside diff-tree.
I donno.

------------
How does this work, and what do we do about merges?

The algorithm considers that the first parent is our main line of
development and treats it somewhat special than other parents.  So we
pass on the blame to the first parent if a line has not changed from
it.  For lines that have changed from the first parent, we must have
either inherited that change from some other parent, or it could have
been merge conflict resolution edit we did on our own.

The following picture illustrates how we pass on and assign blames.

In the sample, the original O was forked into A and B and then merged
into M.  Line 1, 2, and 4 did not change.  Line 3 and 5 are changed in
A, and Line 5 and 6 are changed in B.  M made its own decision to
resolve merge conflicts at Line 5 to something different from A and B:

                A: 1 2 T 4 T 6
               /               \ 
O: 1 2 3 4 5 6                  M: 1 2 T 4 M S
               \               / 
                B: 1 2 3 4 S S

In the following picture, each line is annotated with a blame letter.
A lowercase blame (e.g. "a" for "1") means that commit or its ancestor
is the guilty party but we do not know which particular ancestor is
responsible for the change yet.  An uppercase blame means that we know
that commit is the guilty party.

First we look at M (the HEAD) and initialize Git::Blame->{LINE} like
this:

             M: 1 2 T 4 M S
                m m m m m m

That is, we know all lines are results of modification made by some
ancestor of M, so we assign lowercase 'm' to all of them.

Then we examine our first parent A.  Throughout the algorithm, we are
always only interested in the lines we are the suspect, but this being
the initial round, we are the suspect for all of them.  We notice that
1 2 T 4 are the same as the parent A, so we pass the blame for these
four lines to A.  M and S are different from A, so we leave them as
they are (note that we do not immediately take the blame for them):

             M: 1 2 T 4 M S
                a a a a m m

Next we go on to examine parent B.  Again, we are only interested in
the lines we are still the suspect (i.e. M and S).  We notice S is
something we inherited from B, so we pass the blame on to it, like
this:

             M: 1 2 T 4 M S
                a a a a m b

Once we exhausted the parents, we look at the results and take
responsibility for the remaining ones that we are still the suspect:

             M: 1 2 T 4 M S
                a a a a M b

We are done with M.  And we know commits A and B need to be examined
further, so we do them recursively.  When we look at A, we again only
look at the lines that A is the suspect:

             A: 1 2 T 4 T 6
                a a a a M b

Among 1 2 T 4, comparing against its parent O, we notice 1 2 4 are
the same so pass the blame for those lines to O:

             A: 1 2 T 4 T 6
                o o a o M b

A is a non-merge commit; we have already exhausted the parents and
take responsibility for the remaining ones that A is the suspect:

             A: 1 2 T 4 T 6
                o o A o M b

We go on like this and the final result would become:

             O: 1 2 3 4 5 6
                O O A O M B
