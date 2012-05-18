From: Jeff King <peff@peff.net>
Subject: [PATCH 07/13] fmt_ident: drop IDENT_WARN_ON_NO_NAME code
Date: Fri, 18 May 2012 19:14:31 -0400
Message-ID: <20120518231431.GG30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:14:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWNb-0008Vs-By
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946701Ab2ERXOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:14:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48773
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946677Ab2ERXOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:14:34 -0400
Received: (qmail 7755 invoked by uid 107); 18 May 2012 23:14:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:14:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:14:31 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197987>

There are no more callers who want this, so we can drop it.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  5 ++---
 ident.c | 11 ++++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index f63b71f..65cbab5 100644
--- a/cache.h
+++ b/cache.h
@@ -887,9 +887,8 @@ unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
 
-#define IDENT_WARN_ON_NO_NAME  1
-#define IDENT_ERROR_ON_NO_NAME 2
-#define IDENT_NO_DATE	       4
+#define IDENT_ERROR_ON_NO_NAME 1
+#define IDENT_NO_DATE	       2
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
diff --git a/ident.c b/ident.c
index af92b2c..d2fa271 100644
--- a/ident.c
+++ b/ident.c
@@ -312,7 +312,6 @@ const char *fmt_ident(const char *name, const char *email,
 	char date[50];
 	int i;
 	int error_on_no_name = (flag & IDENT_ERROR_ON_NO_NAME);
-	int warn_on_no_name = (flag & IDENT_WARN_ON_NO_NAME);
 	int name_addr_only = (flag & IDENT_NO_DATE);
 
 	if (!name)
@@ -323,13 +322,11 @@ const char *fmt_ident(const char *name, const char *email,
 	if (!*name) {
 		struct passwd *pw;
 
-		if ((warn_on_no_name || error_on_no_name) &&
-		    name == git_default_name && env_hint) {
-			fputs(env_hint, stderr);
-			env_hint = NULL; /* warn only once */
-		}
-		if (error_on_no_name)
+		if (error_on_no_name) {
+			if (name == git_default_name)
+				fputs(env_hint, stderr);
 			die("empty ident %s <%s> not allowed", name, email);
+		}
 		pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
-- 
1.7.10.1.16.g53a707b
