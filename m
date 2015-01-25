From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/21] ls-files: buffer full item in strbuf before printing
Date: Sun, 25 Jan 2015 19:37:40 +0700
Message-ID: <1422189476-7518-6-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:27:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMHo-0001t2-4H
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbbAYM1Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:27:24 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:45459 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbbAYM1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:27:23 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so6507768pab.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o038nXyYQXN3YMScAIMLzEoqxXsWuHSMbS/MKJlRnYU=;
        b=0yiTzCi/7OjuOGSCpq6GO11i/z2IlIVtt7ForQGRxsbFe4EIEeEIHAls82tyZ2KGmw
         qGXneVxXXPx4VmPYQsoTp5j1L01vsOXQFv7Qe4sliOBvQI9rCNHwVys1qczNtX7eLfMF
         Ks4ApCQ7w7HQPYZb8VwsRwPbPNHHf4nhEdTiE06mfteNVGXOHTQaX9hRAt1oNO1jUYVJ
         Oa0ZMXRy+4DF672F+3ZPllCRP3OMmoKYJT8e4bwWhGPFWuOzL3jJzTBTr6cD/vgirslv
         v1/37OYSWT5FQIvgReQ2qP3fnNq1xyqvm+GWmetvI/9wetFOcFCqlLaaBm2pw59c/pMF
         vRrA==
X-Received: by 10.66.124.227 with SMTP id ml3mr26745855pab.28.1422188842757;
        Sun, 25 Jan 2015 04:27:22 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id g11sm7228291pat.24.2015.01.25.04.27.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:27:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:38:46 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263002>

Buffering so that we can manipulate the strings (e.g. coloring)
further before finally printing them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 48 +++++++++++++++++++++++++++++++++++-----------=
--
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 99cee20..b6f0d9f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -47,18 +47,30 @@ static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
=20
-static void write_name(const char *name)
+static void write_name(struct strbuf *sb, const char *name)
 {
 	/*
 	 * With "--full-name", prefix_len=3D0; this caller needs to pass
 	 * an empty string in that case (a NULL is good for "").
 	 */
-	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
-				   stdout, line_terminator);
+	const char *real_prefix =3D prefix_len ? prefix : NULL;
+	if (!line_terminator) {
+		struct strbuf sb2 =3D STRBUF_INIT;
+		strbuf_addstr(sb, relative_path(name, real_prefix, &sb2));
+		strbuf_release(&sb2);
+	} else
+		quote_path_relative(name, real_prefix, sb);
+	strbuf_addch(sb, line_terminator);
+}
+
+static void strbuf_fputs(struct strbuf *sb, FILE *fp)
+{
+	fwrite(sb->buf, sb->len, 1, fp);
 }
=20
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
+	static struct strbuf sb =3D STRBUF_INIT;
 	int len =3D max_prefix_len;
=20
 	if (len >=3D ent->len)
@@ -67,8 +79,10 @@ static void show_dir_entry(const char *tag, struct d=
ir_entry *ent)
 	if (!dir_path_match(ent, &pathspec, len, ps_matched))
 		return;
=20
-	fputs(tag, stdout);
-	write_name(ent->name);
+	strbuf_reset(&sb);
+	strbuf_addstr(&sb, tag);
+	write_name(&sb, ent->name);
+	strbuf_fputs(&sb, stdout);
 }
=20
 static void show_other_files(struct dir_struct *dir)
@@ -134,6 +148,7 @@ static void show_killed_files(struct dir_struct *di=
r)
=20
 static void show_ce_entry(const char *tag, const struct cache_entry *c=
e)
 {
+	static struct strbuf sb =3D STRBUF_INIT;
 	int len =3D max_prefix_len;
=20
 	if (len >=3D ce_namelen(ce))
@@ -161,16 +176,18 @@ static void show_ce_entry(const char *tag, const =
struct cache_entry *ce)
 		tag =3D alttag;
 	}
=20
+	strbuf_reset(&sb);
 	if (!show_stage) {
-		fputs(tag, stdout);
+		strbuf_addstr(&sb, tag);
 	} else {
-		printf("%s%06o %s %d\t",
-		       tag,
-		       ce->ce_mode,
-		       find_unique_abbrev(ce->sha1,abbrev),
-		       ce_stage(ce));
+		strbuf_addf(&sb, "%s%06o %s %d\t",
+			    tag,
+			    ce->ce_mode,
+			    find_unique_abbrev(ce->sha1, abbrev),
+			    ce_stage(ce));
 	}
-	write_name(ce->name);
+	write_name(&sb, ce->name);
+	strbuf_fputs(&sb, stdout);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
=20
@@ -206,7 +223,12 @@ static void show_ru_info(void)
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
 			       find_unique_abbrev(ui->sha1[i], abbrev),
 			       i + 1);
-			write_name(path);
+			/*
+			 * With "--full-name", prefix_len=3D0; this caller needs to pass
+			 * an empty string in that case (a NULL is good for "").
+			 */
+			write_name_quoted_relative(path, prefix_len ? prefix : NULL,
+						   stdout, line_terminator);
 		}
 	}
 }
--=20
2.2.0.84.ge9c7a8a
