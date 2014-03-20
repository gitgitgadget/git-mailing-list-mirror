From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] ls-files: add --color to highlight based on $LS_COLORS
Date: Thu, 20 Mar 2014 17:15:48 +0700
Message-ID: <1395310551-23201-6-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa1H-0001FI-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427AbaCTKQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:16:11 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:53769 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbaCTKQI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:16:08 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so724380pab.24
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mtW5cf+tBAV3cnmIgn5nCgo+72Wz0SPjH4vRvJJ403Q=;
        b=NQyKTis6aTqzQMcqURFafm9C2yvSx8uwuQFH5bQwRwts1L76yYOVgxwrfW4lmTHKqp
         A9JDLKqtSM9/Po+T83W75WdIafVLYc5VJAzWR0frmVScGtuplG+AP2VDk96IcauxbjbZ
         SYBUYXuEbswcFvrdNg3scn/xR9dir/vQkXH2ODEtYnhYJrKdRgngZRcp1r1DZi0Tvx+Y
         NH1vSj4XQvEV13pPKza7T9bPjpM6NpYok9JYEfVc1q9FsYCjPvccRJFwd0h/K/azDJvl
         GDJDaoF3nBos70/eP9NKsJbjNP/+Q5B9LmxDAtXag3VTzgIQtf2rEYlwKihFd/zUp2mQ
         10/g==
X-Received: by 10.67.3.97 with SMTP id bv1mr46492432pad.54.1395310567707;
        Thu, 20 Mar 2014 03:16:07 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id ff4sm7799774pad.24.2014.03.20.03.16.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:16:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:16:54 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244534>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..463280e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,6 +14,8 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "pathspec.h"
+#include "color.h"
+#include "ls_colors.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -27,6 +29,7 @@ static int show_killed;
 static int show_valid_bit;
 static int line_terminator =3D '\n';
 static int debug_mode;
+static int use_color;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -57,6 +60,33 @@ static void write_name(const char *name)
 				   stdout, line_terminator);
 }
=20
+static void write_dir_entry(const struct dir_entry *ent)
+{
+	if (want_color(use_color)) {
+		static struct strbuf sb =3D STRBUF_INIT;
+		struct stat st;
+		int statok;
+		quote_path_relative(ent->name, prefix_len ? prefix : NULL, &sb);
+		statok =3D stat(ent->name, &st) =3D=3D 0;
+		print_color_indicator(sb.buf, st.st_mode, 0, statok, 0);
+		fputs(sb.buf, stdout);
+		printf("%s%c", GIT_COLOR_RESET, line_terminator);
+	} else
+		write_name(ent->name);
+}
+
+static void write_ce_name(const struct cache_entry *ce)
+{
+	if (want_color(use_color)) {
+		static struct strbuf sb =3D STRBUF_INIT;
+		quote_path_relative(ce->name, prefix_len ? prefix : NULL, &sb);
+		print_color_indicator(sb.buf, ce->ce_mode, 1, 1, 0);
+		fputs(sb.buf, stdout);
+		printf("%s%c", GIT_COLOR_RESET, line_terminator);
+	} else
+		write_name(ce->name);
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len =3D max_prefix_len;
@@ -68,7 +98,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 		return;
=20
 	fputs(tag, stdout);
-	write_name(ent->name);
+	write_dir_entry(ent);
 }
=20
 static void show_other_files(struct dir_struct *dir)
@@ -170,7 +200,7 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 		       find_unique_abbrev(ce->sha1,abbrev),
 		       ce_stage(ce));
 	}
-	write_name(ce->name);
+	write_ce_name(ce);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
=20
@@ -501,6 +531,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("if any <file> is not in the index, treat this as an error")),
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
 			N_("pretend that paths removed since <tree-ish> are still present")=
),
+		OPT__COLOR(&use_color, N_("show color")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
@@ -548,6 +579,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
+	if (want_color(use_color))
+		parse_ls_color();
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
--=20
1.9.0.40.gaa8c3ea
