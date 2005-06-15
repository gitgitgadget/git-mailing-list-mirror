From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Reorganization of git-commit-script [rev 3]
Date: Wed, 15 Jun 2005 17:35:58 +1000
Message-ID: <20050615073558.25126.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 09:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiSMr-0006Vc-Bt
	for gcvg-git@gmane.org; Wed, 15 Jun 2005 09:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFOHgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 03:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVFOHgR
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 03:36:17 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:13184 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261255AbVFOHgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 03:36:01 -0400
Received: (qmail 25137 invoked by uid 500); 15 Jun 2005 07:35:58 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This change re-organizes git-commit-script to break out
the different phases of execution into separate bash
functions.

The main body is now:

if ! print_status > .editmsg; then
	# error handling
fi

if edit_message .editmsg .cmitmsg; then
	exec_commit .cmitmsg
	# cleanup
fi

The subsequent patch in this series adds support for
an optional .nextmsg file to enable the pre-population
of commit message text by external tools.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

[rev 3] - oops, sorry, forgot to test merge case
---

 git-commit-script |  100 ++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/git-commit-script b/git-commit-script
old mode 100644
new mode 100755
--- a/git-commit-script
+++ b/git-commit-script
@@ -1,44 +1,74 @@
 #!/bin/sh
+
+print_status() {
+	if [ ! -r $GIT_DIR/HEAD ]; then
+		if [ -z "$(git-ls-files)" ]; then
+			echo Nothing to commit 1>&2
+			return 1
+		fi
+cat <<EOF
+#
+# Initial commit
+# 
+$(git-ls-files | sed s/^/# New file: )
+#
+EOF
+	elif [ -f $GIT_DIR/MERGE_HEAD ]; then
+cat <<EOF
+#
+# It looks like your may be committing a MERGE.
+# If this is not correct, please remove the file
+# $GIT_DIR/MERGE_HEAD
+# and try again
+#
+EOF
+	fi
+	git-status-script
+}
+
+edit_message() {
+	status=$1
+	msg=$2
+
+	:> $msg
+	${VISUAL:-${EDITOR:-vi}} "$status"
+	grep -v '^#' < $status | git-stripspace >$msg
+	[ -s $msg ]
+	return $?
+}
+
+commit_parents() {
+	[ -f $GIT_DIR/HEAD ] &&
+	echo -n "-p HEAD" &&
+	[ -f $GIT_DIR/MERGE_HEAD ] &&
+	echo -n " -p MERGE_HEAD"
+	echo ""
+}
+
+exec_commit() {
+	msg=$1
+	tree=$(git-write-tree) || exit 1
+	parents=$(commit_parents) || exit 1
+	commit=$(cat $msg | git-commit-tree $tree $parents) || exit 1
+	echo $commit > $GIT_DIR/HEAD
+	rm -f -- $GIT_DIR/MERGE_HEAD
+}
+
+SENTINEL="#SENTINEL - delete this line to confirm the commit"
 : ${GIT_DIR=.git}
 if [ ! -d $GIT_DIR ]; then
 	echo Not a git directory 1>&2
 	exit 1
 fi
-PARENTS="-p HEAD"
-if [ ! -r $GIT_DIR/HEAD ]; then
-	if [ -z "$(git-ls-files)" ]; then
-		echo Nothing to commit 1>&2
-		exit 1
-	fi
-	(
-		echo "#"
-		echo "# Initial commit"
-		echo "#"
-		git-ls-files | sed 's/^/# New file: /'
-		echo "#"
-	) > .editmsg
-	PARENTS=""
-else
-	if [ -f $GIT_DIR/MERGE_HEAD ]; then
-		echo "#"
-		echo "# It looks like your may be committing a MERGE."
-		echo "# If this is not correct, please remove the file"
-		echo "#	$GIT_DIR/MERGE_HEAD"
-		echo "# and try again"
-		echo "#"
-		PARENTS="-p HEAD -p MERGE_HEAD"
-	fi > .editmsg
-	git-status-script >> .editmsg
-fi
-if [ "$?" != "0" ]
-then
+
+if ! print_status > .editmsg; then
 	cat .editmsg
+	rm .editmsg
 	exit 1
 fi
-${VISUAL:-${EDITOR:-vi}} .editmsg
-grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
-[ -s .cmitmsg ] || exit 1
-tree=$(git-write-tree) || exit 1
-commit=$(cat .cmitmsg | git-commit-tree $tree $PARENTS) || exit 1
-echo $commit > $GIT_DIR/HEAD
-rm -f -- $GIT_DIR/MERGE_HEAD
+
+if edit_message .editmsg .cmitmsg; then
+	exec_commit .cmitmsg
+	[ -f .editmsg ] && rm .editmsg
+	[ -f .cmitmsg ] && rm .cmitmsg
+fi
------------
