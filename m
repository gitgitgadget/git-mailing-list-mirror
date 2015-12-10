From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] ident: loosen getpwuid error in non-strict mode
Date: Thu, 10 Dec 2015 16:41:29 -0500
Message-ID: <20151210214129.GC8374@sigill.intra.peff.net>
References: <20151210213228.GB29055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 22:41:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a78y2-0000Le-22
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 22:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbbLJVld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 16:41:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:39993 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753799AbbLJVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 16:41:32 -0500
Received: (qmail 14319 invoked by uid 102); 10 Dec 2015 21:41:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 15:41:32 -0600
Received: (qmail 24042 invoked by uid 107); 10 Dec 2015 21:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 16:41:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 16:41:29 -0500
Content-Disposition: inline
In-Reply-To: <20151210213228.GB29055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282234>

If the user has not specified an identity and we have to
turn to getpwuid() to find the username or gecos field, we
die immediately when getpwuid fails (e.g., because the user
does not exist). This is OK for making a commit, where we
have set IDENT_STRICT and would want to bail on bogus input.

But for something like a reflog, where the ident is "best
effort", it can be pain. For instance, even running "git
clone" with a UID that is not in /etc/passwd will result in
git barfing, just because we can't find an ident to put in
the reflog.

Instead of dying in xgetpwuid_self, we can instead return a
fallback value, and set a "bogus" flag. For the username in
an email, we already have a "default_email_is_bogus" flag.
For the name field, we introduce (and check) a matching
"default_name_is_bogus" flag. As a bonus, this means you now
get the usual "tell me who you are" advice instead of just a
"no such user" error.

No tests, as this is dependent on configuration outside of
git's control. However, I did confirm that it behaves
sensibly when I delete myself from the local /etc/passwd
(reflogs get written, and commits complain).

Signed-off-by: Jeff King <peff@peff.net>
---
I dislike #ifdefs in the middle of functions like the one below, but I
couldn't come up with an elegant way to avoid it. We're reusing "struct
passwd" for our fallback, so we need to know whether we have that field
to set or not.

An obvious alternative would be to always return our own

  struct git_passwd_struct {
	const char *name;
	const char *gecos;
  };

and translate the existing getpwuid() on the fly. That still needs an
#ifdef, but we could then get rid of the #ifdef for the get_gecos()
macro.

Yet another alternative is to simply zero the fallback passwd struct,
and pw->pw_gecos will either not exist, or will be NULL. But then the
callers have to do something sane with the NULL, and the whole point of
this exercise was to avoid callers having to deal with the error cases
directly, so...

 ident.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/ident.c b/ident.c
index 085cfbe..2d5b876 100644
--- a/ident.c
+++ b/ident.c
@@ -11,6 +11,7 @@ static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static struct strbuf git_default_date = STRBUF_INIT;
 static int default_email_is_bogus;
+static int default_name_is_bogus;
 
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
@@ -24,15 +25,22 @@ static int author_ident_explicitly_given;
 #define get_gecos(struct_passwd) ((struct_passwd)->pw_gecos)
 #endif
 
-static struct passwd *xgetpwuid_self(void)
+static struct passwd *xgetpwuid_self(int *is_bogus)
 {
 	struct passwd *pw;
 
 	errno = 0;
 	pw = getpwuid(getuid());
-	if (!pw)
-		die(_("unable to look up current user in the passwd file: %s"),
-		    errno ? strerror(errno) : _("no such user"));
+	if (!pw) {
+		struct passwd fallback;
+		fallback.pw_name = "unknown";
+#ifndef NO_GECOS_IN_PWENT
+		fallback.pw_gecos = "Unknown";
+#endif
+		pw = &fallback;
+		if (is_bogus)
+			*is_bogus = 1;
+	}
 	return pw;
 }
 
@@ -122,7 +130,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email,
 const char *ident_default_name(void)
 {
 	if (!git_default_name.len) {
-		copy_gecos(xgetpwuid_self(), &git_default_name);
+		copy_gecos(xgetpwuid_self(&default_name_is_bogus), &git_default_name);
 		strbuf_trim(&git_default_name);
 	}
 	return git_default_name.buf;
@@ -138,8 +146,8 @@ const char *ident_default_email(void)
 			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else
-			copy_email(xgetpwuid_self(), &git_default_email,
-				   &default_email_is_bogus);
+			copy_email(xgetpwuid_self(&default_email_is_bogus),
+				   &git_default_email, &default_email_is_bogus);
 		strbuf_trim(&git_default_email);
 	}
 	return git_default_email.buf;
@@ -327,10 +335,16 @@ const char *fmt_ident(const char *name, const char *email,
 				fputs(env_hint, stderr);
 			die("empty ident name (for <%s>) not allowed", email);
 		}
-		pw = xgetpwuid_self();
+		pw = xgetpwuid_self(NULL);
 		name = pw->pw_name;
 	}
 
+	if (want_name && strict &&
+	    name == git_default_name.buf && default_name_is_bogus) {
+		fputs(env_hint, stderr);
+		die("unable to auto-detect name (got '%s')", name);
+	}
+
 	if (strict && email == git_default_email.buf && default_email_is_bogus) {
 		fputs(env_hint, stderr);
 		die("unable to auto-detect email address (got '%s')", email);
-- 
2.6.3.636.g1460207
