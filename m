From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] prompt: fall back to terminal if askpass fails
Date: Fri, 3 Feb 2012 17:16:02 -0500
Message-ID: <20120203221602.GB8065@sigill.intra.peff.net>
References: <20120203213654.GD1890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Feanil Patel <feanil@gmail.com>, git@vger.kernel.org
To: Neal Groothuis <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Fri Feb 03 23:16:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtRQQ-0007p6-Sm
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 23:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874Ab2BCWQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 17:16:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56060
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754078Ab2BCWQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 17:16:05 -0500
Received: (qmail 2909 invoked by uid 107); 3 Feb 2012 22:23:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Feb 2012 17:23:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Feb 2012 17:16:02 -0500
Content-Disposition: inline
In-Reply-To: <20120203213654.GD1890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189816>

The current askpass code simply dies if calling an askpass
helper fails. Worse, in some failure modes it doesn't even
print an error (if start_command fails, then it prints its
own error; if reading fails, we print an error; but if the
command exits non-zero, finish_command fails and we print
nothing!).

Let's be more kind to the user by printing an error message
when askpass doesn't work out, and then falling back to the
terminal (which also may fail, of course, but we die already
there with a nice message).

While we're at it, let's clean up the existing error
messages a bit.  Now that our prompts are very long and
contain quotes and colons themselves, our error messages are
hard to read.

So the new failure modes look like:

  [before, with a terminal]
  $ GIT_ASKPASS=false git push
  $ echo $?
  128

  [before, with no terminal, and we must give up]
  $ setsid git push
  fatal: could not read 'Password for 'https://peff@github.com': ': No such device or address

  [after, with a terminal]
  $ GIT_ASKPASS=false git push
  error: unable to read askpass response from 'false'
  Password for 'https://peff@github.com':

  [after, with no terminal, and we must give up]
  $ GIT_ASKPASS=false setsid git push
  error: unable to read askpass response from 'false'
  fatal: could not read Password for 'https://peff@github.com': No such device or address

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably, the terminal-failure error message shouldn't even bother
reporting errno. I can't imagine it failing for any reason other than
ENODEV, and the message would probably be less confusing as:

  fatal: could not prompt on terminal for Password for...

 prompt.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/prompt.c b/prompt.c
index 64f817b..d851807 100644
--- a/prompt.c
+++ b/prompt.c
@@ -9,6 +9,7 @@ static char *do_askpass(const char *cmd, const char *prompt)
 	struct child_process pass;
 	const char *args[3];
 	static struct strbuf buffer = STRBUF_INIT;
+	int err = 0;
 
 	args[0] = cmd;
 	args[1]	= prompt;
@@ -19,15 +20,21 @@ static char *do_askpass(const char *cmd, const char *prompt)
 	pass.out = -1;
 
 	if (start_command(&pass))
-		exit(1);
+		return NULL;
 
 	if (strbuf_read(&buffer, pass.out, 20) < 0)
-		die("failed to get '%s' from %s\n", prompt, cmd);
+		err = 1;
 
 	close(pass.out);
 
 	if (finish_command(&pass))
-		exit(1);
+		err = 1;
+
+	if (err) {
+		error("unable to read askpass response from '%s'", cmd);
+		strbuf_release(&buffer);
+		return NULL;
+	}
 
 	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));
 
@@ -36,7 +43,7 @@ static char *do_askpass(const char *cmd, const char *prompt)
 
 char *git_prompt(const char *prompt, int flags)
 {
-	char *r;
+	char *r = NULL;
 
 	if (flags & PROMPT_ASKPASS) {
 		const char *askpass;
@@ -47,12 +54,15 @@ char *git_prompt(const char *prompt, int flags)
 		if (!askpass)
 			askpass = getenv("SSH_ASKPASS");
 		if (askpass && *askpass)
-			return do_askpass(askpass, prompt);
+			r = do_askpass(askpass, prompt);
 	}
 
-	r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
 	if (!r)
-		die_errno("could not read '%s'", prompt);
+		r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
+	if (!r) {
+		/* prompts already contain ": " at the end */
+		die("could not read %s%s", prompt, strerror(errno));
+	}
 	return r;
 }
 
-- 
1.7.9.rc1.28.gf4be5
