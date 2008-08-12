From: Petr Baudis <pasky@suse.cz>
Subject: Re: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 19:32:57 +0200
Message-ID: <20080812173257.GK10151@machine.or.cz>
References: <20080812161854.GB30067@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>,
	Manoj Srivastava <srivasta@debian.org>,
	vcs distro packaging discussion list 
	<vcs-pkg-discuss@lists.alioth.debian.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 19:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSxl9-0006lr-Hz
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 19:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYHLRdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 13:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbYHLRc7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 13:32:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58451 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbYHLRc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 13:32:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 20B70393A530; Tue, 12 Aug 2008 19:32:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812161854.GB30067@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92119>

  Hi,

On Tue, Aug 12, 2008 at 01:18:54PM -0300, martin f krafft wrote:
> I want to use TopGit for distro packaging. Any of my packages have
> one or more feature branches, some intended for upstream, some
> distro-specific. As I am packaging TopGit for Debian, I encountered
> the situation that two branches conflict with each other (they
> change the same line), but there is no dependency between the
> branches. Thus, when I squash the branches into a series, the
> resulting patches will not apply (they both change the same original
> line to something else).

  yes, that is good point.

> Obviously, I can introduce a "fake" dependency to force TopGit to
> create one patch based on another. However, this then prevents me
> from testing and developing the depending branch in isolation,
> meaning that I always have to have the dependent branch applied when
> I want to work on the second feature. Furthermore, it's not
> trivially possible in this situation to cherry-pick only the second
> patch.

  Well, at least we're not _worse_ off than when using a classical patch
series instead of TopGit, since all the downsides would be the same as
if we had this "fake dependency", right? Though of course, it would be
nice if we could do better here.

> As an alternative, it may be possible, however, to let TopGit know
> about a "fake dependency" from B on A. When serialised, TopGit would
> notice that there are multiple paths from master to B (master->B and
> master->A->B) and use the longer one.

  I'm sorry, I don't follow you here. If there is a dependency, TopGit
will always serialize A first, if there is no dependency, reordering
won't help you since B's base won't accomodate A.

> Do you see any other ways in which the situation could be handled?


  First, let's consider the simplest situation:

	A--C
          /
	B.

(These are branches, not commits!)

  In this case, we _CAN_ actually serialize A,B by doing a "resolution
sling" operation - simply take diff(A,C) instead of diff(B^,B)!

  The trouble is that we will have:

	A1--A2--A3--A4--C
                       /
	B1--B2--B3--B4.

  Here, we would have to squash B1..B4 to B in order to be able to do
this, which is of course undesirable. We want to sling the C resolution
in front of B1, and there seems to be no simple way to do this - or can
anyone see any?

  So we would have to ask the user to propagate it instead. Let's call
these "tie branches":

	A1--A2--A3--A4------------------C
		     \                 /
		      T1--T2--T3--T4  /		tree(T4) == tree(C)
		     /   /   /   /   /
		    B1--B2--B3--B4--'

  I guess this is just a more formalized way of rewording your other
proposal. Then, TopGit, instead of directly setting up C_base by merging
A4+B4, would create the tie branches T1..T4 and use T4 as C_base.

  I'm not really happy about this idea, though. It would complicate
TopGit even much more than it is now, and I'm not sure if this is worth
it instead of just requiring you to maintain your dependencies more
carefully when you intend to serialize your series later.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
