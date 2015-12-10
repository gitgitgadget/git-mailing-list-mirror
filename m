From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] ident: keep a flag for bogus default_email
Date: Thu, 10 Dec 2015 16:35:36 -0500
Message-ID: <20151210213535.GB8374@sigill.intra.peff.net>
References: <20151210213228.GB29055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 22:35:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a78sK-000658-He
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 22:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbbLJVfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 16:35:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:39989 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753417AbbLJVfi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 16:35:38 -0500
Received: (qmail 13799 invoked by uid 102); 10 Dec 2015 21:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 15:35:38 -0600
Received: (qmail 24007 invoked by uid 107); 10 Dec 2015 21:35:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 16:35:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 16:35:36 -0500
Content-Disposition: inline
In-Reply-To: <20151210213228.GB29055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282233>

If we have to deduce the user's email address and can't come
up with something plausible for the hostname, we simply
write "(none)" or ".(none)" in the hostname.

Later, our strict-check is forced to use strstr to look for
this magic string. This is probably not a problem in
practice, but it's rather ugly. Let's keep an extra flag
that tells us the email is bogus, and check that instead.

We could get away with simply setting the global in
add_domainname(); it only gets called to write into
git_default_email. However, let's make the code a little
more obvious to future readers by actually passing a pointer
to our "bogus" flag down the call-chain.

Signed-off-by: Jeff King <peff@peff.net>
---
I waffled on the "passing it around" thing. The patch is a lot smaller
if we just set the global directly, and I doubt these static helpers
will ever get reused for anything else. But the pattern does get reused
in the next patch, which sets the "email" and "name" flags separately
depending on context.

I was also tempted to have a single "default_ident_is_flaky", but that
does get some corner cases wrong (e.g., you have a bogus auto-guessed
name, an OK auto-guessed email, and set GIT_COMMITTER_NAME but not
GIT_COMMITTER_EMAIL). I doubt those come up in practice, but it's not
that hard to do the right thing.

 ident.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/ident.c b/ident.c
index d7c70e2..085cfbe 100644
--- a/ident.c
+++ b/ident.c
@@ -10,6 +10,7 @@
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static struct strbuf git_default_date = STRBUF_INIT;
+static int default_email_is_bogus;
 
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
@@ -82,7 +83,7 @@ static int add_mailname_host(struct strbuf *buf)
 	return 0;
 }
 
-static void add_domainname(struct strbuf *out)
+static void add_domainname(struct strbuf *out, int *is_bogus)
 {
 	char buf[1024];
 	struct hostent *he;
@@ -90,17 +91,21 @@ static void add_domainname(struct strbuf *out)
 	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
 		strbuf_addstr(out, "(none)");
+		*is_bogus = 1;
 		return;
 	}
 	if (strchr(buf, '.'))
 		strbuf_addstr(out, buf);
 	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
 		strbuf_addstr(out, he->h_name);
-	else
+	else {
 		strbuf_addf(out, "%s.(none)", buf);
+		*is_bogus = 1;
+	}
 }
 
-static void copy_email(const struct passwd *pw, struct strbuf *email)
+static void copy_email(const struct passwd *pw, struct strbuf *email,
+		       int *is_bogus)
 {
 	/*
 	 * Make up a fake email address
@@ -111,7 +116,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
 
 	if (!add_mailname_host(email))
 		return;	/* read from "/etc/mailname" (Debian) */
-	add_domainname(email);
+	add_domainname(email, is_bogus);
 }
 
 const char *ident_default_name(void)
@@ -133,7 +138,8 @@ const char *ident_default_email(void)
 			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else
-			copy_email(xgetpwuid_self(), &git_default_email);
+			copy_email(xgetpwuid_self(), &git_default_email,
+				   &default_email_is_bogus);
 		strbuf_trim(&git_default_email);
 	}
 	return git_default_email.buf;
@@ -325,8 +331,7 @@ const char *fmt_ident(const char *name, const char *email,
 		name = pw->pw_name;
 	}
 
-	if (strict && email == git_default_email.buf &&
-	    strstr(email, "(none)")) {
+	if (strict && email == git_default_email.buf && default_email_is_bogus) {
 		fputs(env_hint, stderr);
 		die("unable to auto-detect email address (got '%s')", email);
 	}
-- 
2.6.3.636.g1460207
