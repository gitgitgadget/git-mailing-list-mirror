From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-show-branches-script
Date: Mon, 15 Aug 2005 02:56:06 -0700
Message-ID: <7v4q9r1q2x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 15 11:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4bhS-0000lC-NQ
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVHOJ4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVHOJ4I
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:56:08 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:16795 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932449AbVHOJ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 05:56:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815095606.YDJQ17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 05:56:06 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Often I find myself wanting to do quick branches check when I am
not in the windowing environment and cannot run gitk.

This stupid script shows commits leading to the heads of
interesting branches with indication which ones belong to which
branches, so that fork point is somewhat discernible without
using gitk.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-show-branches-script.txt |   69 ++++++++++++++++++++++++++++
 Documentation/git.txt                      |    2 +
 Makefile                                   |    1 
 git-show-branches-script                   |   53 ++++++++++++++++++++++
 4 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-show-branches-script.txt
 create mode 100755 git-show-branches-script

8d67319c6e28035abdb848b9b2f31a8c5711bd49
diff --git a/Documentation/git-show-branches-script.txt b/Documentation/git-show-branches-script.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-show-branches-script.txt
@@ -0,0 +1,69 @@
+git-show-branches-script(1)
+===========================
+v0.99.4, Aug 2005
+
+NAME
+----
+git-show-branches-script - Show branches and their commits.
+
+SYNOPSIS
+--------
+'git show-branches <reference>...'
+
+DESCRIPTION
+-----------
+Shows the head commits from the named <reference> (or all refs under
+$GIT_DIR/refs/heads), and displays concise list of commit logs
+to show their relationship semi-visually.
+
+OPTIONS
+-------
+<reference>::
+	Name of the reference under $GIT_DIR/refs/heads/.
+
+
+OUTPUT
+------
+Given N <references>, the first N lines are the one-line
+description from their commit message.  The branch head that is
+pointed at by $GIT_DIR/HEAD is prefixed with an asterisk '*'
+character while other heads are prefixed with a '!' character.
+
+Following these N lines, one-line log for each commit is
+displayed, indented N places.  If a commit is on the I-th
+branch, the I-th indentation character shows a '+' sign;
+otherwise it shows a space.
+
+The following example shows three branches, "pu", "master" and
+"rc":
+
+	* [pu] Add cheap local clone '-s' flag to git-clone-script
+	 ! [master] Documentation updates.
+	  ! [rc] Merge master into rc
+	+   Add cheap local clone '-s' flag to git-clone-script
+	+   Alternate object pool mechanism updates.
+	+   Audit rev-parse users.
+	++  Documentation updates.
+	  + Merge master into rc
+	+++ [PATCH] plug memory leak in diff.c::diff_free_filepair()
+
+These three branches all forked from a common commit, "[PATCH]
+plug memory leak...", and "rc" has one commit ahead of it.  The
+"master" branch has one different commit that is also shared by
+"pu" branch, and "pu" branch has three more commits on top of
+"master" branch.
+
+
+Author
+------
+Written by Junio C Hamano <junkio@cox.net>
+
+
+Documentation
+--------------
+Documentation by Junio C Hamano.
+
+
+GIT
+---
+Part of the link:git.html[git] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -188,6 +188,8 @@ link:git-pull-script.html[git-pull-scrip
 link:git-commit-script.html[git-commit-script]::
 	Record changes to the repository.
 
+link:git-show-branches-script.html[git-show-branches-script]::
+	Show branches and their commits.
 
 Ancilliary Commands
 -------------------
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -71,6 +71,7 @@ SCRIPTS=git git-apply-patch-script git-m
 SCRIPTS += git-count-objects-script
 # SCRIPTS += git-send-email-script
 SCRIPTS += git-revert-script
+SCRIPTS += git-show-branches-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-show-branches-script b/git-show-branches-script
new file mode 100755
--- /dev/null
+++ b/git-show-branches-script
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Show refs and their recent commits.
+#
+
+. git-sh-setup-script || die "Not a git repository"
+
+headref=`readlink $GIT_DIR/HEAD`
+case "$#" in
+0)
+	set x `cd $GIT_DIR/refs &&
+	    find heads -type f -print |
+	    sed -e 's|heads/||' |
+	    sort`
+	shift ;;
+esac
+
+hh= in=
+for ref
+do
+	case "/$headref" in
+	*/"$ref") H='*' ;;
+	*) H='!' ;;
+	esac
+	h=`git-rev-parse --verify "$ref^0"` || exit
+	l=`git-log-script --max-count=1 --pretty=oneline "$h" |
+		sed -e 's/^[^ ]* //'`
+	hh="$hh $h"
+	echo "$in$H [$ref] $l"
+	in="$in "
+done
+set x $hh
+shift
+
+git-rev-list --pretty=oneline "$@" |
+while read v l
+do
+	in=''
+	for h
+	do
+		b=`git-merge-base $h $v`
+		case "$b" in
+		$v) in="$in+" ;;
+		*)  in="$in " ;;
+		esac
+	done
+
+	echo "$in $l"
+	case "$in" in
+	*' '*) ;;
+	*) break ;;
+	esac
+done
