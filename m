From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 14:18:53 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org>
References: <20080703182650.GA11166@old.davidb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:20:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWEC-0001nO-RN
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbYGCVTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 17:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbYGCVTd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:19:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35688 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754044AbYGCVTc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 17:19:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m63LIrxE011754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 3 Jul 2008 14:18:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m63LIr8A027641;
	Thu, 3 Jul 2008 14:18:53 -0700
In-Reply-To: <20080703182650.GA11166@old.davidb.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.366 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87321>



On Thu, 3 Jul 2008, David Brown wrote:
> 
> First we tried a git-merge and resolved the conflicts.  The problem here is
> that the resultant code didn't work.  git-bisect wasn't very useful because
> the intermediate versions don't have resolved conflicts.
> 
> Yesterday, one developer cherry picked company B's changes into a branch.
> It appears he resolved the conflicts for each commit, which should make
> bisecting easier.

What I would suggest is actually a stupid combination of the two. The 
advantage and disadvantage of the cherry-picking is:

 - the cherry-picking obviously gave you the end result you wanted, and is 
   bisectable at a per-commit level (ie each cherry-pick was a 
   "micro-merge", and if there was a merge problem, it would show up 
   exactly in _that_ one)

BUT

 - the cherry-picking doesn't help future merges, since the history is 
   disjoint, and as such it will always diverge and just cause more and 
   more problems down the road to keep on doing this.

so what I would suggest is

 - generate the *state* of the tree by cherry-picking each commit one by 
   one, and verify that state.

 - but then do a merge that picks that one state as the merge result 
   (this is all assuming you cherry-picked every single commit, of 
   course!)

The latter thing is really easy to do. Just do the merge, and ignore the 
conflicts that happen entirely, because you then just use the tree from 
the temporary cherry-picking branch

	# Try to merge the other branch ..
	git merge otherbranch

	# .. but ignore conflicts entirely by then
	# setting the index and checked-out state to
	# the known-good end result
	git read-tree -u --reset cherry-picked-branch

	# .. and commit that instead
	git commit

	# and you can now remove the cherry-picked branch
	# that was only used for the tree
	git branch -D cherry-picked-branch

to actually commit that merge and get rid of the temporary cherry-picking 
branch.

(Of course, if the merge actually doesn't generate any conflicts, and thus 
commits it, but doesn't actually _work_, then that "git commit" needs to 
be a "git commit --amend" instead, in order to actually replace the merge 
commit rather than add a fixup commit afterwards)

End result: you have a nice merge with nice history that actually 
converges at a common point, but you effectively did the merge resolution 
one commit at a time with cherry-picking (or "git rebase", which is 
obviously just a convenient shorthand for cherry-picking everything).

This actually has a few other advantages too: "git show --cc" on that 
merge will also show the conflicts the way they got resolved, so you 
actually end up with some useful information this way too.

			Linus
