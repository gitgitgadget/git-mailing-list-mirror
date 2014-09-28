From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 30/32] git_path(): keep "info/sparse-checkout" per work-tree
Date: Sun, 28 Sep 2014 08:22:44 +0700
Message-ID: <1411867366-3821-31-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3F4-0002pR-G5
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbaI1BZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:25:35 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64791 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:25:34 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so3356711pad.25
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EyIp9OZZq5bOmKFLRMIx1HHlhnBz4o1ZBkKmo54WeWc=;
        b=HGhztB3Gr/A1lEBwPLpT9LLbA8GrAMTr9wmKSjYsS24uhnIij2gOS5iNx0gbR9610o
         2wmFcXWu7DJ7x+v4Pa4k40bAJLO8bTEq3x7aoebHn0zurd0YzYO3BTHFarQq0ii5wZAC
         UCGL+2SAPuYQCv/VamKsgGdjqAEUW6HHebah8nbkTRhDbz1HB1I7HY5/+P7Zcw2rBXHf
         2mPgPyc029kWCGgeH5D4K89m0BpPfEIb96iL0h1kqPS4Pp3Pjg6M31Av+Cxvz0FW7DmP
         0qdGyudf+obS+Arsiwc3lNcCF2TFnz3XCB0BPnEBhp4IYIGDMvSBkPsOZNzzK/n+q5Ci
         M57Q==
X-Received: by 10.66.251.132 with SMTP id zk4mr24573639pac.47.1411867534397;
        Sat, 27 Sep 2014 18:25:34 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id po6sm8518684pbb.56.2014.09.27.18.25.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:25:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:25:37 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257588>

Currently git_path("info/sparse-checkout") resolves to
$GIT_COMMON_DIR/info/sparse-checkout in multiple worktree mode. It
makes more sense for the sparse checkout patterns to be per worktree,
so you can have multiple checkouts with different parts of the tree.

With this, "git checkout --to <new>" on a sparse checkout will create
<new> as a full checkout. Which is expected, it's how a new checkout
is made. The user can reshape the worktree afterwards.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c                | 3 ++-
 t/t0060-path-utils.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/path.c b/path.c
index cd8e2d6..35d498e 100644
--- a/path.c
+++ b/path.c
@@ -103,7 +103,8 @@ static void update_common_dir(struct strbuf *buf, i=
nt git_dir_len)
 	char *base =3D buf->buf + git_dir_len;
 	const char **p;
=20
-	if (is_dir_file(base, "logs", "HEAD"))
+	if (is_dir_file(base, "logs", "HEAD") ||
+	    is_dir_file(base, "info", "sparse-checkout"))
 		return;	/* keep this in $GIT_DIR */
 	for (p =3D common_list; *p; p++) {
 		const char *path =3D *p;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index f5d6f80..93605f4 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -270,6 +270,7 @@ test_git_path GIT_COMMON_DIR=3Dbar objects         =
         bar/objects
 test_git_path GIT_COMMON_DIR=3Dbar objects/bar              bar/object=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar info/exclude             bar/info/e=
xclude
 test_git_path GIT_COMMON_DIR=3Dbar info/grafts              bar/info/g=
rafts
+test_git_path GIT_COMMON_DIR=3Dbar info/sparse-checkout     .git/info/=
sparse-checkout
 test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remote=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/branch=
es/bar
 test_git_path GIT_COMMON_DIR=3Dbar logs/refs/heads/master   bar/logs/r=
efs/heads/master
--=20
2.1.0.rc0.78.gc0d8480
