From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/18] ls-files: buffer full item in strbuf before printing
Date: Sun, 30 Mar 2014 20:55:56 +0700
Message-ID: <1396187769-30863-6-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGDp-0002wZ-16
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaC3N4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:16 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57609 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaC3N4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:11 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so6824227pdj.12
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pPf7tbn9dMSgp51CKAdw4rT5YQAnEp0NeLiqNI3pfyc=;
        b=XcdANMIE7/JI0i/EbH0r9X8XHWMvHF30m22JW+LkpOpBUzpvf5AdDcCK9RjD10yrPH
         93BcC3L8pTehwBZxWwbefYXbR1CcG4TD0L4rTPW1zZ+NnjIiTLDRd96FjkadIX6A6qr8
         4H1//W/0v3sTO5ApZi4JYZBeKBFTK14ko+3I6UJkZ+v/n+b5azkflWNjLJjs9JwwVab2
         pRFPEVOn5s26de+Qjq151Xbz2qe6Bddk0FIO00AaEAXpca/18udkMpHsUSPU/oYXU6UP
         H3xBdV3YzEv56vQLIIIC2T+tpiY3F7DhNo8uwfN1FBkWNMwN3hc2osR2QrBMSuOUQBwr
         yPxw==
X-Received: by 10.66.136.103 with SMTP id pz7mr410744pab.140.1396187771306;
        Sun, 30 Mar 2014 06:56:11 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id pi1sm26223809pac.14.2014.03.30.06.56.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:08 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245469>

Buffering so that we can manipulate the strings (e.g. coloring)
further before finally printing them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 48 +++++++++++++++++++++++++++++++++++-----------=
--
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 47c3880..6e30592 100644
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
+			    find_unique_abbrev(ce->sha1,abbrev),
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
1.9.1.345.ga1a145c
