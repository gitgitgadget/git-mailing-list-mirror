From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/16] list-files: add -F/--classify
Date: Mon,  9 Mar 2015 17:18:27 +0700
Message-ID: <1425896314-10941-10-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumz-0002AN-I2
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbbCIKTu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:50 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:43390 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbbCIKTs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:48 -0400
Received: by pdjp10 with SMTP id p10so56792114pdj.10
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=d+UDtx1v2f95MNNjM5ivvEH2GUEYWRBknyAqmLa7d8s=;
        b=c7aE6klFxUM946W+j/LFLGXGWeTAA8EFMqC53X3l2i02DtlOip8Gh0zUGF0PsrdygD
         AFrpV5YYzbrL93WzAYq4y5kHM59kULy3O9/ywwNs1HECPAElkNsPOBTzi7cV24wSrsdo
         bF8JAQAKt96AC3GreQXqugsGgso4tbicVkAMGUEbxcl4996UzCv7e5ktkN5SGwpU8ULe
         cjDgoMtDbldxvQn0+PABOgy0eRBO5vyb6jfBY4DAyow0VEisQbniD2TVP4JGyOYmpf75
         3jV29eb4aliiYJ75eg/qtvidZuL18XwoLQwbvfz7zl+8A/11qRVXBN2TV0Y24dNiHzpT
         3dCg==
X-Received: by 10.66.144.100 with SMTP id sl4mr50857889pab.128.1425896387461;
        Mon, 09 Mar 2015 03:19:47 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id d9sm18509311pdk.3.2015.03.09.03.19.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:43 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265151>

This appends an indicator after the file name if it's executable, a
directory and so on, like in GNU ls. In fact append_indicator() is a
rewrite from get_type_indicator() in coreutils.git commit
7326d1f1a67edf21947ae98194f98c38b6e9e527.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 316f59c..97fa8bf 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -15,6 +15,7 @@ static unsigned int colopts;
 static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
+static int show_indicator;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -31,9 +32,33 @@ struct option ls_options[] =3D {
 	OPT_SET_INT('R', "recursive", &max_depth,
 		    N_("shortcut for --max-depth=3D-1"), -1),
 	OPT__COLOR(&use_color, N_("show color")),
+	OPT_BOOL('F', "classify", &show_indicator,
+		 N_("append indicator (one of */=3D>@|) to entries")),
 	OPT_END()
 };
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
 static void add_one(struct string_list *result, const char *name, int =
mode,
 		    const char *tag)
 {
@@ -47,6 +72,8 @@ static void add_one(struct string_list *result, const=
 char *name, int mode,
 		color_filename(&sb, name, quoted.buf, mode, 1);
 		strbuf_release(&quoted);
 	}
+	if (show_indicator)
+		append_indicator(&sb, mode);
 	strbuf_insert(&sb, 0, "   ", 3);
 	sb.buf[0] =3D tag[0];
 	sb.buf[1] =3D tag[1];
--=20
2.3.0.rc1.137.g477eb31
