From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 10/19] Do not read .git/info/exclude if there is no repository
Date: Sun, 21 Mar 2010 17:30:37 +0700
Message-ID: <1269167446-7799-11-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIVJ-0003RX-Ju
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab0CUKfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:30 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:59165 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115Ab0CUKf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:28 -0400
Received: by mail-yx0-f182.google.com with SMTP id 12so1312096yxe.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=I8LYljrDIpy/UN3NpBfUGqkS8dSkYIIHXk+FlcWjnNY=;
        b=AL2kzAOsSxA/CmrOJz/kHq1c/0mnzQ1jON6LftqzQgxZDSGUJWPXxhY3NP8lB0VrRG
         36i9ZdR++nMV/Pd1l8dfYotwnY2oFYn3sZmecIQoQFzqh9gAAKIbuzRenhyTRbEhKmWT
         LPa+affejUW6ii9HcwBUyH6xrNciZn5BHcOfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=X+gChfsQGKvQnbRyaIkxbOtrCsfKNh5RAbeO2pyXhF8+jPKxo7xjuC01d10piafzpl
         lpeCgthi8dl6x1Au0vXXRyVgIjDdUmwB3OOmR579MhRV7TiZzBHRpkpkHWtIMCEhjOeA
         37PtUSvxKDPQnIxp2R/q091A6f/uAs1o2JN9g=
Received: by 10.101.105.22 with SMTP id h22mr5987631anm.185.1269167728253;
        Sun, 21 Mar 2010 03:35:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 23sm3355025iwn.14.2010.03.21.03.35.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:31:46 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142806>


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
1.7.0.2.425.gb99f1
