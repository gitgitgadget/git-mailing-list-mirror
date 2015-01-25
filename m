From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/21] ls_colors.c: add a function to color a file name
Date: Sun, 25 Jan 2015 19:37:38 +0700
Message-ID: <1422189476-7518-4-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:27:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMHb-0001af-K2
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbbAYM1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:27:11 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:57418 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbbAYM1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:27:09 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so6463414pab.11
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OQMZuJna9DFkFVvjwt7HB5Ps+6kerXzxF8A2FDydU6Y=;
        b=eKQrYiWPWGjX5QmWJkXhNQ9teLkgJZKYNZzXT/90aZr/zrh4MEHiENE79LqZ7PVp0Z
         V+2A4oPoJXMFl1pIv/E0RTP95rcJxm7WTT59jf/YaUCvYJ6mF1if8xvkwsBxXaQCjXT3
         +CbpptIRhe5vd5buTWXxSqS0YpagfNo4kXT1BKfXeQJOjMH95Vjesz7WJExMGaCT1+6E
         DBvuh3nn12oa4dQg/hZftjGtupnpqZvilxZ96+v44XLd6elJwhzWWL/AvWVacG95zHnb
         kKJ2v+4GCA6fqdB2V/Smj/NL7yb9xRLb2X0t4OjhutxIX93P93NE4FdkOfD9uH4ZEcrB
         SydQ==
X-Received: by 10.70.48.170 with SMTP id m10mr25984379pdn.142.1422188829028;
        Sun, 25 Jan 2015 04:27:09 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id a13sm7125481pdm.44.2015.01.25.04.27.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:27:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:38:32 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263000>

The new function is based on print_color_indicator() from commit
7326d1f1a67edf21947ae98194f98c38b6e9e527 in coreutils.git.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 color.h     |  2 ++
 ls_colors.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 68 insertions(+)

diff --git a/color.h b/color.h
index 3eaa5bd..b6904a3 100644
--- a/color.h
+++ b/color.h
@@ -94,5 +94,7 @@ void color_print_strbuf(FILE *fp, const char *color, =
const struct strbuf *sb);
 int color_is_nil(const char *color);
=20
 void parse_ls_color(void);
+void color_filename(struct strbuf *sb, const char *name,
+		    const char *display_name, mode_t mode, int linkok);
=20
 #endif /* COLOR_H */
diff --git a/ls_colors.c b/ls_colors.c
index 08e7068..7d2e2e0 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -422,3 +422,69 @@ void parse_ls_color(void)
 		color_symlink_as_referent =3D 1;
 	git_config(ls_colors_config, NULL);
 }
+
+void color_filename(struct strbuf *sb, const char *name,
+		    const char *display_name, mode_t mode, int linkok)
+{
+	int type;
+	struct color_ext_type *ext;	/* Color extension */
+
+	if (S_ISREG(mode)) {
+		type =3D LS_FL;
+		if ((mode & S_ISUID) !=3D 0)
+			type =3D LS_SU;
+		else if ((mode & S_ISGID) !=3D 0)
+			type =3D LS_SG;
+		else if ((mode & (S_IXUSR | S_IXGRP | S_IXOTH)) !=3D 0)
+			type =3D LS_EX;
+	} else if (S_ISDIR(mode)) {
+		if ((mode & S_ISVTX) && (mode & S_IWOTH))
+			type =3D LS_TW;
+		else if ((mode & S_IWOTH) !=3D 0)
+			type =3D LS_OW;
+		else if ((mode & S_ISVTX) !=3D 0)
+			type =3D LS_ST;
+		else
+			type =3D LS_DI;
+	} else if (S_ISLNK(mode))
+		type =3D (!linkok && *ls_colors[LS_OR]) ? LS_OR : LS_LN;
+	else if (S_ISFIFO(mode))
+		type =3D LS_PI;
+	else if (S_ISSOCK(mode))
+		type =3D LS_SO;
+	else if (S_ISBLK(mode))
+		type =3D LS_BD;
+	else if (S_ISCHR(mode))
+		type =3D LS_CD;
+#ifdef S_ISDOOR
+	else if (S_ISDOOR(mode))
+		type =3D LS_DO;
+#endif
+	else
+		/* Classify a file of some other type as C_ORPHAN.  */
+		type =3D LS_OR;
+
+	/* Check the file's suffix only if still classified as C_FILE.  */
+	ext =3D NULL;
+	if (type =3D=3D LS_FL) {
+		/* Test if NAME has a recognized suffix.  */
+		size_t len =3D strlen(name);
+		const char *p =3D name + len;		/* Pointer to final \0.  */
+		for (ext =3D color_ext_list; ext !=3D NULL; ext =3D ext->next) {
+			if (ext->ext.len <=3D len &&
+			    !strncmp(p - ext->ext.len, ext->ext.string, ext->ext.len))
+				break;
+		}
+	}
+
+	if (display_name)
+		name =3D display_name;
+	if (ext)
+		strbuf_addf(sb, "\033[%.*sm%s%s",
+			    (int)ext->seq.len, ext->seq.string,
+			    name, GIT_COLOR_RESET);
+	else if (*ls_colors[type])
+		strbuf_addf(sb, "%s%s%s", ls_colors[type], name, GIT_COLOR_RESET);
+	else
+		strbuf_addstr(sb, name);
+}
--=20
2.2.0.84.ge9c7a8a
