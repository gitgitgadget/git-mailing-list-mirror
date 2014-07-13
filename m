From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 30/31] git_path(): keep "info/sparse-checkout" per work-tree
Date: Sun, 13 Jul 2014 11:51:07 +0700
Message-ID: <1405227068-25506-31-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6BpO-0001yi-Km
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159AbaGMEzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:55:55 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33441 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbaGMEzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:53 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so691580pab.12
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5Tfs+O6F+mjnU2Ki9NKVdCmpmIDnc4lS0O80TsVltXc=;
        b=ccJzIhwFhiEUu7lulro2CaNDQMybFIXB2J4HNPra+EW0BYotHfn8zAc1x7NeU+09kv
         ddTDw800AhLTdD6GHecaf8xkOKvCSCcrSr7XsZH5lQUqKdjHfczu9sZ4+5rsGp1LbFrr
         ASMJecak6kok+7j4sJ5/GClbmFntsaNAer8RSnUHMLyaFX9MIiMrEYcJRg0587mAMQdc
         RQIEMvVR2voh3vrHQRyRccp/RILM8QkN8GGOay8sKzQcyXAEu+Xcpnx8tYHczpBtBcIt
         k+rCHTpgmRWpPFjzBrzNfPgGHWJLM83/8iaXvjVkaw2ijWoDTWXEn8jpYjh0UXJAN2PB
         Iu8g==
X-Received: by 10.68.93.101 with SMTP id ct5mr4168204pbb.27.1405227353104;
        Sat, 12 Jul 2014 21:55:53 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id ba10sm9079854pdb.73.2014.07.12.21.55.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:53 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253433>

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
index 2dabcef..da82aab 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -269,6 +269,7 @@ test_git_path GIT_COMMON_DIR=3Dbar logs/HEAD       =
         .git/logs/HEAD
 test_git_path GIT_COMMON_DIR=3Dbar objects                  bar/object=
s
 test_git_path GIT_COMMON_DIR=3Dbar objects/bar              bar/object=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar info/exclude             bar/info/e=
xclude
+test_git_path GIT_COMMON_DIR=3Dbar info/sparse-checkout     .git/info/=
sparse-checkout
 test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remote=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/branch=
es/bar
 test_git_path GIT_COMMON_DIR=3Dbar logs/refs/heads/master   bar/logs/r=
efs/heads/master
--=20
1.9.1.346.ga2b5940
