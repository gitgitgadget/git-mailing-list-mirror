From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH 2/3] help.c: make term_columns() cached and export it
Date: Fri, 10 Feb 2012 17:39:31 +0100
Message-ID: <1328891972-23695-3-git-send-email-zbyszek@in.waw.pl>
References: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
 <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 10 17:40:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvtWm-0000tp-L9
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 17:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758483Ab2BJQko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 11:40:44 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:52365 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757501Ab2BJQkn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 11:40:43 -0500
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RvtWc-0000kd-Gu; Fri, 10 Feb 2012 17:40:42 +0100
X-Mailer: git-send-email 1.7.9.263.g8cced
In-Reply-To: <1328891972-23695-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190419>

Since term_columns() will usually fail, when a pager is installed,
the cache is primed before the pager is installed. If a pager is not
installed, then the cache will be set on first use.

Conforms to The Single UNIX Specification, Version 2
(http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html#tag_002_0=
03).

Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
 help.c  |   37 +++++++++++++++++++++++++++++--------
 help.h  |    2 ++
 pager.c |    5 +++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/help.c b/help.c
index bc15066..5d1cb1d 100644
--- a/help.c
+++ b/help.c
@@ -5,26 +5,47 @@
 #include "help.h"
 #include "common-cmds.h"
=20
-/* most GUI terminals set COLUMNS (although some don't export it) */
-static int term_columns(void)
+/*=20
+ * Cache for term_columns() value. Set on first use or when
+ * installing a pager and replacing stdout.
+ */
+static int term_columns_cache;
+
+/*=20
+ * Return cached value (if set) or $COLUMNS (if set and positive) or
+ * ioctl(1, TIOCGWINSZ).ws_col (if positive) or 80.
+ *
+ * $COLUMNS even if set, is usually not exported, so
+ * the variable can be used to override autodection.
+ */
+int term_columns(void)
 {
-	char *col_string =3D getenv("COLUMNS");
+	char *col_string;
 	int n_cols;
=20
-	if (col_string && (n_cols =3D atoi(col_string)) > 0)
-		return n_cols;
+	if (term_columns_cache)
+		return term_columns_cache;
+
+	col_string =3D getenv("COLUMNS");
+	if (col_string && (n_cols =3D atoi(col_string)) > 0) {
+		term_columns_cache =3D n_cols;
+		return term_columns_cache;
+	}
=20
 #ifdef TIOCGWINSZ
 	{
 		struct winsize ws;
 		if (!ioctl(1, TIOCGWINSZ, &ws)) {
-			if (ws.ws_col)
-				return ws.ws_col;
+			if (ws.ws_col) {
+				term_columns_cache =3D ws.ws_col;
+				return term_columns_cache;
+			}
 		}
 	}
 #endif
=20
-	return 80;
+	term_columns_cache =3D 80;
+	return term_columns_cache;
 }
=20
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
diff --git a/help.h b/help.h
index b6b12d5..880a4b4 100644
--- a/help.h
+++ b/help.h
@@ -29,4 +29,6 @@ extern void list_commands(const char *title,
 			  struct cmdnames *main_cmds,
 			  struct cmdnames *other_cmds);
=20
+extern int term_columns(void);
+
 #endif /* HELP_H */
diff --git a/pager.c b/pager.c
index 975955b..e7032de 100644
--- a/pager.c
+++ b/pager.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "help.h"
=20
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
@@ -76,6 +77,10 @@ void setup_pager(void)
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
--=20
1.7.9.263.g4be11.dirty
