From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] ident: keep separate "explicit" flags for author and
 committer
Date: Tue, 13 Nov 2012 11:52:03 -0500
Message-ID: <20121113165203.GB12626@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 17:52:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYJiq-00074Q-6o
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 17:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab2KMQwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 11:52:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47538 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab2KMQwI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 11:52:08 -0500
Received: (qmail 26493 invoked by uid 107); 13 Nov 2012 16:52:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 11:52:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 11:52:03 -0500
Content-Disposition: inline
In-Reply-To: <20121113164845.GD20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209635>

We keep track of whether the user ident was given to us
explicitly, or if we guessed at it from system parameters
like username and hostname. However, we kept only a single
variable. This covers the common cases (because the author
and committer will usually come from the same explicit
source), but can miss two cases:

  1. GIT_COMMITTER_* is set explicitly, but we fallback for
     GIT_AUTHOR. We claim the ident is explicit, even though
     the author is not.

  2. GIT_AUTHOR_* is set and we ask for author ident, but
     not committer ident. We will claim the ident is
     implicit, even though it is explicit.

This patch uses two variables instead of one, updates both
when we set the "fallback" values, and updates them
individually when we read from the environment.

Rather than keep user_ident_sufficiently_given as a
compatibility wrapper, we update the only two callers to
check the committer_ident, which matches their intent and
what was happening already.

Signed-off-by: Jeff King <peff@peff.net>
---
Case 1 made me initially think might need to check
author_ident_sufficiently_given when deciding whether to show the
"Author:" line during commit.  But I don't think it is necessary, as we
already check !strcmp(author, committer); if the committer is explicit
and the author is identical, even if it is implicit, there is no point
in telling the user.

 builtin/commit.c |  4 ++--
 cache.h          |  3 ++-
 ident.c          | 32 +++++++++++++++++++++++++-------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1dd2ec5..d6dd3df 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -755,7 +755,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				ident_shown++ ? "" : "\n",
 				author_ident->buf);
 
-		if (!user_ident_sufficiently_given())
+		if (!committer_ident_sufficiently_given())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
 				"Committer: %s"),
@@ -1265,7 +1265,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 		strbuf_addstr(&format, "\n Author: ");
 		strbuf_addbuf_percentquote(&format, &author_ident);
 	}
-	if (!user_ident_sufficiently_given()) {
+	if (!committer_ident_sufficiently_given()) {
 		strbuf_addstr(&format, "\n Committer: ");
 		strbuf_addbuf_percentquote(&format, &committer_ident);
 		if (advice_implicit_identity) {
diff --git a/cache.h b/cache.h
index 50d9eea..18fdd18 100644
--- a/cache.h
+++ b/cache.h
@@ -1149,7 +1149,8 @@ struct config_include_data {
 #define CONFIG_INCLUDE_INIT { 0 }
 extern int git_config_include(const char *name, const char *value, void *data);
 
-extern int user_ident_sufficiently_given(void);
+extern int committer_ident_sufficiently_given(void);
+extern int author_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
diff --git a/ident.c b/ident.c
index 733d69d..ac9672f 100644
--- a/ident.c
+++ b/ident.c
@@ -14,7 +14,8 @@ static char git_default_date[50];
 #define IDENT_NAME_GIVEN 01
 #define IDENT_MAIL_GIVEN 02
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
-static int user_ident_explicitly_given;
+static int committer_ident_explicitly_given;
+static int author_ident_explicitly_given;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
@@ -113,7 +114,8 @@ const char *ident_default_email(void)
 
 		if (email && email[0]) {
 			strbuf_addstr(&git_default_email, email);
-			user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+			committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+			author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		} else
 			copy_email(xgetpwuid_self(), &git_default_email);
 		strbuf_trim(&git_default_email);
@@ -331,6 +333,10 @@ const char *fmt_name(const char *name, const char *email)
 
 const char *git_author_info(int flag)
 {
+	if (getenv("GIT_AUTHOR_NAME"))
+		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
+	if (getenv("GIT_AUTHOR_EMAIL"))
+		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
@@ -340,16 +346,16 @@ const char *git_author_info(int flag)
 const char *git_committer_info(int flag)
 {
 	if (getenv("GIT_COMMITTER_NAME"))
-		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_COMMITTER_EMAIL"))
-		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
 			 flag);
 }
 
-int user_ident_sufficiently_given(void)
+static int ident_is_sufficient(int user_ident_explicitly_given)
 {
 #ifndef WINDOWS
 	return (user_ident_explicitly_given & IDENT_MAIL_GIVEN);
@@ -358,6 +364,16 @@ int user_ident_sufficiently_given(void)
 #endif
 }
 
+int committer_ident_sufficiently_given(void)
+{
+	return ident_is_sufficient(committer_ident_explicitly_given);
+}
+
+int author_ident_sufficiently_given(void)
+{
+	return ident_is_sufficient(author_ident_explicitly_given);
+}
+
 int git_ident_config(const char *var, const char *value, void *data)
 {
 	if (!strcmp(var, "user.name")) {
@@ -365,7 +381,8 @@ int git_ident_config(const char *var, const char *value, void *data)
 			return config_error_nonbool(var);
 		strbuf_reset(&git_default_name);
 		strbuf_addstr(&git_default_name, value);
-		user_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
+		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
 		return 0;
 	}
 
@@ -374,7 +391,8 @@ int git_ident_config(const char *var, const char *value, void *data)
 			return config_error_nonbool(var);
 		strbuf_reset(&git_default_email);
 		strbuf_addstr(&git_default_email, value);
-		user_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
 		return 0;
 	}
 
-- 
1.8.0.207.gdf2154c
