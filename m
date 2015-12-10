From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] ident: make xgetpwuid_self() a static local helper
Date: Thu, 10 Dec 2015 16:33:05 -0500
Message-ID: <20151210213304.GA8374@sigill.intra.peff.net>
References: <20151210213228.GB29055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 22:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a78pt-0000tu-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 22:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbbLJVdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 16:33:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:39981 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752144AbbLJVdH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 16:33:07 -0500
Received: (qmail 13592 invoked by uid 102); 10 Dec 2015 21:33:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 15:33:07 -0600
Received: (qmail 23977 invoked by uid 107); 10 Dec 2015 21:33:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 16:33:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 16:33:05 -0500
Content-Disposition: inline
In-Reply-To: <20151210213228.GB29055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282232>

This function is defined in wrapper.c, but nobody besides
ident.c uses it. And nobody is likely to in the future,
either, as anything that cares about the user's name should
be going through the ident code.

Moving it here is a cleanup of the global namespace, but it
will also enable further cleanups inside ident.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h |  3 ---
 ident.c           | 12 ++++++++++++
 wrapper.c         | 12 ------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8e39867..2da0a75 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -929,9 +929,6 @@ int access_or_die(const char *path, int mode, unsigned flag);
 /* Warn on an inaccessible file that ought to be accessible */
 void warn_on_inaccessible(const char *path);
 
-/* Get the passwd entry for the UID of the current process. */
-struct passwd *xgetpwuid_self(void);
-
 #ifdef GMTIME_UNRELIABLE_ERRORS
 struct tm *git_gmtime(const time_t *);
 struct tm *git_gmtime_r(const time_t *, struct tm *);
diff --git a/ident.c b/ident.c
index 5ff1aad..d7c70e2 100644
--- a/ident.c
+++ b/ident.c
@@ -23,6 +23,18 @@ static int author_ident_explicitly_given;
 #define get_gecos(struct_passwd) ((struct_passwd)->pw_gecos)
 #endif
 
+static struct passwd *xgetpwuid_self(void)
+{
+	struct passwd *pw;
+
+	errno = 0;
+	pw = getpwuid(getuid());
+	if (!pw)
+		die(_("unable to look up current user in the passwd file: %s"),
+		    errno ? strerror(errno) : _("no such user"));
+	return pw;
+}
+
 static void copy_gecos(const struct passwd *w, struct strbuf *name)
 {
 	char *src;
diff --git a/wrapper.c b/wrapper.c
index 6fcaa4d..c95e290 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -601,18 +601,6 @@ int access_or_die(const char *path, int mode, unsigned flag)
 	return ret;
 }
 
-struct passwd *xgetpwuid_self(void)
-{
-	struct passwd *pw;
-
-	errno = 0;
-	pw = getpwuid(getuid());
-	if (!pw)
-		die(_("unable to look up current user in the passwd file: %s"),
-		    errno ? strerror(errno) : _("no such user"));
-	return pw;
-}
-
 char *xgetcwd(void)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.6.3.636.g1460207
