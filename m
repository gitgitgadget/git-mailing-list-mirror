From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Fri, 26 Aug 2005 11:03:33 -0700
Message-ID: <7voe7keft6.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043B9B85@scsmsx401.amr.corp.intel.com>
	<7vr7chmqop.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508261501510.18279@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 20:03:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8iYR-0000Q9-3f
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 20:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVHZSDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 14:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVHZSDf
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 14:03:35 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51390 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965156AbVHZSDf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 14:03:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826180334.NKYN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 14:03:34 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508261501510.18279@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 26 Aug 2005 15:04:43 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7817>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I like it. As Linus stated, the index originally had a different role from 
> what it has now, so it really should be an internal git thing, i.e. the 
> git user should not expect the index not to change when pulling.

Actually the issue and the way patch addresses it is not limited
to the index file.  The problem is that the relashionship
between your working tree and the $GIT_DIR/HEAD commit changes
unexpectedly (from the POV of the working tree) when the ref
being updated by the "push in reverse" machinery happens to be
the head of the branch you are currently on.  The working tree
is supposed to be based on $GIT_DIR/HEAD, but after the "push in
reverse".  This fix is about fast forwarding the working tree,
including the checked out files on the filesystem, to the
updated head when it happens.

I am tempted to move this logic to "git fetch" instead, because
it has the same issue.  Tony's "linus" branch example has been
updated to do a "git fetch" instead of "git pull" from the
earlier description in his howto, but if he happens to be on the
"linus" branch, he would still have this same problem.

Of course, doing this in "git fetch" needs to be done a bit more
carefully than in "git pull", because by definition "pull" is a
fetch followed by merging into the working tree, implying that
the repository has an associated working tree.  But "fetch" by
itself can be used for a naked repository [*1*], and we should
not unconditionally attempt to update the working tree that may
not exist.

I am planning to use the lack of index file for this detection,
but I've seen some people made an rsync copy of their private
repository as a whole to publish, so this heuristic may
probabaly break.  Maybe the lack of "$GIT_DIR/index" and
$GIT_DIR not ending with "/.git" and not being ".git"?  I am
undecided.

In the meantime, warning the user about the issue and suggesting
how to do the fast-forwarding of the working tree himself in the
warning message might be the safest and the most sensible thing
to do.


[Footnote]

*1* Do we want a term in the glossary to mean repositories like
linux-2.6.git and git.git that do not have associated working
trees?
