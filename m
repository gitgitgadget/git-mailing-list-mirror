From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 1/2] Save terminal width before setting up pager and export term_columns()
Date: Sun, 12 Feb 2012 15:12:32 +0100
Message-ID: <1329055953-29632-1-git-send-email-zbyszek@in.waw.pl>
References: <7vsjigl79j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sun Feb 12 15:13:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwaAs-0004Q9-V2
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 15:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab2BLONA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 09:13:00 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52387 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754875Ab2BLONA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 09:13:00 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RwaAj-0001vV-46; Sun, 12 Feb 2012 15:12:57 +0100
X-Mailer: git-send-email 1.7.9.3.g2429d.dirty
In-Reply-To: <7vsjigl79j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190569>

term_columns() checks for terminal width via ioctl(2). After
redirecting, stdin is no longer terminal to get terminal width.

Check terminal width and save it before redirecting stdin in
setup_pager() by calling term_columns().

Move term_columns() to pager.c and export it in cache.h.

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 cache.h |  1 +
 help.c  | 22 -------------------
 pager.c | 45 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 22 deletions(-)

This replaces cb0850f (Save terminal width before setting up pager -
2012-02-04) from Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy and my previ=
ous patch to export
term_columns().

This is directly on top of v1.7.9 as requested.

I removed Signed-off-by from Nguy=E1=BB=85n and Junio because the patch=
 is
substantially changed.

diff --git a/cache.h b/cache.h
index 10afd71..2f30b3a 100644
--- a/cache.h
+++ b/cache.h
@@ -1175,6 +1175,7 @@ extern void setup_pager(void);
 extern const char *pager_program;
 extern int pager_in_use(void);
 extern int pager_use_color;
+extern int term_columns(void);
=20
 extern const char *editor_program;
 extern const char *askpass_program;
diff --git a/help.c b/help.c
index cbbe966..14eefc9 100644
--- a/help.c
+++ b/help.c
@@ -5,28 +5,6 @@
 #include "help.h"
 #include "common-cmds.h"
=20
-/* most GUI terminals set COLUMNS (although some don't export it) */
-static int term_columns(void)
-{
-	char *col_string =3D getenv("COLUMNS");
-	int n_cols;
-
-	if (col_string && (n_cols =3D atoi(col_string)) > 0)
-		return n_cols;
-
-#ifdef TIOCGWINSZ
-	{
-		struct winsize ws;
-		if (!ioctl(1, TIOCGWINSZ, &ws)) {
-			if (ws.ws_col)
-				return ws.ws_col;
-		}
-	}
-#endif
-
-	return 80;
-}
-
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent =3D xmalloc(sizeof(*ent) + len + 1);
diff --git a/pager.c b/pager.c
index 975955b..b8049a4 100644
--- a/pager.c
+++ b/pager.c
@@ -76,6 +76,10 @@ void setup_pager(void)
 	if (!pager)
 		return;
=20
+	/* prime the term_columns() cache before it is too
+	 * late and stdout is replaced */
+	(void) term_columns();
+
 	setenv("GIT_PAGER_IN_USE", "true", 1);
=20
 	/* spawn the pager */
@@ -110,3 +114,44 @@ int pager_in_use(void)
 	env =3D getenv("GIT_PAGER_IN_USE");
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
+
+/*
+ * Return cached value (if set) or $COLUMNS (if set and positive) or
+ * ioctl(1, TIOCGWINSZ).ws_col (if positive) or 80.
+ *
+ * $COLUMNS even if set, is usually not exported, so
+ * the variable can be used to override autodection.
+ * This behaviour conforms to The Single UNIX Specification, Version 2
+ * (http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html#tag_0=
02_003).
+ */
+int term_columns(void)
+{
+	static int term_columns_cache;
+
+	char *col_string;
+	int n_cols;
+
+	if (term_columns_cache)
+		return term_columns_cache;
+
+	col_string =3D getenv("COLUMNS");
+	if (col_string && (n_cols =3D atoi(col_string)) > 0) {
+		term_columns_cache =3D n_cols;
+		return term_columns_cache;
+	}
+
+#ifdef TIOCGWINSZ
+	{
+		struct winsize ws;
+		if (!ioctl(1, TIOCGWINSZ, &ws)) {
+			if (ws.ws_col) {
+				term_columns_cache =3D ws.ws_col;
+				return term_columns_cache;
+			}
+		}
+	}
+#endif
+
+	term_columns_cache =3D 80;
+	return term_columns_cache;
+}
--=20
1.7.9.3.g2429d.dirty
