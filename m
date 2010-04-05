From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/43] Do not read .git/info/exclude if there is no repository
Date: Mon,  5 Apr 2010 20:41:16 +0200
Message-ID: <1270492888-26589-32-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:49:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrMp-0007UX-B7
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab0DEStm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:49:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:19801 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161Ab0DEStl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:49:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1462317qwh.37
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=R8IRGWVlva2dJNWd1NXhsFT3ykc3Ic/ngBACyPRbG2Y=;
        b=oJwLWJIliLmdhT/oNdtdrzdaKyoC+4poOKAeZZ/+nZW51CztrDJrenwiklMse7X5EG
         suZY9SwTH+tbsqBL1DVpVvPlqovZPwfUpPAQk6U8bRW96CjxK77eEi/7ZgCwU8HnQLBH
         C3hETcXvKUZ0ENEr8WfiAgPDONRsMwtmQ6qSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xt1TfG2cOtyu+mNx9JLh7MnpsxOvBxY+Y1/8Gl0ufRf9BWhODHBmoUQHSo82ykSTE1
         XA0RWKdyeqCTWvGCrDQvdPD8A9E/zjBX9oYdllMltOc/rRWdEOUZeiKAKIH4/NfKcAx3
         qOyEYbMtlATQG5lv9cc7+6cJEQURqK5L7iL4Q=
Received: by 10.224.91.136 with SMTP id n8mr249207qam.345.1270493009154;
        Mon, 05 Apr 2010 11:43:29 -0700 (PDT)
Received: from dektop ([72.14.241.36])
        by mx.google.com with ESMTPS id 4sm25746313qwe.32.2010.04.05.11.43.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:27 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:22 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144044>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c           |    8 +++++---
 t/t7002-grep.sh |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index cb83332..0bd5d9f 100644
--- a/dir.c
+++ b/dir.c
@@ -1040,9 +1040,11 @@ void setup_standard_excludes(struct dir_struct *=
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
1.7.0.rc1.541.g2da82.dirty
