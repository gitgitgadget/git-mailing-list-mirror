From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 4/5] Use run_command() to spawn external diff programs instead of fork/exec.
Date: Sun, 30 Sep 2007 22:10:00 +0200
Message-ID: <1191183001-5368-5-git-send-email-johannes.sixt@telecom.at>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-3-git-send-email-johannes.sixt@telecom.at>
 <1191183001-5368-4-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 30 22:10:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic57I-0002Yg-Ko
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbXI3UKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXI3UKJ
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:10:09 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:36910 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbXI3UKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:10:04 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 7D8A49735E;
	Sun, 30 Sep 2007 22:10:03 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191183001-5368-4-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59555>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 diff.c |   38 +++-----------------------------------
 1 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/diff.c b/diff.c
index 0bd7e24..29dfa82 100644
--- a/diff.c
+++ b/diff.c
@@ -9,6 +9,7 @@
 #include "xdiff-interface.h"
 #include "color.h"
 #include "attr.h"
+#include "run-command.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1748,40 +1749,6 @@ static void remove_tempfile_on_signal(int signo)
 	raise(signo);
 }
 
-static int spawn_prog(const char *pgm, const char **arg)
-{
-	pid_t pid;
-	int status;
-
-	fflush(NULL);
-	pid = fork();
-	if (pid < 0)
-		die("unable to fork");
-	if (!pid) {
-		execvp(pgm, (char *const*) arg);
-		exit(255);
-	}
-
-	while (waitpid(pid, &status, 0) < 0) {
-		if (errno == EINTR)
-			continue;
-		return -1;
-	}
-
-	/* Earlier we did not check the exit status because
-	 * diff exits non-zero if files are different, and
-	 * we are not interested in knowing that.  It was a
-	 * mistake which made it harder to quit a diff-*
-	 * session that uses the git-apply-patch-script as
-	 * the GIT_EXTERNAL_DIFF.  A custom GIT_EXTERNAL_DIFF
-	 * should also exit non-zero only when it wants to
-	 * abort the entire diff-* session.
-	 */
-	if (WIFEXITED(status) && !WEXITSTATUS(status))
-		return 0;
-	return -1;
-}
-
 /* An external diff command takes:
  *
  * diff-cmd name infile1 infile1-sha1 infile1-mode \
@@ -1834,7 +1801,8 @@ static void run_external_diff(const char *pgm,
 		*arg++ = name;
 	}
 	*arg = NULL;
-	retval = spawn_prog(pgm, spawn_arg);
+	fflush(NULL);
+	retval = run_command_v_opt(spawn_arg, 0);
 	remove_tempfile();
 	if (retval) {
 		fprintf(stderr, "external diff died, stopping at %s.\n", name);
-- 
1.5.3.3.1134.gee562
