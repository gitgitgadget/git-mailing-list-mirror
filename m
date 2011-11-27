From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] refactor git_getpass into generic prompt function
Date: Sun, 27 Nov 2011 03:29:32 -0500
Message-ID: <20111127082932.GB1702@sigill.intra.peff.net>
References: <20111127082744.GA32068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 09:29:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUa7G-0002u6-QT
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab1K0I3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:29:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53663
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753972Ab1K0I3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:29:34 -0500
Received: (qmail 13094 invoked by uid 107); 27 Nov 2011 08:36:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Nov 2011 03:36:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2011 03:29:32 -0500
Content-Disposition: inline
In-Reply-To: <20111127082744.GA32068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185972>

This will allow callers to specify more options (e.g.,
leaving echo on). The original git_getpass becomes a slim
wrapper around the new function.

Signed-off-by: Jeff King <peff@peff.net>
---
Making askpass optional isn't necessary for this series, but splitting
it actually makes the code a little cleaner, imho, and some callers
might eventually want to turn it off.

 prompt.c |   41 +++++++++++++++++++++++++----------------
 prompt.h |    3 +++
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/prompt.c b/prompt.c
index 42a1c9f..7c8f9aa 100644
--- a/prompt.c
+++ b/prompt.c
@@ -3,26 +3,13 @@
 #include "strbuf.h"
 #include "prompt.h"
 
-char *git_getpass(const char *prompt)
+static char *do_askpass(const char *cmd, const char *prompt, const char *name)
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
+		die("failed to read %s from %s\n", name, cmd);
 
 	close(pass.out);
 
@@ -46,3 +33,25 @@
 
 	return buffer.buf;
 }
+
+char *git_prompt(const char *prompt, const char *name, int flags)
+{
+	if (flags & PROMPT_ASKPASS) {
+		const char *askpass;
+
+		askpass = getenv("GIT_ASKPASS");
+		if (!askpass)
+			askpass = askpass_program;
+		if (!askpass)
+			askpass = getenv("SSH_ASKPASS");
+		if (askpass && *askpass)
+			return do_askpass(askpass, prompt, name);
+	}
+
+	return getpass(prompt);
+}
+
+char *git_getpass(const char *prompt)
+{
+	return git_prompt(prompt, "password", PROMPT_ASKPASS);
+}
diff --git a/prompt.h b/prompt.h
index 0fd7bd9..18868c2 100644
--- a/prompt.h
+++ b/prompt.h
@@ -1,6 +1,9 @@
 #ifndef PROMPT_H
 #define PROMPT_H
 
+#define PROMPT_ASKPASS (1<<0)
+
+char *git_prompt(const char *prompt, const char *name, int flags);
 char *git_getpass(const char *prompt);
 
 #endif /* PROMPT_H */
-- 
1.7.7.4.7.g24824
