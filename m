From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/6] t5000: factor out check_tar
Date: Mon, 20 May 2013 11:58:26 +0200
Message-ID: <1369043909-59207-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 20 11:58:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeMrm-0004UC-4Z
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 11:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab3ETJ6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 05:58:38 -0400
Received: from india601.server4you.de ([85.25.151.105]:56480 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab3ETJ6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 05:58:36 -0400
Received: from debian.Speedport_W_504V_Typ_A (p4FFDA8FE.dip0.t-ipconnect.de [79.253.168.254])
	by india601.server4you.de (Postfix) with ESMTPSA id 6ECA852F
	for <git@vger.kernel.org>; Mon, 20 May 2013 11:58:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224946>

Create a helper function that extracts a tar archive and checks its
contents, modelled after check_zip in t5003.

Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t5000-tar-tree.sh | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 41cd609..8337a1f 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -30,6 +30,26 @@ GUNZIP=3D${GUNZIP:-gzip -d}
=20
 SUBSTFORMAT=3D%H%n
=20
+check_tar() {
+	tarfile=3D$1.tar
+	listfile=3D$1.lst
+	dir=3D$1
+	dir_with_prefix=3D$dir/$2
+
+	test_expect_success ' extract tar archive' '
+		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
+	'
+
+	test_expect_success ' validate filenames' '
+		(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
+		test_cmp a.lst $listfile
+	'
+
+	test_expect_success ' validate file contents' '
+		diff -r a ${dir_with_prefix}a
+	'
+}
+
 test_expect_success \
     'populate workdir' \
     'mkdir a &&
@@ -81,6 +101,8 @@ test_expect_success \
     'git archive' \
     'git archive HEAD >b.tar'
=20
+check_tar b
+
 test_expect_success \
     'git tar-tree' \
     'git tar-tree HEAD >b2.tar'
@@ -125,19 +147,6 @@ test_expect_success \
      test_cmp .git/$(git symbolic-ref HEAD) b.commitid'
=20
 test_expect_success \
-    'extract tar archive' \
-    '(mkdir b && cd b && "$TAR" xf -) <b.tar'
-
-test_expect_success \
-    'validate filenames' \
-    '(cd b/a && find .) | sort >b.lst &&
-     test_cmp a.lst b.lst'
-
-test_expect_success \
-    'validate file contents' \
-    'diff -r a b/a'
-
-test_expect_success \
     'git tar-tree with prefix' \
     'git tar-tree HEAD prefix >c.tar'
=20
--=20
1.8.2.3
