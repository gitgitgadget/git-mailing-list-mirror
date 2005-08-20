From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Infamous 'octopus merge'
Date: Sat, 20 Aug 2005 11:25:28 -0700
Message-ID: <7vbr3smpnr.fsf@assigned-by-dhcp.cox.net>
References: <7vvf20o4sp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 20 20:26:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Y2B-0003tv-96
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 20:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbVHTSZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 14:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbVHTSZa
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 14:25:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60307 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932670AbVHTSZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 14:25:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820182527.RFPE3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 14:25:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This script uses the list of heads and their origin multi-head "git
fetch" left in the $GIT_DIR/FETCH_HEAD file, and makes an octopus
merge on top of the current HEAD using them.

The implementation tries to be strict for the sake of safety.  It
insists that your working tree is clean (no local changes) and matches
the HEAD, and when any of the merged heads does not automerge, the
whole process is aborted and tries to rewind your working tree is to
the original state.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile           |    1 +
 git-octopus-script |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100755 git-octopus-script

325918bdc88517826fb7f14fba87a34b92ea2b52
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -72,6 +72,7 @@ SCRIPTS += git-count-objects-script
 # SCRIPTS += git-send-email-script
 SCRIPTS += git-revert-script
 SCRIPTS += git-show-branches-script
+SCRIPTS += git-octopus-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-octopus-script b/git-octopus-script
new file mode 100755
--- /dev/null
+++ b/git-octopus-script
@@ -0,0 +1,103 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# Resolve two or more trees recorded in $GIT_DIR/FETCH_HEAD.
+#
+. git-sh-setup-script || die "Not a git archive"
+
+usage () {
+    die "usage: git octopus"
+}
+
+# Sanity check the heads early.
+while read SHA1 REPO
+do
+	test $(git-cat-file -t $SHA1) = "commit" ||
+		die "$REPO given to octopus is not a commit"
+done <"$GIT_DIR/FETCH_HEAD"
+
+head=$(git-rev-parse --verify HEAD) || exit
+
+git-update-cache --refresh ||
+	die "Your working tree is dirty."
+test "$(git-diff-cache --cached "$head")" = "" ||
+	die "Your working tree does not match HEAD."
+
+# MRC is the current "merge reference commit"
+# MRT is the current "merge result tree"
+
+MRC=$head MSG= PARENT="-p $head"
+MRT=$(git-write-tree)
+CNT=1 ;# counting our head
+NON_FF_MERGE=0
+while read SHA1 REPO
+do
+	common=$(git-merge-base $MRC $SHA1) ||
+		die "Unable to find common commit with $SHA1 from $REPO"
+
+	if test "$common" = $SHA1
+	then
+		echo "Already up-to-date: $REPO"
+		continue
+	fi
+
+	CNT=`expr $CNT + 1`
+	PARENT="$PARENT -p $SHA1"
+	MSG="$MSG
+	$REPO"
+
+	if test "$common,$NON_FF_MERGE" = "$MRC,0"
+	then
+		# The first head being merged was a fast-forward.
+		# Advance MRC to the head being merged, and use that
+		# tree as the intermediate result of the merge.
+		# We still need to count this as part of the parent set.
+
+		echo "Fast forwarding to: $REPO"
+		git-read-tree -u -m $head $SHA1 || exit
+		MRC=$SHA1 MRT=$(git-write-tree)
+		continue
+	fi
+
+	NON_FF_MERGE=1
+
+	echo "Trying simple merge with $REPO"
+	git-read-tree -u -m $common $MRT $SHA1 || exit
+	next=$(git-write-tree 2>/dev/null)
+	if test $? -ne 0
+	then
+		echo "Simple merge did not work, trying automatic merge."
+		git-merge-cache -o git-merge-one-file-script -a || {
+		git-read-tree --reset "$head"
+		git-checkout-tree -f -q -u -a
+		die "Automatic merge failed; should not be doing Octopus"
+		}
+		next=$(git-write-tree 2>/dev/null)
+	fi
+	MRC=$common
+	MRT=$next
+done <"$GIT_DIR/FETCH_HEAD"
+
+# Just to be careful in case the user feeds nonsense to us.
+case "$CNT" in
+1)
+	echo "No changes."
+	exit 0 ;;
+2)
+	echo "Not an Octopus; making an ordinary commit."
+	MSG="Merge "`expr "$MSG" : '.	\(.*\)'` ; # remove LF and TAB
+	;;
+*)
+	# In an octopus, the original head is just one of the equals,
+	# so we should list it as such.
+	HEAD_LINK=`readlink "$GIT_DIR/HEAD"`
+	MSG="Octopus merge of the following:
+
+	$HEAD_LINK from .$MSG"
+	;;
+esac
+result_commit=$(echo "$MSG" | git-commit-tree $MRT $PARENT)
+echo "Committed merge $result_commit"
+echo $result_commit >"$GIT_DIR"/HEAD
+git-diff-tree -p $head $result_commit | git-apply --stat
