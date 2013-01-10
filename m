From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Thu, 10 Jan 2013 06:26:55 -0500
Message-ID: <20130110112655.GB21993@sigill.intra.peff.net>
References: <20130104124756.GA402@sigill.intra.peff.net>
 <7vr4lu3wx7.fsf@alter.siamese.dyndns.org>
 <20130109205116.GA24605@sigill.intra.peff.net>
 <7vehhu3u2y.fsf@alter.siamese.dyndns.org>
 <20130110001844.GC21054@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bart Trojanowski <bart@jukie.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 12:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtGI2-0003Hb-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 12:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab3AJL06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 06:26:58 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53461 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab3AJL06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 06:26:58 -0500
Received: (qmail 7118 invoked by uid 107); 10 Jan 2013 11:28:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jan 2013 06:28:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jan 2013 06:26:55 -0500
Content-Disposition: inline
In-Reply-To: <20130110001844.GC21054@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213135>

On Wed, Jan 09, 2013 at 04:18:44PM -0800, Jonathan Nieder wrote:

> > Do we know if we are upstream of a pager that reads from us through
> > a pipe (I think we should, especially in a case where we are the one
> > who processed the "git -p $alias" option)?  Is there any other case
> > where we would want to ignore child's death by SIGPIPE?
> 
> When we die early by SIGPIPE because output was piped to "head", I
> still think the early end of output is not notable enough to complain
> about.
> 
> I'm not sure whether there are SIGPIPE instances we really don't want
> to be silent about, though.  I suspect not. ;-)

Some of our plumbing writes over pipes (e.g., pack-objects writing back
to send-pack, which is multiplexing over the network, or receive-pack
writing to index-pack). We _should_ be checking the value of every
write(), and your final close(), and making sure that sub-processes
reports success. But leaving SIGPIPE on is an extra safety measure; in
theory it can catch an unchecked write.

When one of those programs goes wrong, the message can be an extra
debugging aid. If the process died unexpectedly with no message (since
it died by signal), seeing "pack-objects died by signal 13" is much
better than not seeing anything at all. Usually it is accompanied by
other messages (like "remote end hung up unexpectedly" or similar), but
the extra output has helped me track down server-side issues in the
past.

> Compare <http://thread.gmane.org/gmane.comp.version-control.git/2062>,
> <http://thread.gmane.org/gmane.comp.version-control.git/48469/focus=48665>.

The argument there seems to be that bash is stupid for complaining about
SIGPIPE. And I would agree for the "alias" case, where we are running
commands from the command-line in a very shell-like manner. But
wait_or_whine is also used for connecting internal bits together.

Maybe the right rule is "if we are using the shell to execute, do not
mention SIGPIPE"? It seems a little iffy at first, but:

  1. It tends to coincide with direct use of internal tools versus
     external tools.

  2. We do not reliably get SIGPIPE there, anyway, since most shells
     will convert it into exit code 141 before we see it.

I.e., something like:

diff --git a/run-command.c b/run-command.c
index 24eaad5..8bd0b08 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,7 +226,7 @@ static inline void set_cloexec(int fd)
 		fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 }
 
-static int wait_or_whine(pid_t pid, const char *argv0)
+static int wait_or_whine(pid_t pid, const char *argv0, int ignore_sigpipe)
 {
 	int status, code = -1;
 	pid_t waiting;
@@ -242,7 +242,8 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		error("waitpid is confused (%s)", argv0);
 	} else if (WIFSIGNALED(status)) {
 		code = WTERMSIG(status);
-		if (code != SIGINT && code != SIGQUIT)
+		if (code != SIGINT && code != SIGQUIT &&
+		    (!ignore_sigpipe || code != SIGPIPE))
 			error("%s died of signal %d", argv0, code);
 		/*
 		 * This return value is chosen so that code & 0xff
@@ -433,7 +434,7 @@ fail_pipe:
 		 * At this point we know that fork() succeeded, but execvp()
 		 * failed. Errors have been reported to our stderr.
 		 */
-		wait_or_whine(cmd->pid, cmd->argv[0]);
+		wait_or_whine(cmd->pid, cmd->argv[0], 0);
 		failed_errno = errno;
 		cmd->pid = -1;
 	}
@@ -538,7 +539,7 @@ int finish_command(struct child_process *cmd)
 
 int finish_command(struct child_process *cmd)
 {
-	return wait_or_whine(cmd->pid, cmd->argv[0]);
+	return wait_or_whine(cmd->pid, cmd->argv[0], cmd->use_shell);
 }
 
 int run_command(struct child_process *cmd)
@@ -725,7 +726,7 @@ int finish_async(struct async *async)
 int finish_async(struct async *async)
 {
 #ifdef NO_PTHREADS
-	return wait_or_whine(async->pid, "child process");
+	return wait_or_whine(async->pid, "child process", 0);
 #else
 	void *ret = (void *)(intptr_t)(-1);
 
