From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 16:18:51 -0400
Message-ID: <20120328201851.GA29315@sigill.intra.peff.net>
References: <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:19:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzKd-00067S-0k
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab2C1USy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:18:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36329
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932376Ab2C1USx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:18:53 -0400
Received: (qmail 21290 invoked by uid 107); 28 Mar 2012 20:19:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 16:19:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 16:18:51 -0400
Content-Disposition: inline
In-Reply-To: <20120328194516.GD8982@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194185>

On Wed, Mar 28, 2012 at 02:45:16PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > That's what the patch I posted earlier does. But it means we _also_
> > report "permission denied" for inaccessible directories, which is
> > needlessly confusing (and much more common, I would think).
> 
> So the message could say
> 
> 	$ nosuch
> 	nosuch: Permission denied
> 	hint: A permissions problem was encountered searching for or
> 	hint: executing that command on the $PATH.
> 	hint: Check your PATH setting and permissions.
> 
> or even
> 
> 	$ nosuch
> 	nosuch: No such file or directory or permission denied

That is slightly better than the current behavior, but for people in
James's situation, it's still quite ugly. How about this patch, which
just treats the inaccessible directory case as ENOENT. This matches
bash's behavior. And we don't need any other patches. In James's
situation, the problem just goes away, and we still get an error on a
nonexecutable file.

It won't continue trying aliases in the latter case, but we could put my
other patches on top if we want to. It's less compelling to do so,
though, because having "git-foo" in your path and not executable
probably _is_ a configuration error that you should deal with.

-Peff

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
index 1db8abf..4bdbea8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -76,6 +76,39 @@ static inline void dup_devnull(int to)
 }
 #endif
 
+static int file_in_path_is_nonexecutable(const char *file)
+{
+	const char *p = getenv("PATH");
+
+	if (!p)
+		return 0;
+
+	while (1) {
+		const char *end = strchrnul(p, ':');
+		const char *path;
+		struct stat st;
+
+		path = mkpath("%.*s/%s", (int)(end - p), p, file);
+		if (!stat(path, &st) && access(path, X_OK) < 0)
+			return 1;
+
+		if (!*end)
+			break;
+
+		p = end + 1;
+	}
+
+	return 0;
+}
+
+int sane_execvp(const char *file, char * const argv[])
+{
+	int ret = execvp(file, argv);
+	if (ret < 0 && errno == EACCES && !file_in_path_is_nonexecutable(file))
+		errno = ENOENT;
+	return ret;
+}
+
 static const char **prepare_shell_cmd(const char **argv)
 {
 	int argc, nargc = 0;
@@ -114,7 +147,7 @@ static int execv_shell_cmd(const char **argv)
 {
 	const char **nargv = prepare_shell_cmd(argv);
 	trace_argv_printf(nargv, "trace: exec:");
-	execvp(nargv[0], (char **)nargv);
+	sane_execvp(nargv[0], (char **)nargv);
 	free(nargv);
 	return -1;
 }
@@ -339,7 +372,7 @@ fail_pipe:
 		} else if (cmd->use_shell) {
 			execv_shell_cmd(cmd->argv);
 		} else {
-			execvp(cmd->argv[0], (char *const*) cmd->argv);
+			sane_execvp(cmd->argv[0], (char *const*) cmd->argv);
 		}
 		if (errno == ENOENT) {
 			if (!cmd->silent_exec_failure)
