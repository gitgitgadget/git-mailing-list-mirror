From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/17] ls: show directories as well as files
Date: Wed, 26 Mar 2014 20:48:17 +0700
Message-ID: <1395841697-11742-18-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoD1-0000zH-6Q
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbaCZNt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:49:29 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:51284 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754178AbaCZNt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:49:29 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so1962257pad.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W890Be/HdoX5M1XXEptzDahMxcu3rod4VL8JDy/1Ing=;
        b=mXGGxInInEb3jMjW2DByhCZ8kj8w84I0diDHOnISgDtw+/Qt5y69Iz4CcVizJi2rg0
         ODf/vz4HQTe1hbmEsLIEktbzuKxsMaIMO22S/y+/guUsLY4J9gFh5ANl1GUPoZlImKA6
         +BHFyO7njnB+GXrlmrOnKF+Ma8+IcxltrKy1abJ2x3blTp3IQ0/D6lTf63+fiQJnmBjF
         hL0NRZB/r39LZIROYvxcvv6DtNfNebq9hYOzY8pMSwYwxGDOq9Qa4SC6kCYr4XlKcP9A
         aJ0v1sG10jZ7I10FHmqa08DdXMmPPViLgjSEY1xWiLjahbg1TS2ZfkbFlad7DTJ/1zM2
         /f4g==
X-Received: by 10.68.7.66 with SMTP id h2mr85742875pba.91.1395841768621;
        Wed, 26 Mar 2014 06:49:28 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id vw9sm58542642pbc.68.2014.03.26.06.49.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:49:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:50:20 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245196>

The index does not store directories explicitly (except submodules) so
we have to figure them out from file list. The function
show_directories() deliberately generates duplicate directories and
expects the previous patch to remove duplicates.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index cd8e35c..7e50192 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -27,6 +27,7 @@ static int show_resolve_undo;
 static int show_modified;
 static int show_killed;
 static int show_valid_bit;
+static int show_dirs;
 static int line_terminator =3D '\n';
 static int debug_mode;
 static int use_color;
@@ -337,6 +338,43 @@ static void show_files(struct dir_struct *dir)
 	}
 }
=20
+static void show_directories(const struct cache_entry *ce)
+{
+	static const char *last_directory;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *p =3D ce->name + prefix_len;
+	const char *sep;
+
+	if (last_directory) {
+		int len =3D strlen(last_directory);
+		if (!strncmp(ce->name, last_directory, len) &&
+		    ce->name[len] =3D=3D '/')
+			p +=3D len + 1;
+	}
+
+	while (*p && (sep =3D strchr(p, '/'))) {
+		struct strbuf sb2 =3D STRBUF_INIT;
+		strbuf_reset(&sb);
+		strbuf_add(&sb, ce->name, sep - ce->name);
+		p =3D sep + 1;
+		if (!match_pathspec(&pathspec, sb.buf, sb.len,
+				    prefix_len, NULL, 1))
+			continue;
+		write_name(&sb2, sb.buf);
+		if (want_color(use_color)) {
+			struct strbuf sb3 =3D STRBUF_INIT;
+			color_filename(&sb3, ce->name, sb2.buf, S_IFDIR, 1);
+			strbuf_release(&sb2);
+			sb2 =3D sb3;
+		}
+		if (show_tag)
+			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
+		last_directory =3D strbuf_detach(&sb, NULL);
+		strbuf_fputs(&sb2, last_directory, NULL);
+		strbuf_release(&sb2);
+	}
+}
+
 static void show_files_compact(struct dir_struct *dir)
 {
 	int i;
@@ -357,6 +395,8 @@ static void show_files_compact(struct dir_struct *d=
ir)
 		const struct cache_entry *ce =3D active_cache[i];
 		struct stat st;
 		int err, shown =3D 0;
+		if (show_dirs)
+			show_directories(ce);
 		if ((dir->flags & DIR_SHOW_IGNORED) &&
 		    !ce_excluded(dir, ce))
 			continue;
@@ -825,6 +865,7 @@ int cmd_ls(int argc, const char **argv, const char =
*cmd_prefix)
 	use_color =3D -1;
 	max_depth =3D 0;
 	show_tag =3D -1;
+	show_dirs =3D 1;
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_ls_options,
 			     ls_usage, 0);
--=20
1.9.1.345.ga1a145c
