From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 07/10] user-manual: move howto/using-topic-branches into manual
Date: Mon, 14 May 2007 11:21:26 -0400
Message-ID: <37059.5261607834$1179156137@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
 <11791560893022-git-send-email->
 <11791560891179-git-send-email->
 <1179156089470-git-send-email->
 <11791560892667-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>,
	Tony Luck <tony.luck@intel.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNK-0006P0-K6
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885AbXENPVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756794AbXENPVu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:50 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54981 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756719AbXENPVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:38 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMc-0004zC-2q; Mon, 14 May 2007 11:21:30 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <11791560892667-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47256>

From: J. Bruce Fields <bfields@citi.umich.edu>

Move howto/using-topic-branches into the user manual as an example for
the "sharing development" chapter.  While we're at it, remove some
discussion that's covered in earlier chapters, modernize somewhat (use
separate-heads setup, remotes, replace "whatchanged" by "log", etc.),
and replace syntax we'd need to explain by syntax we've already covered
(e.g. old..new instead of new ^old).

The result may not really describe what Tony Luck does any more.... Hope
that's not annoying.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/howto/using-topic-branches.txt |  296 -------------------------
 Documentation/user-manual.txt                |  297 +++++++++++++++++++++++++-
 2 files changed, 296 insertions(+), 297 deletions(-)
 delete mode 100644 Documentation/howto/using-topic-branches.txt

diff --git a/Documentation/howto/using-topic-branches.txt b/Documentation/howto/using-topic-branches.txt
deleted file mode 100644
index 2c98194..0000000
--- a/Documentation/howto/using-topic-branches.txt
+++ /dev/null
@@ -1,296 +0,0 @@
-Date: Mon, 15 Aug 2005 12:17:41 -0700
-From: tony.luck@intel.com
-Subject: Some tutorial text (was git/cogito workshop/bof at linuxconf au?)
-Abstract: In this article, Tony Luck discusses how he uses GIT
- as a Linux subsystem maintainer.
-
-Here's something that I've been putting together on how I'm using
-GIT as a Linux subsystem maintainer.
-
--Tony
-
-Last updated w.r.t. GIT 1.1
-
-Linux subsystem maintenance using GIT
--------------------------------------
-
-My requirements here are to be able to create two public trees:
-
-1) A "test" tree into which patches are initially placed so that they
-can get some exposure when integrated with other ongoing development.
-This tree is available to Andrew for pulling into -mm whenever he wants.
-
-2) A "release" tree into which tested patches are moved for final
-sanity checking, and as a vehicle to send them upstream to Linus
-(by sending him a "please pull" request.)
-
-Note that the period of time that each patch spends in the "test" tree
-is dependent on the complexity of the change.  Since GIT does not support
-cherry picking, it is not practical to simply apply all patches to the
-test tree and then pull to the release tree as that would leave trivial
-patches blocked in the test tree waiting for complex changes to accumulate
-enough test time to graduate.
-
-Back in the BitKeeper days I achieved this by creating small forests of
-temporary trees, one tree for each logical grouping of patches, and then
-pulling changes from these trees first to the test tree, and then to the
-release tree.  At first I replicated this in GIT, but then I realised
-that I could so this far more efficiently using branches inside a single
-GIT repository.
-
-So here is the step-by-step guide how this all works for me.
-
-First create your work tree by cloning Linus's public tree:
-
- $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
-
-Change directory into the cloned tree you just created
-
- $ cd work
-
-Set up a remotes file so that you can fetch the latest from Linus' master
-branch into a local branch named "linus":
-
- $ cat > .git/remotes/linus
- URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
- Pull: master:linus
- ^D
-
-and create the linus branch:
-
- $ git branch linus
-
-The "linus" branch will be used to track the upstream kernel.  To update it,
-you simply run:
-
- $ git fetch linus
-
-you can do this frequently (and it should be safe to do so with pending
-work in your tree, but perhaps not if you are in mid-merge).
-
-If you need to keep track of other public trees, you can add remote branches
-for them too:
-
- $ git branch another
- $ cat > .git/remotes/another
- URL: ... insert URL here ...
- Pull: name-of-branch-in-this-remote-tree:another
- ^D
-
-and run:
-
- $ git fetch another
-
-Now create the branches in which you are going to work, these start
-out at the current tip of the linus branch.
-
- $ git branch test linus
- $ git branch release linus
-
-These can be easily kept up to date by merging from the "linus" branch:
-
- $ git checkout test && git merge "Auto-update from upstream" test linus
- $ git checkout release && git merge "Auto-update from upstream" release linus
-
-Important note!  If you have any local changes in these branches, then
-this merge will create a commit object in the history (with no local
-changes git will simply do a "Fast forward" merge).  Many people dislike
-the "noise" that this creates in the Linux history, so you should avoid
-doing this capriciously in the "release" branch, as these noisy commits
-will become part of the permanent history when you ask Linus to pull
-from the release branch.
-
-Set up so that you can push upstream to your public tree (you need to
-log-in to the remote system and create an empty tree there before the
-first push).
-
- $ cat > .git/remotes/mytree
- URL: master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
- Push: release
- Push: test
- ^D
-
-and the push both the test and release trees using:
-
- $ git push mytree
-
-or push just one of the test and release branches using:
-
- $ git push mytree test
-or
- $ git push mytree release
-
-Now to apply some patches from the community.  Think of a short
-snappy name for a branch to hold this patch (or related group of
-patches), and create a new branch from the current tip of the
-linus branch:
-
- $ git checkout -b speed-up-spinlocks linus
-
-Now you apply the patch(es), run some tests, and commit the change(s).  If
-the patch is a multi-part series, then you should apply each as a separate
-commit to this branch.
-
- $ ... patch ... test  ... commit [ ... patch ... test ... commit ]*
-
-When you are happy with the state of this change, you can pull it into the
-"test" branch in preparation to make it public:
-
- $ git checkout test && git merge "Pull speed-up-spinlock changes" test speed-up-spinlocks
-
-It is unlikely that you would have any conflicts here ... but you might if you
-spent a while on this step and had also pulled new versions from upstream.
-
-Some time later when enough time has passed and testing done, you can pull the
-same branch into the "release" tree ready to go upstream.  This is where you
-see the value of keeping each patch (or patch series) in its own branch.  It
-means that the patches can be moved into the "release" tree in any order.
-
- $ git checkout release && git merge "Pull speed-up-spinlock changes" release speed-up-spinlocks
-
-After a while, you will have a number of branches, and despite the
-well chosen names you picked for each of them, you may forget what
-they are for, or what status they are in.  To get a reminder of what
-changes are in a specific branch, use:
-
- $ git-whatchanged branchname ^linus | git-shortlog
-
-To see whether it has already been merged into the test or release branches
-use:
-
- $ git-rev-list branchname ^test
-or
- $ git-rev-list branchname ^release
-
-[If this branch has not yet been merged you will see a set of SHA1 values
-for the commits, if it has been merged, then there will be no output]
-
-Once a patch completes the great cycle (moving from test to release, then
-pulled by Linus, and finally coming back into your local "linus" branch)
-the branch for this change is no longer needed.  You detect this when the
-output from:
-
- $ git-rev-list branchname ^linus
-
-is empty.  At this point the branch can be deleted:
-
- $ git branch -d branchname
-
-Some changes are so trivial that it is not necessary to create a separate
-branch and then merge into each of the test and release branches.  For
-these changes, just apply directly to the "release" branch, and then
-merge that into the "test" branch.
-
-To create diffstat and shortlog summaries of changes to include in a "please
-pull" request to Linus you can use:
-
- $ git-whatchanged -p release ^linus | diffstat -p1
-and
- $ git-whatchanged release ^linus | git-shortlog
-
-
-Here are some of the scripts that I use to simplify all this even further.
-
-==== update script ====
-# Update a branch in my GIT tree.  If the branch to be updated
-# is "linus", then pull from kernel.org.  Otherwise merge local
-# linus branch into test|release branch
-
-case "$1" in
-test|release)
-	git checkout $1 && git merge "Auto-update from upstream" $1 linus
-	;;
-linus)
-	before=$(cat .git/refs/heads/linus)
-	git fetch linus
-	after=$(cat .git/refs/heads/linus)
-	if [ $before != $after ]
-	then
-		git-whatchanged $after ^$before | git-shortlog
-	fi
-	;;
-*)
-	echo "Usage: $0 linus|test|release" 1>&2
-	exit 1
-	;;
-esac
-
-==== merge script ====
-# Merge a branch into either the test or release branch
-
-pname=$0
-
-usage()
-{
-	echo "Usage: $pname branch test|release" 1>&2
-	exit 1
-}
-
-if [ ! -f .git/refs/heads/"$1" ]
-then
-	echo "Can't see branch <$1>" 1>&2
-	usage
-fi
-
-case "$2" in
-test|release)
-	if [ $(git-rev-list $1 ^$2 | wc -c) -eq 0 ]
-	then
-		echo $1 already merged into $2 1>&2
-		exit 1
-	fi
-	git checkout $2 && git merge "Pull $1 into $2 branch" $2 $1
-	;;
-*)
-	usage
-	;;
-esac
-
-==== status script ====
-# report on status of my ia64 GIT tree
-
-gb=$(tput setab 2)
-rb=$(tput setab 1)
-restore=$(tput setab 9)
-
-if [ `git-rev-list release ^test | wc -c` -gt 0 ]
-then
-	echo $rb Warning: commits in release that are not in test $restore
-	git-whatchanged release ^test
-fi
-
-for branch in `ls .git/refs/heads`
-do
-	if [ $branch = linus -o $branch = test -o $branch = release ]
-	then
-		continue
-	fi
-
-	echo -n $gb ======= $branch ====== $restore " "
-	status=
-	for ref in test release linus
-	do
-		if [ `git-rev-list $branch ^$ref | wc -c` -gt 0 ]
-		then
-			status=$status${ref:0:1}
-		fi
-	done
-	case $status in
-	trl)
-		echo $rb Need to pull into test $restore
-		;;
-	rl)
-		echo "In test"
-		;;
-	l)
-		echo "Waiting for linus"
-		;;
-	"")
-		echo $rb All done $restore
-		;;
-	*)
-		echo $rb "<$status>" $restore
-		;;
-	esac
-	git-whatchanged $branch ^linus | git-shortlog
-done
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5404d6f..3f51522 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1790,7 +1790,302 @@ gitweb/INSTALL in the git source tree for instructions on setting it up.
 Examples
 --------
 
-TODO: topic branches, typical roles as in everyday.txt, ?
+[[maintaining-topic-branches]]
+Maintaining topic branches for a Linux subsystem maintainer
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+This describes how Tony Luck uses git in his role as maintainer of the
+IA64 architecture for the Linux kernel.
+
+He uses two public branches:
+
+ - A "test" tree into which patches are initially placed so that they
+   can get some exposure when integrated with other ongoing development.
+   This tree is available to Andrew for pulling into -mm whenever he
+   wants.
+
+ - A "release" tree into which tested patches are moved for final sanity
+   checking, and as a vehicle to send them upstream to Linus (by sending
+   him a "please pull" request.)
+
+He also uses a set of temporary branches ("topic branches"), each
+containing a logical grouping of patches.
+
+To set this up, first create your work tree by cloning Linus's public
+tree:
+
+-------------------------------------------------
+$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git work
+$ cd work
+-------------------------------------------------
+
+Linus's tree will be stored in the remote branch named origin/master,
+and can be updated using gitlink:git-fetch[1]; you can track other
+public trees using gitlink:git-remote[1] to set up a "remote" and
+git-fetch[1] to keep them up-to-date; see <<repositories-and-branches>>.
+
+Now create the branches in which you are going to work; these start out
+at the current tip of the linus branch, and should be set up (using the
+--track option to gitlink:git-branch[1]) to merge changes in from linus
+by default.
+
+-------------------------------------------------
+$ git branch --track test origin/master
+$ git branch --track release origin/master
+-------------------------------------------------
+
+These can be easily kept up to date using gitlink:git-pull[1]
+
+-------------------------------------------------
+$ git checkout test && git pull
+$ git checkout release && git pull
+-------------------------------------------------
+
+Important note!  If you have any local changes in these branches, then
+this merge will create a commit object in the history (with no local
+changes git will simply do a "Fast forward" merge).  Many people dislike
+the "noise" that this creates in the Linux history, so you should avoid
+doing this capriciously in the "release" branch, as these noisy commits
+will become part of the permanent history when you ask Linus to pull
+from the release branch.
+
+A few configuration variables (see gitlink:git-config[1]) can
+make it easy to push both branches to your public tree.  (See
+<<setting-up-a-public-repository>>.)
+
+-------------------------------------------------
+$ cat >> .git/config <<EOF
+[remote "mytree"]
+	url =  master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
+	push = release
+	push = test
+EOF
+-------------------------------------------------
+
+Then you can push both the test and release trees using
+gitlink:git-push[1]:
+
+-------------------------------------------------
+$ git push mytree
+-------------------------------------------------
+
+or push just one of the test and release branches using:
+
+-------------------------------------------------
+$ git push mytree test
+-------------------------------------------------
+
+or
+
+-------------------------------------------------
+$ git push mytree release
+-------------------------------------------------
+
+Now to apply some patches from the community.  Think of a short
+snappy name for a branch to hold this patch (or related group of
+patches), and create a new branch from the current tip of the
+linus branch:
+
+-------------------------------------------------
+$ git checkout -b speed-up-spinlocks origin
+-------------------------------------------------
+
+Now you apply the patch(es), run some tests, and commit the change(s).  If
+the patch is a multi-part series, then you should apply each as a separate
+commit to this branch.
+
+-------------------------------------------------
+$ ... patch ... test  ... commit [ ... patch ... test ... commit ]*
+-------------------------------------------------
+
+When you are happy with the state of this change, you can pull it into the
+"test" branch in preparation to make it public:
+
+-------------------------------------------------
+$ git checkout test && git pull . speed-up-spinlocks
+-------------------------------------------------
+
+It is unlikely that you would have any conflicts here ... but you might if you
+spent a while on this step and had also pulled new versions from upstream.
+
+Some time later when enough time has passed and testing done, you can pull the
+same branch into the "release" tree ready to go upstream.  This is where you
+see the value of keeping each patch (or patch series) in its own branch.  It
+means that the patches can be moved into the "release" tree in any order.
+
+-------------------------------------------------
+$ git checkout release && git pull . speed-up-spinlocks
+-------------------------------------------------
+
+After a while, you will have a number of branches, and despite the
+well chosen names you picked for each of them, you may forget what
+they are for, or what status they are in.  To get a reminder of what
+changes are in a specific branch, use:
+
+-------------------------------------------------
+$ git log linux..branchname | git-shortlog
+-------------------------------------------------
+
+To see whether it has already been merged into the test or release branches
+use:
+
+-------------------------------------------------
+$ git log test..branchname
+-------------------------------------------------
+
+or
+
+-------------------------------------------------
+$ git log release..branchname
+-------------------------------------------------
+
+(If this branch has not yet been merged you will see some log entries.
+If it has been merged, then there will be no output.)
+
+Once a patch completes the great cycle (moving from test to release, then
+pulled by Linus, and finally coming back into your local "linus" branch)
+the branch for this change is no longer needed.  You detect this when the
+output from:
+
+-------------------------------------------------
+$ git log linus..branchname
+-------------------------------------------------
+
+is empty.  At this point the branch can be deleted:
+
+-------------------------------------------------
+$ git branch -d branchname
+-------------------------------------------------
+
+Some changes are so trivial that it is not necessary to create a separate
+branch and then merge into each of the test and release branches.  For
+these changes, just apply directly to the "release" branch, and then
+merge that into the "test" branch.
+
+To create diffstat and shortlog summaries of changes to include in a "please
+pull" request to Linus you can use:
+
+-------------------------------------------------
+$ git diff --stat origin..release
+-------------------------------------------------
+
+and
+
+-------------------------------------------------
+$ git log -p origin..release | git shortlog
+-------------------------------------------------
+
+Here are some of the scripts that simplify all this even further.
+
+-------------------------------------------------
+==== update script ====
+# Update a branch in my GIT tree.  If the branch to be updated
+# is "linus", then pull from kernel.org.  Otherwise merge local
+# linus branch into test|release branch
+
+case "$1" in
+test|release)
+	git checkout $1 && git pull . origin
+	;;
+linus)
+	before=$(cat .git/refs/heads/origin/master)
+	git fetch linus
+	after=$(cat .git/refs/heads/origin/master)
+	if [ $before != $after ]
+	then
+		git log $before..$after | git shortlog
+	fi
+	;;
+*)
+	echo "Usage: $0 linus|test|release" 1>&2
+	exit 1
+	;;
+esac
+-------------------------------------------------
+
+-------------------------------------------------
+==== merge script ====
+# Merge a branch into either the test or release branch
+
+pname=$0
+
+usage()
+{
+	echo "Usage: $pname branch test|release" 1>&2
+	exit 1
+}
+
+if [ ! -f .git/refs/heads/"$1" ]
+then
+	echo "Can't see branch <$1>" 1>&2
+	usage
+fi
+
+case "$2" in
+test|release)
+	if [ $(git log $2..$1 | wc -c) -eq 0 ]
+	then
+		echo $1 already merged into $2 1>&2
+		exit 1
+	fi
+	git checkout $2 && git pull . $1
+	;;
+*)
+	usage
+	;;
+esac
+-------------------------------------------------
+
+-------------------------------------------------
+==== status script ====
+# report on status of my ia64 GIT tree
+
+gb=$(tput setab 2)
+rb=$(tput setab 1)
+restore=$(tput setab 9)
+
+if [ `git rev-list test..release | wc -c` -gt 0 ]
+then
+	echo $rb Warning: commits in release that are not in test $restore
+	git log test..release
+fi
+
+for branch in `ls .git/refs/heads`
+do
+	if [ $branch = linus -o $branch = test -o $branch = release ]
+	then
+		continue
+	fi
+
+	echo -n $gb ======= $branch ====== $restore " "
+	status=
+	for ref in test release linus
+	do
+		if [ `git rev-list $ref..$branch | wc -c` -gt 0 ]
+		then
+			status=$status${ref:0:1}
+		fi
+	done
+	case $status in
+	trl)
+		echo $rb Need to pull into test $restore
+		;;
+	rl)
+		echo "In test"
+		;;
+	l)
+		echo "Waiting for linus"
+		;;
+	"")
+		echo $rb All done $restore
+		;;
+	*)
+		echo $rb "<$status>" $restore
+		;;
+	esac
+	git log origin/master..$branch | git shortlog
+done
+-------------------------------------------------
 
 
 [[cleaning-up-history]]
-- 
1.5.1.4.19.g69e2
