From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 04/14] Use run_command() to spawn external diff programs instead of fork/exec.
Date: Sat, 13 Oct 2007 22:06:14 +0200
Message-ID: <1192305984-22594-5-git-send-email-johannes.sixt@telecom.at>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 13 22:06:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgnG0-0008MX-UX
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 22:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254AbXJMUGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 16:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbXJMUGd
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 16:06:33 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:52578 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbXJMUG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 16:06:27 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 0DF0B13A6AA;
	Sat, 13 Oct 2007 22:06:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60761>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 diff.c |   38 +++-----------------------------------
 1 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/diff.c b/diff.c
index 0ee9ea1..d03dc6a 100644
--- a/diff.c
+++ b/diff.c
@@ -9,6 +9,7 @@
 #include "xdiff-interface.h"
 #include "color.h"
 #include "attr.h"
+#include "run-command.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1791,40 +1792,6 @@ static void remove_tempfile_on_signal(int signo)
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
@@ -1877,7 +1844,8 @@ static void run_external_diff(const char *pgm,
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
