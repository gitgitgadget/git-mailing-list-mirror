From: bfields@fieldses.org
Subject: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 18:47:35 -0500
Message-ID: <11676088582634-git-send-email-bfields@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org> <1167608858759-git-send-email-bfields@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 01 00:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1APA-0007zX-Vw
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 00:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbWLaXrn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 18:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbWLaXrn
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 18:47:43 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38254 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbWLaXrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 18:47:39 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1AOw-0002Ey-DA; Sun, 31 Dec 2006 18:47:38 -0500
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.gac28
In-Reply-To: <1167608858759-git-send-email-bfields@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35714>

From: J. Bruce Fields <bfields@citi.umich.edu>

Update examples.  I'm not sure if the last two examples are really useful
any more.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/git-pull.txt |   75 +++++++++++++++++++++++++------------------
 1 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 2a5aea7..5b9ff96 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -37,8 +37,15 @@ EXAMPLES
 --------
 
 git pull, git pull origin::
-	Fetch the default head from the repository you cloned
-	from and merge it into your current branch.
+	Update the remote tracking brances for the repository
+	you cloned from, then merge one of them into your
+	current branch.  Normally the branch merged in is
+	the HEAD of the remote repository, when your master
+	branch is checked out.  When on another branch,
+	the (alphabetically) first branch from the remote
+	repository is merged in.  These defaults can be modified
+	using the branch and remote sections of the repository
+	configuration; see gitlink:git-repo-config[1] for details.
 
 git pull -s ours . obsolete::
 	Merge local branch `obsolete` into the current branch,
@@ -58,51 +65,57 @@ You should refrain from abusing this option to sneak substantial
 changes into a merge commit.  Small fixups like bumping
 release/version name would be acceptable.
 
-Command line pull of multiple branches from one repository::
+Pull of multiple branches from one repository using default configuration::
 +
 ------------------------------------------------
-$ cat .git/remotes/origin
-URL: git://git.kernel.org/pub/scm/git/git.git
-Pull: master:origin
-
+$ git repo-config -l
+...
+remote.origin.url=git://git.kernel.org/pub/scm/git/git.git
+remote.origin.fetch=+refs/heads/*:refs/remotes/foo/*
+branch.master.remote=origin
+branch.master.merge=refs/heads/master
 $ git checkout master
-$ git fetch origin master:origin +pu:pu maint:maint
-$ git pull . origin
+$ git fetch origin
+$ git pull . origin/master
 ------------------------------------------------
 +
-Here, a typical `.git/remotes/origin` file from a
+Here, a typical configuration created by the
 `git-clone` operation is used in combination with
-command line options to `git-fetch` to first update
-multiple branches of the local repository and then
-to merge the remote `origin` branch into the local
-`master` branch.  The local `pu` branch is updated
-even if it does not result in a fast forward update.
+`git-fetch` to update all of the remote tracking
+branches for `origin` (the remote repository which
+you originally cloned from).  Thanks to the "+" on
+the `remote.origin.fetch` line, the tracking branches
+will all be updated even if they do not result in a
+fast forward update.
++
+The `git pull` command then merges the newly
+fetched origin/master into the local `master` branch.
 Here, the pull can obtain its objects from the local
 repository using `.`, as the previous `git-fetch` is
 known to have already obtained and made available
 all the necessary objects.
++
+Note that given the configuration above, a simple
+`git pull` would have the same result as the above
+sequence of fetch and pull.
 
 
-Pull of multiple branches from one repository using `.git/remotes` file::
+Commandline pull of multiple branches from one repository::
 +
 ------------------------------------------------
-$ cat .git/remotes/origin
-URL: git://git.kernel.org/pub/scm/git/git.git
-Pull: master:origin
-Pull: +pu:pu
-Pull: maint:maint
-
 $ git checkout master
-$ git pull origin
+$ git fetch origin master:origin +pu:pu maint:maint
+$ git pull . origin
 ------------------------------------------------
 +
-Here, a typical `.git/remotes/origin` file from a
-`git-clone` operation has been hand-modified to include
-the branch-mapping of additional remote and local
-heads directly.  A single `git-pull` operation while
-in the `master` branch will fetch multiple heads and
-merge the remote `origin` head into the current,
-local `master` branch.
+Assuming the same configuration as above, this overrides
+the default fetch behavior, updating (or creating, as
+necessary) branches "origin", "pu", and "maint" in the
+local repository by fetching from the branches (respectively)
+"master", "pu", and "maint" from the remote repository.
++
+The "pu" branch will be updated even if it is does not
+fast-foward; the others will not be.
 
 
 If you tried a pull which resulted in a complex conflicts and
@@ -112,7 +125,7 @@ gitlink:git-reset[1].
 
 SEE ALSO
 --------
-gitlink:git-fetch[1], gitlink:git-merge[1]
+gitlink:git-fetch[1], gitlink:git-merge[1], gitlink:git-repo-config[1]
 
 
 Author
-- 
1.5.0.rc0.gac28
