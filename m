From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn set-tree bug
Date: Sun, 10 Jun 2007 22:52:38 -0700
Message-ID: <7vir9vox5l.fsf@assigned-by-dhcp.cox.net>
References: <466C8B35.3020207@midwinter.com>
	<003401c7abba$c7574300$0e67a8c0@Jocke> <20070611042509.GA19866@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 07:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxcpc-0007MF-0Q
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 07:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbXFKFwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 01:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbXFKFwk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 01:52:40 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36905 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbXFKFwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 01:52:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611055238.MLWQ12207.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Jun 2007 01:52:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A5se1X0071kojtg0000000; Mon, 11 Jun 2007 01:52:38 -0400
In-Reply-To: <20070611042509.GA19866@muzzle> (Eric Wong's message of "Sun, 10
	Jun 2007 21:25:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49820>

Eric Wong <normalperson@yhbt.net> writes:

> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>> > -----Original Message-----
>> > From: Steven Grimm [mailto:koreth@midwinter.com] 
>> > Sent: den 11 juni 2007 01:37
>> > To: Joakim Tjernlund
>> > Cc: 'Eric Wong'; 'git'
>> > Subject: Re: git-svn set-tree bug
>> > 
>> > Joakim Tjernlund wrote:
>> > > Is there a way to tell set-tree to commit the whole "merge" branch
>> > > as one svn commit?
>> > > If I merge the latest kernel into my tree there will
>> > > be a lot of commits that I don't want in svn.
>> > >   
>> > 
>> > You want a "squash" merge. Something like this:
>> > 
>> > git checkout -b tempbranch origin/svn-branch-to-commit-merge-to
>> > git merge --squash branch-with-commits-you-want-to-merge
>> > git commit
>> > git svn dcommit
>> > 
>> > The "merge" command will merge in the changes but will not commit 
>> > anything; when you do the explicit "commit" command 
>> > afterwards, you get 
>> > the contents of the merge but from git's point of view it's just a 
>> > regular commit so git-svn doesn't get confused.
>> > 
>> > After you do git svn dcommit, you may want to edit 
>> > .git/info/grafts to 
>> > tell git after the fact that this commit was a merge. It won't hurt 
>> > git-svn at that point and it will mean you can do another merge later 
>> > without git getting confused about what has already been merged.
>> > 
>> > Take a look at the script I posted a while back, which does something 
>> > similar:
>> > 
>> > http://www.spinics.net/lists/git/msg29119.html
>
> I must have missed this message the first time around.
>
>> Hi Steven
>> 
>> That looks promising, especially Junos comment about making git-svn
>> able to deal with merges. Eric, do you feel this is doable?
>
> Doable?  Yes.  However, I think using grafts is quite hackish and
> unreliable[1].  I'd rather just have users using set-tree if
> they want to deal with non-linear history in the first place.
>
> I'd personally avoid any sort of non-linear history when interacting
> with SVN repositories, however.

I've been wondering if you can do a moral equilvalent of the
graft trick but without using graft inside dcommit.  Perform a
merge --squash of the other branch (call the tip commit $B),
then dcommit on the git side as usual, and call it commit $C.
Steven's procedure would do a graft trick here, but instead of
doing that, rewrite $C to have the two parents.  Using the tree
object of $C, create a new git commit $D that is a merge between
the parent of $C (i.e. $C^) and the squashed branch tip $B.
Replace the tip of the current branch (which is $C) with $D.
Finally, replace the mapping between svn commit and git side
recorded in the revdb (which currently says $C on the git side
corresponds to the HEAD of SVN side) with this new commit $D.

Wouldn't that let the git side know what was merged into the
branch, so that later merges on the git side would go smoothly?

Or am I grossly misunderstanding how dcommit, tracking of svn vs
git commit mappings and the graft trick work?
