From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/25] list-files: add --max-depth, -R and default to --max-depth=0
Date: Mon,  6 Apr 2015 20:52:18 +0700
Message-ID: <1428328354-14897-10-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7T9-0005G5-R5
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbbDFNxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:35 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33751 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbDFNxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:35 -0400
Received: by pdbnk13 with SMTP id nk13so45351151pdb.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=60aB7EgCTSZjNNRzJAPBmnn+0XHPaMU4iI+ZFhtAy6I=;
        b=NCq7GYrMO75TVyU/SClLVTox76Yhm3TBCcgwRLk1Ju3iOd48QxlLxD7gfneWL1opKP
         oacPQSRPzI/xUD6NLiktf8YbTbKtsToFBxkqiSgOOiTZ9bXg+b0vZDsABzXeUJejcVq2
         bn3dwsqov+DyK9zV385cLsqgtK7wC1oHwOTlzbb73Y5fakxvY2jfl9gxA/blMVW/rnxH
         ZPPcHkf820cm06vw0oNw7uNEn+56NAxCVY0VDgWR5xwZEnww4W+7NHd9TGi8OiXMwXni
         msb5NCfQd9ytkek+sWt/dot4k1rqVrt0hyYEIUrLL3e6w8sTWHgbL5vAdlbd+CDl8cp3
         Z+7g==
X-Received: by 10.66.227.169 with SMTP id sb9mr27961800pac.11.1428328414552;
        Mon, 06 Apr 2015 06:53:34 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id fm3sm4786755pdb.73.2015.04.06.06.53.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:45 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266854>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  |  9 ++++++++-
 t/t7013-list-files.sh | 40 ++++++++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 8913770..4599cf0 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -28,6 +28,7 @@ static const char *prefix;
 static int prefix_length;
 static int show_tag =3D -1;
 static unsigned int colopts;
+static int max_depth;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -39,6 +40,11 @@ struct option ls_options[] =3D {
 	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
 	OPT_SET_INT('1', NULL, &colopts,
 		    N_("shortcut for --no-column"), COL_PARSEOPT),
+	{ OPTION_INTEGER, 0, "max-depth", &max_depth, N_("depth"),
+	  N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
+	  NULL, 1 },
+	OPT_SET_INT('R', "recursive", &max_depth,
+		    N_("shortcut for --max-depth=3D-1"), -1),
 	OPT_END()
 };
=20
@@ -178,9 +184,10 @@ int cmd_list_files(int argc, const char **argv, co=
nst char *cmd_prefix)
=20
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
+		       (max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       cmd_prefix, argv);
-	pathspec.max_depth =3D 0;
+	pathspec.max_depth =3D max_depth;
 	pathspec.recursive =3D 1;
 	finalize_colopts(&colopts, -1);
=20
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index b43245c..89930c7 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -10,8 +10,8 @@ test_expect_success 'setup' '
 	git add .
 '
=20
-test_expect_success 'list-files from index' '
-	git list-files >actual &&
+test_expect_success 'list-files -R from index' '
+	git list-files -R >actual &&
 	cat >expect <<-\EOF &&
 	a
 	b
@@ -23,22 +23,34 @@ test_expect_success 'list-files from index' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'list-files from index' '
+	git list-files --max-depth=3D0 >actual &&
+	cat >expect <<-\EOF &&
+	a
+	b
+	c
+	EOF
+	test_cmp expect actual &&
+	git list-files >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'column output' '
-	COLUMNS=3D20 git list-files --column=3Dalways >actual &&
+	COLUMNS=3D20 git list-files -R --column=3Dalways >actual &&
 	cat >expected <<-\EOF &&
 	a        sa/a
 	b        sa/sb/b
 	c        sc/c
 	EOF
 	test_cmp expected actual &&
-	COLUMNS=3D20 git -c column.listfiles=3Dalways list-files >actual &&
+	COLUMNS=3D20 git -c column.listfiles=3Dalways list-files -R >actual &=
&
 	cat >expected <<-\EOF &&
 	a        sa/a
 	b        sa/sb/b
 	c        sc/c
 	EOF
 	test_cmp expected actual &&
-	COLUMNS=3D20 git -c column.listfiles=3Dalways list-files -1 >actual &=
&
+	COLUMNS=3D20 git -c column.listfiles=3Dalways list-files -1R >actual =
&&
 	cat >expected <<-\EOF &&
 	a
 	b
@@ -51,7 +63,7 @@ test_expect_success 'column output' '
 '
=20
 test_expect_success 'list-files selectively from index' '
-	git list-files "*a" >actual &&
+	git list-files -R "*a" >actual &&
 	cat >expect <<-\EOF &&
 	a
 	sa/a
@@ -59,10 +71,22 @@ test_expect_success 'list-files selectively from in=
dex' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--max-depth' '
+	git list-files --max-depth=3D1 >actual &&
+	cat >expected <<-\EOF &&
+	a
+	b
+	c
+	sa/a
+	sc/c
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'list-files from subdir ' '
 	(
 	cd sa &&
-	git list-files >actual &&
+	git list-files -R >actual &&
 	cat >expect <<-\EOF &&
 	a
 	sb/b
@@ -74,7 +98,7 @@ test_expect_success 'list-files from subdir ' '
 test_expect_success 'list-files from subdir (2)' '
 	(
 	cd sa &&
-	git list-files ../a sb >actual &&
+	git list-files -R ../a sb >actual &&
 	cat >expect <<-\EOF &&
 	../a
 	sb/b
--=20
2.3.0.rc1.137.g477eb31
