From: Jeff King <peff@peff.net>
Subject: [PATCHv2 01/15] ident: split setup_ident into separate functions
Date: Mon, 21 May 2012 19:09:43 -0400
Message-ID: <20120521230943.GA10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbjb-0006mB-K0
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab2EUXJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:09:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51196
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab2EUXJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:09:46 -0400
Received: (qmail 7684 invoked by uid 107); 21 May 2012 23:10:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:09:43 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198146>

This function sets up the default name, email, and date, and
is not publicly available. Let's split it into three public
functions so that callers can get just the parts they need.

While we're at it, let's change the interface to simple
accessors. The original function was called only by fmt_ident,
and contained logic for "if we already have some other
value, don't load the default" which properly belongs in
fmt_ident.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |  3 +++
 ident.c | 35 +++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index e14ffcd..0c095d4 100644
--- a/cache.h
+++ b/cache.h
@@ -894,6 +894,9 @@ extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
+extern const char *ident_default_name(void);
+extern const char *ident_default_email(void);
+extern const char *ident_default_date(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
 
diff --git a/ident.c b/ident.c
index 87c697c..0f7dcae 100644
--- a/ident.c
+++ b/ident.c
@@ -117,21 +117,20 @@ static void copy_email(const struct passwd *pw)
 			sizeof(git_default_email) - len);
 }
 
-static void setup_ident(const char **name, const char **emailp)
+const char *ident_default_name(void)
 {
-	struct passwd *pw = NULL;
-
-	/* Get the name ("gecos") */
-	if (!*name && !git_default_name[0]) {
-		pw = getpwuid(getuid());
+	if (!git_default_name[0]) {
+		struct passwd *pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
 		copy_gecos(pw, git_default_name, sizeof(git_default_name));
 	}
-	if (!*name)
-		*name = git_default_name;
+	return git_default_name;
+}
 
-	if (!*emailp && !git_default_email[0]) {
+const char *ident_default_email(void)
+{
+	if (!git_default_email[0]) {
 		const char *email = getenv("EMAIL");
 
 		if (email && email[0]) {
@@ -139,19 +138,20 @@ static void setup_ident(const char **name, const char **emailp)
 				sizeof(git_default_email));
 			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else {
-			if (!pw)
-				pw = getpwuid(getuid());
+			struct passwd *pw = getpwuid(getuid());
 			if (!pw)
 				die("You don't exist. Go away!");
 			copy_email(pw);
 		}
 	}
-	if (!*emailp)
-		*emailp = git_default_email;
+	return git_default_email;
+}
 
-	/* And set the default date */
+const char *ident_default_date(void)
+{
 	if (!git_default_date[0])
 		datestamp(git_default_date, sizeof(git_default_date));
+	return git_default_date;
 }
 
 static int add_raw(char *buf, size_t size, int offset, const char *str)
@@ -311,7 +311,10 @@ const char *fmt_ident(const char *name, const char *email,
 	int warn_on_no_name = (flag & IDENT_WARN_ON_NO_NAME);
 	int name_addr_only = (flag & IDENT_NO_DATE);
 
-	setup_ident(&name, &email);
+	if (!name)
+		name = ident_default_name();
+	if (!email)
+		email = ident_default_email();
 
 	if (!*name) {
 		struct passwd *pw;
@@ -331,7 +334,7 @@ const char *fmt_ident(const char *name, const char *email,
 		name = git_default_name;
 	}
 
-	strcpy(date, git_default_date);
+	strcpy(date, ident_default_date());
 	if (!name_addr_only && date_str && date_str[0]) {
 		if (parse_date(date_str, date, sizeof(date)) < 0)
 			die("invalid date format: %s", date_str);
-- 
1.7.10.1.19.g711d603
