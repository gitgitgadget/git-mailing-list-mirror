From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/18] list-files: add -F/--classify
Date: Sun, 30 Mar 2014 20:56:08 +0700
Message-ID: <1396187769-30863-18-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEm-0003dD-UE
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbaC3N5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:57:19 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39052 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbaC3N5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:57:18 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so6828199pde.39
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JE+N0c/Zxt0sP/Z56pZ6Ilz//OXZ8rAvEDeG7RhxXdE=;
        b=Biugs+Cr9Rt5dL6W82XDZwmiHzYsbhcPPeWLMJRS07drVhWbia45VRXD7vp0JvrFvL
         LSBKJxysTO6NsWlYHKQ0QBbJJPiq9kymCna3XHWcYxvHLI0ZnAEusoim9K/Owrt8SRs8
         ZZ5U8DIZP66Cmzr/9q97kKYLqOe6aJQVoAzkgy9O2GRivf+q/vabTyvww8s3XcJgmdMR
         WuVjjKWFfo9JOV54q7AvMzeHYea0A+9AxCkZU37LFWkXPcw5Vl424oDJ3asCDxARD4yn
         j03kxREV5FOtNVve9R9pzBaH1328KF1Y1U9VIu+FfhJo1Wx3p4OFiZ4ZZTjyiPjVbUCs
         H0ww==
X-Received: by 10.68.226.197 with SMTP id ru5mr19345587pbc.77.1396187837718;
        Sun, 30 Mar 2014 06:57:17 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id bz4sm37357845pbb.12.2014.03.30.06.57.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:57:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:58:14 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245481>

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
index 0ef616b..22084eb 100644
--- a/Documentation/git-list-files.txt
+++ b/Documentation/git-list-files.txt
@@ -51,6 +51,12 @@ OPTIONS
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
index 9dc1c39..2d475f0 100644
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
@@ -189,6 +214,8 @@ static void write_ce_name(struct strbuf *sb, const =
struct cache_entry *ce)
 		color_filename(sb, ce->name, quoted.buf, ce->ce_mode, 1);
 	else
 		strbuf_addbuf(sb, &quoted);
+	if (show_indicator)
+		append_indicator(sb, ce->ce_mode);
 	strbuf_addch(sb, line_terminator);
 	strbuf_release(&quoted);
 }
@@ -366,6 +393,8 @@ static void show_directories(const struct cache_ent=
ry *ce)
 		}
 		if (show_tag)
 			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
+		if (show_indicator)
+			append_indicator(&sb2, S_IFDIR);
 		last_directory =3D strbuf_detach(&sb, NULL);
 		strbuf_fputs(&sb2, last_directory, NULL);
 		strbuf_release(&sb2);
@@ -701,6 +730,8 @@ int cmd_ls_files(int argc, const char **argv, const=
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
1.9.1.345.ga1a145c
