From: Jeff King <peff@peff.net>
Subject: [PATCH 04/13] move identity config parsing to ident.c
Date: Fri, 18 May 2012 19:11:03 -0400
Message-ID: <20120518231103.GD30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:11:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWKI-0003rV-HW
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946792Ab2ERXLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:11:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48759
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946744Ab2ERXLG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:11:06 -0400
Received: (qmail 7638 invoked by uid 107); 18 May 2012 23:11:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:11:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:11:03 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197983>

There's no reason for this to be in config, except that once
upon a time all of the config parsing was there. It makes
more sense to keep the ident code together.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  |  1 +
 config.c | 24 +-----------------------
 ident.c  | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index 0c095d4..86224c8 100644
--- a/cache.h
+++ b/cache.h
@@ -899,6 +899,7 @@ extern const char *ident_default_email(void);
 extern const char *ident_default_date(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
+extern int git_ident_config(const char *, const char *, void *);
 
 struct ident_split {
 	const char *name_begin;
diff --git a/config.c b/config.c
index eeee986..71ef171 100644
--- a/config.c
+++ b/config.c
@@ -762,28 +762,6 @@ static int git_default_core_config(const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_user_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "user.name")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strlcpy(git_default_name, value, sizeof(git_default_name));
-		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
-		return 0;
-	}
-
-	if (!strcmp(var, "user.email")) {
-		if (!value)
-			return config_error_nonbool(var);
-		strlcpy(git_default_email, value, sizeof(git_default_email));
-		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config.txt. */
-	return 0;
-}
-
 static int git_default_i18n_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "i18n.commitencoding"))
@@ -870,7 +848,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 		return git_default_core_config(var, value);
 
 	if (!prefixcmp(var, "user."))
-		return git_default_user_config(var, value);
+		return git_ident_config(var, value, dummy);
 
 	if (!prefixcmp(var, "i18n."))
 		return git_default_i18n_config(var, value);
diff --git a/ident.c b/ident.c
index 0f7dcae..bb1158f 100644
--- a/ident.c
+++ b/ident.c
@@ -388,3 +388,24 @@ int user_ident_sufficiently_given(void)
 	return (user_ident_explicitly_given == IDENT_ALL_GIVEN);
 #endif
 }
+
+int git_ident_config(const char *var, const char *value, void *data)
+{
+	if (!strcmp(var, "user.name")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strlcpy(git_default_name, value, sizeof(git_default_name));
+		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		return 0;
+	}
+
+	if (!strcmp(var, "user.email")) {
+		if (!value)
+			return config_error_nonbool(var);
+		strlcpy(git_default_email, value, sizeof(git_default_email));
+		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		return 0;
+	}
+
+	return 0;
+}
-- 
1.7.10.1.16.g53a707b
