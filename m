From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Redirect stderr to a pipe before redirecting stdout to
 stderr
Date: Mon, 3 Mar 2008 08:21:11 +0100
Message-ID: <20080303082111.24d3ea73.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, nanako3@bluebottle.com, pascal@obry.net
To: Junio C Hamano <gitster@pobox.com>, Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4uP-0000fo-Dr
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbYCCHP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 02:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbYCCHP2
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:15:28 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:45548 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbYCCHP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 02:15:27 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 57C6E1AB2E1;
	Mon,  3 Mar 2008 08:15:26 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 08C3F1AB2C4;
	Mon,  3 Mar 2008 08:15:25 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75899>

With this patch, in the 'start_command' function after forking
we now take care of stderr in the child process before stdout.

This way if 'start_command' is called with a 'child_process'
argument like this:

	.err = -1;
	.stdout_to_stderr = 1;

then stderr will be redirected to a pipe before stdout is
redirected to stderr. So we can now get the process' stdout
from the pipe (as well as its stderr).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 run-command.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

	This patch should make my previous patch:

	[PATCH 1/2] help: add "man.viewer" config var to use "woman" or "konqueror"

	work as expected (at least with Emacs 21 and 22).

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
