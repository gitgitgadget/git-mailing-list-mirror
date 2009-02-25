From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn and repository hierarchy?
Date: Wed, 25 Feb 2009 10:26:10 +0100
Message-ID: <49A50EB2.80300@drmicha.warpmail.net>
References: <20090224223412.GA4573@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 10:28:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcG3k-0000wE-JY
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbZBYJ0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755389AbZBYJ0d
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:26:33 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52361 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754877AbZBYJ0c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 04:26:32 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 39EBB2A60F0;
	Wed, 25 Feb 2009 04:26:29 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 25 Feb 2009 04:26:29 -0500
X-Sasl-enc: u+teFTE2XGWxy1BbkQkMSSiooucoB4XStHX/k1jn2oam 1235553988
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 71ECF3C37;
	Wed, 25 Feb 2009 04:26:28 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090223 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090224223412.GA4573@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111420>

Josef Wolf venit, vidit, dixit 24.02.2009 23:34:
> Hello,
> 
> I have set up a repository hierarchy like this:
> 
> 
>          subversion-repos
>                 |
>            git-svn-repos
>           /     |     \
>       clone1  clone2  clone3
> 
> 
> subversion-repos is an existing repository that can not be converted to
> git.
> 
> 
> git-svn-clone is meant as an intermediate "synchronization" repository.
> I never commit directly to this repos.  Its only intention is to
> synchronize the clones to each other and against subversion-repos.
> git-svn-clone was created by
> 
>      git svn init --stdlayout $svn_url git-svn-repos
>      (cd git-svn-repos && git svn fetch)
> 
> 
> cloneX are ordinary git clones of git-svn-repos for the day-by-day work.
> They were created by
> 
>      git clone git-svn-repos cloneX
> 
> 
> I can successfully work on the clones.  To synchronize with git-svn-clone,
> I do
>      git stash
>      git pull
>      git push origin
>      git stash apply
>      git stash clear
> And here is my first problem: every time I push to git-svn-repos, its
> working tree gets out of sync, because pushing don't update the tree.
> So every time I push, "git status" shows me local modifications which
> are actually outdated files.  I thought I could use a bare repository
> to avoid this problem, but git-svn refuses to work on a bare repos.
> So here's my first question: Any ideas how to get around this?

Recent enough git should even warn you against doing that, "that" being
pushing into checked out branches.

Your diagram above is missing important info, namely which branches you
are pushing into. But the problem indicates that you are pushing into a
checked out branch.

git-svn can't operate on bare repos beacuse rebasing needs a worktree.

> Once git-svn-repos is cleaned up, I want it to synchronize against
> subversion-repos.  Thus I do
> 
>      git svn rebase
>      git svn dcommit
> 
> This works most of the time.  Sometimes, I get error messages
> like this from rebase:
> 
>   Applying Fix logging of IP-Addresses when reading access list.
>   error: patch failed: upnp/websrv:528
>   error: upnp/websrv: patch does not apply
>   Using index info to reconstruct a base tree...
>   Falling back to patching base and 3-way merge...
>   No changes -- Patch already applied.
> 
> I've never seen any damage after this error message, and the last line
> suggests that this is only some informative warning.
> 
> 
> But now here's the real catch:  this time I got following error
> message from "git svn rebase":
> 
>   Auto-merged server/misc.c
>   CONFLICT (content): Merge conflict in server/misc.c
>   Failed to merge in the changes.
>   Patch failed at 0005.
>   
>   When you have resolved this problem run "git rebase --continue".
>   If you would prefer to skip this patch, instead run "git rebase --skip".
>   To restore the original branch and stop rebasing run "git rebase --abort".
> 
> Unfortunately, none of the three suggested commands help.
> 
> Investigation reveals that the conflict was caused by two independent
> commits to one of the clones. That is: both commits were on the same
> clone and no commits were done to the other clones in the mean time.
> The commits just happen to touch neighboring lines.
> 
> Those two commits have managed to go all the way up from cloneA through
> git-svn-repos to subversion-repos without any problem.  Only on the way
> back from subversion-repos to git-svn-repos, they create the conflict.
> 
> Any ideas how to clean up from the situation?  And how to avoid this
> problem in the future?

In your git-svn-repo you need more branches in order to do the
integration work:

>From your clones, push into branches like remotes/incoming/clone1 or
remotes/clone1/master etc. on your git-svn-repo. Using remote branches
there makes sure they will never be checked out.

Then, on git-svn-repo, you need to integrate the incoming clone branches
with the svn branches:

- rebase master first using git svn rebase
- If this fetches new revisions from svn it means that your clones were
not up to date. Decide now whether you want to rebase your clones first
and resolve any possible conflicts there (i.e.: git fetch on the clones,
rebase your changes on top, git push to incoming) or want to continue here.
- Integrate the incoming clone branches on top of master. If git svn
fetched new revisions in the previous step then master can't be fast
forwarded to the incoming clone branch tip. You'll have to cherry-pick
or use format-patch|am.
- Now dcommit.

AFAICS, the problem in a git-svn workflow is always svn's missing merge
capabilities whenever svn and git development diverge, such as when your
clones develop on top of a svn revision which is not current any more.
Somewhere the integration work has to done, and it will involve a
rebase. I think it's easier to do the rebase on the clone because it's
"pure git" there, i.e.: If git-svn fetches new stuff go back and do the
work on the clone. The only problem is if this is a quickly moving target.

Michael

P.S.: Uh, did somebody say cleanup? Who made the mess? ;)
