From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 9 Jan 2009 04:48:43 -0500
Message-ID: <20090109094843.GA4056@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <20090109092250.GA1809@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 10:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLE0z-00025x-7q
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbZAIJsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 04:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbZAIJsq
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 04:48:46 -0500
Received: from peff.net ([208.65.91.99]:45355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbZAIJsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 04:48:45 -0500
Received: (qmail 17706 invoked by uid 107); 9 Jan 2009 09:49:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 04:49:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 04:48:43 -0500
Content-Disposition: inline
In-Reply-To: <20090109092250.GA1809@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104995>

On Fri, Jan 09, 2009 at 04:22:50AM -0500, Jeff King wrote:

> So I think to do things right, we have to be even more complicated. When
> we spawn the pager, we keep git as a single process. We register the
> atexit() handler to wait for the pager, and intercept any death signals
> to do the same. Then, if we are running a builtin, it is business as
> usual. But if we want to exec something, instead we have to actually
> spawn into the three-process form. Meaning we have to use run_command to
> start it, and then wait for it and the pager to return.

Actually, this turned out to be quite a small patch. It fixes the
problem you were seeing, and it should work on Windows. It incurs an
extra fork() for every dashed-external that we try.

There is a little noise in the patch, so let me highlight the three
things that are happening (a "real" patch should break this into three
patches in a series):

  1. The noise is from renaming the static run_command, which conflicts
     with the definition in run_command.h

  2. Substituting run_command for execvp.

  3. run_command needs to signal "I couldn't exec this" as opposed to
     other errors, since we care about the difference here. I do this
     here with exit(127), but probably we should recognize this in
     wait_or_whine and hand out the same error code for posix and mingw
     platforms.

As for the extra fork, we could do away with it if we scanned the path
looking for the external before just exec'ing it. I think this is better
in the long run anyway, because then we can do other setup specific to
running an external command (I don't remember the details, but I ran
afoul of this when I was doing pager stuff a while ago).

Patch is below.

---
diff --git a/git.c b/git.c
index ecc8fad..fa946b9 100644
--- a/git.c
+++ b/git.c
@@ -2,6 +2,7 @@
 #include "exec_cmd.h"
 #include "cache.h"
 #include "quote.h"
+#include "run-command.h"
 
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate|--no-pager] [--bare] [--git-dir=GIT_DIR] [--work-tree=GIT_WORK_TREE] [--help] COMMAND [ARGS]";
@@ -219,7 +220,7 @@ struct cmd_struct {
 	int option;
 };
 
-static int run_command(struct cmd_struct *p, int argc, const char **argv)
+static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status;
 	struct stat st;
@@ -384,7 +385,7 @@ static void handle_internal_command(int argc, const char **argv)
 		struct cmd_struct *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
-		exit(run_command(p, argc, argv));
+		exit(run_builtin(p, argc, argv));
 	}
 }
 
@@ -392,6 +393,7 @@ static void execv_dashed_external(const char **argv)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	const char *tmp;
+	int status;
 
 	strbuf_addf(&cmd, "git-%s", argv[0]);
 
@@ -406,8 +408,13 @@ static void execv_dashed_external(const char **argv)
 
 	trace_argv_printf(argv, "trace: exec:");
 
-	/* execvp() can only ever return if it fails */
-	execvp(cmd.buf, (char **)argv);
+	/*
+	 * if we failed because the command was not found, it is
+	 * OK to return. Otherwise, we just pass along the status code.
+	 */
+	status = run_command_v_opt(argv, 0);
+	if (status != 127 && status != -ERR_RUN_COMMAND_FORK)
+		exit(-status);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
diff --git a/run-command.c b/run-command.c
index c90cdc5..539609e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -118,7 +118,7 @@ int start_command(struct child_process *cmd)
 		} else {
 			execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
-		die("exec %s failed.", cmd->argv[0]);
+		exit(127);
 	}
 #else
 	int s0 = -1, s1 = -1, s2 = -1;	/* backups of stdin, stdout, stderr */
