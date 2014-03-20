From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/8] Add git-ls, a user friendly version of ls-files and more
Date: Thu, 20 Mar 2014 17:15:51 +0700
Message-ID: <1395310551-23201-9-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:16:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa1f-0001kY-06
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993AbaCTKQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:16:35 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:44342 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921AbaCTKQd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:16:33 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so721448pab.41
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9AU/UY8wUorzpHkH46We0Udeqbrh3ceV2YCEJo43DOc=;
        b=XVtAcmkh3tyBHEQrwhmTbaA8lbv4WdIOJFckre8zGXDlpVGnSQGVq72BPWsGZA3eFY
         ar6jC1JmF4RKBKd/4j9PK8GjW+lfEZpFqtnGf7eb/83XDFdJSSSMzCwMwAPu8oxZioa7
         lMC6/JsTaSfwl6i0P1saeiPzhCjGTAUXzAUVBLMaYZCH8F1fz9dHuHp0rqE9uTq2TnNR
         lsb7QS8Nl2P5bSuII2Bouu6W2dYw3I867SbzGBCheuURKegMMzRjZb144LkHKtKuZhBP
         hq6e4pHnKolOnJMn818CJXy7r0YvwHe1ZB8r7dfANe9SKP25SIDBFnfQfQcJ8xts2Ek0
         YXeQ==
X-Received: by 10.68.58.34 with SMTP id n2mr46449347pbq.122.1395310592945;
        Thu, 20 Mar 2014 03:16:32 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id yv5sm2959032pbb.49.2014.03.20.03.16.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:16:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:17:19 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244538>

=46or now it's simply a wrapper of ls-files with some default
goodies. But I want it to be the UI for ls-tree and perhaps git diff
--name-only [--cached] too.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin.h          |  1 +
 builtin/ls-files.c | 19 +++++++++++++++++++
 git.c              |  1 +
 3 files changed, 21 insertions(+)

diff --git a/builtin.h b/builtin.h
index c47c110..177aa7d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -75,6 +75,7 @@ extern int cmd_index_pack(int argc, const char **argv=
, const char *prefix);
 extern int cmd_init_db(int argc, const char **argv, const char *prefix=
);
 extern int cmd_log(int argc, const char **argv, const char *prefix);
 extern int cmd_log_reflog(int argc, const char **argv, const char *pre=
fix);
+extern int cmd_ls(int argc, const char **argv, const char *prefix);
 extern int cmd_ls_files(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_ls_tree(int argc, const char **argv, const char *prefix=
);
 extern int cmd_ls_remote(int argc, const char **argv, const char *pref=
ix);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2c51b0a..5354339 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -17,6 +17,7 @@
 #include "color.h"
 #include "ls_colors.h"
 #include "column.h"
+#include "argv-array.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -479,6 +480,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	int require_work_tree =3D 0, show_tag =3D 0, i;
 	unsigned int colopts =3D 0;
 	int max_depth =3D -1;
+	int refresh =3D 0;
 	const char *max_prefix;
 	struct dir_struct dir;
 	struct exclude_list *el;
@@ -539,6 +541,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
+		OPT_HIDDEN_BOOL(0, "refresh-index", &refresh, N_("refresh index")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
@@ -555,6 +558,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
=20
 	if (read_cache() < 0)
 		die("index file corrupt");
+	if (refresh)
+		refresh_cache(REFRESH_QUIET);
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
@@ -652,3 +657,17 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
=20
 	return 0;
 }
+
+int cmd_ls(int argc, const char **argv, const char *cmd_prefix)
+{
+	struct argv_array av =3D ARGV_ARRAY_INIT;
+	argv_array_pushl(&av, "ls-files",
+			 "--color", "--column", "--max-depth=3D0",
+			 "--exclude-standard", "--refresh-index",
+			 NULL);
+	argv++;
+	while (*argv)
+		argv_array_push(&av, *argv++);
+	trace_argv_printf(av.argv, "trace: built-in: git");
+	return cmd_ls_files(av.argc, av.argv, cmd_prefix);
+}
diff --git a/git.c b/git.c
index 9efd1a3..682a81e 100644
--- a/git.c
+++ b/git.c
@@ -381,6 +381,7 @@ static struct cmd_struct commands[] =3D {
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
 	{ "log", cmd_log, RUN_SETUP },
+	{ "ls", cmd_ls, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
--=20
1.9.0.40.gaa8c3ea
