From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/6] fix local clone from a linked checkout
Date: Mon, 28 Sep 2015 20:06:10 +0700
Message-ID: <1443445576-29526-1-git-send-email-pclouds@gmail.com>
References: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, bjornar@snoksrud.no,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 28 15:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgY8L-0005SH-PP
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 15:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479AbbI1NGR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Sep 2015 09:06:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35240 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932899AbbI1NGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 09:06:16 -0400
Received: by pacfv12 with SMTP id fv12so178198517pac.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IouGtAm+ehnYAeP752H+fMXuuOlMngQi4yTmLq1uzjI=;
        b=ZisuJYMFPdC3Vh3eBa1UyFKAUwvpwucxFe5K7XvQ6aLbMfRj8EYEBmvuCySfH8PLKj
         P+QzgpNN5uLkwFuQL3bVnvD4d2ZoslVEkhvrQT4sJzBXbLi92cqNg9jpseiwDZ1TD/aI
         aRZoMMcwyc12y+A2wxH7F1408siiti2X6ny/Eedshii1Y/ZiTQtNReDbK/jgglGN2Hhl
         BfxkzuuUbwjakZcLQ4AQrwGBt0B5VKRwSiP2XlfFeNVPNQznE9RK2vnWrYRHqsLfSMEj
         GhWYQnaVUPpZKIdVAMmwxLWn9XvO3yIdUUQzl83mmDg7K0M3aertRZuhOLR3GjnUCnzw
         JfuQ==
X-Received: by 10.68.238.130 with SMTP id vk2mr22124430pbc.114.1443445575938;
        Mon, 28 Sep 2015 06:06:15 -0700 (PDT)
Received: from lanh ([171.232.94.118])
        by smtp.gmail.com with ESMTPSA id fx4sm19362271pbb.92.2015.09.28.06.06.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 06:06:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Sep 2015 20:06:50 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442106148-22895-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278716>

This fixes another embarassing bug in 4/6 and adds tests to make sure
it works. Changes since v3

-- 8< --
diff --git a/path.c b/path.c
index 32d4ca6..a346134 100644
--- a/path.c
+++ b/path.c
@@ -439,7 +439,7 @@ const char *enter_repo(const char *path, int strict=
)
 		path =3D validated_path;
 	}
 	else {
-		const char *gitfile =3D read_gitfile(used_path);
+		const char *gitfile =3D read_gitfile(path);
 		if (gitfile)
 			path =3D gitfile;
 		if (chdir(path))
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 9393322..9670e8c 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -116,4 +116,46 @@ test_expect_success 'setup_git_dir twice in subdir=
' '
 	)
 '
=20
+test_expect_success 'enter_repo non-strict mode' '
+	test_create_repo enter_repo &&
+	(
+		cd enter_repo &&
+		test_tick &&
+		test_commit foo &&
+		mv .git .realgit &&
+		echo "gitdir: .realgit" >.git
+	) &&
+	git ls-remote enter_repo >actual &&
+	cat >expected <<-\EOF &&
+	946e985ab20de757ca5b872b16d64e92ff3803a9	HEAD
+	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/heads/master
+	946e985ab20de757ca5b872b16d64e92ff3803a9	refs/tags/foo
+	EOF
+	test_cmp expected actual
+'
+
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
-- 8< --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  path.c: delete an extra space
  t0002: add test for enter_repo(), non-strict mode
  enter_repo: avoid duplicating logic, use is_git_directory() instead
  enter_repo: allow .git files in strict mode
  clone: allow --local from a linked checkout
  clone: better error when --reference is a linked checkout

 builtin/clone.c         | 13 ++++++++++---
 path.c                  | 14 +++++++++-----
 t/t0002-gitfile.sh      | 42 +++++++++++++++++++++++++++++++++++++++++=
+
 t/t2025-worktree-add.sh |  5 +++++
 4 files changed, 66 insertions(+), 8 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
