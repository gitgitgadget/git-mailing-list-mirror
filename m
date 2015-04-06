From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/25] list-files: make :(glob) pathspec default
Date: Mon,  6 Apr 2015 20:52:33 +0700
Message-ID: <1428328354-14897-25-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Uh-0006PH-80
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbbDFNzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:55:10 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33687 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbbDFNzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:55:09 -0400
Received: by pdbnk13 with SMTP id nk13so45387911pdb.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k/QbmT1PBMVd6zIAylobR9ez8Gaf6YNQLKytdBhn3KE=;
        b=GzRFYDf2l6bN/ntBlFIWqyLUNovOdOzuXaJ4ksEkB4suhdNsX9HI2iz6xzwt0M6FDs
         GSo6KcuUXRyYS3oSnmLOaOarL9MykB2TlRvWPQD/aFa8euJxVjcb330l68NME5IZ5CGq
         ekTXzPrrJexIUZYLi+vWd8gam3Es1sMpcGG3bT0FakP+UTG8PEOEerXZmc4DHiDOrHNh
         277PxtavsN6pqQkRadzJX0dXOTe3HZBVRgb+SjwfgmPdnaj9e6Z9thu00ugftd20IM3L
         YuhdDSkXFrVeyz45A46mqKxTKnDGD6s0mMZZn/1iL4B7EbtuGo7U6NUPWnU4J3s3UfDm
         GIlA==
X-Received: by 10.70.134.198 with SMTP id pm6mr27886591pdb.17.1428328509287;
        Mon, 06 Apr 2015 06:55:09 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id gl2sm4775035pbc.52.2015.04.06.06.55.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:55:08 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:55:20 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266870>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 1 +
 pathspec.c            | 4 ++++
 pathspec.h            | 1 +
 t/t7013-list-files.sh | 7 ++++++-
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index fc9c8d4..c85bb55 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -557,6 +557,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       (max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
+		       PATHSPEC_DEFAULT_GLOB |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       cmd_prefix, argv);
 	pathspec.max_depth =3D max_depth;
diff --git a/pathspec.c b/pathspec.c
index 5573127..3770c26 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -396,6 +396,10 @@ void parse_pathspec(struct pathspec *pathspec,
 	global.glob    =3D git_env_bool(GIT_GLOB_PATHSPECS_ENVIRONMENT,    0)=
 !=3D 0;
 	global.noglob  =3D git_env_bool(GIT_NOGLOB_PATHSPECS_ENVIRONMENT,  0)=
 !=3D 0;
 	global.icase   =3D git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT,   0)=
 !=3D 0;
+	if ((flags & PATHSPEC_DEFAULT_GLOB) &&
+	    !getenv(GIT_GLOB_PATHSPECS_ENVIRONMENT) &&
+	    !getenv(GIT_NOGLOB_PATHSPECS_ENVIRONMENT))
+		global.glob =3D 1;
 	if (global.glob && global.noglob)
 		die(_("global 'glob' and 'noglob' pathspec settings are incompatible=
"));
=20
diff --git a/pathspec.h b/pathspec.h
index 0c11262..7e4058f 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -67,6 +67,7 @@ struct pathspec {
  * allowed, then it will automatically set for every pathspec.
  */
 #define PATHSPEC_LITERAL_PATH (1<<8)
+#define PATHSPEC_DEFAULT_GLOB (1<<9) /* :(glob) by default */
=20
 extern void parse_pathspec(struct pathspec *pathspec,
 			   unsigned magic_mask,
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index 392cce1..4a9368e 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -116,11 +116,16 @@ test_expect_success 'column output' '
 '
=20
 test_expect_success 'list-files selectively from index' '
-	git list-files -R "*a" >actual &&
+	git list-files -R "**/a" >actual &&
 	cat >expect <<-\EOF &&
 	a
 	sa/a
 	EOF
+	test_cmp expect actual &&
+	git list-files -R "*a" >actual &&
+	cat >expect <<-\EOF &&
+	a
+	EOF
 	test_cmp expect actual
 '
=20
--=20
2.3.0.rc1.137.g477eb31
