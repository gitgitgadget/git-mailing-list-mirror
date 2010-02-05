From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 1/6] run-command: Allow stderr to be a caller supplied pipe
Date: Fri,  5 Feb 2010 12:57:37 -0800
Message-ID: <1265403462-20572-2-git-send-email-spearce@spearce.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 22:04:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVLQ-0007MN-4Z
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503Ab0BEVDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:03:55 -0500
Received: from george.spearce.org ([209.20.77.23]:41730 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754927Ab0BEVDw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:03:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 2AD1B381FD
	for <git@vger.kernel.org>; Fri,  5 Feb 2010 20:57:44 +0000 (UTC)
X-Mailer: git-send-email 1.7.0.rc1.199.g9253ab
In-Reply-To: <1265403462-20572-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139088>

Like .out, .err may now be set to a file descriptor > 0, which
is a writable pipe/socket/file that the child's stderr will be
redirected into.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/technical/api-run-command.txt |    2 +-
 run-command.c                               |    8 ++++++++
 run-command.h                               |    2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index b26c281..a1280dd 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -135,7 +135,7 @@ stderr as follows:
 
 	.in: The FD must be readable; it becomes child's stdin.
 	.out: The FD must be writable; it becomes child's stdout.
-	.err > 0 is not supported.
+	.err: The FD must be writable; it becomes child's stderr.
 
   The specified FD is closed by start_command(), even if it fails to
   run the sub-process!
diff --git a/run-command.c b/run-command.c
index cf2d8f7..bfd2312 100644
--- a/run-command.c
+++ b/run-command.c
@@ -94,6 +94,9 @@ fail_pipe:
 		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
+		} else if (cmd->err > 1) {
+			dup2(cmd->err, 2);
+			close(cmd->err);
 		}
 
 		if (cmd->no_stdout)
@@ -156,6 +159,9 @@ fail_pipe:
 	} else if (need_err) {
 		s2 = dup(2);
 		dup2(fderr[1], 2);
+	} else if (cmd->err > 2) {
+		s2 = dup(2);
+		dup2(cmd->err, 2);
 	}
 
 	if (cmd->no_stdout) {
@@ -228,6 +234,8 @@ fail_pipe:
 
 	if (need_err)
 		close(fderr[1]);
+	else if (cmd->err)
+		close(cmd->err);
 
 	return 0;
 }
diff --git a/run-command.h b/run-command.h
index fb34209..a29171a 100644
--- a/run-command.h
+++ b/run-command.h
@@ -18,7 +18,7 @@ struct child_process {
 	 * - Specify > 0 to set a channel to a particular FD as follows:
 	 *     .in: a readable FD, becomes child's stdin
 	 *     .out: a writable FD, becomes child's stdout/stderr
-	 *     .err > 0 not supported
+	 *     .err: a writable FD, becomes child's stderr
 	 *   The specified FD is closed by start_command(), even in case
 	 *   of errors!
 	 */
-- 
1.7.0.rc1.199.g9253ab
