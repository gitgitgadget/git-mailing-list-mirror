From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH/RFC] notice error exit from pager
Date: Tue, 26 Jul 2011 23:04:02 +0200
Message-ID: <20110726210401.GA25207@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: j6t@kdbg.org, torvalds@linux-foundation.org,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 23:05:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qloob-0005bI-H7
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 23:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab1GZVFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 17:05:12 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:50528 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751503Ab1GZVFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 17:05:10 -0400
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 58D9E130049;
	Tue, 26 Jul 2011 23:04:02 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177900>

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
     file descriptor. That is my best guess, at least, from reading
     the code. Hannes, can you confirm if this analysis is correct?

 (2) finish_command: The parent correctly detects the 127 exit
     status from the child, but the error output goes nowhere,
     since by that time it is already being redirected to the
     child.

No simple solution for (1) comes to mind. I am not sure if this bug
is still relevant. I could not reproduce it here with less version
436. If this bug was fixed a long time ago, maybe we can remove the
workaround by now?

Number (2) can be solved by not sending error output to the pager.
But I am not completely satisfied with that solution.  Not
redirecting error output to the pager can result in the pager
overwriting error output with standard output. Right now, I can't
think of any common situations where this would be the case. But,
for example, a git log on a broken repo with some missing commits
will abort at some point with "error: could not read <sha1> [...]".
With this patch, if there is at least one page of standard output
before that error, the error message is not visible at all and the
output simply stops as if git log had reached the root commit.

The easiest solution is to produce the error output in the child.
Below is a patch for that. The previous code seems to go through
some pain to let the parent handle the error output. But I don't
see the point. Is there more to this than meets my eye?

Clemens

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 run-command.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index 70e8a24..944a882 100644
--- a/run-command.c
+++ b/run-command.c
@@ -127,9 +127,6 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 		if (code == 127) {
 			code = -1;
 			failed_errno = ENOENT;
-			if (!silent_exec_failure)
-				error("cannot run %s: %s", argv0,
-					strerror(ENOENT));
 		}
 	} else {
 		error("waitpid is confused (%s)", argv0);
@@ -287,10 +284,14 @@ fail_pipe:
 		 * Do not check for cmd->silent_exec_failure; the parent
 		 * process will check it when it sees this exit code.
 		 */
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
