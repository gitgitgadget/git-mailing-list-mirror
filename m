From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 17:57:04 -0400
Message-ID: <20120328215704.GB10795@sigill.intra.peff.net>
References: <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:57:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0ri-0005WM-AH
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278Ab2C1V5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:57:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36439
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab2C1V5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:57:07 -0400
Received: (qmail 22687 invoked by uid 107); 28 Mar 2012 21:57:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 17:57:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 17:57:04 -0400
Content-Disposition: inline
In-Reply-To: <20120328201851.GA29315@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194206>

Here's a rework of the patch based on the comments so far.

It handles empty path elements properly, and it handles the munging of
errno properly.  It uses a strbuf to avoid any path limitations (in
practice, I don't expect this to be much of an issue, but it matches
what glibc does. And this is the slow error-path anyway, so it's not a
big deal). And it has miscellaneous style fixes and comments.

No tests yet. I'll post some output on that in a minute.

---
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
index 1db8abf..2b0c311 100644
--- a/run-command.c
+++ b/run-command.c
@@ -76,6 +76,63 @@ static inline void dup_devnull(int to)
 }
 #endif
 
+static int exists_in_PATH(const char *file)
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
+		if (!access(buf.buf, F_OK)) {
+			strbuf_release(&buf);
+			return 1;
+		}
+
+		if (!*end)
+			break;
+		p = end + 1;
+	}
+
+	strbuf_release(&buf);
+	return 0;
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
@@ -114,7 +171,7 @@ static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
 	trace_argv_printf(nargv, "trace: exec:");
-	execvp(nargv[0], (char **)nargv);
+	sane_execvp(nargv[0], (char **)nargv);
 	free(nargv);
 	return -1;
 }
@@ -339,7 +396,7 @@ fail_pipe:
 		} else if (cmd->use_shell) {
 			execv_shell_cmd(cmd->argv);
 		} else {
-			execvp(cmd->argv[0], (char *const*) cmd->argv);
+			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
