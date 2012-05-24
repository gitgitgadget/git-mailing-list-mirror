From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] ident: refactor NO_DATE flag in fmt_ident
Date: Thu, 24 May 2012 19:26:50 -0400
Message-ID: <20120524232650.GB11084@sigill.intra.peff.net>
References: <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:27:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhQn-0007GB-J2
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934009Ab2EXX0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:26:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54582
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290Ab2EXX0w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:26:52 -0400
Received: (qmail 2129 invoked by uid 107); 24 May 2012 23:27:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:27:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:26:50 -0400
Content-Disposition: inline
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198445>

As a short-hand, we extract this flag into the local
variable "name_addr_only". It's more accurate to simply
negate this and refer to it as "want_date", which will be
less confusing when we add more NO_* flags.

While we're touching this part of the code, let's move the
call to ident_default_date() only when we are actually going
to use it, not when we have NO_DATE set, or when we get a
date from the environment.

Signed-off-by: Jeff King <peff@peff.net>
---
Just refactoring for the next patch...

 ident.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/ident.c b/ident.c
index f5160e1..59beef2 100644
--- a/ident.c
+++ b/ident.c
@@ -268,7 +268,7 @@ const char *fmt_ident(const char *name, const char *email,
 	static struct strbuf ident = STRBUF_INIT;
 	char date[50];
 	int error_on_no_name = (flag & IDENT_ERROR_ON_NO_NAME);
-	int name_addr_only = (flag & IDENT_NO_DATE);
+	int want_date = !(flag & IDENT_NO_DATE);
 
 	if (!name)
 		name = ident_default_name();
@@ -287,10 +287,13 @@ const char *fmt_ident(const char *name, const char *email,
 		name = pw->pw_name;
 	}
 
-	strcpy(date, ident_default_date());
-	if (!name_addr_only && date_str && date_str[0]) {
-		if (parse_date(date_str, date, sizeof(date)) < 0)
-			die("invalid date format: %s", date_str);
+	if (want_date) {
+		if (date_str && date_str[0]) {
+			if (parse_date(date_str, date, sizeof(date)) < 0)
+				die("invalid date format: %s", date_str);
+		}
+		else
+			strcpy(date, ident_default_date());
 	}
 
 	strbuf_reset(&ident);
@@ -298,7 +301,7 @@ const char *fmt_ident(const char *name, const char *email,
 	strbuf_addstr(&ident, " <");
 	strbuf_addstr_without_crud(&ident, email);
 	strbuf_addch(&ident, '>');
-	if (!name_addr_only) {
+	if (want_date) {
 		strbuf_addch(&ident, ' ');
 		strbuf_addstr_without_crud(&ident, date);
 	}
-- 
1.7.10.1.25.g7031a0f
