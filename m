From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Sun, 04 Sep 2005 00:32:23 -0700
Message-ID: <7v64thl248.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>
	<20050903190500.GB8379@mars.ravnborg.org>
	<7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
	<20050903220355.GA1895@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 09:33:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBozS-0007NK-82
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 09:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVIDHcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 03:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVIDHcb
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 03:32:31 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27064 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751187AbVIDHca (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 03:32:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050904073224.FQCX24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 03:32:24 -0400
To: Sam Ravnborg <sam@ravnborg.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8050>

Sam Ravnborg <sam@ravnborg.org> writes:

> If the problem is not fully understood it can be difficult to come up
> with the proper solution. And with the example above the problem should
> be really easy to understand.
> Then we have the tree as used by hpa with a few more mergers in it. But
> the above is what was initial tried to do with the added complexity of a
> few more renames etc.

All true.  Let's redraw that simplified scenario, and see if
what I said still holds.  It may be interesting to store my
previous message and this one and run diff between them.  I
suspect that the main difference to come out would be the the
problem description part and the merge machinery part would not
be all that different.

------------
This is a simplified scenario of klibc vs klibc-kbuild HPA had
trouble with, to help us think of a way to solve this
interesting merge problem.

	 #1 - #3 - #5 - #7
       /    /         /
    #0 - #2 - #4 - #6

There are two lines of developments.  #0->#1 renames F to G and
introduces K.  #0->#2 keeps F as F and does not introduce K.

At commit #3, #2 is merged into #1.  The changes made to the
file contents of F between #0 and #2 are appreciated, but we
would also want to keep our decision to rename F to G and our
new file K.  So commit #3 has the resulting merge contents in G
and has K, inherited from #1.  This _might_ be different from
what we traditionally consider a 'merge', but from the use case
point of view it is a valid thing one would want to do.

I handwaved in my original message, but resolving this merge is
not something git can help you mechanically; obviously it cannot
decide if you want to keep the rename for you.

Commit #4 is a continued development from #2; changes are made
to F, and there is no K.  Commit #5 similarly is a continued
development from #3; its changes are made to G and K also has
further changes.

We are about to merge #6 into #5 to create #7.  We should be
able to take advantage of what the user did when the merge #3
was made; namely, we should be able to infer that the line of
development that flows #0 .. #3 .. #7 prefers to rename F to G,
and also wants the newly introduced K.  We should be able to
tell it by looking at what the merge #3 did.

Now, how can we use git to figure that out?

First, given our current head (#5) and the other head we are
about to merge (#6), we need a way to tell if we merged from
them before (i.e. the existence of #3) and if so the latest of
such merge (i.e. #3).

The merge base between #5 and #6 is #2.  We can look at commits
between us (#5) and the merge base (#2), find a merge (#3),
which has two parents.  One of the parents is #2 which is
reachable from #6, and the other is #1 which is not reachable
from #6 but is reachable from #5.  Can we say that this reliably
tells us that #2 is on their side and #1 is on our side?  Does
the fact that #3 is the commit topologically closest to #5 tell
us that #3 is the one we want to look deeper?

This is still handwaving, but assuming the answers to these
questions are yes, we have found that the 'previous' merge is
#3, that #1 is its parent on our side, and that #2 is its parent
on their side.

Then we can ask 'diff-tree -M #2 #3' to see what `tree
structure` non-changes we do _not_ want from their line of
development, while slurping the contents changes from them.
When making the tree to put at #7, just like I outlined to my
previous message to HPA, we can first create a tree that is a
derivative of #6 with only the structural changes detected
between #2 and #3 (which are 'rename from F to G' and 'addition
of K') applied.  Here, applying 'addition of K' is only
conceptual, unlike the original message you (Sam) had trouble
with due to my misunderstanding of which line of development
renames/adds.  It is conceptual in the sense that we do not have
to do anything special.  #6-adjusted is different from #6 in
that it has F's contents from #6 at G.

Similarly, we make another derivative, this time of #2, with
only the structural changes to adjust it to 'our' tree (again,
'rename from F to G' and 'addition of K' which is only
conceptual --- that is, #2-adjusted has contents of F from #2 at
G).  Then we can run 3-way git-read-tree like this:

    git-read-tree -m -u '#2-adjusted' '#5' '#6-adjusted'

The last part, using the structurally adjusted tree as the
merge-base tree, is what I forgot to do in the previous message
to HPA.

In all these three trees fed to read-tree, the original F
(modified in two lines since #0 which had it at F) appears at F,
so the normal 3-way merge machinery would work just fine.  #2
does not have G (neither #2-adjusted), #5 does, and #6 does not
(neither #6-adjusted), so again the ordinary 3-way merge
machinery would pick up G from #5 and drop it in #7.  That's why
'adjusting to our tree' for addition is only conceptual, unlike
the removal and rename in the previous message.

So as I said, the principle is not that different.

Any volunteer to code this up and see how well it works in
practice?
