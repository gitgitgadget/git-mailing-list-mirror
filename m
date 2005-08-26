From: tony.luck@intel.com
Subject: [PATCH] update howto/using-topic-branches.txt
Date: Thu, 25 Aug 2005 22:11:08 -0700
Message-ID: <200508260511.j7Q5B83A021367@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 09:54:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8WV3-0006aI-BI
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 07:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVHZFLK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 01:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbVHZFLK
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 01:11:10 -0400
Received: from fmr22.intel.com ([143.183.121.14]:30948 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751511AbVHZFLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 01:11:09 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7Q5B9fY002970
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 05:11:09 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7Q5DcBw019666
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 05:13:38 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7Q5B8mU021368
	for <git@vger.kernel.org>; Thu, 25 Aug 2005 22:11:08 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7Q5B83A021367;
	Thu, 25 Aug 2005 22:11:08 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7772>

Various updates and cleanups for my howto on using branches in GIT
as a Linux subsystem maintainer.  Three categories of changes:
1) Updates for new features in GIT 0.99.5
2) Changes to use "git fetch" rather than "git pull" to update local linus branch.
3) Cleanups suggested by Len Brown

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/Documentation/howto/using-topic-branches.txt b/Documentation/howto/using-topic-branches.txt
--- a/Documentation/howto/using-topic-branches.txt
+++ b/Documentation/howto/using-topic-branches.txt
@@ -5,12 +5,10 @@ Subject: Some tutorial text (was git/cog
 Here's something that I've been putting together on how I'm using
 GIT as a Linux subsystem maintainer.
 
-I suspect that I'm a bit slap-happy with the "git checkout" commands in
-the examples below, and perhaps missing some of the _true-git_ ways of
-doing things.
-
 -Tony
 
+Last updated w.r.t. GIT 0.99.5
+
 Linux subsystem maintenance using GIT
 -------------------------------------
 
@@ -48,24 +46,38 @@ Change directory into the cloned tree yo
 
  $ cd work
 
-Make a GIT branch named "linus", and rename the "origin" branch as linus too:
+Set up a remotes file so that you can fetch the latest from Linus' master
+branch into a local branch named "linus":
+
+ $ cat > .git/remotes/linus
+ URL: rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+ Pull: master:linus
+ ^D
 
- $ git checkout -b linus
- $ mv .git/branches/origin .git/branches/linus
+and create the linus branch:
+
+ $ git branch linus
 
 The "linus" branch will be used to track the upstream kernel.  To update it,
 you simply run:
 
- $ git checkout linus && git pull linus
+ $ git fetch linus
+
+you can do this frequently (and it should be safe to do so with pending
+work in your tree, but perhaps not if you are in mid-merge).
 
-you can do this frequently (as long as you don't have any uncommited work
-in your tree).
+If you need to keep track of other public trees, you can add remote branches
+for them too:
 
-If you need to keep track of other public trees, you can add branches for
-them too:
+ $ git branch another
+ $ cat > .git/remotes/another
+ URL: ... insert URL here ...
+ Pull: name-of-branch-in-this-remote-tree:another
+ ^D
 
- $ git checkout -b another linus
- $ echo URL-for-another-public-tree > .git/branches/another
+and run:
+
+ $ git fetch another
 
 Now create the branches in which you are going to work, these start
 out at the current tip of the linus branch.
@@ -78,15 +90,25 @@ These can be easily kept up to date by m
  $ git checkout test && git resolve test linus "Auto-update from upstream"
  $ git checkout release && git resolve release linus "Auto-update from upstream"
 
-Set up so that you can push upstream to your public tree:
+Set up so that you can push upstream to your public tree (you need to
+log-in to the remote system and create an empty tree there before the
+first push).
 
- $ echo master.kernel.org:/ftp/pub/scm/linux/kernel/git/aegl/linux-2.6.git > .git/branches/origin
+ $ cat > .git/remotes/mytree
+ URL: master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6.git
+ Push: release
+ Push: test
+ ^D
 
-and then push each of the test and release branches using:
+and the push both the test and release trees using:
 
- $ git push origin test
-and
- $ git push origin release
+ $ git push mytree
+
+or push just one of the test and release branches using:
+
+ $ git push mytree test
+or
+ $ git push mytree release
 
 Now to apply some patches from the community.  Think of a short
 snappy name for a branch to hold this patch (or related group of
@@ -169,9 +191,9 @@ test|release)
 	git checkout $1 && git resolve $1 linus "Auto-update from upstream"
 	;;
 linus)
-	before=$(cat .git/HEAD)
-	git checkout linus && git pull linus
-	after=$(cat .git/HEAD)
+	before=$(cat .git/refs/heads/linus)
+	git fetch linus
+	after=$(cat .git/refs/heads/linus)
 	if [ $before != $after ]
 	then
 		git-whatchanged $after ^$before | git-shortlog
