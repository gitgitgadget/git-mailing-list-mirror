From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH v2 properly indented] fix start_command() bug when stdin is closed
Date: Mon, 25 Aug 2008 15:37:35 +0200
Message-ID: <E1KXcH3-0000zJ-0m@fencepost.gnu.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
Cc: Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXcKU-0007iX-Av
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 15:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866AbYHYNj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 09:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbYHYNj6
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 09:39:58 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:34490 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756851AbYHYNj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 09:39:57 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1KXcH3-0000zJ-0m; Mon, 25 Aug 2008 09:38:25 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93623>

Karl Chen pointed out a problem in the use of dup2+close in
start_command() when one or more of file descriptors 0/1/2 are closed.
In order to rename a pipe file descriptor to 0, it does

    dup2(from, 0);
    close(from);

... but if stdin was closed (for example) from == 0, so that

    dup2(0, 0);
    close(0);

just ends up closing the pipe.  This patch fixes it by opening all of
the "low" descriptors to /dev/null.

In most cases this patch will not cause any additional system calls;
actually by reusing the /dev/null descriptor when possible (instead
of opening a fresh one in dup_devnull) it may even save a handful in
some cases. :-)

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
Acknowledged-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 run-command.c |   35 ++++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 13 deletions(-)

	> "Karl Chen pointed out a problem..." (just to give due credit).

	Of course.

	> Except for the insane GNU style indentation  ;-)

	*blush* -- both problems deriving from too hasty e-mail cut&paste.

	> this makes a lot of sense. [...] MINGW32 [...] pass the test suite.

	Thanks, also for testing Windows.

	Paolo

diff --git a/run-command.c b/run-command.c
index caab374..4619494 100644
--- a/run-command.c
+++ b/run-command.c
@@ -2,25 +2,33 @@
 #include "run-command.h"
 #include "exec_cmd.h"
 
+static int devnull_fd = -1;
+
 static inline void close_pair(int fd[2])
 {
 	close(fd[0]);
 	close(fd[1]);
 }
 
-static inline void dup_devnull(int to)
-{
-	int fd = open("/dev/null", O_RDWR);
-	dup2(fd, to);
-	close(fd);
-}
-
 int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
 
 	/*
+	 * Make sure that all file descriptors <= 2 are open, otherwise we
+	 * mess them up when dup'ing pipes onto stdin/stdout/stderr.  Since
+	 * we are at it, save a file descriptor on /dev/null to use it later.
+	 */
+	if (devnull_fd == -1) {
+		devnull_fd = open("/dev/null", O_RDWR);
+		while (devnull_fd >= 0 && devnull_fd <= 2)
+			devnull_fd = dup(devnull_fd);
+		if (devnull_fd == -1)
+			die("opening /dev/null failed (%s)", strerror(errno));
+	}
+
+	/*
 	 * In case of errors we must keep the promise to close FDs
 	 * that have been passed in via ->in and ->out.
 	 */
@@ -72,7 +81,7 @@ int start_command(struct child_process *cmd)
 	cmd->pid = fork();
 	if (!cmd->pid) {
 		if (cmd->no_stdin)
-			dup_devnull(0);
+			dup2(devnull_fd, 0);
 		else if (need_in) {
 			dup2(fdin[0], 0);
 			close_pair(fdin);
@@ -82,14 +91,14 @@ int start_command(struct child_process *cmd)
 		}
 
 		if (cmd->no_stderr)
-			dup_devnull(2);
+			dup2(devnull_fd, 2);
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
 		}
 
 		if (cmd->no_stdout)
-			dup_devnull(1);
+			dup2(devnull_fd, 1);
 		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
@@ -127,7 +136,7 @@ int start_command(struct child_process *cmd)
 
 	if (cmd->no_stdin) {
 		s0 = dup(0);
-		dup_devnull(0);
+		dup2(devnull_fd, 0);
 	} else if (need_in) {
 		s0 = dup(0);
 		dup2(fdin[0], 0);
@@ -138,7 +147,7 @@ int start_command(struct child_process *cmd)
 
 	if (cmd->no_stderr) {
 		s2 = dup(2);
-		dup_devnull(2);
+		dup2(devnull_fd, 2);
 	} else if (need_err) {
 		s2 = dup(2);
 		dup2(fderr[1], 2);
@@ -146,7 +155,7 @@ int start_command(struct child_process *cmd)
 
 	if (cmd->no_stdout) {
 		s1 = dup(1);
-		dup_devnull(1);
+		dup2(devnull_fd, 1);
 	} else if (cmd->stdout_to_stderr) {
 		s1 = dup(1);
 		dup2(2, 1);
-- 
1.5.5
