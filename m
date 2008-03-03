From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] run-command: Redirect stderr to a pipe before redirecting
 stdout to stderr
Date: Mon, 3 Mar 2008 20:06:23 +0100
Message-ID: <20080303200623.ac862ed1.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Xavier Maillard <xma@gnu.org>, git@vger.kernel.org,
	nanako3@bluebottle.com, pascal@obry.net
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:01:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFuc-0001KV-4m
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbYCCTAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 14:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbYCCTAp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:00:45 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:55170 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751093AbYCCTAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 14:00:44 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 62F321AB32E;
	Mon,  3 Mar 2008 20:00:42 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 2D0A01AB2BF;
	Mon,  3 Mar 2008 20:00:38 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75970>

From: "Shawn O. Pearce" <spearce@spearce.org>

With this patch, in the 'start_command' function after forking
we now take care of stderr in the child process before stdout.

This way if 'start_command' is called with a 'child_process'
argument like this:

	.err = -1;
	.stdout_to_stderr = 1;

then stderr will be redirected to a pipe before stdout is
redirected to stderr. So we can now get the process' stdout
from the pipe (as well as its stderr).

Update documentation in 'api-run-command.txt' accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/api-run-command.txt |    7 ++++---
 run-command.c                               |   14 +++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

	The changes since the previous versions are:

		- added documentation,
		- added 'From: "Shawn O. Pearce" <spearce@spearce.org>',
		- improved title.

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index dfbf9ac..c097f8b 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -111,9 +111,10 @@ stderr as follows:
 	.no_stdin, .no_stdout, .no_stderr: The respective channel is
 		redirected to /dev/null.
 
-	.stdout_to_stderr: stdout of the child is redirected to the
-		parent's stderr (i.e. *not* to what .err or
-		.no_stderr specify).
+	.stdout_to_stderr: stdout of the child is redirected to its
+		stderr. This happens before stderr is itself
+		redirected. So stdout will follow stderr to wherever
+		it is redirected.
 
 To modify the environment of the sub-process, specify an array of
 string pointers (NULL terminated) in .env:
diff --git a/run-command.c b/run-command.c
index 743757c..44100a7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -91,6 +91,13 @@ int start_command(struct child_process *cmd)
 			close(cmd->in);
 		}
 
+		if (cmd->no_stderr)
+			dup_devnull(2);
+		else if (need_err) {
+			dup2(fderr[1], 2);
+			close_pair(fderr);
+		}
+
 		if (cmd->no_stdout)
 			dup_devnull(1);
 		else if (cmd->stdout_to_stderr)
@@ -103,13 +110,6 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
-		if (cmd->no_stderr)
-			dup_devnull(2);
-		else if (need_err) {
-			dup2(fderr[1], 2);
-			close_pair(fderr);
-		}
