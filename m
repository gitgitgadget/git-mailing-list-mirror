From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] run-command: drop silent_exec_failure arg from
 wait_or_whine
Date: Fri, 30 Nov 2012 17:40:50 -0500
Message-ID: <20121130224050.GA23772@sigill.intra.peff.net>
References: <20121130223943.GA27120@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Fox <pgf@foxharp.boston.ma.us>,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 23:41:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeZGq-0007vZ-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 23:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab2K3Wky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 17:40:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47983 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab2K3Wkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 17:40:53 -0500
Received: (qmail 6930 invoked by uid 107); 30 Nov 2012 22:41:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 17:41:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 17:40:50 -0500
Content-Disposition: inline
In-Reply-To: <20121130223943.GA27120@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210948>

We do not actually use this parameter; instead we complain
from the child itself (for fork/exec) or from start_command
(if we are using spawn on Windows).

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 3b982e4..3aae270 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,7 +226,7 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
+static int wait_or_whine(pid_t pid, const char *argv0)
 {
 	int status, code = -1;
 	pid_t waiting;
@@ -432,8 +432,7 @@ fail_pipe:
 		 * At this point we know that fork() succeeded, but execvp()
 		 * failed. Errors have been reported to our stderr.
 		 */
-		wait_or_whine(cmd->pid, cmd->argv[0],
-			      cmd->silent_exec_failure);
+		wait_or_whine(cmd->pid, cmd->argv[0]);
 		failed_errno = errno;
 		cmd->pid = -1;
 	}
@@ -538,7 +537,7 @@ int finish_command(struct child_process *cmd)
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->silent_exec_failure);
+	return wait_or_whine(cmd->pid, cmd->argv[0]);
 }
 
 int run_command(struct child_process *cmd)
-- 
1.8.0.1.620.g558b0aa
