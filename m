From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR
Date: Fri, 26 Jun 2015 17:37:35 +0700
Message-ID: <1435315055-27011-1-git-send-email-pclouds@gmail.com>
References: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 12:37:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8R0V-0007ug-Ci
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 12:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbbFZKhK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2015 06:37:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36266 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbFZKhH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 06:37:07 -0400
Received: by paceq1 with SMTP id eq1so66666865pac.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=gbRMhKiE8WMdQU/w6bbT2pxJxGcaR90yyJM5zpesejs=;
        b=PUtPNQ76j/DTvh22q+meu7CogACCm68fwZSRji/wrJDf4d10IOYS7iiEREDsLjSZ4Y
         qjfZx0xJevXTcvDd/x6nxsV9/a85j+G02iFCVeFI4VLbbCtb1yXC3a3BB6Y6P4Yci26X
         xLix2e1oTCXsoArAJpxE0kwYIaq0676rhjUNhZ5wwmqt4eOlPTfE7BcTBtYPFAdUJ9Cx
         MfcCVe8Y0ncHZFSZIm+b9LKxENrWRFHQuP7slqU53r0ihBmRRy4Od5ub9+SYzdGuq4eS
         UyCO15fjmoKRZDF0RSQS64Ff/tc5ss2l2otDkNqjyvWrBt9yqtZEGm6mKolH7aqGKzmS
         HviA==
X-Received: by 10.70.50.199 with SMTP id e7mr2098273pdo.124.1435315026799;
        Fri, 26 Jun 2015 03:37:06 -0700 (PDT)
Received: from lanh ([115.73.11.68])
        by mx.google.com with ESMTPSA id zf1sm32868558pbc.43.2015.06.26.03.37.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2015 03:37:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 26 Jun 2015 17:37:38 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272770>

In the test case, we run setup_git_dir_gently() the first time to read
$GIT_DIR/config so that we can resolve aliases. We'll enter
setup_discovered_git_dir() and may or may not call set_git_dir() near
the end of the function, depending on whether the detected git dir is
".git" or not. This set_git_dir() will set env var $GIT_DIR.

=46or normal repo, git dir detected via setup_discovered_git_dir() will=
 be
".git", and set_git_dir() is not called. If .git file is used however,
the git dir can't be ".git" and set_git_dir() is called and $GIT_DIR
set. This is the key of this problem.

If we expand an alias (or autocorrect command names), then
setup_git_dir_gently() is run the second time. If $GIT_DIR is not set i=
n
the first run, we run the same setup_discovered_git_dir() as before.
Nothing to see. If it is, however, we'll enter setup_explicit_git_dir()
this time.

This is where the "fun" is. The legacy behavior is, if $GIT_WORK_TREE i=
s
not set but $GIT_DIR is, cwd is chosen as worktree's top. If you happen
to stand at worktree's top when you do this, all is well. If you are in
a subdir "foo/bar" (real worktree's top is "foo"), this behavior bites
you: your detected worktree is now "foo/bar", but the first run
correctly detected worktree as "foo". You get "internal error: work tre=
e
has already been set" as a result.

Bottom line is, when $GIT_DIR is set, $GIT_WORK_TREE should be set too
unless there's no work tree. But setting $GIT_WORK_TREE inside
set_git_dir() may backfire. We don't know at that point if work tree is
already configured by the caller. So set it when work tree is
detected. It does not harm if $GIT_WORK_TREE is set while $GIT_DIR is
not.

Reported-by: Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c      |  2 ++
 t/t0002-gitfile.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/environment.c b/environment.c
index 61c685b..8f1b249 100644
--- a/environment.c
+++ b/environment.c
@@ -231,6 +231,8 @@ void set_git_work_tree(const char *new_work_tree)
 	}
 	git_work_tree_initialized =3D 1;
 	work_tree =3D xstrdup(real_path(new_work_tree));
+	if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
+		error("Could not set GIT_WORK_TREE to '%s'", work_tree);
 }
=20
 const char *get_git_work_tree(void)
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 37e9396..9393322 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -99,4 +99,21 @@ test_expect_success 'check rev-list' '
 	test "$SHA" =3D "$(git rev-list HEAD)"
 '
=20
+test_expect_success 'setup_git_dir twice in subdir' '
+	git init sgd &&
+	(
+		cd sgd &&
+		git config alias.lsfi ls-files &&
+		mv .git .realgit &&
+		echo "gitdir: .realgit" >.git &&
+		mkdir subdir &&
+		cd subdir &&
+		>foo &&
+		git add foo &&
+		git lsfi >actual &&
+		echo foo >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
