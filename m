From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] teach wait_or_whine a "quiet" mode
Date: Thu, 31 Mar 2011 14:43:42 -0400
Message-ID: <20110331184342.GA16906@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 20:43:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5MqU-0001Fi-NK
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 20:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759023Ab1CaSnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 14:43:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60514
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759001Ab1CaSnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 14:43:45 -0400
Received: (qmail 1299 invoked by uid 107); 31 Mar 2011 18:44:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 14:44:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 14:43:42 -0400
Content-Disposition: inline
In-Reply-To: <20110331184243.GA12027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170511>

The wait_or_whine function will complain to stderr in a few
cases:

  1. We fail to actually waitpid() correctly.

  2. The child died of a signal.

  3. The child returned exit code 127, indicating a missing
     command to exec after forking.

We already have a silent_exec_failure flag to silence (3).
Let's convert that into a "quiet" flag to also silence (2).
This shouldn't result in signal failure being silent for
existing users of silent_exec_failure, since they already
will need to be checking the return code and complaining for
the case of a non-zero exit code.

For (1), it probably makes sense to always complain about a
failure to correctly wait, so let's not quiet that.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index 0d95340..0d5626a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -240,7 +240,7 @@ fail_pipe:
 	return 0;
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
+static int wait_or_whine(pid_t pid, const char *argv0, int quiet)
 {
 	int status, code = -1;
 	pid_t waiting;
@@ -256,7 +256,8 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code = WTERMSIG(status);
-		error("%s died of signal %d", argv0, code);
+		if (!quiet)
+			error("%s died of signal %d", argv0, code);
 		/*
 		 * This return value is chosen so that code & 0xff
 		 * mimics the exit code that a POSIX shell would report for
@@ -271,7 +272,7 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 		if (code == 127) {
 			code = -1;
 			failed_errno = ENOENT;
-			if (!silent_exec_failure)
+			if (!quiet)
 				error("cannot run %s: %s", argv0,
 					strerror(ENOENT));
 		}
-- 
1.7.4.13.g8566c
