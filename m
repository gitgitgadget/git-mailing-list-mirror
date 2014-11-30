From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/34] git_path(): keep "info/sparse-checkout" per work-tree
Date: Sun, 30 Nov 2014 15:24:55 +0700
Message-ID: <1417335899-27307-31-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuztc-0000ej-RI
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbaK3IaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:30:14 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45529 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaK3IaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:30:13 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so9133827pab.21
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AxVEhdUycpjGoNAUYObSGE4XMXybTIqE7zn66ifXhAk=;
        b=pFkQtBgGVdOyM5mgGOBvsk+ML894AElmfN3Ft/59cYV7+irqnR+FxO6g1hsKZC8gm8
         1Gy1MIUkvGQw9xrKZNOMQOr4bn8XoKR4NYYc9H8KdhI5oozgwqBLw+jO8tirO66J3VI/
         TRpGklTaoWDP/z1GOgu8XNmZcKg6G6Dl8GvMCLx/R8PkGdjlNKyAD8JtDeC9cptQmc/9
         BtgjTFR/7SFPfzsDXcSZZhCbI70Ylh+cTGmnZq/XaDHCu/lRPgoyCZiYz8vhRMEN44sT
         QH91Kau3g9Xbcy/9C5JS4S9oQjdcQ2b5IxBFfuqul6SXgnWcwwdronOQCj5XjQfcY26w
         7yjw==
X-Received: by 10.68.135.163 with SMTP id pt3mr87797642pbb.106.1417336212928;
        Sun, 30 Nov 2014 00:30:12 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id qc8sm14332006pdb.70.2014.11.30.00.30.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:30:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:30:11 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260417>

Currently git_path("info/sparse-checkout") resolves to
$GIT_COMMON_DIR/info/sparse-checkout in multiple worktree mode. It
makes more sense for the sparse checkout patterns to be per worktree,
so you can have multiple checkouts with different parts of the tree.

With this, "git checkout --to <new>" on a sparse checkout will create
<new> as a full checkout. Which is expected, it's how a new checkout
is made. The user can reshape the worktree afterwards.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
