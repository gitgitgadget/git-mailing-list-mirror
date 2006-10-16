From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and u-boot broken.
Date: Sun, 15 Oct 2006 20:47:36 -0700
Message-ID: <20061016034736.GA8782@localdomain>
References: <012b01c6f0a6$a1a636e0$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 05:47:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZJS4-0006gx-B8
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 05:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWJPDrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 23:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWJPDrj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 23:47:39 -0400
Received: from hand.yhbt.net ([66.150.188.102]:60826 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751447AbWJPDri (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 23:47:38 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 39B6E7DC08D;
	Sun, 15 Oct 2006 20:47:37 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 15 Oct 2006 20:47:37 -0700
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Disposition: inline
In-Reply-To: <012b01c6f0a6$a1a636e0$1267a8c0@Jocke>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28949>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > > Any chance you can update it with more examples?
> > > > Especially one that show how one can do one big initial
> > > > commit then merge your own changes on top of that?
> > > 
> > > Hmm.. large imports from git to svn can get confusing, and generally
> > > aren't very useful on the svn side since history gets flattened.
> > > So I generally don't recommend importing complete git histories into
> > > svn.
> > 
> > Yes, that's what I am trying to avoid below. Basically I want 
> > to commit to SVN the
> > whole u-boot tree as one commit up to the point where I 
> > started to do my changes.
> > Then I want my changes per commit on top of that. However I 
> > don't want to loose the
> > ability to merge/pull in future updates from denx u-boot tree.
> > 
> > I just don't know how to do it, the script below fails when 
> > it tries to 
> > pull the rest of the tree. Any ideas?
> 
> I really need some advice here, if you can share some ideas that would be great.
> 
> > 
> > > 
> > > > Something like this
> > > > REPO="file:///tmp/SVNuboot"
> > > > REPO_PATH="/tmp/SVNuboot"
> > > > GIT_REPO="/tmp/mygituboot"
> > > > ORG_REPO="/usr/local/src/u-boot"
> > > > rm -rf "$REPO_PATH"
> > > > rm -rf "$GIT_REPO"
> > > > svnadmin create "$REPO_PATH"
> > > > svn mkdir -m "initial repo layout" "$REPO"/trunk 
> > > "$REPO"/branches "$REPO"/tags
> > > > mkdir -p "$GIT_REPO"
> > > > cd "$GIT_REPO"
> > > > git-svn init "$REPO"/trunk
> > > > echo  [user] >> .git/config
> > > > echo  name="jocke" >> .git/config
> > > > echo  email="Joakim.Tjernlund@transmode.se" >> .git/config
> > > > git-svn fetch
> > > > git checkout -b svn-branch remotes/git-svn
> > > > git-fetch "$ORG_REPO" tmcu2:tmcu

I assume the tmcu* branch is private as I don't see it in the u-boot
repo.

> > > > git-branch initial-uboot f5e0d03970409feb3c77ab0107d5dece6b7d45c9
> > > > git pull . initial-uboot
> > > > # --squash makes one large commit.
> > > > git pull --squash . initial-uboot
> > > > cg-commit -m "merge up to 
> > f5e0d03970409feb3c77ab0107d5dece6b7d45c9"
> > > > git-svn commit -q remotes/git-svn..svn-branch
> > > > git pull . tmcu # This doesn't work, I get merge conflicts
> > > > git-svn commit -q remotes/git-svn..svn-branch

Using -q suppresses potentially useful information.  I wouldn't use
it if you're not sure about what you're doing.

I would do something like this:

... (same stuff as above before with svn setup...)
git clone $ORG_REPO $GIT_REPO
cd $GIT_REPO
git-svn init "$REPO"/trunk
git-svn fetch

# sync the SVN repo with initial-uboot
# this will just commit a snapshot, without history, which I assume
# is what you want.
git-branch initial-uboot f5e0d03970409feb3c77ab0107d5dece6b7d45c9
git-svn commit initial-uboot
git checkout -b svn-branch remotes/git-svn
git-pull . tmcu2

# this should work assuming the path from initial-uboot..tmcu2 is linear
# use gitk initial-uboot..tmcu2 to check
git-svn dcommit

Also, git-svn is really designed for individual developers who prefer to
use git, but need to interact with project that already uses SVN.
u-boot already uses git, so I don't see why you'd need git-svn :)

-- 
Eric Wong
