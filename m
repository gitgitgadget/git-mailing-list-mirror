From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/17] ls_colors.c: add function to color a file name
Date: Wed, 26 Mar 2014 20:48:03 +0700
Message-ID: <1395841697-11742-4-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:48:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoBb-0007uj-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbaCZNsC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:02 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:50382 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbaCZNr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:47:57 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so1949481pbc.18
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8PTkjMWpdPrguNLp/XBiO/xwbujJNG3rd70LRgPhobA=;
        b=A9Nz4Sh9r06R+LyX6LYrfG/GfpZIlq5aZAvg+nToVmcET7L6legMO9OrBw35hE9fUX
         COGrSy3AW1XzEpYZCWnPwWyd2DKWLbxjw2jk59J2aF3nqKQQPOPhifeBa/sB2zbDTwzl
         o/6maXUef/E6IgQ5ZukRWN+XuvlOphiE86bgGH5E60HWZbzOCRzXoh82n5Z8kIXjBwsS
         MEEeE7CRIIw4WeETRt88hQ/HDKWHy1NdLh1Z1ORmR2NEH87qcgExKdO1VwKYDvBmR3Hg
         aY/XtBDBPLqVK/baXULRi/zYxV6aDDub3CXddyI67afCUNlyFocW9BOxEF/k4AZRN1N0
         2A4w==
X-Received: by 10.68.163.3 with SMTP id ye3mr86487125pbb.78.1395841677254;
        Wed, 26 Mar 2014 06:47:57 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id pe3sm58535321pbc.23.2014.03.26.06.47.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:47:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:48:49 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245182>

Tthe new function is based on print_color_indicator() from commit
7326d1f1a67edf21947ae98194f98c38b6e9e527 in coreutils.git.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 color.h     |  2 ++
 ls_colors.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 68 insertions(+)

diff --git a/color.h b/color.h
index 640fc48..398369a 100644
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
index cef5a92..1125329 100644
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
+	if (S_ISREG (mode)) {
+		type =3D LS_FL;
+		if ((mode & S_ISUID) !=3D 0)
+			type =3D LS_SU;
+		else if ((mode & S_ISGID) !=3D 0)
+			type =3D LS_SG;
+		else if ((mode & (S_IXUSR | S_IXGRP | S_IXOTH)) !=3D 0)
+			type =3D LS_EX;
+	} else if (S_ISDIR (mode)) {
+		if ((mode & S_ISVTX) && (mode & S_IWOTH))
+			type =3D LS_TW;
+		else if ((mode & S_IWOTH) !=3D 0)
+			type =3D LS_OW;
+		else if ((mode & S_ISVTX) !=3D 0)
+			type =3D LS_ST;
+		else
+			type =3D LS_DI;
+	} else if (S_ISLNK (mode))
+		type =3D (!linkok && *ls_colors[LS_OR]) ? LS_OR : LS_LN;
+	else if (S_ISFIFO (mode))
+		type =3D LS_PI;
+	else if (S_ISSOCK (mode))
+		type =3D LS_SO;
+	else if (S_ISBLK (mode))
+		type =3D LS_BD;
+	else if (S_ISCHR (mode))
+		type =3D LS_CD;
+#ifdef S_ISDOOR
+	else if (S_ISDOOR (mode))
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
1.9.1.345.ga1a145c
