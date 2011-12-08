From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] credential: use git_prompt instead of git_getpass
Date: Thu, 8 Dec 2011 03:33:51 -0500
Message-ID: <20111208083351.GG26409@sigill.intra.peff.net>
References: <20111208082118.GA1507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 09:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYZQU-0001so-AF
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 09:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab1LHIdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 03:33:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43118
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525Ab1LHIdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 03:33:53 -0500
Received: (qmail 25884 invoked by uid 107); 8 Dec 2011 08:40:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Dec 2011 03:40:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Dec 2011 03:33:51 -0500
Content-Disposition: inline
In-Reply-To: <20111208082118.GA1507@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186543>

We use git_getpass to retrieve the username and password
from the terminal. However, git_getpass will not echo the
username as the user types. We can fix this by using the
more generic git_prompt, which underlies git_getpass but
lets us specify an "echo" option.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/credential.c b/credential.c
index fbb7231..62d1c56 100644
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
+	r = git_prompt(prompt.buf, flags);
 
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
1.7.8.rc2.8.gf0f4f
