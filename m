From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] refactor git_getpass into generic prompt function
Date: Thu, 8 Dec 2011 03:31:33 -0500
Message-ID: <20111208083133.GD26409@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:31:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZON-00016Q-BH
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab1LHIbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:31:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43107
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab1LHIbg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:31:36 -0500
Received: (qmail 25792 invoked by uid 107); 8 Dec 2011 08:38:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:38:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:31:33 -0500
Content-Disposition: inline
In-Reply-To: <20111208082118.GA1507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186540>

This will allow callers to specify more options (e.g.,
leaving echo on). The original git_getpass becomes a slim
wrapper around the new function.

Signed-off-by: Jeff King <peff@peff.net>
---
Similar to patch 2 from the previous series. Two big differences:

 1. The first series accidentally dropped the "die if we don't get a
    password" behavior during the refactor, but we want to keep it.

 2. The first series had a special "name" parameter just for generating
    error messages. This drops it in the name of simplicity, so error
    messages have gone from (assuming you don't have a tty):

      Could not read password: No such device or address

    to:

      Could not read 'Username for 'https://example.com': ': No such
      device or address

    which is verbose, yes, but contains a little more useful
    information. The formatting is rather unfortunate, but I don't think
    it's worth worrying too much about.

 prompt.c |   46 ++++++++++++++++++++++++++++++----------------
 prompt.h |    3 +++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/prompt.c b/prompt.c
index 42a1c9f..2002644 100644
--- a/prompt.c
+++ b/prompt.c
@@ -3,26 +3,13 @@
 #include "strbuf.h"
 #include "prompt.h"
 
-char *git_getpass(const char *prompt)
+static char *do_askpass(const char *cmd, const char *prompt)
 {
-	const char *askpass;
 	struct child_process pass;
 	const char *args[3];
 	static struct strbuf buffer = STRBUF_INIT;
 
-	askpass = getenv("GIT_ASKPASS");
-	if (!askpass)
-		askpass = askpass_program;
-	if (!askpass)
-		askpass = getenv("SSH_ASKPASS");
-	if (!askpass || !(*askpass)) {
-		char *result = getpass(prompt);
-		if (!result)
-			die_errno("Could not read password");
-		return result;
-	}
-
-	args[0] = askpass;
+	args[0] = cmd;
 	args[1]	= prompt;
 	args[2] = NULL;
 
@@ -35,7 +22,7 @@
 
 	strbuf_reset(&buffer);
 	if (strbuf_read(&buffer, pass.out, 20) < 0)
-		die("failed to read password from %s\n", askpass);
+		die("failed to get '%s' from %s\n", prompt, cmd);
 
 	close(pass.out);
 
@@ -46,3 +33,30 @@
 
 	return buffer.buf;
 }
+
+char *git_prompt(const char *prompt, int flags)
+{
+	char *r;
+
+	if (flags & PROMPT_ASKPASS) {
+		const char *askpass;
+
+		askpass = getenv("GIT_ASKPASS");
+		if (!askpass)
+			askpass = askpass_program;
+		if (!askpass)
+			askpass = getenv("SSH_ASKPASS");
+		if (askpass && *askpass)
+			return do_askpass(askpass, prompt);
+	}
+
+	r = getpass(prompt);
+	if (!r)
+		die_errno("could not read '%s'", prompt);
+	return r;
+}
+
+char *git_getpass(const char *prompt)
+{
+	return git_prompt(prompt, PROMPT_ASKPASS);
+}
diff --git a/prompt.h b/prompt.h
index 0fd7bd9..9ab85a7 100644
--- a/prompt.h
+++ b/prompt.h
@@ -1,6 +1,9 @@
 #ifndef PROMPT_H
 #define PROMPT_H
 
+#define PROMPT_ASKPASS (1<<0)
+
+char *git_prompt(const char *prompt, int flags);
 char *git_getpass(const char *prompt);
 
 #endif /* PROMPT_H */
-- 
1.7.8.rc2.8.gf0f4f
