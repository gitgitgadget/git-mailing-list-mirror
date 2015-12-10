From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] ident: keep a flag for bogus default_email
Date: Thu, 10 Dec 2015 17:54:16 -0500
Message-ID: <20151210225416.GA1648@sigill.intra.peff.net>
References: <20151210213228.GB29055@sigill.intra.peff.net>
 <20151210213535.GB8374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7A6S-0007x3-Vs
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 23:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbbLJWyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 17:54:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:40033 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752079AbbLJWyT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 17:54:19 -0500
Received: (qmail 20621 invoked by uid 102); 10 Dec 2015 22:54:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 16:54:19 -0600
Received: (qmail 24733 invoked by uid 107); 10 Dec 2015 22:54:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 17:54:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 17:54:16 -0500
Content-Disposition: inline
In-Reply-To: <20151210213535.GB8374@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282237>

On Thu, Dec 10, 2015 at 04:35:35PM -0500, Jeff King wrote:

> @@ -82,7 +83,7 @@ static int add_mailname_host(struct strbuf *buf)
>  	return 0;
>  }
>  
> -static void add_domainname(struct strbuf *out)
> +static void add_domainname(struct strbuf *out, int *is_bogus)
>  {
>  	char buf[1024];
>  	struct hostent *he;
> @@ -90,17 +91,21 @@ static void add_domainname(struct strbuf *out)
>  	if (gethostname(buf, sizeof(buf))) {
>  		warning("cannot get host name: %s", strerror(errno));
>  		strbuf_addstr(out, "(none)");
> +		*is_bogus = 1;
>  		return;
>  	}
>  	if (strchr(buf, '.'))
>  		strbuf_addstr(out, buf);
>  	else if ((he = gethostbyname(buf)) && strchr(he->h_name, '.'))
>  		strbuf_addstr(out, he->h_name);
> -	else
> +	else {
>  		strbuf_addf(out, "%s.(none)", buf);
> +		*is_bogus = 1;
> +	}

This hunk has some minor conflicts with ep/ident-with-getaddrinfo, which
graduated to master in the tips you just pushed out.

Here's a rebased version on top of the current master (the other patches
can remain the same).

-- >8 --
Subject: [PATCH] ident: keep a flag for bogus default_email

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
 ident.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/ident.c b/ident.c
index 140dd63..fde3244 100644
--- a/ident.c
+++ b/ident.c
@@ -10,6 +10,7 @@
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
 static struct strbuf git_default_date = STRBUF_INIT;
+static int default_email_is_bogus;
 
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
@@ -108,22 +109,26 @@ static int canonical_name(const char *host, struct strbuf *out)
 	return status;
 }
 
-static void add_domainname(struct strbuf *out)
+static void add_domainname(struct strbuf *out, int *is_bogus)
 {
 	char buf[1024];
 
 	if (gethostname(buf, sizeof(buf))) {
 		warning("cannot get host name: %s", strerror(errno));
 		strbuf_addstr(out, "(none)");
+		*is_bogus = 1;
 		return;
 	}
 	if (strchr(buf, '.'))
 		strbuf_addstr(out, buf);
-	else if (canonical_name(buf, out) < 0)
+	else if (canonical_name(buf, out) < 0) {
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
@@ -134,7 +139,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email)
 
 	if (!add_mailname_host(email))
 		return;	/* read from "/etc/mailname" (Debian) */
-	add_domainname(email);
+	add_domainname(email, is_bogus);
 }
 
 const char *ident_default_name(void)
@@ -156,7 +161,8 @@ const char *ident_default_email(void)
 			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else
-			copy_email(xgetpwuid_self(), &git_default_email);
+			copy_email(xgetpwuid_self(), &git_default_email,
+				   &default_email_is_bogus);
 		strbuf_trim(&git_default_email);
 	}
 	return git_default_email.buf;
@@ -348,8 +354,7 @@ const char *fmt_ident(const char *name, const char *email,
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
