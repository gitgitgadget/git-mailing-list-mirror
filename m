From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/25] list-files: add -F/--classify
Date: Mon,  6 Apr 2015 20:52:21 +0700
Message-ID: <1428328354-14897-13-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7TS-0005Ue-Of
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbbDFNxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:54 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34917 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbbDFNxy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:54 -0400
Received: by patj18 with SMTP id j18so45123336pat.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=atU5D+ckSzmb3kOxYy8RqZiHoHNcivD59llZ0n+17xM=;
        b=fZzjfli/xw95uQJPKcUTjNS8TOWkgpnyEShgBAeG3QpvaOIFB0ela9FokdsEu5ST3c
         aUm+Gaba8Djx4ss8kztqQtzKulqHVAnoaokLrXGLsUVm0iqjX9T1hY1PzBiYAllrkLas
         6/4d1PlckDIisYjygTwiW4q1aHGGdln7N8xsgfl2aZaMzn6uZnd6qVwcjTdcq06CjcGC
         qSXen6MUIrWsqNcTjrE1qDUyaKuKbRPP+Qc9DDOCMXuCUhxxYhdhs8FYA0qTEr7zsL3Y
         0+FN1vRBrQ/mrGKsIXgKQ8wKne3qt/pMSyxWdld4MtnqIVf3G7NxFsj6SWZAP0F6em9H
         /giA==
X-Received: by 10.68.254.226 with SMTP id al2mr27834373pbd.44.1428328433573;
        Mon, 06 Apr 2015 06:53:53 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id n5sm4800891pdh.27.2015.04.06.06.53.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:05 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266857>

This appends an indicator after the file name if it's executable, a
directory and so on, like in GNU ls. In fact append_indicator() is a
rewrite from get_type_indicator() in coreutils.git commit
7326d1f1a67edf21947ae98194f98c38b6e9e527.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 27 +++++++++++++++++++++++++++
 t/t7013-list-files.sh | 13 +++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 02a088d..31f1f25 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -34,6 +34,7 @@ static unsigned int colopts;
 static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
+static int show_indicator;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -51,6 +52,8 @@ struct option ls_options[] =3D {
 	OPT_SET_INT('R', "recursive", &max_depth,
 		    N_("shortcut for --max-depth=3D-1"), -1),
 	OPT__COLOR(&use_color, N_("show color")),
+	OPT_BOOL('F', "classify", &show_indicator,
+		 N_("append indicator (one of */=3D>@|) to entries")),
 	OPT_END()
 };
=20
@@ -204,6 +207,28 @@ static void cleanup_tags(struct item_list *result)
 	}
 }
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
 /* this is similar to quote_path_relative() except it does not clear s=
b */
 static void quote_item(struct strbuf *out, const struct item *item)
 {
@@ -241,6 +266,8 @@ static void display(const struct item_list *result)
 				       get_mode(item), 1);
 			strbuf_release(&sb);
 		}
+		if (show_indicator)
+			append_indicator(&quoted, get_mode(item));
 		if (column_active(colopts))
 			string_list_append(&s, quoted.buf);
 		else
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index cdbc34a..16d000e 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -154,4 +154,17 @@ test_expect_success 'color.ls.*' '
 	)
 '
=20
+test_expect_success '--classify' '
+	(
+	cd 2 &&
+	git list-files -F >actual &&
+	cat >expected <<-\EOF &&
+	dir/
+	file
+	gitlink
+	EOF
+	test_cmp expected actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
