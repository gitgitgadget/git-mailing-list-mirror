From: Jeff King <peff@peff.net>
Subject: [PATCH] run-command: treat inaccessible directories as ENOENT
Date: Fri, 30 Mar 2012 03:52:18 -0400
Message-ID: <20120330075217.GA8384@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Klaver <fransklaver@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 09:52:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDWdF-0006C4-LP
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 09:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759220Ab2C3HwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 03:52:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40985
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758920Ab2C3HwU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 03:52:20 -0400
Received: (qmail 12482 invoked by uid 107); 30 Mar 2012 07:52:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 03:52:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 03:52:18 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194337>

When execvp reports EACCES, it can be one of two things:

  1. We found a file to execute, but did not have
     permissions to do so.

  2. We did not have permissions to look in some directory
     in the $PATH.

In the former case, we want to consider this a
permissions problem and report it to the user as such (since
getting this for something like "git foo" is likely a
configuration error).

In the latter case, there is a good chance that the
inaccessible directory does not contain anything of
interest. Reporting "permission denied" is confusing to the
user (and prevents our usual "did you mean...?" lookup). It
also prevents git from trying alias lookup, since we do so
only when an external command does not exist (not when it
exists but has an error).

This patch detects EACCES from execvp, checks whether we are
in case (2), and if so converts errno to ENOENT. This
behavior matches that of "bash" (but not of simpler shells
that use execvp more directly, like "dash").

Test stolen from Junio.

Signed-off-by: Jeff King <peff@peff.net>
---
Here's the patch we've been discussing with a commit message and a few
minor modifications:

  1. I split the find-in-path function so that Frans can build on it
     with further checks if he wants. However, note that it will need a
     little more refactoring; it finds the first entry in the PATH,
     whereas I think he would want the first executable entry
     (admittedly, having a non-executable entry followed by an
     executable one which _also_ fails for a different reason is a
     pretty wild corner case).

  2. I pulled the test from what Junio posted earlier. I started to
     write a full test script that checked each of the cases I
     mentioned earlier. However, in all but the alias case (which is
     what is tested here), the behavior is really only distinguishable
     by the error messages, and I didn't want to get into testing what
     strerror(EACCES) prints. I can re-roll if we really want to go
     there.

 cache.h                |    2 ++
 exec_cmd.c             |    2 +-
 run-command.c          |   66 ++++++++++++++++++++++++++++++++++++++++++++++--
 t/t0061-run-command.sh |   13 ++++++++++
 4 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index e5e1aa4..59e1c44 100644
--- a/cache.h
+++ b/cache.h
@@ -1276,4 +1276,6 @@ extern struct startup_info *startup_info;
 /* builtin/merge.c */
 int checkout_fast_forward(const unsigned char *from, const unsigned char *to);
 
+int sane_execvp(const char *file, char *const argv[]);
+
 #endif /* CACHE_H */
diff --git a/exec_cmd.c b/exec_cmd.c
index 171e841..125fa6f 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -134,7 +134,7 @@ int execv_git_cmd(const char **argv) {
 	trace_argv_printf(nargv, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	execvp("git", (char **)nargv);
+	sane_execvp("git", (char **)nargv);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
diff --git a/run-command.c b/run-command.c
index 1db8abf..7123436 100644
--- a/run-command.c
+++ b/run-command.c
@@ -76,6 +76,68 @@ static inline void dup_devnull(int to)
 }
 #endif
 
+static char *locate_in_PATH(const char *file)
+{
+	const char *p = getenv("PATH");
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!p || !*p)
+		return 0;
+
+	while (1) {
+		const char *end = strchrnul(p, ':');
+
+		strbuf_reset(&buf);
+
+		/* POSIX specifies an empty entry as the current directory. */
+		if (end != p) {
+			strbuf_add(&buf, p, end - p);
+			strbuf_addch(&buf, '/');
+		}
+		strbuf_addstr(&buf, file);
+
+		if (!access(buf.buf, F_OK))
+			return strbuf_detach(&buf, NULL);
+
+		if (!*end)
+			break;
+		p = end + 1;
+	}
+
+	strbuf_release(&buf);
+	return NULL;
+}
+
+static int exists_in_PATH(const char *file)
+{
+	char *r = locate_in_PATH(file);
+	free(r);
+	return r != NULL;
+}
+
+int sane_execvp(const char *file, char * const argv[])
+{
+	if (!execvp(file, argv))
+		return 0;
+
+	/*
+	 * When a command can't be found because one of the directories
+	 * listed in $PATH is unsearchable, execvp reports EACCES, but
+	 * careful usability testing (read: analysis of occasional bug
+	 * reports) reveals that "No such file or directory" is more
+	 * intuitive.
+	 *
+	 * We avoid commands with "/", because execvp will not do $PATH
+	 * lookups in that case.
+	 *
+	 * The reassignment of EACCES to errno looks like a no-op below,
+	 * but we need to protect against exists_in_PATH overwriting errno.
+	 */
+	if (errno == EACCES && !strchr(file, '/'))
+		errno = exists_in_PATH(file) ? EACCES : ENOENT;
+	return -1;
+}
+
 static const char **prepare_shell_cmd(const char **argv)
 {
 	int argc, nargc = 0;
@@ -114,7 +176,7 @@ static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
 	trace_argv_printf(nargv, "trace: exec:");
-	execvp(nargv[0], (char **)nargv);
+	sane_execvp(nargv[0], (char **)nargv);
 	free(nargv);
 	return -1;
 }
@@ -339,7 +401,7 @@ fail_pipe:
 		} else if (cmd->use_shell) {
 			execv_shell_cmd(cmd->argv);
 		} else {
-			execvp(cmd->argv[0], (char *const*) cmd->argv);
+			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 8d4938f..17e969d 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -34,4 +34,17 @@ test_expect_success POSIXPERM 'run_command reports EACCES' '
 	grep "fatal: cannot exec.*hello.sh" err
 '
 
+test_expect_success POSIXPERM 'unreadable directory in PATH' '
+	mkdir local-command &&
+	test_when_finished "chmod u+rwx local-command && rm -fr local-command" &&
+	git config alias.nitfol "!echo frotz" &&
+	chmod a-rx local-command &&
+	(
+		PATH=./local-command:$PATH &&
+		git nitfol >actual
+	) &&
+	echo frotz >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.9.5.7.g11b89
