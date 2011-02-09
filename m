From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/16] Move term_columns() to pager.c and save terminal width before pager
Date: Wed,  9 Feb 2011 19:24:29 +0700
Message-ID: <1297254284-3729-2-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:26:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn981-0006wL-7P
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab1BIM0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:26:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35859 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab1BIM0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:26:22 -0500
Received: by mail-iy0-f174.google.com with SMTP id 8so92702iyj.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Ay+Tl+eoSRfWThryLYE2k/ABq4vrT+nmRbDFDETRW40=;
        b=VbvCJIXTN+HiIrFX9Q8lttIrcfkiEAFQIVmUuDcIE3+i4YPWqtivf4Ug7+1jj3p+G7
         qvvMS2MRQRT79qR9npNa98gy4bigtHVlmtq5d2BHVvwgHw4sDYQJ/Vf06rjki1QsS676
         b8d9HQbp6Tg3QCAWqc4nZEIZVInHv9uhkZv1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Di6JtiGQaGF36ENz+tBhuYBPVNvwN7EVMiUhsGhaikGWC5XYGsacWprUetlO0nOv6g
         riYVFwTigbX+BIK5ekrL4JxFd1SH4jCsGzlByvewstIycSRPIDPFj4LiFi4QCIjGcb3+
         evInIdllB//NnRbXkvpvpCuLJ12W0S2Ksq76c=
Received: by 10.231.34.195 with SMTP id m3mr20607301ibd.116.1297254382236;
        Wed, 09 Feb 2011 04:26:22 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id z4sm244588ibg.19.2011.02.09.04.26.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:26:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:24:52 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166406>

term_columns() checks for terminal width via ioctl(2). After
redirecting, stdin is no longer terminal to get terminal width.

Check terminal width and save it before redirect stdin in setup_pager()
and let term_columns() reuse the value.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    1 +
 column.h |    6 ++++++
 help.c   |   23 +----------------------
 pager.c  |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 22 deletions(-)
 create mode 100644 column.h

diff --git a/Makefile b/Makefile
index 775ee83..ed9e94b 100644
--- a/Makefile
+++ b/Makefile
@@ -1956,6 +1956,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
+pager.o help.o: column.h
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
index 7654f1b..768f64c 100644
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
index dac358f..dad6329 100644
--- a/pager.c
+++ b/pager.c
@@ -12,6 +12,19 @@
  */
=20
 static int spawned_pager;
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
=20
 #ifndef WIN32
 static void pager_preexec(void)
@@ -74,12 +87,17 @@ const char *git_pager(int stdout_is_tty)
 void setup_pager(void)
 {
 	const char *pager =3D git_pager(isatty(1));
+	int width;
=20
 	if (!pager)
 		return;
=20
 	spawned_pager =3D 1; /* means we are emitting to terminal */
=20
+	width =3D retrieve_terminal_width();
+	if (width)
+		max_columns =3D width;
+
 	/* spawn the pager */
 	pager_argv[0] =3D pager;
 	pager_process.use_shell =3D 1;
@@ -116,3 +134,18 @@ int pager_in_use(void)
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
1.7.2.2
