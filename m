From: Eric Kidd <git@randomhacks.net>
Subject: [PATCH] filter-branch: Fix fatal error on bare repositories
Date: Tue,  3 Feb 2009 13:27:03 -0500
Message-ID: <1233685623-39501-1-git-send-email-git@randomhacks.net>
Cc: Eric Kidd <git@randomhacks.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 19:50:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUQLY-0003MT-8R
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbZBCSsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbZBCSsn
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:48:43 -0500
Received: from randomhacks.net ([69.93.127.95]:56467 "EHLO randomhacks.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbZBCSsm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:48:42 -0500
X-Greylist: delayed 1276 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Feb 2009 13:48:42 EST
Received: from mfpt-71-169-176-91.myfairpoint.net ([71.169.176.91] helo=localhost.localdomain)
	by randomhacks.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <git@randomhacks.net>)
	id 1LUPzZ-00024j-4w; Tue, 03 Feb 2009 13:27:25 -0500
X-Mailer: git-send-email 1.6.1.2.253.ga34a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108238>

When git filter-branch is run on a bare repository, it prints out a fatal
error message:

  $ git filter-branch branch
  Rewrite 476c4839280c219c2317376b661d9d95c1727fc3 (9/9)
  WARNING: Ref 'refs/heads/branch' is unchanged
  fatal: This operation must be run in a work tree

Note that this fatal error message doesn't prevent git filter-branch from
exiting successfully. (Why doesn't git filter-branch actually exit with an
error when a shell command fails? I'm not sure why it was designed this
way.)

This error message is caused by the following section of code at the end of
git-filter-branch.sh:

  if [ "$(is_bare_repository)" = false ]; then
          unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
          test -z "$ORIG_GIT_DIR" || {
                  GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
          }
          ... elided ...
          git read-tree -u -m HEAD
  fi

The problem is the call to $(is_bare_repository), which is made before
GIT_DIR and GIT_WORK_TREE are restored.  This call always returns "false",
even when we're running in a bare repository.  But this means that we will
attempt to call 'git read-tree' even in a bare repository, which will fail
and print an error.

This patch modifies git-filter-branch.sh to restore the original
environment variables before trying to call is_bare_repository.
---
 git-filter-branch.sh     |   25 +++++++++++++------------
 t/t7003-filter-branch.sh |    4 +++-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index eb62f71..b75d0ba 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -469,19 +469,20 @@ rm -rf "$tempdir"
 
 trap - 0
 
+unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
+test -z "$ORIG_GIT_DIR" || {
+	GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
+}
+test -z "$ORIG_GIT_WORK_TREE" || {
+	GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
+	export GIT_WORK_TREE
+}
+test -z "$ORIG_GIT_INDEX_FILE" || {
+	GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
+	export GIT_INDEX_FILE
+}
+
 if [ "$(is_bare_repository)" = false ]; then
-	unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
-	test -z "$ORIG_GIT_DIR" || {
-		GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
-	}
-	test -z "$ORIG_GIT_WORK_TREE" || {
-		GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
-		export GIT_WORK_TREE
-	}
-	test -z "$ORIG_GIT_INDEX_FILE" || {
-		GIT_INDEX_FILE="$ORIG_GIT_INDEX_FILE" &&
-		export GIT_INDEX_FILE
-	}
 	git read-tree -u -m HEAD
 fi
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 8537bf9..cb04743 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -39,7 +39,9 @@ test_expect_success 'result is really identical' '
 '
 
 test_expect_success 'rewrite bare repository identically' '
-	(git config core.bare true && cd .git && git filter-branch branch)
+	(git config core.bare true && cd .git &&
+	 git filter-branch branch > filter-output 2>&1 &&
+	! fgrep fatal filter-output)
 '
 git config core.bare false
 test_expect_success 'result is really identical' '
-- 
1.6.1.2.253.ga34a.dirty
