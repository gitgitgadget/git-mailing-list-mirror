From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] updates for Documentation/howto/using-topic-branches.txt
Date: Thu, 18 Aug 2005 09:42:56 -0700
Message-ID: <200508181642.j7IGguq3008139@agluck-lia64.sc.intel.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 18:44:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5nTt-0004bb-JP
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 18:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVHRQnC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 12:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVHRQnC
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 12:43:02 -0400
Received: from fmr22.intel.com ([143.183.121.14]:40924 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932298AbVHRQnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 12:43:00 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7IGguq6018826;
	Thu, 18 Aug 2005 16:42:56 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7IGjMMi017488;
	Thu, 18 Aug 2005 16:45:22 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7IGgucE008140;
	Thu, 18 Aug 2005 09:42:56 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7IGguq3008139;
	Thu, 18 Aug 2005 09:42:56 -0700
To: Junio C Hamano <junkio@cox.net>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Small fix (use "git branch" to make branches, rather than "git checkout -b").

Optimization for trivial patches (apply to release and merge to test).

Three sample scripts appended.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/Documentation/howto/using-topic-branches.txt b/Documentation/howto/using-topic-branches.txt
--- a/Documentation/howto/using-topic-branches.txt
+++ b/Documentation/howto/using-topic-branches.txt
@@ -70,8 +70,8 @@ them too:
 Now create the branches in which you are going to work, these start
 out at the current tip of the linus branch.
 
- $ git checkout -b test linus
- $ git checkout -b release linus
+ $ git branch test linus
+ $ git branch release linus
 
 These can be easily kept up to date by merging from the "linus" branch:
 
@@ -144,6 +144,11 @@ is empty.  At this point the branch can 
 
  $ rm .git/refs/heads/branchname
 
+Some changes are so trivial that it is not necessary to create a separate
+branch and then merge into each of the test and release branches.  For
+these changes, just apply directly to the "release" branch, and then
+merge that into the "test" branch.
+
 To create diffstat and shortlog summaries of changes to include in a "please
 pull" request to Linus you can use:
 
@@ -151,3 +156,109 @@ pull" request to Linus you can use:
 and
  $ git-whatchanged release ^linus | git-shortlog
 
+
+Here are some of the scripts that I use to simplify all this even further.
+
+==== update script ====
+# Update a branch in my GIT tree.  If the branch to be updated
+# is "linus", then pull from kernel.org.  Otherwise merge local
+# linus branch into test|release branch
+
+case "$1" in
+test|release)
+	git checkout $1 && git resolve $1 linus "Auto-update from upstream"
+	;;
+linus)
+	before=$(cat .git/HEAD)
+	git checkout linus && git pull linus
+	after=$(cat .git/HEAD)
+	if [ $before != $after ]
+	then
+		git-whatchanged $after ^$before | git-shortlog
+	fi
+	;;
+*)
+	echo "Usage: $0 linus|test|release" 1>&2
+	exit 1
+	;;
+esac
+
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
+	if [ $(git-rev-list $1 ^$2 | wc -c) -eq 0 ]
+	then
+		echo $1 already merged into $2 1>&2
+		exit 1
+	fi
+	git checkout $2 && git resolve $2 $1 "Pull $1 into $2 branch"
+	;;
+*)
+	usage
+	;;
+esac
+
+==== status script ====
+# report on status of my ia64 GIT tree
+
+gb=$(tput setab 2)
+rb=$(tput setab 1)
+restore=$(tput setab 9)
+
+if [ `git-rev-tree release ^test | wc -c` -gt 0 ]
+then
+	echo $rb Warning: commits in release that are not in test $restore
+	git-whatchanged release ^test
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
+		if [ `git-rev-tree $branch ^$ref | wc -c` -gt 0 ]
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
+	git-whatchanged $branch ^linus | git-shortlog
+done
