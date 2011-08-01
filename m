From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] notice error exit from pager
Date: Mon, 1 Aug 2011 19:59:21 +0200
Message-ID: <20110801175921.GA17092@toss>
References: <20110726210401.GA25207@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwm4-0007OH-K8
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab1HAR72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 13:59:28 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:49955 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751874Ab1HAR71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 13:59:27 -0400
Received: from localhost (p5B22CD28.dip.t-dialin.net [91.34.205.40])
	by bsmtp.bon.at (Postfix) with ESMTP id AA577A7EB3;
	Mon,  1 Aug 2011 19:59:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110726210401.GA25207@toss.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178367>

If the pager fails to run, git produces no output, e.g.:

 $ GIT_PAGER=not-a-command git log

The error reporting fails for two reasons:

 (1) start_command: There is a mechanism that detects errors during
     execvp introduced in 2b541bf8 (start_command: detect execvp
     failures early). The child writes one byte to a pipe only if
     execvp fails.  The parent waits for either EOF, when the
     successful execvp automatically closes the pipe (see
     FD_CLOEXEC in fcntl(1)), or it reads a single byte, in which
     case it knows that the execvp failed. This mechanism is
     incompatible with the workaround introduced in 35ce8622
     (pager: Work around window resizing bug in 'less'), which
     waits for input from the parent before the exec. Since both
     the parent and the child are waiting for input from each
     other, that would result in a deadlock. In order to avoid
     that, the mechanism is disabled by closing the child_notifier
     file descriptor.

 (2) finish_command: The parent correctly detects the 127 exit
     status from the child, but the error output goes nowhere,
     since by that time it is already being redirected to the
     child.

No simple solution for (1) comes to mind.

Number (2) can be solved by not sending error output to the pager.
Not redirecting error output to the pager can result in the pager
overwriting error output with standard output, however.

Since there is no reliable way to handle error reporting in the
parent, produce the output in the child instead.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Nothing new compared to the RFC, just a slightly trimmed commit
message.

 run-command.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5c91f37..a2796c4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -125,9 +125,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 		if (code == 127) {
 			code = -1;
 			failed_errno = ENOENT;
-			if (!silent_exec_failure)
-				error("cannot run %s: %s", argv0,
-					strerror(ENOENT));
 		}
 	} else {
 		error("waitpid is confused (%s)", argv0);
@@ -282,14 +279,14 @@ fail_pipe:
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		/*
-		 * Do not check for cmd->silent_exec_failure; the parent
-		 * process will check it when it sees this exit code.
-		 */
-		if (errno == ENOENT)
+		if (errno == ENOENT) {
+			if (!cmd->silent_exec_failure)
+				error("cannot run %s: %s", cmd->argv[0],
+					strerror(ENOENT));
 			exit(127);
-		else
+		} else {
 			die_errno("cannot exec '%s'", cmd->argv[0]);
+		}
 	}
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
-- 
1.7.3.1.105.g84915
