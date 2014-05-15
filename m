From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] run-command: store an optional argv_array
Date: Thu, 15 May 2014 04:33:26 -0400
Message-ID: <20140515083326.GA26866@sigill.intra.peff.net>
References: <20140515082943.GA26473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 10:33:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkr6e-0001XZ-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 10:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbaEOIdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 04:33:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:52055 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751614AbaEOId2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 04:33:28 -0400
Received: (qmail 20231 invoked by uid 102); 15 May 2014 08:33:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 May 2014 03:33:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2014 04:33:26 -0400
Content-Disposition: inline
In-Reply-To: <20140515082943.GA26473@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249068>

All child_process structs need to point to an argv. For
flexibility, we do not mandate the use of a dynamic
argv_array. However, because the child_process does not own
the memory, this can make memory management with a
separate argv_array difficult.

For example, if a function calls start_command but not
finish_command, the argv memory must persist. The code needs
to arrange to clean up the argv_array separately after
finish_command runs. As a result, some of our code in this
situation just leaks the memory.

To help such cases, this patch adds a built-in argv_array to
the child_process, which gets cleaned up automatically (both
in finish_command and when start_command fails).  Callers
may use it if they choose, but can continue to use the raw
argv if they wish.

Signed-off-by: Jeff King <peff@peff.net>
---
This is the most RFC part of the series, because I really didn't know
what to call it. We have two arrays in the struct now: the "argv" array
which can point to anything, and the new internal argv_array struct,
which here I called "args". That name seems confusingly similar; I
wanted something short since it will be used in a lot of calls, but
couldn't think of anything better. Suggestions welcome.

I did toy with the idea of just forcing all callers to use the
argv_array, and calling it "argv". But that seemed unnecessarily
disruptive.

 Documentation/technical/api-run-command.txt | 7 +++++++
 run-command.c                               | 9 ++++++++-
 run-command.h                               | 3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 5d7d7f2..69510ae 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -109,6 +109,13 @@ terminated), of which .argv[0] is the program name to run (usually
 without a path). If the command to run is a git command, set argv[0] to
 the command name without the 'git-' prefix and set .git_cmd = 1.
 
+Note that the ownership of the memory pointed to by .argv stays with the
+caller, but it should survive until `finish_command` completes. If the
+.argv member is NULL, `start_command` will point it at the .args
+`argv_array` (so you may use one or the other, but you must use exactly
+one). The memory in .args will be cleaned up automatically during
+`finish_command` (or during `start_command` when it is unsuccessful).
+
 The members .in, .out, .err are used to redirect stdin, stdout,
 stderr as follows:
 
diff --git a/run-command.c b/run-command.c
index 75abc47..be07d4a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -279,6 +279,9 @@ int start_command(struct child_process *cmd)
 	int failed_errno;
 	char *str;
 
+	if (!cmd->argv)
+		cmd->argv = cmd->args.argv;
+
 	/*
 	 * In case of errors we must keep the promise to close FDs
 	 * that have been passed in via ->in and ->out.
@@ -328,6 +331,7 @@ int start_command(struct child_process *cmd)
 fail_pipe:
 			error("cannot create %s pipe for %s: %s",
 				str, cmd->argv[0], strerror(failed_errno));
+			argv_array_clear(&cmd->args);
 			errno = failed_errno;
 			return -1;
 		}
@@ -519,6 +523,7 @@ fail_pipe:
 			close_pair(fderr);
 		else if (cmd->err)
 			close(cmd->err);
+		argv_array_clear(&cmd->args);
 		errno = failed_errno;
 		return -1;
 	}
@@ -543,7 +548,9 @@ fail_pipe:
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0]);
+	int ret = wait_or_whine(cmd->pid, cmd->argv[0]);
+	argv_array_clear(&cmd->args);
+	return ret;
 }
 
 int run_command(struct child_process *cmd)
diff --git a/run-command.h b/run-command.h
index 3653bfa..ea73de3 100644
--- a/run-command.h
+++ b/run-command.h
@@ -5,8 +5,11 @@
 #include <pthread.h>
 #endif
 
+#include "argv-array.h"
+
 struct child_process {
 	const char **argv;
+	struct argv_array args;
 	pid_t pid;
 	/*
 	 * Using .in, .out, .err:
-- 
2.0.0.rc1.436.g03cb729
