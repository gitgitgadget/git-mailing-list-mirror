From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 19:36:39 -0400
Message-ID: <20060927233639.GE21839@spearce.org>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de> <451AB122.9020600@gmail.com> <Pine.LNX.4.63.0609280113490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 01:36:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSixS-0004VZ-HA
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 01:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031252AbWI0Xgv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 19:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031253AbWI0Xgv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 19:36:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:7623 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1031252AbWI0Xgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 19:36:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSix6-0000Wo-RZ; Wed, 27 Sep 2006 19:36:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6D1D820FB28; Wed, 27 Sep 2006 19:36:40 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609280113490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27947>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 27 Sep 2006, A Large Angry SCM wrote:
> > Wouldn't an fsck in the parent complain about missing objects?
> 
> ... not if my original idea (which I might have forgotten to mention ;-) 
> was implemented: symlinking subproject/.git/objects to .git/objects.

Right.  Which is one of the truely wonderful things about symlinks
in .git/refs and symlinking .git/objects. :-)


I don't know about anyone else but this thread has certainly helped
me rationalize a few thoughts about "subproject" support.

The major things I've taken away from it are:

 - Subprojects of any reasonable SCM should be supported.

   Although this is Git we sometimes want to play nice with other
   people working in the same pond.  We have a historical track
   record of doing this when it makes sense (git-svn, git-cvsserver,
   etc.) but clearly doing it for every SCM out there is not
   possible.

   But that said having "out of the box" support for Git subprojects
   within a larger Git project should Just Work.  It doesn't
   really yet.

 - Higher level projects should drive subprojects.

   Higher level projects tend to be composed of specific revisions or
   specific generations of subprojects.

   Part of the content of the higher level project is just what
   those subproject specifications are and how those subprojects
   should appear in a working directory.

 - Git Porcelain should help the user.

   Git operations should translate down through lower level projects
   when possible, and lower level project changes should push up
   when possible.

   E.g. git-fetch in a higher level repository should percolate
   down into the lower level repositories automatically.  Ditto with
   git-checkout and probably git-push.  git-commit in a lower level
   repository probably should update the specification file(s)
   in the higher level repository but not commit the higher level
   repository.

 - The subproject SCM interface needs to be modular.

   Users need to include many different subprojects and not all of
   them use Git.  Ideally Git would be able to at least be easily
   taught by the user how to invoke a particular subproject's SCM
   for the purpose of an initial checkout, if not for additional
   operations such as pull, push, commit and tag.


I used the term "generation of subprojects" as not everyone wants
to bind their root project to a specific revision of a subproject.
Indeed that may not be entirely practical.  Instead just a particular
lineage of development (e.g. "Version 1.0" vs. "Version 1.2")
may be all that is needed.

For example including a CVS hosted subproject into a larger Git
project means you can't use a specific SHA1 to reference a single
version of that CVS subproject.  Yet you can use a CVS branch
or label name.  But both of those are moving targets in a CVS
repository.  But in a sane CVS project a label or a branch will
be relatively stable over time, meaning that its good enough given
that its all we got (without importing everything into Git anyway).

Likewise a Git project including a Git subproject should be able
to reference a named tag of the subproject.  If the subproject
changes its tag and the fetcher agrees to the change (with a
--force) then its OK for the subproject to follow that tag change.
Likewise it should be acceptable for a subproject to reference a
specific branch head.  Although this is a moving target that may be
acceptable while the higher level project is under rapid development.

However an annoted tag probably should not be able to be created
on the higher level project unless all lower-level subprojects
are referenced by tags (or the equivilant) in their SCM.  Which
implies using a "stable tag" in CVS, a "/tags/foo@rev" in SVN,
or an annotated tag in Git and updating the specification file(s)
to reflect that.

-- 
Shawn.
