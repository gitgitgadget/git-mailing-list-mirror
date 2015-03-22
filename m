From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] run-command: forbid using run_command with piped output
Date: Sun, 22 Mar 2015 06:10:43 -0400
Message-ID: <20150322101043.GG11615@peff.net>
References: <20150322095924.GA24651@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 11:11:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZcqS-0006ma-Sd
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 11:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444AbbCVKKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 06:10:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:36721 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752415AbbCVKKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 06:10:46 -0400
Received: (qmail 32717 invoked by uid 102); 22 Mar 2015 10:10:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 05:10:46 -0500
Received: (qmail 7045 invoked by uid 107); 22 Mar 2015 10:10:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 22 Mar 2015 06:10:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2015 06:10:43 -0400
Content-Disposition: inline
In-Reply-To: <20150322095924.GA24651@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266064>

Because run_command both spawns and wait()s for the command
before returning control to the caller, any reads from the
pipes we open must necessarily happen after wait() returns.
This can lead to deadlock, as the child process may block on
writing to us while we are blocked waiting for it to exit.

Worse, it only happens when the child fills the pipe buffer,
which means that the problem may come and go depending on
the platform and the size of the output produced by the
child.

Let's detect and flag this dangerous construct so that we
can catch potential bugs early in the test suite rather than
having them happen in the field.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 3afb124..23636e0 100644
--- a/run-command.c
+++ b/run-command.c
@@ -557,7 +557,12 @@ int finish_command(struct child_process *cmd)
 
 int run_command(struct child_process *cmd)
 {
-	int code = start_command(cmd);
+	int code;
+
+	if (cmd->out < 0 || cmd->err < 0)
+		die("BUG: run_command with a pipe can cause deadlock");
+
+	code = start_command(cmd);
 	if (code)
 		return code;
 	return finish_command(cmd);
-- 
2.3.3.618.ga041503
