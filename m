From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-filter-branch.sh: Allow running in bare repositories
Date: Wed, 23 Jul 2008 23:55:42 +0200
Message-ID: <20080723215509.32438.49155.stgit@localhost>
References: <7v8wvtjwa8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 23 23:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmKN-0001BP-RP
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbYGWVzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbYGWVzz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:55:55 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:52397 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750799AbYGWVzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:55:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 0A3132ACCA2;
	Wed, 23 Jul 2008 23:55:42 +0200 (CEST)
In-Reply-To: <7v8wvtjwa8.fsf@gitster.siamese.dyndns.org>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89786>

Commit 46eb449c restricted git-filter-branch to non-bare repositories
unnecessarily; git-filter-branch can work on bare repositories just
fine.

Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  I have my own opinion about the readability-fork ratio in this particular
case, but there's no use arguing about this. ;-)

 git-filter-branch.sh     |   36 ++++++++++++++++++++----------------
 t/t7003-filter-branch.sh |    8 ++++++++
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index d04c346..ddf7187 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -97,9 +97,11 @@ USAGE="[--env-filter <command>] [--tree-filter <command>] \
 OPTIONS_SPEC=
 . git-sh-setup
 
-git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD -- ||
-	die "Cannot rewrite branch(es) with a dirty working directory."
+if [ "$(is_bare_repository)" = false ]; then
+	git diff-files --quiet &&
+		git diff-index --cached --quiet HEAD --) ||
+		die "Cannot rewrite branch(es) with a dirty working directory.
+fi
 
 tempdir=.git-rewrite
 filter_env=
@@ -434,18 +436,20 @@ rm -rf "$tempdir"
 
 trap - 0
 
-unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
-test -z "$ORIG_GIT_DIR" || {
-	GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
-}
-test -z "$ORIG_GIT_WORK_TREE" || {
-	GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
-	export GIT_WORK_TREE
-}
-test -z "$ORIG_GIT_INDEX_FILE" || {
-	GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
-	export GIT_INDEX_FILE
-}
-git read-tree -u -m HEAD
+if [ "$(is_bare_repository)" = false ]; then
+	unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
+	test -z "$ORIG_GIT_DIR" || {
+		GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
+	}
+	test -z "$ORIG_GIT_WORK_TREE" || {
+		GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
+		export GIT_WORK_TREE
+	}
+	test -z "$ORIG_GIT_INDEX_FILE" || {
+		GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
+		export GIT_INDEX_FILE
+	}
+	git read-tree -u -m HEAD
+fi
 
 exit $ret
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e26f726..a0ab096 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -38,6 +38,14 @@ test_expect_success 'result is really identical' '
 	test $H = $(git rev-parse HEAD)
 '
 
+test_expect_success 'rewrite bare repository identically' '
+	(git config core.bare true && cd .git && git-filter-branch branch)
+'
+git config core.bare false
+test_expect_success 'result is really identical' '
+	test $H = $(git rev-parse HEAD)
+'
+
 test_expect_success 'rewrite, renaming a specific file' '
 	git-filter-branch -f --tree-filter "mv d doh || :" HEAD
 '
