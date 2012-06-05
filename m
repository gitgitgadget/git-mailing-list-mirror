From: Jeff King <peff@peff.net>
Subject: [PATCH] pager: drop "wait for output to run less" hack
Date: Tue, 5 Jun 2012 04:56:04 -0400
Message-ID: <20120605085604.GA27298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 10:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbpYn-0004DX-2S
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 10:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757875Ab2FEI4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 04:56:13 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43155
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab2FEI4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 04:56:12 -0400
Received: (qmail 15428 invoked by uid 107); 5 Jun 2012 08:56:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 04:56:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 04:56:04 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199218>

On Tue, Jun 05, 2012 at 02:56:28AM -0400, Jeff King wrote:

> > +static int fd_to_close;
> > +void close_fd_prexec_cb(void)
> > +{
> > +	if(debug)
> > +		fprintf(stderr, "close_fd_prexec_cb closing %d\n", fd_to_close);
> > +	close(fd_to_close);
> > +}
> 
> Note that preexec_cb does not work at all on Windows, as it assumes a
> forking model (rather than a spawn, which leaves no room to execute
> arbitrary code in the child). If all you want to do is open an extra
> pipe, then probably run-command should be extended to handle this
> (though I have no idea how complex that would be for the Windows side of
> things, it is at least _possible_, as opposed to preexec_cb, which will
> never be possible).

I'm really tempted to do this:

-- >8 --
Commit 35ce862 (pager: Work around window resizing bug in
'less', 2007-01-24) causes git's pager sub-process to wait
to receive input after forking but before exec-ing the
pager. To handle this, run-command had to grow a "pre-exec
callback" feature. Unfortunately, this feature does not work
at all on Windows (where we do not fork), and interacts
poorly with run-command's parent notification system. Its
use should be discouraged.

The bug in less was fixed in version 406, which was released
in June 2007. It is probably safe at this point to remove
our workaround. That lets us rip out the preexec_cb feature
entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
I checked, and even RHEL5 is on less 436. So besides people on antique
"I installed less from source more than 5 years ago" systems, my only
concern would be that some other pager depends on this hack in a weird
way. But I have never heard of such a thing, so...

 pager.c       | 18 ------------------
 run-command.c | 10 ----------
 run-command.h |  1 -
 3 files changed, 29 deletions(-)

diff --git a/pager.c b/pager.c
index 4dcb08d..c0b4387 100644
--- a/pager.c
+++ b/pager.c
@@ -11,21 +11,6 @@
  * something different on Windows.
  */
 
-#ifndef WIN32
-static void pager_preexec(void)
-{
-	/*
-	 * Work around bug in "less" by not starting it until we
-	 * have real input
-	 */
-	fd_set in;
-
-	FD_ZERO(&in);
-	FD_SET(0, &in);
-	select(1, &in, NULL, &in, NULL);
-}
-#endif
-
 static const char *pager_argv[] = { NULL, NULL };
 static struct child_process pager_process;
 
@@ -93,9 +78,6 @@ void setup_pager(void)
 		static const char *env[] = { "LESS=FRSX", NULL };
 		pager_process.env = env;
 	}
-#ifndef WIN32
-	pager_process.preexec_cb = pager_preexec;
-#endif
 	if (start_command(&pager_process))
 		return;
 
diff --git a/run-command.c b/run-command.c
index 606791d..dff28a7 100644
--- a/run-command.c
+++ b/run-command.c
@@ -394,16 +394,6 @@ fail_pipe:
 					unsetenv(*cmd->env);
 			}
 		}
-		if (cmd->preexec_cb) {
-			/*
-			 * We cannot predict what the pre-exec callback does.
-			 * Forgo parent notification.
-			 */
-			close(child_notifier);
-			child_notifier = -1;
-
-			cmd->preexec_cb();
-		}
 		if (cmd->git_cmd) {
 			execv_git_cmd(cmd->argv);
 		} else if (cmd->use_shell) {
diff --git a/run-command.h b/run-command.h
index 44f7d2b..850c638 100644
--- a/run-command.h
+++ b/run-command.h
@@ -39,7 +39,6 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned use_shell:1;
 	unsigned clean_on_exit:1;
-	void (*preexec_cb)(void);
 };
 
 int start_command(struct child_process *);
-- 
1.7.11.rc1.3.gf8b4f5c

Reply-To: 
In-Reply-To: <20120605065628.GA25809@sigill.intra.peff.net>
