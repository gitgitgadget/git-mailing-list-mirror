From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/16] Do not read .git/info/exclude if there is no repository
Date: Thu, 11 Mar 2010 20:22:28 +0700
Message-ID: <1268313754-28179-11-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiMi-0001K7-JR
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476Ab0CKNXl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:23:41 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab0CKNXg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:23:36 -0500
Received: by mail-pw0-f46.google.com with SMTP id 1so9492pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xr7EWeBsHnKUHhYvOf2SfgrSQHZsQdcU+CgBQaTIwkk=;
        b=pnd8JbBWx9iHkLy39OzxPhSG3eKkdCUnPSnEtRtk0/lwVMgTjQ7v9JmJHmq1mNKtbj
         6kTvukb/J6TeNRbYJ+4nccDH7Ir80BTTr7s8vX6Qb3R3HAiO/QcgczC2JWTtZqszhIVt
         GAsGA7vNuYzfyFDd5urr94dqXTLZO1UoyDfGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aKA5JMkrnFOVqQDZdvtobOkflrgd5/m7+vXGznLfdlYVvYxL2a0wSbWkwR2CHNV7bO
         5vonKaeaKKsBBOtk6qagpHZxWn6ywlRkCxQ5+PQSNOtWB5NHxQnZf1VWM5TOsDsNFeK6
         P5LUO+CNII37XQomXcayXkZQkXD0DJhwcW0/A=
Received: by 10.115.67.25 with SMTP id u25mr1322913wak.213.1268313816060;
        Thu, 11 Mar 2010 05:23:36 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 21sm8861010pzk.12.2010.03.11.05.23.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:23:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:31 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141972>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c           |    8 +++++---
 t/t7002-grep.sh |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 133c333..fee19fe 100644
--- a/dir.c
+++ b/dir.c
@@ -1024,9 +1024,11 @@ void setup_standard_excludes(struct dir_struct *=
dir)
 	const char *path;
=20
 	dir->exclude_per_dir =3D ".gitignore";
-	path =3D git_path("info/exclude");
-	if (!access(path, R_OK))
-		add_excludes_from_file(dir, path);
+	if (!startup_info || startup_info->have_repository) {
+		path =3D git_path("info/exclude");
+		if (!access(path, R_OK))
+			add_excludes_from_file(dir, path);
+	}
 	if (excludes_file && !access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index e249c3e..06ec4cb 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -527,4 +527,28 @@ test_expect_success 'grep -e -- -- path' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'Setup fake .git' '
+	cd t &&
+	GIT_CEILING_DIRECTORIES=3D"`pwd`" &&
+	export GIT_CEILING_DIRECTORIES &&
+	cd a &&
+	mkdir -p .git/info &&
+	cd ../..
+
+'
+
+test_expect_success 'Ignore fake .git/info/exclude' '
+	(
+		cd t/a &&
+		echo v > .git/info/exclude &&
+		git grep --no-index vvv . &&
+		rm .git/info/exclude
+	)
+'
+
+test_expect_success 'Unsetup fake .git' '
+	rm -rf t/a &&
+	unset GIT_CEILING_DIRECTORIES
+'
+
 test_done
--=20
1.7.0.1.384.g6abcaa
