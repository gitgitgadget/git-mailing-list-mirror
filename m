From: Jeff King <peff@peff.net>
Subject: [PATCHv2 4/4] git: use run_command to execute dashed externals
Date: Wed, 28 Jan 2009 02:38:14 -0500
Message-ID: <20090128073814.GD31884@coredump.intra.peff.net>
References: <20090128073059.GD19165@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS51S-0008Fh-As
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbZA1HiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZA1HiR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:38:17 -0500
Received: from peff.net ([208.65.91.99]:47529 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbZA1HiR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:38:17 -0500
Received: (qmail 19629 invoked by uid 107); 28 Jan 2009 07:38:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:38:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:38:14 -0500
Content-Disposition: inline
In-Reply-To: <20090128073059.GD19165@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107495>

We used to simply try calling execvp(); if it succeeded,
then we were done and the new program was running. If it
didn't, then we knew that it wasn't a valid command.

Unfortunately, this interacted badly with the new pager
handling. Now that git remains the parent process and the
pager is spawned, git has to hang around until the pager is
finished. We install an atexit handler to do this, but that
handler never gets called if we successfully run execvp.

You could see this behavior by running any dashed external
using a pager (e.g., "git -p stash list"). The command
finishes running, but the pager is still going. In the case
of less, it then gets an error reading from the terminal and
exits, potentially leaving the terminal in a broken state
(and not showing the output).

This patch just uses run_command to try running the
dashed external. The parent git process then waits for the
external process to complete and then handles the pager
cleanup as it would for an internal command.

Signed-off-by: Jeff King <peff@peff.net>
---
Incorporates negated status fix from JSixt.

This version also differentiates in the exit code and stderr output
whether we simply failed to exec the command versus passing along its
status code.

 git.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index 45e493d..b02b05b 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "cache.h"
 #include "quote.h"
+#include "run-command.h"
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
@@ -392,6 +393,7 @@ static void execv_dashed_external(const char **argv)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	const char *tmp;
+	int status;
 
 	strbuf_addf(&cmd, "git-%s", argv[0]);
 
@@ -406,10 +408,17 @@ static void execv_dashed_external(const char **argv)
 
 	trace_argv_printf(argv, "trace: exec:");
 
-	/* execvp() can only ever return if it fails */
-	execvp(cmd.buf, (char **)argv);
-
-	trace_printf("trace: exec failed: %s\n", strerror(errno));
+	/*
+	 * if we fail because the command is not found, it is
+	 * OK to return. Otherwise, we just pass along the status code.
+	 */
+	status = run_command_v_opt(argv, 0);
+	if (status != -ERR_RUN_COMMAND_EXEC) {
+		if (IS_RUN_COMMAND_ERR(status))
+			die("unable to run '%s'", argv[0]);
+		exit(-status);
+	}
+	errno = ENOENT; /* as if we called execvp */
 
 	argv[0] = tmp;
 
-- 
1.6.1.1.367.g30b36
