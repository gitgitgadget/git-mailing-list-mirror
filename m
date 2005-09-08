From: Amos Waterland <apw@rossby.metr.ou.edu>
Subject: [PATCH] Do not create bogus branch from flag to git branch
Date: Wed, 7 Sep 2005 21:13:26 -0500
Message-ID: <20050908021326.GA18776@rossby.metr.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 04:14:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDBvk-0007a6-Jc
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 04:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVIHCN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 22:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVIHCN6
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 22:13:58 -0400
Received: from rossby.metr.ou.edu ([129.15.192.80]:15118 "EHLO
	rossby.metr.ou.edu") by vger.kernel.org with ESMTP id S932562AbVIHCN5
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 22:13:57 -0400
Received: from rossby.metr.ou.edu (localhost.metr.ou.edu [127.0.0.1])
	by rossby.metr.ou.edu (8.12.9p2/8.12.9) with ESMTP id j882DRP3018902;
	Wed, 7 Sep 2005 21:13:27 -0500 (CDT)
	(envelope-from apw@rossby.metr.ou.edu)
Received: (from apw@localhost)
	by rossby.metr.ou.edu (8.12.9p2/8.12.9/Submit) id j882DQT0018901;
	Wed, 7 Sep 2005 21:13:26 -0500 (CDT)
	(envelope-from apw)
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8192>

If you run `git branch --help', you will unexpectedly have created a new
branch named "--help".  This simple patch adds logic and a usage
statement to catch this and similar problems, and adds a testcase for it.

Signed-off-by: Amos Waterland <apw@rossby.metr.ou.edu>

---

 git-branch-script |   16 ++++++++++++++++
 t/t3200-branch.sh |   27 +++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100755 t/t3200-branch.sh

09dc220283888eabd4dbb3ca647d13de6d6c876e
diff --git a/git-branch-script b/git-branch-script
--- a/git-branch-script
+++ b/git-branch-script
@@ -2,6 +2,16 @@
 
 . git-sh-setup-script || die "Not a git archive"
 
+usage () {
+    echo >&2 "usage: $(basename $0)"' [<branchname> [start-point]]
+
+If no arguments, show available branches and mark current branch with a star.
+If one argument, create a new branch <branchname> based off of current HEAD.
+If two arguments, create a new branch <branchname> based off of <start-point>.
+'
+    exit 1
+}
+
 case "$#" in
 0)
 	headref=$(readlink "$GIT_DIR/HEAD" | sed -e 's|^refs/heads/||')
@@ -25,6 +35,12 @@ case "$#" in
 	head="$2^0" ;;
 esac
 branchname="$1"
+
+case "$branchname" in
+-*)
+	usage;;
+esac
+
 rev=$(git-rev-parse --verify "$head") || exit
 
 [ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
new file mode 100755
--- /dev/null
+++ b/t/t3200-branch.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Amos Waterland
+#
+
+test_description='git branch --foo should not create bogus branch
+
+This test runs git branch --help and checks that the argument is properly
+handled.  Specifically, that a bogus branch is not created.
+'
+. ./test-lib.sh
+
+test_expect_success \
+    'prepare an trivial repository' \
+    'echo Hello > A &&
+     git update-cache --add A &&
+     git commit -m "Initial commit."'
+
+test_expect_failure \
+    'git branch --help should return error code' \
+    'git branch --help'
+
+test_expect_failure \
+    'git branch --help should not have created a bogus branch' \
+    'test -f .git/refs/heads/--help'
+
+test_done
