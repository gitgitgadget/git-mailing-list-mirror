From: Michael Smith <msmith@cbnco.com>
Subject: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Tue, 13 Nov 2007 07:29:59 -0500
Message-ID: <11949569992214-git-send-email-msmith@cbnco.com>
Cc: gitster@pobox.com, Michael Smith <msmith@cbnco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 13:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrvCX-0007UL-FY
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 13:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbXKMMsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 07:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbXKMMsx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 07:48:53 -0500
Received: from smtp.cbnco.com ([207.164.182.72]:38237 "EHLO smtp.cbnco.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbXKMMsw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 07:48:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.cbnco.com (Postfix) with ESMTP id C948121B32B;
	Tue, 13 Nov 2007 07:30:02 -0500 (EST)
Received: from smtp.cbnco.com ([127.0.0.1])
 by localhost (mail.cbnco.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24152-10; Tue, 13 Nov 2007 07:30:02 -0500 (EST)
Received: by smtp.cbnco.com (Postfix, from userid 1003)
	id 13C2F21C6E9; Tue, 13 Nov 2007 07:30:01 -0500 (EST)
X-Spam-Score: 
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on sid.cbnco.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=7.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8
Received: from juice.ott.cti.com (auriga-dmzgw.cbnco.com [207.164.182.65])
	by smtp.cbnco.com (Postfix) with ESMTP id 2AE7B21B32B;
	Tue, 13 Nov 2007 07:30:00 -0500 (EST)
Received: by juice.ott.cti.com (Postfix, from userid 1000)
	id 10D2E4DCE0E; Tue, 13 Nov 2007 07:29:59 -0500 (EST)
X-Mailer: git-send-email 1.5.3.1.20.gb860
X-Virus-Scanned: amavisd-new at cbnco.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64798>

Add some sections about tracking third-party sources to the advanced
branching chapter. This might save some guesswork for tasks like
importing snapshots and tracking local changes.

Signed-off-by: Michael Smith <msmith@cbnco.com>
---

Years of heavy CVS abuse left me partly brain damaged, and some things that
are pretty easy in Git seemed like they should have been more complicated.
Hopefully this should make it painfully obvious how do to the equivalent
of CVS vendor branches.

 Documentation/user-manual.txt |  139 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 139 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d99adc6..942f851 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2711,6 +2711,145 @@ gitlink:git-config[1].
 See gitlink:git-config[1] for more details on the configuration
 options mentioned above.
 
+[[tracking-sources]]
+Tracking local changes to third-party sources
+---------------------------------------------
+
+[[tracking-sources-git]]
+Tracking changes when the upstream is a Git repository
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You don't have to do anything special to keep track of your changes to a
+Git project. All you need is a remote tracking branch for the upstream
+repository--either one of the remote branches created by
+gitlink:git-clone[1], or one you created according to
+<<fetching-individual-branches>>.
+
+Given a situation where you've merged the tracking branch's changes into
+your local branch, then made some more changes, as in the diagram below:
+
+................................................
+ o--o--a--c--e--f--g <-- origin/master (remote tracking branch)
+        \     \
+         b--d--m--h--i <-- master
+................................................
+
+You can view all your local changes--b, d, h, and i--with the
+gitlink:git-diff[1] command:
+
+------------------------------------------
+$ git diff origin/master...master
+------------------------------------------
+
+The three-dot `\...` tells gitlink:git-diff[1] to show the changes on the
+master branch since the last common ancestor with origin/master. (If you
+used two dots instead of three, you'd see the entire patch to go from
+origin/master to master, including reversing commits "f" and "g".)
+
+You can use the gitlink:git-cherry[1] command to display the commit
+IDs that are only present on your local branch, or only on the remote
+branch, respectively:
+
+------------------------------------------------
+$ git cherry -v origin/master master
++ 8ed8ff9315e36824e601659b168bbaad5e4d53ca b
++ 2bf7cdf2bef8e6f8b213634ce67dd01cc9e145e0 d
++ 14f97309ca82f742bc42d03fa4619a81973521a9 h
++ 4497730f04ed9849c807f2a5bf8f097f87636d3f i
+$ git cherry -v master origin/master
++ 8cc12a9763279d6f0c913ef47e0a996193aaa1c5 f
++ c793ea90311db286c0e22d227b494f09620aef3d g
+------------------------------------------------
+
+`git show <commit-id>` can display the full log message and patch for you.
+
+[[tracking-sources-snapshots]]
+Tracking changes when the upstream uses snapshots
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To track your changes to projects that aren't using Git, you can commit
+a snapshot or release onto a branch in your repository, then tag it. If
+you are used to vendor branches in CVS, you'll find this is similar,
+although CVS combines the commit, tag, and sometimes merge operations
+into one "import" command. Here's an example:
+
+------------------------------------------------
+$ mkdir project
+$ cd project
+$ git init
+$ cp -a ~/src/project-1.0/* .
+$ git add .
+$ git commit -m "Import Project v1.0"
+$ git tag v1.0
+$ git branch upstream
+------------------------------------------------
+
+Make your changes as usual on the "master" branch, or on topic branches
+that you merge to "master". For the next import, switch to the
+"upstream" branch, commit the new version, then switch back and merge in
+the changes:
+
+------------------------------------------------
+$ git checkout upstream
+$ rm -r *
+$ cp -a ~/src/project-1.1/* .
+      # "git add ." will catch the added and modified files
+$ git add .
+      # the "-a" flag will commit file deletions, too
+$ git commit -a -m "Import Project v1.1"
+$ git tag v1.1
+$ git checkout master
+$ git merge upstream
+------------------------------------------------
+
+If you are publishing your repository, you may also want to push the
+"upstream" branch and your tags.
+
+[[fixing-branch-ancestry]]
+Fixing branch ancestry
+~~~~~~~~~~~~~~~~~~~~~~
+
+Git can only do a sensible merge if it knows about a common ancestor
+between your local changes and the third-party sources. It needs to know
+the commit where your local changes and the third-party sources began to
+diverge--in other words, the last time they were merged. There are some
+cases where Git might not have a record of this merge:
+
+1. You imported CVS or Subversion vendor branch history into Git.
+Sometimes this can produce completely independent master and vendor
+branches with no merging between the two. All the changes are there,
+they just aren't linked by a merge. You can see this in `gitk --all` as
+two parallel development histories.
+2. You've been importing third-party tarballs or snapshots into Git, but
+now the upstream has switched to Git and you want to pull from their new
+repository. As far as Git knows, their branch is completely independent
+from yours, with no common ancestry.
+
+You can fix situations like these by doing a merge that isn't really a
+merge, using the "ours" merge strategy. Look through the history on the
+third-party branch and try to find the exact commit that matches the
+last snapshot you imported. Often there's a tag close to the commit, or
+on the commit, if you're lucky--but don't trust it blindly; check the
+diffs. Check out your local branch and tell Git about the relationship:
+
+------------------------------------------------
+$ git remote add upstreamgit git://upstream.org/project.git
+$ git fetch upstreamgit
+$ git tag
+v1.0
+v1.1
+v1.2
+$ git checkout master
+$ git merge --strategy=ours \
+    -m "Tie old v1.1 into our history by merging with strategy=ours." \
+    v1.1
+------------------------------------------------
+
+You'll see the branches merge together in `gitk --all` or `git
+show-branch master upstreamgit/master`.  Now you'll be able to merge any
+changes from the remote branch since v1.1 with `git merge
+upstreamgit/master`.
+
 
 [[git-concepts]]
 Git concepts
-- 
1.5.3.2.102.ge6eb7
