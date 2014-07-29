From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/8] environment.c: fix incorrect git_graft_file initialization
Date: Tue, 29 Jul 2014 20:50:29 +0700
Message-ID: <1406641831-2390-7-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:53:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7q8-0005ph-JK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbaG2NxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:53:09 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33847 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbaG2NxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:53:05 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so11738578pdb.31
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P9lxKs4X+QKJeQTpO08KvLZ5Ix93iTF/urUUMg3XdJU=;
        b=qbZW+lX510bhbus2tbyA6gSWz6L3PSElfkiaoAYBmaNKaYtplPuhrwIF3CWdnjBzOt
         0q6/XLF2XWT8ZIwbSLd6T8aZ7kmHjf6TA0nU0/CE3GWCgtjhI1CWVQEfKp9MfgTaC1l6
         J1FBedWafQuQVExdUZrBMTMP3oWivE8uWlTSUSCT0DYsX/pmARkAvNaHT9cTHGu1fSLv
         zMfDgGfIQq/V9cfdgYlEvRhb5xHsye+eNN1JJb9lt215A/2NBHEtafMMlXCBq423KLzA
         IloJd1D16fWgbBpypZcCiB77xm4xqVu5YAySTxbDTpF5AerQVmzl4NXoTyEY79Fg1Hfs
         YeuQ==
X-Received: by 10.66.240.140 with SMTP id wa12mr2145746pac.99.1406641984632;
        Tue, 29 Jul 2014 06:53:04 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id tw6sm77948915pac.23.2014.07.29.06.53.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:53:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:53:07 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254439>

"info/grafts" should be part of the "common repository" when accessed
from a linked checkout (iow $GIT_COMMON_DIR/info/grafts, not
$GIT_DIR/info/grafts).

git_path("info/grafts") returns correctly, even without this fix,
because it detects that $GIT_GRAFT_FILE is not set, so it goes with the
common rule: anything except sparse-checkout in 'info' belongs to commo=
n
repo. But get_graft_file() would return a wrong value and that one is
used for setting grafts up.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c          |  2 +-
 t/t0060-path-utils.sh  |  1 +
 t/t2025-checkout-to.sh | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 50ed40a..d5b0788 100644
--- a/environment.c
+++ b/environment.c
@@ -157,7 +157,7 @@ static void setup_git_env(void)
 					   "objects", &git_db_env);
 	git_index_file =3D git_path_from_env(INDEX_ENVIRONMENT, git_dir,
 					   "index", &git_index_env);
-	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, git_dir,
+	git_graft_file =3D git_path_from_env(GRAFT_ENVIRONMENT, git_common_di=
r,
 					   "info/grafts", &git_graft_env);
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs =3D 0;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index da82aab..93605f4 100755
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
+test_git_path GIT_COMMON_DIR=3Dbar info/grafts              bar/info/g=
rafts
 test_git_path GIT_COMMON_DIR=3Dbar info/sparse-checkout     .git/info/=
sparse-checkout
 test_git_path GIT_COMMON_DIR=3Dbar remotes/bar              bar/remote=
s/bar
 test_git_path GIT_COMMON_DIR=3Dbar branches/bar             bar/branch=
es/bar
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 8a00310..508993f 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -81,4 +81,22 @@ test_expect_success 'checkout from a bare repo witho=
ut --to' '
 	)
 '
=20
+test_expect_success 'checkout with grafts' '
+	test_when_finished rm .git/info/grafts &&
+	test_commit abc &&
+	SHA1=3D`git rev-parse HEAD` &&
+	test_commit def &&
+	test_commit xyz &&
+	echo "`git rev-parse HEAD` $SHA1" >.git/info/grafts &&
+	cat >expected <<-\EOF &&
+	xyz
+	abc
+	EOF
+	git log --format=3D%s -2 >actual &&
+	test_cmp expected actual &&
+	git checkout --detach --to grafted master &&
+	git --git-dir=3Dgrafted/.git log --format=3D%s -2 >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
