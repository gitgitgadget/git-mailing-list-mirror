From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] rollback index if git-commit is interrupted by a signal
Date: Thu, 29 May 2008 10:03:40 +0200
Message-ID: <E1K1eXC-0005xW-Jd@fencepost.gnu.org>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 29 11:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1eZl-0005xe-7I
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 11:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYE2Jgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbYE2Jgo
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 05:36:44 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45951 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbYE2Jgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 05:36:44 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1K1eXC-0005xW-Jd
	for git@vger.kernel.org; Thu, 29 May 2008 05:34:58 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83186>

If git-commit is interrupted by a signal, the index.lock file may be left
in the repository.  This patch teaches git to break them, and adds a test.

This will usually happen if you ^Z the editor, and then either close the
terminal or kill git.  However, the patch is more defensive and sets up
the signal handlers so that the entire creation of the index is protected.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-commit.c  |   25 ++++++++++++++-----------
 t/t7502-commit.sh |   14 ++++++++++++++
 2 files changed, 28 insertions(+), 11 deletions(-)

	rollback_index_files handles cleanly the case when the lock
	had not been established; git-status tests check for this.

	The test is a bit tricky.  To find git's PID, I use a separate shell
	so that I can "exec" git: git will then inherit the same PID as the
	shell, which I get with $$.  Using a subshell does not work because bash
	optimizes subshells and does not fork a copy of itself -- this however
	means that it will not be able to really honor the "exec" command,
	and git will get a different PID!
	
diff --git a/builtin-commit.c b/builtin-commit.c
index b294c1f..ef8b1f0 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -111,17 +111,8 @@ static struct option builtin_commit_options[] = {
 
 static void rollback_index_files(void)
 {
-	switch (commit_style) {
-	case COMMIT_AS_IS:
-		break; /* nothing to do */
-	case COMMIT_NORMAL:
-		rollback_lock_file(&index_lock);
-		break;
-	case COMMIT_PARTIAL:
-		rollback_lock_file(&index_lock);
-		rollback_lock_file(&false_lock);
-		break;
-	}
+	rollback_lock_file(&index_lock);
+	rollback_lock_file(&false_lock);
 }
 
 static int commit_index_files(void)
@@ -215,6 +206,13 @@ static void create_base_index(void)
 		exit(128); /* We've already reported the error, finish dying */
 }
 
+static void rollback_on_signal(int signo)
+{
+	rollback_index_files();
+	signal(signo, SIG_DFL);
+	raise(signo);
+}
+
 static char *prepare_index(int argc, const char **argv, const char *prefix)
 {
 	int fd;
@@ -235,6 +233,11 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	if (*argv)
 		pathspec = get_pathspec(prefix, argv);
 
+	signal (SIGINT, rollback_on_signal);
+	signal (SIGHUP, rollback_on_signal);
+	signal (SIGTERM, rollback_on_signal);
+	signal (SIGQUIT, rollback_on_signal);
+
 	/*
 	 * Non partial, non as-is commit.
 	 *
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 3531a99..7d5643d 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -212,4 +212,18 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	test "`cat .git/result`" = "editor not started"
 '
 
+pwd=`pwd`
+cat > .git/FAKE_EDITOR << EOF
+#! /bin/sh
+# kill -TERM command added below.
+EOF
+
+test_expect_success 'a signal breaks locks' '
+	echo >>negative &&
+	sh -c '\''
+	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  GIT_EDITOR=.git/FAKE_EDITOR exec git commit -a'\'' && exit 1  # should fail
+	! test -f .git/index.lock
+'
+
 test_done
-- 
1.5.5
