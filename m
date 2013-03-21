From: Jeff King <peff@peff.net>
Subject: [PATCH 6/4] run-command: always set failed_errno in start_command
Date: Thu, 21 Mar 2013 11:45:00 -0400
Message-ID: <20130321154500.GB2075@sigill.intra.peff.net>
References: <20130321154402.GA25907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:45:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhgQ-0000HZ-DL
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739Ab3CUPpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:45:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33941 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453Ab3CUPpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:45:08 -0400
Received: (qmail 24402 invoked by uid 107); 21 Mar 2013 15:46:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 11:46:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 11:45:00 -0400
Content-Disposition: inline
In-Reply-To: <20130321154402.GA25907@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218739>

When we fail to fork, we set the failed_errno variable to
the value of errno so it is not clobbered by later syscalls.
However, we do so in a conditional, and it is hard to see
later under what conditions the variable has a valid value.

Instead of setting it only when fork fails, let's just
always set it after forking. This is more obvious for human
readers (as we are no longer setting it as a side effect of
a strerror call), and it is more obvious to gcc, which no
longer generates a spurious -Wuninitialized warning. It also
happens to match what the WIN32 half of the #ifdef does.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 07e27ff..765c2ce 100644
--- a/run-command.c
+++ b/run-command.c
@@ -273,7 +273,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
-	int failed_errno = failed_errno;
+	int failed_errno;
 	char *str;
 
 	/*
@@ -341,6 +341,7 @@ fail_pipe:
 		notify_pipe[0] = notify_pipe[1] = -1;
 
 	cmd->pid = fork();
+	failed_errno = errno;
 	if (!cmd->pid) {
 		/*
 		 * Redirect the channel to write syscall error messages to
@@ -420,7 +421,7 @@ fail_pipe:
 	}
 	if (cmd->pid < 0)
 		error("cannot fork() for %s: %s", cmd->argv[0],
-			strerror(failed_errno = errno));
+			strerror(errno));
 	else if (cmd->clean_on_exit)
 		mark_child_for_cleanup(cmd->pid);
 
-- 
1.8.2.rc2.8.g2161951
