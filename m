From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/19] git_config(): do not read .git/config if there is no repository
Date: Sun, 21 Mar 2010 17:30:36 +0700
Message-ID: <1269167446-7799-10-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIVJ-0003RX-27
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab0CUKfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44274 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0CUKfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:21 -0400
Received: by gyg8 with SMTP id 8so2223551gyg.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=O9D74QA0mrB1Ps7cHXKFFZJ5Y1vB7Dtf0luZ0u3wl1Q=;
        b=TA82ViqmSDntqO8fNN9PzSMfGgfUfTbBFOZnlzoH1Cgccv5sPdDYgRFURrpoUchgdF
         UAfhVMmMfVg2f1GVhPjqUBmrO98E7Uw3JxDUmcUUu4hGu+8jjGnTBebEA1gXJgsJLhUj
         1c7m3jzKWn1VgTHFy3inqAuNKRq/8WfK8yoRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JARaqTZ7xUhcc1WSVatYOr86WaXrhcr1apCg5tyeyFyhCpS8gfhI0ndn6CkFL0raEJ
         vuwxtnCSDsR5zC6xiX4hnMV8M8ouWqFr4eVeVaBaDheluIF+63wE8HOG0pUc2H9J2QfS
         zVsPpjHSZ0mNp+OT2T8Ib4zUB13L0MHp5mp8I=
Received: by 10.101.22.19 with SMTP id z19mr12812384ani.71.1269167720826;
        Sun, 21 Mar 2010 03:35:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 20sm1550524iwn.13.2010.03.21.03.35.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:38 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142805>

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
1.7.0.2.425.gb99f1
