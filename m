From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/16] git_config(): do not read .git/config if there is no repository
Date: Thu, 11 Mar 2010 20:22:27 +0700
Message-ID: <1268313754-28179-10-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMi-0001K7-23
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460Ab0CKNXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:34 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0CKNXb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:31 -0500
Received: by mail-pw0-f46.google.com with SMTP id 1so9492pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mxTNNFdXvdqnI0SQwWztNTzDwQsZ1qjFMy3uK3R4kpU=;
        b=l0ZvmjjL3e3Dip7vBVHtCXbzjshxTXHHG+L2fhF00tcDHAALl80Qyilix+3Nw70HqI
         FoOcrAjyfGaBDKNEeD6+pcBDAR9Nusw+sh4GmL6/714kmb9zRhq2GrnKOkcB2+i5ttpU
         XLPiV0gO7ThQh+8vMm/3dVqijFQAGifDVxXAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Gk6bzwqJ3JeRGxxBqLDM+gxIWpboyLcGJgx0zD4l5x4ZT493QZ/e1yzt9pgA0ijEwb
         p2/RgnwcFsFtB5nA6UKL4P5yH2p9KqGGI2BT0JU5PiPdTwYhEfKTT3nNEULQT7orMYRw
         O2Y2RMuPBH700d9AVrVcc+8tVLXXcK3HKWOJ0=
Received: by 10.143.26.14 with SMTP id d14mr1388710wfj.59.1268313811159;
        Thu, 11 Mar 2010 05:23:31 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 21sm8838135pzk.4.2010.03.11.05.23.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:29 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:25 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141970>

If no repository is found, do not bother calling git_pathdup(). If a
command forgets to call setup_git_directory*() or enter_repo(),
$GIT_DIR/config will be missed, though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 config.c               |    3 ++-
 t/t1300-repo-config.sh |   13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index 2d38096..07d854a 100644
--- a/config.c
+++ b/config.c
@@ -737,7 +737,8 @@ int git_config(config_fn_t fn, void *data)
 	char *repo_config =3D NULL;
 	int ret;
=20
-	repo_config =3D git_pathdup("config");
+	if (!startup_info || startup_info->have_repository)
+		repo_config =3D git_pathdup("config");
 	ret =3D git_config_early(fn, data, repo_config);
 	if (repo_config)
 		free(repo_config);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f11f98c..cfb70e2 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -824,4 +824,17 @@ test_expect_success 'check split_cmdline return' "
 	test_must_fail git merge master
 	"
=20
+test_expect_success 'skip .git/config if there is no repository' '
+	(
+		mkdir -p a/b/.git &&
+		cd a &&
+		GIT_CEILING_DIRECTORIES=3D"`pwd`" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd b &&
+		echo "[core]" > .git/config &&
+		echo "wrong =3D true" >> .git/config &&
+		test -z "$(git var -l | grep core.wrong)"
+	)
+'
+
 test_done
--=20
1.7.0.1.384.g6abcaa
