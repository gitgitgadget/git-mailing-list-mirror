From: Jeff King <peff@peff.net>
Subject: [PATCHv2 4/9] refactor git_getpass into generic prompt function
Date: Sat, 10 Dec 2011 05:40:57 -0500
Message-ID: <20111210104057.GD16648@sigill.intra.peff.net>
References: <20111210103943.GA16478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 11:41:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZKMd-0000DV-1Q
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 11:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab1LJKlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 05:41:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47053
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1LJKk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 05:40:59 -0500
Received: (qmail 14366 invoked by uid 107); 10 Dec 2011 10:47:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 10 Dec 2011 05:47:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2011 05:40:57 -0500
Content-Disposition: inline
In-Reply-To: <20111210103943.GA16478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186751>

This will allow callers to specify more options (e.g.,
leaving echo on). The original git_getpass becomes a slim
wrapper around the new function.

Signed-off-by: Jeff King <peff@peff.net>
---
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
1.7.8.rc2.40.gaf387
