From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 4/5] Use run_command() to spawn external diff programs instead of fork/exec.
Date: Wed,  3 Oct 2007 22:09:39 +0200
Message-ID: <1191442180-15905-5-git-send-email-johannes.sixt@telecom.at>
References: <200709302340.17644.johannes.sixt@telecom.at>
 <1191442180-15905-1-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-2-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-3-git-send-email-johannes.sixt@telecom.at>
 <1191442180-15905-4-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 03 22:09:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdAXc-0003Ig-Dw
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 22:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbXJCUJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 16:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbXJCUJt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 16:09:49 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:33604 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447AbXJCUJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 16:09:42 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 58E9110B4FC;
	Wed,  3 Oct 2007 22:09:41 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.3.1134.gee562
In-Reply-To: <1191442180-15905-4-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59875>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 diff.c |   38 +++-----------------------------------
 1 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/diff.c b/diff.c
index 6648e01..30b7544 100644
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
