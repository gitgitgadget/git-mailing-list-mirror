From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/21] list-files: add -F/--classify
Date: Sun, 25 Jan 2015 19:37:53 +0700
Message-ID: <1422189476-7518-19-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMJn-0004N0-3L
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbbAYM3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:29:25 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:44781 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbbAYM3B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:29:01 -0500
Received: by mail-pd0-f173.google.com with SMTP id fp1so6851969pdb.4
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=S2FWaf58m6Jnh/vsJ0PqMt5dMdaAttpOm0b8vZSiaro=;
        b=0yV6G0uNOVzjR9EzA+hoVw1xwLRqu8Cp6s7v4iAMU/YNUYKLmKdWcXhzL3AyrWqIvT
         u4OeKwR0nGFbur4BZC2Mh8yBpCexGHdbRehBpSD7BYRsR/foPQOR9NdNQ9D+RBRqeaiU
         5enC4T8gCFTeDWcGN8sDB97lB/e2P0EAb5TtBCslNXYUm7QaECL6W1UBLVJNz4RAy8G5
         shaPKIlXso1pfYX+86stG2pOKm8knOAYqsfzZoAB3eoZ1uhcrb1xctsQIcpiIwC7FSD4
         jQD08+h9bbYPSIZONvon18w8Y2WNmVW5rpiz4A/GiUUJyQxAADZsM2UoKodtxQm3qUX2
         kxcQ==
X-Received: by 10.68.234.134 with SMTP id ue6mr26076319pbc.47.1422188941416;
        Sun, 25 Jan 2015 04:29:01 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id co9sm2986281pdb.69.2015.01.25.04.28.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:29:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:40:25 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263017>

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
index 29b5c2e..bbeb4ce 100644
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
@@ -706,6 +735,8 @@ int cmd_ls_files(int argc, const char **argv, const=
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
2.2.0.84.ge9c7a8a
