From: Jeff King <peff@peff.net>
Subject: [PATCHv2 04/15] move identity config parsing to ident.c
Date: Mon, 21 May 2012 19:09:54 -0400
Message-ID: <20120521230954.GD10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:10:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbjq-0007Qp-GI
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab2EUXJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:09:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51207
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab2EUXJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:09:57 -0400
Received: (qmail 7750 invoked by uid 107); 21 May 2012 23:10:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:09:54 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198149>

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
1.7.10.1.19.g711d603
