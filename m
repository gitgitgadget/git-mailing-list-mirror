From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/19] ls-files: buffer full item in strbuf before printing
Date: Sun, 30 Nov 2014 15:55:53 +0700
Message-ID: <1417337767-4505-6-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:57:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0Jg-0002nO-TI
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaK3I5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:57:03 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54373 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbaK3I5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:57:00 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so9222706pad.9
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=78F6nIzl+EXQm6dyLEiKYliElV7jegKDzyp0V49+0Bo=;
        b=rA2DpTZC4kMtui5YKucvCVdi+HtyD8MdmqKhN/diJA89RpnO+pxkWV5CqXFx8GKX3A
         O3QM+gOuZb0K2dW3tlomun7HqzeqCqd/+cSd57kJHNgpY6Dooa5X91jsx0P8S/dbu2H9
         Sc2Scm5Jz0Lz7gY7nOpHQW6kzOSHVD3V/mWlI31n2Y1xIG6+rlxCxSR0I006OerIXYnL
         xM6D98glcht7NsxIXpZYUPWi4Mz+WFLX9q9QHzvgT2ha+3zvhucvlapYZwtl8lWUxjur
         HdHRc4TvL5xF0iWuBSvWDAW1S3N6A7p/TbzSzI3hwPWPMKoXeUEedXfTwNYTDPdZ31e0
         DbrQ==
X-Received: by 10.68.226.6 with SMTP id ro6mr88766730pbc.31.1417337820398;
        Sun, 30 Nov 2014 00:57:00 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id aq1sm14329330pbd.29.2014.11.30.00.56.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:56:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:56:59 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260428>

Buffering so that we can manipulate the strings (e.g. coloring)
further before finally printing them.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 48 +++++++++++++++++++++++++++++++++++-----------=
--
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 99cee20..f20c0fd 100644
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
2.2.0.60.gb7b3c64
