From: Josef Wolf <jw@raven.inka.de>
Subject: git-svn and repository hierarchy?
Date: Tue, 24 Feb 2009 23:34:12 +0100
Message-ID: <20090224223412.GA4573@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 23:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc5yO-0003BD-B3
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 23:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759318AbZBXWkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 17:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759127AbZBXWkP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 17:40:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:60230 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbZBXWkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 17:40:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Lc5wf-000261-QG; Tue, 24 Feb 2009 23:40:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 749F62C88B; Tue, 24 Feb 2009 23:34:12 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111356>

Hello,

I have set up a repository hierarchy like this:


         subversion-repos
                |
           git-svn-repos
          /     |     \
      clone1  clone2  clone3


subversion-repos is an existing repository that can not be converted to
git.


git-svn-clone is meant as an intermediate "synchronization" repository.
I never commit directly to this repos.  Its only intention is to
synchronize the clones to each other and against subversion-repos.
git-svn-clone was created by

     git svn init --stdlayout $svn_url git-svn-repos
     (cd git-svn-repos && git svn fetch)


cloneX are ordinary git clones of git-svn-repos for the day-by-day work.
They were created by

     git clone git-svn-repos cloneX


I can successfully work on the clones.  To synchronize with git-svn-clone,
I do
     git stash
     git pull
     git push origin
     git stash apply
     git stash clear
And here is my first problem: every time I push to git-svn-repos, its
working tree gets out of sync, because pushing don't update the tree.
So every time I push, "git status" shows me local modifications which
are actually outdated files.  I thought I could use a bare repository
to avoid this problem, but git-svn refuses to work on a bare repos.
So here's my first question: Any ideas how to get around this?


Once git-svn-repos is cleaned up, I want it to synchronize against
subversion-repos.  Thus I do

     git svn rebase
     git svn dcommit

This works most of the time.  Sometimes, I get error messages
like this from rebase:

  Applying Fix logging of IP-Addresses when reading access list.
  error: patch failed: upnp/websrv:528
  error: upnp/websrv: patch does not apply
  Using index info to reconstruct a base tree...
  Falling back to patching base and 3-way merge...
  No changes -- Patch already applied.

I've never seen any damage after this error message, and the last line
suggests that this is only some informative warning.


But now here's the real catch:  this time I got following error
message from "git svn rebase":

  Auto-merged server/misc.c
  CONFLICT (content): Merge conflict in server/misc.c
  Failed to merge in the changes.
  Patch failed at 0005.
  
  When you have resolved this problem run "git rebase --continue".
  If you would prefer to skip this patch, instead run "git rebase --skip".
  To restore the original branch and stop rebasing run "git rebase --abort".

Unfortunately, none of the three suggested commands help.

Investigation reveals that the conflict was caused by two independent
commits to one of the clones. That is: both commits were on the same
clone and no commits were done to the other clones in the mean time.
The commits just happen to touch neighboring lines.

Those two commits have managed to go all the way up from cloneA through
git-svn-repos to subversion-repos without any problem.  Only on the way
back from subversion-repos to git-svn-repos, they create the conflict.

Any ideas how to clean up from the situation?  And how to avoid this
problem in the future?
