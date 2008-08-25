From: Karl Chen <quarl@cs.berkeley.edu>
Subject: [PATCH] Fix start_command() pipe bug when stdin is closed.
Date: Mon, 25 Aug 2008 01:28:19 -0700
Message-ID: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 10:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXXS0-0007CO-Pe
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 10:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbYHYI2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 04:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYHYI2U
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 04:28:20 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:57313 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbYHYI2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 04:28:20 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id DD3AE345F1; Mon, 25 Aug 2008 01:28:19 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93605>


I ran into what I think is a bug:
    sh$ git fetch 0<&-

(i.e. run git-fetch with stdin closed.)
It aborts with:
    fatal: read error (Bad file descriptor)

I think the problem arises from the use of dup2+close in
start_command().  It wants to rename a pipe file descriptor to 0,
so it does
    dup2(from, to);
    close(from);

... but in this case from == to == 0, so 
    dup2(0, 0);
    close(0);
just ends up closing the pipe.

The patch below fixes the problem for me.


>From 78446c82131a5ca7f22f92bc32d7f3036bba9629 Mon Sep 17 00:00:00 2001
From: Karl Chen <quarl@quarl.org>
Date: Mon, 25 Aug 2008 01:09:08 -0700
Subject: [PATCH] Fix start_command() pipe bug when stdin is closed.

When intending to rename a fd to 0, if the fd is already 0, then do nothing,
instead of dup2(0,0); close(0);

The problematic behavior could be seen thus: git-fetch 0<&-

Signed-off-by: Karl Chen <quarl@quarl.org>

---
 run-command.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/run-command.c b/run-command.c
index caab374..b4bd80f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,11 +8,18 @@ static inline void close_pair(int fd[2])
 	close(fd[1]);
 }
 
+static inline void rename_fd(int from, int to)
+{
+	if (from != to) {
+		dup2(from, to);
+		close(from);
+	}
+}
+
 static inline void dup_devnull(int to)
 {
 	int fd = open("/dev/null", O_RDWR);
-	dup2(fd, to);
-	close(fd);
+	rename_fd(fd, to);
 }
 
 int start_command(struct child_process *cmd)
@@ -74,18 +81,17 @@ int start_command(struct child_process *cmd)
 		if (cmd->no_stdin)
 			dup_devnull(0);
 		else if (need_in) {
-			dup2(fdin[0], 0);
-			close_pair(fdin);
+			rename_fd(fdin[0], 0);
+			close(fdin[1]);
 		} else if (cmd->in) {
-			dup2(cmd->in, 0);
-			close(cmd->in);
+			rename_fd(cmd->in, 0);
 		}
 
 		if (cmd->no_stderr)
 			dup_devnull(2);
 		else if (need_err) {
-			dup2(fderr[1], 2);
-			close_pair(fderr);
+			rename_fd(fderr[1], 2);
+			close(fderr[0]);
 		}
 
 		if (cmd->no_stdout)
@@ -93,11 +99,10 @@ int start_command(struct child_process *cmd)
 		else if (cmd->stdout_to_stderr)
 			dup2(2, 1);
 		else if (need_out) {
-			dup2(fdout[1], 1);
-			close_pair(fdout);
+			rename_fd(fdout[1], 1);
+			close(fdout[0]);
 		} else if (cmd->out > 1) {
-			dup2(cmd->out, 1);
-			close(cmd->out);
+			rename_fd(cmd->out, 1);
 		}
 
 		if (cmd->dir && chdir(cmd->dir))
-- 
1.5.6.2
