From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] ident: let callers omit name with fmt_indent
Date: Thu, 24 May 2012 19:27:24 -0400
Message-ID: <20120524232723.GC11084@sigill.intra.peff.net>
References: <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:27:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhRL-0000CE-1K
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290Ab2EXX10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:27:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54586
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab2EXX10 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:27:26 -0400
Received: (qmail 2159 invoked by uid 107); 24 May 2012 23:27:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:27:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:27:24 -0400
Content-Disposition: inline
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198446>

Most callers want to see all of "$name <$email> $date", but
a few want only limited parts, omitting the date, or even
the name. We already have IDENT_NO_DATE to handle the date
part, but there's not a good option for getting just the
email. Callers have to done one of:

  1. Call ident_default_email; this does not respect
     environment variables, nor does it promise to trim
     whitespace or other crud from the result.

  2. Call git_{committer,author}_info; this returns the name
     and email, leaving the caller to parse out the wanted
     bits.

This patch adds IDENT_NO_NAME; it stops short of adding
IDENT_NO_EMAIL, as no callers want it (nor are likely to),
and it complicates the error handling of the function.

When no name is requested, the angle brackets (<>) around
the email address are also omitted.

Signed-off-by: Jeff King <peff@peff.net>
---
I worked this up with IDENT_NO_EMAIL, too, but it really just made the
function harder to read. And I doubt any callers are going to want it.

 cache.h |  1 +
 ident.c | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 0ac0d57..4a76c23 100644
--- a/cache.h
+++ b/cache.h
@@ -889,6 +889,7 @@ enum date_mode parse_date_format(const char *format);
 
 #define IDENT_ERROR_ON_NO_NAME 1
 #define IDENT_NO_DATE	       2
+#define IDENT_NO_NAME	       4
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
diff --git a/ident.c b/ident.c
index 59beef2..8b5080d 100644
--- a/ident.c
+++ b/ident.c
@@ -269,13 +269,14 @@ const char *fmt_ident(const char *name, const char *email,
 	char date[50];
 	int error_on_no_name = (flag & IDENT_ERROR_ON_NO_NAME);
 	int want_date = !(flag & IDENT_NO_DATE);
+	int want_name = !(flag & IDENT_NO_NAME);
 
-	if (!name)
+	if (want_name && !name)
 		name = ident_default_name();
 	if (!email)
 		email = ident_default_email();
 
-	if (!*name) {
+	if (want_name && !*name) {
 		struct passwd *pw;
 
 		if (error_on_no_name) {
@@ -297,10 +298,13 @@ const char *fmt_ident(const char *name, const char *email,
 	}
 
 	strbuf_reset(&ident);
-	strbuf_addstr_without_crud(&ident, name);
-	strbuf_addstr(&ident, " <");
+	if (want_name) {
+		strbuf_addstr_without_crud(&ident, name);
+		strbuf_addstr(&ident, " <");
+	}
 	strbuf_addstr_without_crud(&ident, email);
-	strbuf_addch(&ident, '>');
+	if (want_name)
+			strbuf_addch(&ident, '>');
 	if (want_date) {
 		strbuf_addch(&ident, ' ');
 		strbuf_addstr_without_crud(&ident, date);
-- 
1.7.10.1.25.g7031a0f
