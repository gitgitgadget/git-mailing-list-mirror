From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/21] list-files: add -F/--classify
Date: Sun,  8 Feb 2015 16:01:36 +0700
Message-ID: <1423386099-19994-19-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNml-0006RE-BP
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbbBHJEC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:04:02 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:44687 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbbBHJD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:57 -0500
Received: by mail-pa0-f42.google.com with SMTP id bj1so27072836pad.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YI0hcoTTHfHQ0WisGNn6hgBwYebNF6KTfbcR3KJNpvc=;
        b=JYlU2QVXlcm+5FWlWCyxxE7yTOL4F6t+hMNT4kxW96GAx7IhiS+eFxbC0MaFkN/aeu
         OJEA+Rll5hiqn0au/cOjdO32XziHYH3Q+K+TkqYs3IrNho/6a6RbXDf6eSl/8Z5HUUdZ
         +2GTAXSL4nqCiyBAT86UXWOwgZlQUz9R+Q25u46cTo85Ayt15hjRyIUHL0Ydny4f9xgq
         EPSKBFmlbiRMrZID35t7ctcHSD21q4V9j/CPAfas7+IqyjdgFRhdTNmcEZaf0a+3u6fL
         dby0eU3tnREMyQbUjypPcDymg2Q+VN2rpv2+O65+Uc9ikr3L1BxQU8rSlxLI1FZRp8rc
         +u4Q==
X-Received: by 10.68.95.229 with SMTP id dn5mr19394067pbb.160.1423386237466;
        Sun, 08 Feb 2015 01:03:57 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id n2sm12992010pdo.0.2015.02.08.01.03.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:04:05 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263505>

This appends an indicator after the file name if it's executable, a
directory and so on, like in GNU ls. In fact append_indicator() is a
rewrite from get_type_indicator() in coreutils.git commit
7326d1f1a67edf21947ae98194f98c38b6e9e527.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-list-files.txt |  6 ++++++
 builtin/ls-files.c               | 31 +++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/git-list-files.txt b/Documentation/git-list-=
files.txt
index 9d4c127..475c6da 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -52,6 +52,12 @@ OPTIONS
 	multiple file selections. See linkgit::git-ls-files[1] option
 	`-t` for more information.
=20
+-F::
+--classify::
+	Append indicator (one of `*/=3D>@|`, which is executable,
+	directory, socket, Solaris door, symlink, or fifo
+	respectively) to entries.
+
 -R::
 --recursive::
 	Equivalent of `--max-depth=3D-1` (infinite recursion).
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6be08fb..9e444ff 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -29,6 +29,7 @@ static int show_killed;
 static int show_valid_bit;
 static int show_tag;
 static int show_dirs;
+static int show_indicator;
 static int line_terminator =3D '\n';
 static int debug_mode;
 static int use_color;
@@ -77,6 +78,28 @@ static void write_name(struct strbuf *sb, const char=
 *name)
 		quote_path_relative(name, real_prefix, sb);
 }
=20
+static void append_indicator(struct strbuf *sb, mode_t mode)
+{
+	char c =3D 0;
+	if (S_ISREG(mode)) {
+		if (mode & (S_IXUSR | S_IXGRP | S_IXOTH))
+			c =3D '*';
+	} else if (S_ISDIR(mode))
+		c =3D '/';
+	else if (S_ISLNK(mode))
+		c =3D '@';
+	else if (S_ISFIFO(mode))
+		c =3D '|';
+	else if (S_ISSOCK(mode))
+		c =3D '=3D';
+#ifdef S_ISDOOR
+	else if (S_ISDOOR(mode))
+		c =3D '>';
+#endif
+	if (c)
+		strbuf_addch(sb, c);
+}
+
 static void strbuf_fputs(struct strbuf *sb, const char *full_name, FIL=
E *fp)
 {
 	if (column_active(colopts) || porcelain) {
@@ -99,6 +122,8 @@ static void write_dir_entry(struct strbuf *sb, const=
 struct dir_entry *ent)
 		color_filename(sb, ent->name, quoted.buf, st.st_mode, 1);
 	else
 		strbuf_addbuf(sb, &quoted);
+	if (show_indicator && st.st_mode)
+		append_indicator(sb, st.st_mode);
 	strbuf_addch(sb, line_terminator);
 	strbuf_release(&quoted);
 }
@@ -202,6 +227,8 @@ static int show_as_directory(const struct cache_ent=
ry *ce)
 		}
 		if (show_tag)
 			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
+		if (show_indicator)
+			append_indicator(&sb2, S_IFDIR);
 		strbuf_fputs(&sb2, strbuf_detach(&sb, NULL), NULL);
 		strbuf_release(&sb2);
 		return 1;
@@ -218,6 +245,8 @@ static void write_ce_name(struct strbuf *sb, const =
struct cache_entry *ce)
 		color_filename(sb, ce->name, quoted.buf, ce->ce_mode, 1);
 	else
 		strbuf_addbuf(sb, &quoted);
+	if (show_indicator)
+		append_indicator(sb, ce->ce_mode);
 	strbuf_addch(sb, line_terminator);
 	strbuf_release(&quoted);
 }
@@ -714,6 +743,8 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			DIR_SHOW_IGNORED),
 		OPT_BOOL('u', "unmerged", &show_unmerged,
 			N_("show unmerged files")),
+		OPT_BOOL('F', "classify", &show_indicator,
+			 N_("append indicator (one of */=3D>@|) to entries")),
 		OPT__COLOR(&use_color, N_("show color")),
 		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
 		OPT_SET_INT('1', NULL, &colopts,
--=20
2.3.0.rc1.137.g477eb31
