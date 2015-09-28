From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/6] enter_repo: allow .git files in strict mode
Date: Mon, 28 Sep 2015 20:06:14 +0700
Message-ID: <1443445576-29526-5-git-send-email-pclouds@gmail.com>
References: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
 <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 15:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgY8o-0005wa-Dj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933677AbbI1NGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 09:06:40 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34743 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933643AbbI1NGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:06:39 -0400
Received: by padhy16 with SMTP id hy16so174451926pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fhE60UiOvQ1FI90gCIsM97/MlBUQzVj/L4a5/DrHj1A=;
        b=zdP33Hfat33i4jOekpwT/NBa3pY7XEO5Q6D7jaecnCOKV69uXEJd9FgSHM7+D5W0Fh
         Ywr+cdBLAQtodygSxyvg3Tl+t3r0pxxe334iVLLxnRKuCysGR8qorDo7Pq6oocFU2DmR
         t3icyd0JvXWjmE7+hrLt65jupMO0PL4mva4f88rFT9Fi49il/r3l1g0Sj0JgBXryOIvv
         /lbXURBNhqAE2jPTnOGzMrdqit7Xz/QdPo5iJ7LEFwqe3Imm+VbffA9TQXv+Dhip33NP
         rP+lu9uLHLTqX3TaEK24HtleRjtzK85U64QlfzULofc8wo8uTlZarCMXPKpZtRNh0ovR
         Y8XQ==
X-Received: by 10.68.101.69 with SMTP id fe5mr26799948pbb.11.1443445599345;
        Mon, 28 Sep 2015 06:06:39 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id bc1sm19377345pbb.66.2015.09.28.06.06.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 06:06:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 20:07:14 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278721>

Strict mode is about not guessing where .git is. If the user points to =
a
=2Egit file, we know exactly where the target .git dir will be. This ma=
kes
it possible to serve .git files as repository on the server side.

This may be needed even in local clone case because transport.c code
uses upload-pack for fetching remote refs. But right now the
clone/transport code goes with non-strict.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c             |  9 +++++++--
 t/t0002-gitfile.sh | 10 ++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index 7340e11..a346134 100644
--- a/path.c
+++ b/path.c
@@ -438,8 +438,13 @@ const char *enter_repo(const char *path, int stric=
t)
 			return NULL;
 		path =3D validated_path;
 	}
-	else if (chdir(path))
-		return NULL;
+	else {
+		const char *gitfile =3D read_gitfile(path);
+		if (gitfile)
+			path =3D gitfile;
+		if (chdir(path))
+			return NULL;
+	}
=20
 	if (is_git_directory(".")) {
 		set_git_dir(".");
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 2e709cc..9670e8c 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -148,4 +148,14 @@ test_expect_success 'enter_repo linked checkout' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'enter_repo strict mode' '
+	git ls-remote --upload-pack=3D"git upload-pack --strict" foo/.git >ac=
tual &&
+	cat >expected <<-\EOF &&
+	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
+	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
+	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	EOF
+	test_cmp expected actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
