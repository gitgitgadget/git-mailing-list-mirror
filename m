From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/19] ls_colors.c: parse color.ls.* from config file
Date: Sun, 30 Nov 2014 15:55:50 +0700
Message-ID: <1417337767-4505-3-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:56:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0J7-0002X7-HI
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbaK3I4i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:56:38 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44805 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaK3I4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:56:37 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so9158621pab.20
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pTHupYtYjidSgEC+OteDXXfgnrzU0EIaGf1L7S0AaPA=;
        b=U2goFK1GUTlXvKBGFn2DhRAat6wCdQfwXtX6Rd95MUspo0w14J32Gp0MBCwZfEFaM5
         vPPC9kIDm7cu3GEWBm08wZUiw0KSxhst0MKUHBU9C69szdff5U5Q7HYfNGLwI1dllXgc
         8dksGdfHVDVo94v74i4SBy/zJHV2XWj024YYJgYkdbbmj1rWb7vdhCDK/jEj54h1O80G
         1wt54aBh9q6A3FuECRGrglbvmpsqB7VsLhGCd0jqbM55yFA8GX50roUsFxhH0D6RxTIr
         dtPvW9JQczQX1iDtNDAe7P6qo5roj0B55W/1jt16BHRmPDJkOwHQOMsStiCn3CV8AdUb
         j6gg==
X-Received: by 10.66.66.196 with SMTP id h4mr58602294pat.127.1417337796864;
        Sun, 30 Nov 2014 00:56:36 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id 1sm14365597pdw.87.2014.11.30.00.56.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:56:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:56:35 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260425>

This is the second (and preferred) source for color information. This
will override $LS_COLORS.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 11 +++++++++++
 ls_colors.c              | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..2090866 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -940,6 +940,17 @@ color.status.<slot>::
 	to red). The values of these variables may be specified as in
 	color.branch.<slot>.
=20
+color.ls.<slot>::
+	Use customized color for file name colorization. If not set
+	and the environment variable LS_COLORS is set, color settings
+	from $LS_COLORS are used. `<slot>` can be `normal`, `file`,
+	`directory`, `symlink`, `fifo`, `socket`, `block`, `char`,
+	`missing`, `orphan`, `executable`, `door`, `setuid`, `setgid`,
+	`sticky`, `otherwritable`, `stickyotherwritable`, `cap`,
+	`multihardlink`. The values of these variables may be
+	specified as in color.branch.<slot>.
+
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/ls_colors.c b/ls_colors.c
index eb944f4..3e35ffe 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -68,6 +68,14 @@ static const char *const indicator_name[] =3D {
 	NULL
 };
=20
+static const char* const config_name[] =3D {
+	"", "", "", "", "normal", "file", "directory", "symlink",
+	"fifo", "socket", "block", "char", "missing", "orphan", "executable",
+	"door", "setuid", "setgid", "sticky", "otherwritable",
+	"stickyotherwritable", "cap", "multihardlink", "",
+	NULL
+};
+
 struct bin_str {
 	size_t len;			/* Number of bytes */
 	const char *string;		/* Pointer to the same */
@@ -285,6 +293,23 @@ static int get_funky_string(char **dest, const cha=
r **src, int equals_end,
 	return state !=3D ST_ERROR;
 }
=20
+static int ls_colors_config(const char *var, const char *value, void *=
cb)
+{
+	int slot;
+	if (!starts_with(var, "color.ls."))
+		return 0;
+	var +=3D 9;
+	for (slot =3D 0; config_name[slot]; slot++)
+		if (!strcasecmp(var, config_name[slot]))
+			break;
+	if (!config_name[slot])
+		return 0;
+	if (!value)
+		return config_error_nonbool(var);
+	color_parse(value, ls_colors[slot]);
+	return 0;
+}
+
 void parse_ls_color(void)
 {
 	const char *p;			/* Pointer to character being parsed */
@@ -395,4 +420,5 @@ void parse_ls_color(void)
=20
 	if (!strcmp(ls_colors[LS_LN], "target"))
 		color_symlink_as_referent =3D 1;
+	git_config(ls_colors_config, NULL);
 }
--=20
2.2.0.60.gb7b3c64
