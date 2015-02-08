From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/21] ls-files: buffer full item in strbuf before printing
Date: Sun,  8 Feb 2015 16:01:23 +0700
Message-ID: <1423386099-19994-6-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:02:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNlZ-0005tO-PJ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbbBHJCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:02:51 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40324 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbbBHJCr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:02:47 -0500
Received: by pdev10 with SMTP id v10so6990900pde.7
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0Vr5FTWzQc89caybQ/Z7w+rEHqHh8n9UPatc4edjpkI=;
        b=SuD0FHnb3C+S4UNZ/LltsafVmoTFPufUif8fhIU1wIMxNTnVbiBBX67NPisuO2HfdR
         +W8Hk0bwQl9d8NooSLdDrqh0IvitscNzOXgQgbTkBJj2uxbKu9jWr+dwBURbNgwuZV2S
         UBGEhtmROLVuzwC4XYFqVI/LJajJp9uqOkrSiBwjeymLEPQDhwggt4JDYflV8JOQZp9G
         d4PNoi/8AKa2lfeh3vQP1v5meDEWRRciaZcWhMTAh2bkFu2XGalHXfK95X4hE9JEzAkx
         u1rnTGu6acFx2ArNF8VEd1IzOSq4rjCl7hr9MOU8qdTe/lYtpABuPa+Aj2HOZip3BviT
         bzNg==
X-Received: by 10.66.161.233 with SMTP id xv9mr19235830pab.24.1423386166614;
        Sun, 08 Feb 2015 01:02:46 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id c2sm12972270pdi.25.2015.02.08.01.02.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:02:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:02:54 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263492>

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
2.3.0.rc1.137.g477eb31
