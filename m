From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/25] ls_colors.c: add a function to color a file name
Date: Mon,  6 Apr 2015 20:52:12 +0700
Message-ID: <1428328354-14897-4-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7SW-0004nk-KK
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbbDFNw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:52:56 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34003 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbbDFNwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:52:55 -0400
Received: by pdbni2 with SMTP id ni2so45278035pdb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L6wa+MDEIfyvPI5sfctMQMd1sW+YAuimbZ6wE9eX428=;
        b=kagAuBzR+hAI4Z7olINHklC2z5gLXhtbbEhw6nmN9xW2Q+eckF15KrBZ1olmCc3V2W
         lm8YdGC8VM/3A8W4Nd/xh5TP0pyDa80lnOIiokbfCM78CEBRWH/xBaXdwVKQjvpEPznc
         30WnXS5S+RkdjvwwN9igzmCitp2Qp+wLw9un6e7Crwg8E3VkG+y1dKYjPHu4Ptc1flYj
         eoxakSUCPhlzljtrNlF7T0Hm7iwLRWh8LM5ST2RXkebMcVE6ND8X2xuHiz1nP6PWOxL4
         AP6w+WxydIT4W6YYydYeK9qs3XmubGGm1Dw7TsuSzR4dptNBteSWW/O+mZkqs1kNylNe
         W7rA==
X-Received: by 10.66.227.169 with SMTP id sb9mr27957491pac.11.1428328375097;
        Mon, 06 Apr 2015 06:52:55 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id ks1sm4767027pbc.58.2015.04.06.06.52.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:52:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:05 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266848>

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
index 2dc2d39..f84ef0f 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -424,3 +424,69 @@ void parse_ls_color(void)
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
2.3.0.rc1.137.g477eb31
