From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn set-tree bug
Date: Tue, 12 Jun 2007 00:20:35 -0700
Message-ID: <20070612072035.GA29385@muzzle>
References: <466C8B35.3020207@midwinter.com> <003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle> <7vir9vox5l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 09:20:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy0gL-0006wZ-KY
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 09:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbXFLHUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 03:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXFLHUi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 03:20:38 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37667 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbXFLHUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 03:20:38 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1ECD57DC09D;
	Tue, 12 Jun 2007 00:20:36 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Jun 2007 00:20:35 -0700
Content-Disposition: inline
In-Reply-To: <7vir9vox5l.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49931>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> >> > -----Original Message-----
> >> > From: Steven Grimm [mailto:koreth@midwinter.com] 
> >> > Sent: den 11 juni 2007 01:37
> >> > To: Joakim Tjernlund
> >> > Cc: 'Eric Wong'; 'git'
> >> > Subject: Re: git-svn set-tree bug
> >> > 
> >> > Joakim Tjernlund wrote:
> >> > > Is there a way to tell set-tree to commit the whole "merge" branch
> >> > > as one svn commit?
> >> > > If I merge the latest kernel into my tree there will
> >> > > be a lot of commits that I don't want in svn.
> >> > >   
> >> > 
> >> > You want a "squash" merge. Something like this:
> >> > 
> >> > git checkout -b tempbranch origin/svn-branch-to-commit-merge-to
> >> > git merge --squash branch-with-commits-you-want-to-merge
> >> > git commit
> >> > git svn dcommit
> >> > 
> >> > The "merge" command will merge in the changes but will not commit 
> >> > anything; when you do the explicit "commit" command 
> >> > afterwards, you get 
> >> > the contents of the merge but from git's point of view it's just a 
> >> > regular commit so git-svn doesn't get confused.
> >> > 
> >> > After you do git svn dcommit, you may want to edit 
> >> > .git/info/grafts to 
> >> > tell git after the fact that this commit was a merge. It won't hurt 
> >> > git-svn at that point and it will mean you can do another merge later 
> >> > without git getting confused about what has already been merged.
> >> > 
> >> > Take a look at the script I posted a while back, which does something 
> >> > similar:
> >> > 
> >> > http://www.spinics.net/lists/git/msg29119.html
> >
> > I must have missed this message the first time around.
> >
> >> Hi Steven
> >> 
> >> That looks promising, especially Junos comment about making git-svn
> >> able to deal with merges. Eric, do you feel this is doable?
> >
> > Doable?  Yes.  However, I think using grafts is quite hackish and
> > unreliable[1].  I'd rather just have users using set-tree if
> > they want to deal with non-linear history in the first place.
> >
> > I'd personally avoid any sort of non-linear history when interacting
> > with SVN repositories, however.
> 
> I've been wondering if you can do a moral equilvalent of the
> graft trick but without using graft inside dcommit.  Perform a
> merge --squash of the other branch (call the tip commit $B),
> then dcommit on the git side as usual, and call it commit $C.
> Steven's procedure would do a graft trick here, but instead of
> doing that, rewrite $C to have the two parents.  Using the tree
> object of $C, create a new git commit $D that is a merge between
> the parent of $C (i.e. $C^) and the squashed branch tip $B.
> Replace the tip of the current branch (which is $C) with $D.
> Finally, replace the mapping between svn commit and git side
> recorded in the revdb (which currently says $C on the git side
> corresponds to the HEAD of SVN side) with this new commit $D.
> 
> Wouldn't that let the git side know what was merged into the
> branch, so that later merges on the git side would go smoothly?
> 
> Or am I grossly misunderstanding how dcommit, tracking of svn vs
> git commit mappings and the graft trick work?

Ok, it took me a few reads, but I think that'll work...

If dcommit detects a merge commit when doing rev-list When looking at
commit objects, is it safe to assume that the first parent is always the
"mainline" and that parents after it are the ones to merge from?

So if I saw:

commit $X
parent $A
parent $B

I'd basically do:
  reset --hard $A
  merge --squash $B

And resulting in $C which would have the same tree as $X,
then, when dcommit-ting, $D would be created with two parents:
  $D~1 (svn), $B (git), but not $A

Rewritten history:
  $A         =>  $D~1
  $X         =>  $D (HEAD revision in SVN)

$X and $A are now discarded and gc-able.


Of course, since I already have the result of "merge --squash $B" in $X,
I could just rewrite $X with a single parent (call it $X'), dcommit, and
then give $D ($D~1 and $B) as parents.  Avoiding the nastiness of
set-tree

-- 
Eric Wong
