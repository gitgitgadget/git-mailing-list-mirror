From: Jeff King <peff@peff.net>
Subject: [PATCH 5/6] credential: use git_prompt instead of git_getpass
Date: Sun, 27 Nov 2011 03:31:13 -0500
Message-ID: <20111127083113.GE1702@sigill.intra.peff.net>
References: <20111127082744.GA32068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 09:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUa8t-0003Ib-NI
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584Ab1K0IbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:31:15 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53669
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752433Ab1K0IbP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:31:15 -0500
Received: (qmail 13178 invoked by uid 107); 27 Nov 2011 08:37:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 27 Nov 2011 03:37:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2011 03:31:13 -0500
Content-Disposition: inline
In-Reply-To: <20111127082744.GA32068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185975>

When we request a username and password from the user on the
terminal, we can't use stdin/stdout, because they may be
connected to pipes to other git processes.

Instead, we use getpass() (via git_getpass), which will
generally open /dev/tty and read and write from that.  The
only problem is that getpass is meant to take passwords, and
therefore will not echo characters from the username, which
is annoying.

Now that git_prompt understand the "echo" flag, we can use
that to let the user see their username as they type it.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/credential.c b/credential.c
index d918ba5..9ad580d 100644
--- a/credential.c
+++ b/credential.c
@@ -109,7 +109,8 @@ static void credential_describe(struct credential *c, struct strbuf *out)
 		strbuf_addf(out, "/%s", c->path);
 }
 
-static char *credential_ask_one(const char *what, struct credential *c)
+static char *credential_ask_one(const char *what, struct credential *c,
+				int flags)
 {
 	struct strbuf desc = STRBUF_INIT;
 	struct strbuf prompt = STRBUF_INIT;
@@ -121,11 +122,7 @@ static void credential_describe(struct credential *c, struct strbuf *out)
 	else
 		strbuf_addf(&prompt, "%s: ", what);
 
-	/* FIXME: for usernames, we should do something less magical that
-	 * actually echoes the characters. However, we need to read from
-	 * /dev/tty and not stdio, which is not portable (but getpass will do
-	 * it for us). http.c uses the same workaround. */
-	r = git_getpass(prompt.buf);
+	r = git_prompt(prompt.buf, what, flags);
 
 	strbuf_release(&desc);
 	strbuf_release(&prompt);
@@ -135,9 +132,11 @@ static void credential_describe(struct credential *c, struct strbuf *out)
 static void credential_getpass(struct credential *c)
 {
 	if (!c->username)
-		c->username = credential_ask_one("Username", c);
+		c->username = credential_ask_one("Username", c,
+						 PROMPT_ASKPASS|PROMPT_ECHO);
 	if (!c->password)
-		c->password = credential_ask_one("Password", c);
+		c->password = credential_ask_one("Password", c,
+						 PROMPT_ASKPASS);
 }
 
 int credential_read(struct credential *c, FILE *fp)
-- 
1.7.7.4.7.g24824
