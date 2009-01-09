From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 9 Jan 2009 04:22:50 -0500
Message-ID: <20090109092250.GA1809@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 10:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLDbH-0002T1-QJ
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbZAIJW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 04:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbZAIJWz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 04:22:55 -0500
Received: from peff.net ([208.65.91.99]:47738 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbZAIJWx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 04:22:53 -0500
Received: (qmail 17525 invoked by uid 107); 9 Jan 2009 09:23:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 04:23:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 04:22:50 -0500
Content-Disposition: inline
In-Reply-To: <20090109083836.GB21389@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104991>

On Fri, Jan 09, 2009 at 03:38:36AM -0500, Jeff King wrote:

> So the _real_ problem is that we are not always triggering the "wait for
> pager to finish" code because we exec and forget about it. Which means
> this strategy of "git runs child pager" will never work properly.
> Instead, we have to use three processes: git and the pager become child
> processes, while the original process waits for both to exit and returns
> the proper exit code from git.
> 
> Let me try to work up a patch.

Below is a patch that uses the three-process mechanism, and it fixes the
problem. _But_ it is not satisfactory for inclusion, because it won't
work on MINGW32. Since it is actually splitting git into two processes
(one to monitor the pager and one to actually run git), it uses fork.

So I think to do things right, we have to be even more complicated. When
we spawn the pager, we keep git as a single process. We register the
atexit() handler to wait for the pager, and intercept any death signals
to do the same. Then, if we are running a builtin, it is business as
usual. But if we want to exec something, instead we have to actually
spawn into the three-process form. Meaning we have to use run_command to
start it, and then wait for it and the pager to return.

Of course, we don't know ahead of time whether exec'ing a command will
work: we find out by trying. So now we will end up creating a pipe and
fork()ing every time we want to see whether we can exec a command. But I
suppose that only happens once or twice, so maybe the performance impact
isn't relevant.

This is all getting complicated enough that I am tempted to just suggest
reverting ea27a18c. But even that won't fix everything, though, since
MINGW32 still needs to use run_command to spawn the pager. IOW, I think
the breakage you are seeing has always been broken on MINGW32.

Blah. Anyway, here is the Unix-only patch.

---
diff --git a/pager.c b/pager.c
index f19ddbc..68ae669 100644
--- a/pager.c
+++ b/pager.c
@@ -28,18 +28,10 @@ static void pager_preexec(void)
 static const char *pager_argv[] = { "sh", "-c", NULL, NULL };
 static struct child_process pager_process;
 
-static void wait_for_pager(void)
-{
-	fflush(stdout);
-	fflush(stderr);
-	/* signal EOF to pager */
-	close(1);
-	close(2);
-	finish_command(&pager_process);
-}
-
 void setup_pager(void)
 {
+	pid_t git_child;
+	int status;
 	const char *pager = getenv("GIT_PAGER");
 
 	if (!isatty(1))
@@ -68,14 +60,24 @@ void setup_pager(void)
 	if (start_command(&pager_process))
 		return;
 
-	/* original process continues, but writes to the pipe */
-	dup2(pager_process.in, 1);
-	if (isatty(2))
-		dup2(pager_process.in, 2);
-	close(pager_process.in);
+	/* now spawn the actual git process */
+	git_child = fork();
+	if (git_child == -1)
+		die("unable to fork: %s", strerror(errno));
+	if (git_child == 0) {
+		dup2(pager_process.in, 1);
+		if (isatty(2))
+			dup2(pager_process.in, 2);
+		close(pager_process.in);
+		return;
+	}
 
-	/* this makes sure that the parent terminates after the pager */
-	atexit(wait_for_pager);
+	/* and the original process just waits for both to finish */
+	close(pager_process.in);
+	if (waitpid(git_child, &status, 0) < 0)
+		die("wait failure: %s", strerror(errno));
+	finish_command(&pager_process);
+	exit(status);
 }
 
 int pager_in_use(void)
