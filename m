From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Sat, 03 Sep 2005 11:46:53 -0700
Message-ID: <7vy86erntu.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 20:48:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBd2j-0005k4-9W
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 20:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVICSq4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbVICSq4
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 14:46:56 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42376 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751181AbVICSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2005 14:46:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050903184655.TPDN20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Sep 2005 14:46:55 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vek867e29.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 03 Sep 2005 01:25:50 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8042>

This is a simplified scenario of klibc vs klibc-kbuild HPA had
trouble with, to help us think of a way to solve this
interesting merge problem.

	 #1 - #3 - #5 - #7
       /    /         /
    #0 - #2 - #4 - #6

There are two lines of developments.  #0->#2 renames F to G and
introduces K.  #0->#1 keeps F as F and does not introduce K.

At commit #3, #2 is merged into #1.  The changes made to the
file contents of F between #0 and #2 are appreciated, but the
renaming of F to G and introduction of K were not.  So commit #3
has the resulting merge contents in F and does not have file K.
This _might_ be different from what we traditionally consider a
'merge', but from the use case point of view it is a valid thing
one would want to do.

Commit #4 is a continued development from #2; changes are made
to G, and K has further changes.  Commit #5 similarly is a
continued development from #3; its changes are in F and K does
not exist.

We are about to merge #6 into #5 to create #7.  We should be
able to take advantage of what the user did when the merge #3
was made; namely, we should be able to infer that the line of
development that flows #0 .. #3 .. #7 prefers to keep F as F,
and does not want the newly introduced K.  We should be able to
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
structure` changes we do _not_ want from their line of
development, while slurping the contents changes from them.
When making the tree to put at #7, just like I outlined to my
previous message to HPA, we can first create a tree that is a
derivative of #6 with only the structural changes detected
between #2 and #3 (which are 'rename from G to F' and 'removal
of K') applied.  Similarly, we make another derivative, this
time of #2, with only the structural changes to adjust it to
'our' tree (again, 'rename from G to F' and 'removal of K').
Then we can run 3-way git-read-tree like this:

    git-read-tree -m -u '#2-adjusted' '#5' '#6-adjusted'

The last part, using the structurally adjusted tree as the
merge-base tree, is what I forgot to do in the previous message
to HPA.

Hmm.
