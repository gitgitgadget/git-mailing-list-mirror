From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Branching clarifications
Date: Fri, 7 Sep 2007 22:21:26 -0700
Message-ID: <20070908052126.GB28855@soma>
References: <46E18095.60501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 07:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITslC-0008N5-4S
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 07:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbXIHFV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 01:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXIHFV2
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 01:21:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35180 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbXIHFV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 01:21:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E1B3E2DC08D;
	Fri,  7 Sep 2007 22:21:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46E18095.60501@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58101>

Russ Brown <pickscrape@gmail.com> wrote:
> I have a few questions about how/when to use git branches when using
> git-svn (I'm a tad confused...)
> 
> Say I've initialised and fetched a git repo involving trunk and one
> branch (say branch1) from an svn repository.
> 
> If I do git branch -a, I see similar to the following:
> 
> * master
>   branch1
>   trunk
> 
> (branch1 and trunk are in red for me, which I figure means they're
> remotely tracked or something like that?)

Yes, that seems to be the case (I just enabled color.branch=auto in
.git/config for the first time).

> OK, so that's telling me that I currently have master checked out into
> my working copy. My question is: where did master come from? Is it a
> local branch of trunk?

git-svn sets "master" to the most recently committed-to branch
in SVN the first time it fetches.  "git-log master" will tell
you (look at the git-svn-id: lines).

After you do your initial fetch/clone, it should say something like:

  ----------------------------------------------------------------------
  Checked out HEAD:
    svn://my-repository-here/branches/foo r12345
  ----------------------------------------------------------------------

> Moving on, say I want to work on branch1. Can I simply issue git
> checkout branch1? If I do so I get this:
> 
> $ git branch -a
> * (no branch)
>   master
>   branch1
>   trunk
> 
> Which is a bit scary. It seems my working copy is orphaned...

Yes it is.  Branches under the refs/remotes/ hierarchy were created
back in the day to tell the local user they should not commit to
them directly.

> OK, so let's assume I'm supposed to create a local branch of each remote
> branch I want to work on. So:
> 
> $ git branch local/branch1 branch1
> $ git checkout local/branch1
> 
> $ git-branch -a
> * local/branch1
>   master
>   branch1
>   trunk

That's correct.  You can also use "git checkout -b local/branch1 branch1"
instead of those two commands.

> Am I supposed to have used --track when creating  this branch? What are
> the implications for specifying or not specifying that flag when using
> git-svn?

--track has no effect with git-svn.  dcommit will automatically figure
out which branch it should commit to[1].  Running "git-svn dcommit -n"
with 1.5.3 will tell you which URL you'll commit to.

> So I do some editing on this branch, commit and dcommit. The changes
> appear as expected in the repo.
> 
> At this point if I checkout master, the contents look like
> local/branch1, which isn't what I'd suspected (that it would be a branch
> of trunk). What does master represent?

(see above)

> So I checkout local/trunk, and create a new file, commit and dcommit.
> Umm, it's been committed to branch1 on the repo: not trunk,
> 
> So I figure I'm quite obviously doing something wrong here. Could
> someone give me a hand and tell me what it is I'm getting wrong?

If you run "git-log local/trunk", does the first commit to show
a "git-svn-id: " line have the URL pointing to trunk or branch1?

Again, if you're unsure about where you're committing to,
"git-svn dcommit -n" in 1.5.3 is your friend.

[1] - as long as you don't use git-merge or git-pull.  If you decide to
      do those things, make sure you have Lars's latest patches
      that enables --first-parent.
      Otherwise stick with format-patch/am/cherry-pick/fetch/rebase

-- 
Eric Wong
