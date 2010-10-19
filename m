From: Jeff King <peff@peff.net>
Subject: Re: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external
 command
Date: Tue, 19 Oct 2010 09:40:40 -0400
Message-ID: <20101019134040.GA3956@sigill.intra.peff.net>
References: <20101019045300.GA18043@gnu.kitenet.net>
 <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
 <20101019115943.GA8065@dpotapov.dyndns.org>
 <20101019133236.GA804@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Joey Hess <joey@kitenet.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 15:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8CQD-0001vW-WB
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 15:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933989Ab0JSNkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 09:40:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59006 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933994Ab0JSNkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 09:40:03 -0400
Received: (qmail 13344 invoked by uid 111); 19 Oct 2010 13:40:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 19 Oct 2010 13:40:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Oct 2010 09:40:40 -0400
Content-Disposition: inline
In-Reply-To: <20101019133236.GA804@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159330>

On Tue, Oct 19, 2010 at 09:32:36AM -0400, Jeff King wrote:

> How does this interact with the sigchain code? If I do:
> 
>   start_command(...);
>   sigchain_push(...);
>   finish_command(...);
> 
> we will overwrite the function pushed in the sigchain_push with a stale
> handler. I think you could just replace your signal() calls with:
> 
>   sigchain_push(SIGINT, SIG_IGN);
>   ...
>   sigchain_pop(SIGINT);

Which, FWIW, would look like this:

diff --git a/run-command.c b/run-command.c
index 2a1041e..24e0f46 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "exec_cmd.h"
+#include "sigchain.h"
 
 static inline void close_pair(int fd[2])
 {
@@ -102,6 +103,9 @@ static int wait_or_whine(pid_t pid, const char *argv0, int silent_exec_failure)
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
 
+	sigchain_pop(SIGINT);
+	sigchain_pop(SIGQUIT);
+
 	if (waiting < 0) {
 		failed_errno = errno;
 		error("waitpid for %s failed: %s", argv0, strerror(errno));
@@ -202,8 +206,12 @@ fail_pipe:
 		notify_pipe[0] = notify_pipe[1] = -1;
 
 	fflush(NULL);
+	sigchain_push(SIGINT, SIG_IGN);
+	sigchain_push(SIGQUIT, SIG_IGN);
 	cmd->pid = fork();
 	if (!cmd->pid) {
+		sigchain_pop(SIGINT);
+		sigchain_pop(SIGQUIT);
 		/*
 		 * Redirect the channel to write syscall error messages to
 		 * before redirecting the process's stderr so that all die()
