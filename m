From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 2/3] run_command: handle missing command errors more
	gracefully
Date: Tue, 27 Jan 2009 01:27:05 -0500
Message-ID: <20090127062705.GB13161@coredump.intra.peff.net>
References: <20090127062512.GA10487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 07:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRhR2-0000l4-AD
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 07:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbZA0G1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 01:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbZA0G1J
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 01:27:09 -0500
Received: from peff.net ([208.65.91.99]:40363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbZA0G1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 01:27:08 -0500
Received: (qmail 9275 invoked by uid 107); 27 Jan 2009 06:27:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 27 Jan 2009 01:27:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2009 01:27:05 -0500
Content-Disposition: inline
In-Reply-To: <20090127062512.GA10487@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107317>

When run_command was asked to run a non-existant command,
its behavior varied depending on the platform:

  - on POSIX systems, we would fork, and then after the
    execvp call failed, we could call die(), which prints a
    message to stderr and exits with code 128.

  - on Windows, we do a PATH lookup, realize the program
    isn't there, and then return ERR_RUN_COMMAND_FORK

The goal of this patch is to make it clear to callers that
the specific error was a missing command. To do this, we
will return the error code ERR_RUN_COMMAND_EXEC, which is
already defined in run-command.h, checked for in several
places, but never actually gets set.

The new behavior is:

  - on POSIX systems, we exit the forked process with code
    127 (the same as the shell uses to report missing
    commands). The parent process recognizes this code and
    returns an EXEC error. The stderr message is silenced,
    since the caller may be speculatively trying to run a
    command. Instead, we use trace_printf so that somebody
    interested in debugging can see the error that occured.

  - on Windows, we check errno, which is already set
    correctly by mingw_spawnvpe, and report an EXEC error
    instead of a FORK error

Thus it is safe to speculatively run a command:

  int r = run_command_v_opt(argv, 0);
  if (r == -ERR_RUN_COMMAND_EXEC)
	  /* oops, it wasn't found; try something else */
  else
	  /* we failed for some other reason, error is in r */

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index db9ce59..2437798 100644
--- a/run-command.c
+++ b/run-command.c
@@ -118,7 +118,9 @@ int start_command(struct child_process *cmd)
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		die("exec %s failed.", cmd->argv[0]);
+		trace_printf("trace: exec '%s' failed: %s\n", cmd->argv[0],
+				strerror(errno));
+		exit(127);
 	}
 #else
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
@@ -197,7 +199,13 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		if (need_err)
 			close_pair(fderr);
+#ifndef __MINGW32__
 		return -ERR_RUN_COMMAND_FORK;
+#else
+		return errno == ENOENT ?
+			-ERR_RUN_COMMAND_EXEC :
+			-ERR_RUN_COMMAND_FORK;
+#endif
 	}
 
 	if (need_in)
@@ -236,9 +244,14 @@ static int wait_or_whine(pid_t pid)
 		if (!WIFEXITED(status))
 			return -ERR_RUN_COMMAND_WAITPID_NOEXIT;
 		code = WEXITSTATUS(status);
-		if (code)
+		switch (code) {
+		case 127:
+			return -ERR_RUN_COMMAND_EXEC;
+		case 0:
+			return 0;
+		default:
 			return -code;
-		return 0;
+		}
 	}
 }
 
-- 
1.6.1.1.367.g30b36
