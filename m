From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] run-command: propagate EACCES errors to parent
Date: Tue, 27 Mar 2012 14:04:25 -0400
Message-ID: <20120327180425.GA4659@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 20:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCakz-0006SM-73
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 20:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977Ab2C0SE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 14:04:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34381
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab2C0SE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 14:04:27 -0400
Received: (qmail 5574 invoked by uid 107); 27 Mar 2012 18:04:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 14:04:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 14:04:25 -0400
Content-Disposition: inline
In-Reply-To: <20120327175933.GA1716@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194067>

The caller of run_command does not directly get access to
the errno from exec, because it happens in the forked child.
However, knowing the specific reason for an exec failure can
help the parent respond better or produce better error
messages.

We already propagate ENOENT to the parent via exit code 127.
Let's do the same for EACCES with exit code 126, which is
already used by bash to indicate the same thing.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, there is a slight bending of the truth in the commit message.
bash implements its own execvp, and it will only return 126/EACCES if a
file is found via stat(), but is not executable. If there is an
inaccessible directory in the PATH (meaning that stat() will fail), it
will silently convert that to 127/ENOENT.

 run-command.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/run-command.c b/run-command.c
index 1db8abf..e303beb 100644
--- a/run-command.c
+++ b/run-command.c
@@ -185,6 +185,10 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 			code = -1;
 			failed_errno = ENOENT;
 		}
+		else if (code == 126) {
+			code = -1;
+			failed_errno = EACCES;
+		}
 	} else {
 		error("waitpid is confused (%s)", argv0);
 	}
@@ -346,6 +350,11 @@ fail_pipe:
 				error("cannot run %s: %s", cmd->argv[0],
 					strerror(ENOENT));
 			exit(127);
+		} else if (errno == EACCES) {
+			if (!cmd->silent_exec_failure)
+				error("cannot run %s: %s", cmd->argv[0],
+					strerror(errno));
+			exit(126);
 		} else {
 			die_errno("cannot exec '%s'", cmd->argv[0]);
 		}
-- 
1.7.9.5.5.g9b709b
