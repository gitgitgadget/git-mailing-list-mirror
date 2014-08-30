From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/32] git_path(): keep "info/sparse-checkout" per work-tree
Date: Sat, 30 Aug 2014 15:34:00 +0700
Message-ID: <1409387642-24492-31-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe9L-0003Tw-Ui
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbaH3Igf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:35 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:64403 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaH3Igd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:33 -0400
Received: by mail-pd0-f169.google.com with SMTP id g10so2060906pdj.14
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D3Holh4R9WOeRvX9qckRmfp5XGFathzBQZ7mCcBXvTo=;
        b=UtsHQBBzvkBjUY6CEnQp5oCvZHzEpQ5Y0l5Dn9zRFkvLj0wYtXTuo45BraDZTVu7MF
         FpcUAUPHS5drrPrWjeAiOpP1HjknxWbnoWruqpIf9lOi8v0yAzIlhAVwQY5+Ep4ZrsIA
         vKW1cQqyYkaB5ccUVIP02ThWjMSJaMewUZ38FrvyK+X7qjI4svL1ouDH5jt3/tJ8SPWf
         pSjiONTS+Iz/X2yi8UUpowCN4Jk6HDTjRfURwYtdrcWWhjsYTqY4tUSYTOwuwr9DxKVE
         dv4a7g359rBQSu6yAI7rmzsiG+ONhmgVNhuHKLDayvbkXcKYbJqDqVHknz5py1gkbpqi
         u+4w==
X-Received: by 10.66.124.168 with SMTP id mj8mr22329385pab.78.1409387793557;
        Sat, 30 Aug 2014 01:36:33 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id ow8sm2080712pbb.62.2014.08.30.01.36.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:42 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256240>

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
index b5af137..b1dd2bc 100644
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
