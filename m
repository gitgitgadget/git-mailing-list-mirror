From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Make setup_git_env() resolve .git file when $GIT_DIR is not specified
Date: Sat, 31 Aug 2013 08:04:14 +0700
Message-ID: <1377911054-20086-1-git-send-email-pclouds@gmail.com>
References: <xmqq38ps775f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Ximin Luo <infinity0@gmx.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 03:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFZZ1-0007ce-QQ
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 03:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab3HaBBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 21:01:15 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:62267 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab3HaBBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 21:01:14 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so2499111pbc.21
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=C9JS0f81bBHMtWazqUpRIccbzyRfxCEEqUFFBy2OOS0=;
        b=t7kMNjaxAt0bwS05xnkk9UaTUbSOhLlA5kvvPPOkgI4px6VNHTSvohU+HfPMiwCuY1
         LiYt3s34JqlnVbZ7eomAl8H+t1MVtVjzVLB+gCZD8NoeLkDK0dwYxNoCQOwEaMa4QC7E
         9Xdi/h8+a2PGyv9M9p8XrJSBkb/3NNbjUsYxhMhb5UdF1troWeesWM1zWNYwRlEqiWRN
         JT88o28eu2a1xp/Gx2ZVpFJAtwToKUR3tmG807cyHF4UhSmhWQcFmWUbMAsA3Bs8Hxp0
         mFxXgBeTQj2xzryihkPiicXE32ytDQCmuVJTnkRw6SFzAwNhXFzjsDwoauXid+3VmZ+Q
         De0g==
X-Received: by 10.68.244.200 with SMTP id xi8mr12766927pbc.156.1377910874329;
        Fri, 30 Aug 2013 18:01:14 -0700 (PDT)
Received: from lanh ([115.73.192.224])
        by mx.google.com with ESMTPSA id fl3sm937635pad.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 18:01:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 31 Aug 2013 08:04:16 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <xmqq38ps775f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233488>

This makes reinitializing on a .git file repository work.

This is probably the only case that setup_git_env() (via
set_git_dir()) is called on a .git file. Other cases in
setup_git_dir_gently() and enter_repo() both cover .git file case
explicitly because they need to verify the target repo is valid.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Reported-by: Ximin Luo <infinity0@gmx.com>
---
 Slight change in the patch to xstrdup(gitfile) because read_gitfile
 returns a static buffer.

 environment.c   | 9 ++++-----
 t/t0001-init.sh | 4 ++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index 5398c36..378254c 100644
--- a/environment.c
+++ b/environment.c
@@ -123,14 +123,13 @@ static char *expand_namespace(const char *raw_nam=
espace)
=20
 static void setup_git_env(void)
 {
+	const char *gitfile;
+
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
-	git_dir =3D git_dir ? xstrdup(git_dir) : NULL;
-	if (!git_dir) {
-		git_dir =3D read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
-		git_dir =3D git_dir ? xstrdup(git_dir) : NULL;
-	}
 	if (!git_dir)
 		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
+	gitfile =3D read_gitfile(git_dir);
+	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
 	git_object_dir =3D getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
 		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index ad66410..9fb582b 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -379,6 +379,10 @@ test_expect_success 'init with separate gitdir' '
 	test -d realgitdir/refs
 '
=20
+test_expect_success 're-init on .git file' '
+	( cd newdir && git init )
+'
+
 test_expect_success 're-init to update git link' '
 	(
 	cd newdir &&
--=20
1.8.2.83.gc99314b
