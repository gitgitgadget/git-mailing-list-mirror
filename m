From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 01/12] Save terminal width before setting up pager
Date: Sat,  4 Feb 2012 22:59:05 +0700
Message-ID: <1328371156-4009-2-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RthxN-0006Ta-6C
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab2BDPzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:55:00 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36432 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2BDPy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 10:54:59 -0500
Received: by dadp15 with SMTP id p15so3553938dad.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z/QyJAwBpxT97drIrD1jcYppRWuqkN7yBgqHb3FWvS0=;
        b=M0EUpLPNk9bTibhdtRAkZY9lIDADAGLh/a4q9Y8qwZTDh29/LYzX0KP0JFeUusBHF4
         0RmxfcgDpbakcZOZ1mo/7HsShjH0NLSHNxsYg/R/7F/aP14FzweqJvk+js9G8y4NxYaQ
         3lsKSqsMSWoeHw3JozBZb7BhnNALxkkRoNc+I=
Received: by 10.68.240.164 with SMTP id wb4mr28657895pbc.57.1328370898716;
        Sat, 04 Feb 2012 07:54:58 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id b7sm22410377pba.2.2012.02.04.07.54.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:54:57 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 04 Feb 2012 22:59:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189873>

term_columns() checks for terminal width via ioctl(2). After
redirecting, stdin is no longer terminal to get terminal width.

Check terminal width and save it before redirect stdin in
setup_pager() and let term_columns() reuse the value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    1 +
 column.h |    6 ++++++
 help.c   |   23 +----------------------
 pager.c  |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 22 deletions(-)
 create mode 100644 column.h

diff --git a/Makefile b/Makefile
index c457c34..cbbc699 100644
--- a/Makefile
+++ b/Makefile
@@ -2114,6 +2114,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
+help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/column.h b/column.h
new file mode 100644
index 0000000..55d8067
--- /dev/null
+++ b/column.h
@@ -0,0 +1,6 @@
+#ifndef COLUMN_H
+#define COLUMN_H
+
+extern int term_columns(void);
+
+#endif
diff --git a/help.c b/help.c
index cbbe966..672561b 100644
--- a/help.c
+++ b/help.c
@@ -4,28 +4,7 @@
 #include "levenshtein.h"
 #include "help.h"
 #include "common-cmds.h"
-
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
+#include "column.h"
=20
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
diff --git a/pager.c b/pager.c
index 975955b..772a5a6 100644
--- a/pager.c
+++ b/pager.c
@@ -6,6 +6,21 @@
 #define DEFAULT_PAGER "less"
 #endif
=20
+static int spawned_pager;
+static int max_columns;
+
+static int retrieve_terminal_width(void)
+{
+#ifdef TIOCGWINSZ
+	struct winsize ws;
+	if (ioctl(1, TIOCGWINSZ, &ws))  /* e.g., ENOSYS */
+		return 0;
+	return ws.ws_col;
+#else
+	return 0;
+#endif
+}
+
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -72,12 +87,17 @@ const char *git_pager(int stdout_is_tty)
 void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
+	int width;
=20
 	if (!pager)
 		return;
=20
 	setenv("GIT_PAGER_IN_USE", "true", 1);
=20
+	width =3D retrieve_terminal_width();
+	if (width)
+		max_columns =3D width;
+
 	/* spawn the pager */
 	pager_argv[0] =3D pager;
 	pager_process.use_shell =3D 1;
@@ -110,3 +130,18 @@ int pager_in_use(void)
 	env =3D getenv("GIT_PAGER_IN_USE");
 	return env ? git_config_bool("GIT_PAGER_IN_USE", env) : 0;
 }
+
+int term_columns()
+{
+	char *col_string =3D getenv("COLUMNS");
+	int n_cols;
+
+	if (col_string && (n_cols =3D atoi(col_string)) > 0)
+		return n_cols;
+
+	if (spawned_pager && max_columns)
+		return max_columns;
+
+	n_cols =3D retrieve_terminal_width();
+	return n_cols ? n_cols : 80;
+}
--=20
1.7.8.36.g69ee2
