From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach git-stash to "apply --index"
Date: Mon, 2 Jul 2007 12:14:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021213350.4438@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 02 13:15:00 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5Jrv-0002dt-DB
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 13:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752491AbXGBLO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 07:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbXGBLO5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 07:14:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:39176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751368AbXGBLO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 07:14:56 -0400
Received: (qmail invoked by alias); 02 Jul 2007 11:14:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 02 Jul 2007 13:14:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mlT01GsPmBfBA++abR5tudAUoeQGW01fEl3kGmu
	GGGIuT0NahrE07
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51352>


When given this subcommand, git-stash will try to merge the stashed
index into the current one. Only trivial merges are possible, since
we have no index for the index ;-) If a trivial merge is not possible,
git-stash will bail out with a hint to skip the --index option.

For good measure, finally include a test case.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I am not quite sure if this should not be the default, with
	--skip-index to turn it off if the trivial index merge fails,
	and the user might be interested only in the working directory
	changes anyway.

	Comments?

 git-stash.sh     |   21 ++++++++++++++++
 t/t3903-stash.sh |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 04ce30a..45ad2f4 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -98,6 +98,13 @@ apply_stash () {
 	git-diff-files --quiet ||
 		die 'Cannot restore on top of a dirty state'
 
+	unstash_index=
+	case "$1" in
+	--index)
+		unstash_index=t
+		shift
+	esac
+
 	# current index state
 	c_tree=$(git-write-tree) ||
 		die 'Cannot apply a stash in the middle of a merge'
@@ -107,6 +114,15 @@ apply_stash () {
 	b_tree=$(git-rev-parse --verify "$s^:") ||
 		die "$*: no valid stashed state found"
 
+	test -z "$unstash_index" || {
+		git diff --binary $s^2^..$s^2 | git apply --cached
+		test $? -ne 0 &&
+			die 'Conflicts in index. Try without --index.'
+		unstashed_index_tree=$(git-write-tree) ||
+			die 'Could not save index tree'
+		git reset
+	}
+
 	eval "
 		GITHEAD_$w_tree='Stashed changes' &&
 		GITHEAD_$c_tree='Updated upstream' &&
@@ -124,9 +140,12 @@ apply_stash () {
 			die "Cannot unstage modified files"
 		git-status
 		rm -f "$a"
+		test -z "$unstash_index" || git read-tree $unstashed_index_tree
 	else
 		# Merge conflict; keep the exit status from merge-recursive
-		exit
+		status=$?
+		test -z "$unstash_index" || echo 'Index was not unstashed.' >&2
+		exit $status
 	fi
 }
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
new file mode 100755
index 0000000..392ac1c
--- /dev/null
+++ b/t/t3903-stash.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E Schindelin
+#
+
+test_description='Test git-stash'
+
+. ./test-lib.sh
+
+test_expect_success 'stash some dirty working directory' '
+	echo 1 > file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 2 > file &&
+	git add file &&
+	echo 3 > file &&
+	test_tick &&
+	git stash &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD
+'
+
+cat > expect << EOF
+diff --git a/file b/file
+index 0cfbf08..00750ed 100644
+--- a/file
++++ b/file
+@@ -1 +1 @@
+-2
++3
+EOF
+
+test_expect_success 'parents of stash' '
+	test $(git rev-parse stash^) = $(git rev-parse HEAD) &&
+	git diff stash^2..stash > output &&
+	diff -u output expect
+'
+
+test_expect_success 'apply needs clean working directory' '
+	echo 4 > other-file &&
+	git add other-file &&
+	echo 5 > other-file
+	! git stash apply
+'
+
+test_expect_success 'apply stashed changes' '
+	git add other-file &&
+	test_tick &&
+	git commit -m other-file &&
+	git stash apply &&
+	test 3 = $(cat file) &&
+	test 1 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_expect_success 'apply stashed changes (including index)' '
+	git reset --hard HEAD^ &&
+	echo 6 > other-file &&
+	git add other-file &&
+	test_tick &&
+	git commit -m other-file &&
+	git stash apply --index &&
+	test 3 = $(cat file) &&
+	test 2 = $(git show :file) &&
+	test 1 = $(git show HEAD:file)
+'
+
+test_done
