From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] environment.c: fix incorrect git_graft_file initialization
Date: Wed, 23 Jul 2014 18:43:15 +0700
Message-ID: <1406115795-24082-6-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 13:44:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9uyX-0002mA-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 13:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757477AbaGWLop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 07:44:45 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57960 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbaGWLoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 07:44:44 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so1474653pde.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KUcYsPf5oF4kFPpGRTIZ8bch0Q+7lvyZeZ/Mzx1gUak=;
        b=O4UQQL5LYkzW6ALI2WJunIMjljE6nHbK0hLCoZt2/zeeZ/F6ooWtDfJByGOs30/cM3
         mzx/27/Ewn0mmS8+CW45dmWpPtvqfsQoCZDSDwu1PGTr+/zBqGzmNizZ5J5zqnyWI37L
         0cGpcJD3/rigGhYQaid1DufmNvPjtev4l8KU1SxWqt9SoDaXQPqUhIZ1smlX5PhYpqsN
         H3EmO4hVCwKh1VAmEp6Jl3pInealDwFe318yjF7+TLaXYdcYlE32elCGAUEQ/R8BkOse
         UU/ia8rYhs25LdARpxGN9e39PfZsv+pKK1+X9IXQGzaHY44kti9ooCA8mmuFzGIYhc8Q
         dltA==
X-Received: by 10.66.137.11 with SMTP id qe11mr901882pab.80.1406115883939;
        Wed, 23 Jul 2014 04:44:43 -0700 (PDT)
Received: from lanh ([115.73.248.125])
        by mx.google.com with ESMTPSA id w16sm2845355pdl.36.2014.07.23.04.44.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jul 2014 04:44:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Jul 2014 18:44:37 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254068>

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
1.9.1.346.ga2b5940
