From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 3/6] enter_repo: avoid duplicating logic, use is_git_directory() instead
Date: Mon, 28 Sep 2015 20:06:13 +0700
Message-ID: <1443445576-29526-4-git-send-email-pclouds@gmail.com>
References: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
 <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 15:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgY8e-0005p4-9e
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933674AbbI1NGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 09:06:35 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34666 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933653AbbI1NGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:06:34 -0400
Received: by padhy16 with SMTP id hy16so174450083pad.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ns7iluSQx8GfwNxzaTJ7LRADzC0QzplaVHgJ01G7ylc=;
        b=IPSCkZIysStlg4K2VZRZGJl8h43GMYTIyrZcsds2VNfMS/XKEjqidzM4z7wdlf43ao
         5Ix+cfabW398k/NmxEdtD7WwydtC9E1/IpCwNpmGrWdJ/MOrru4qciLTYQoKfM74xic3
         gkoMwrRvh3srQqVUzkM5iWKCuVR2C4D4InS4A4kPTy1Bst9j84OWGPg2CiHYpv7Nxg+5
         VE4BnqNogsjZRQvfyx029bQDi6IT/FOTgwMj1uZUzCj5XaYWaFS+YbvKgwiuNnOIhQgO
         tcPECJNZq2/0rN5qyCkwlaUmlunK8CAqpvRkjSOCP8uJ+q5k32vM4geuMjqzD6Xp/pu+
         oscw==
X-Received: by 10.66.144.40 with SMTP id sj8mr26826444pab.72.1443445593933;
        Mon, 28 Sep 2015 06:06:33 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id rz9sm19380756pbb.61.2015.09.28.06.06.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 06:06:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 20:07:08 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1443445576-29526-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278719>

It matters for linked checkouts where 'refs' directory won't be
available in $GIT_DIR. is_git_directory() knows about $GIT_COMMON_DIR
and can handle this case.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c             |  3 +--
 t/t0002-gitfile.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/path.c b/path.c
index a536ee3..7340e11 100644
--- a/path.c
+++ b/path.c
@@ -441,8 +441,7 @@ const char *enter_repo(const char *path, int strict=
)
 	else if (chdir(path))
 		return NULL;
=20
-	if (access("objects", X_OK) =3D=3D 0 && access("refs", X_OK) =3D=3D 0=
 &&
-	    validate_headref("HEAD") =3D=3D 0) {
+	if (is_git_directory(".")) {
 		set_git_dir(".");
 		check_repository_format();
 		return path;
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 545bfe2..2e709cc 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -134,4 +134,18 @@ test_expect_success 'enter_repo non-strict mode' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'enter_repo linked checkout' '
+	(
+		cd enter_repo &&
+		git worktree add  ../foo refs/tags/foo
+	) &&
+	git ls-remote foo >actual &&
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
