From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [RFC/PATCH 4/4] t/t8007: test textconv support for cat-file
Date: Sun,  6 Jun 2010 13:30:48 +0200
Message-ID: <1275823848-7151-5-git-send-email-clement.poulain@ensimag.imag.fr>
References: <1275823848-7151-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <1275823848-7151-2-git-send-email-clement.poulain@ensimag.imag.fr>
 <1275823848-7151-3-git-send-email-clement.poulain@ensimag.imag.fr>
 <1275823848-7151-4-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, drizzd@aon.at, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 13:32:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLE5N-000667-6W
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 13:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933981Ab0FFLcB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 07:32:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42085 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933639Ab0FFLb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 07:31:58 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o56BOIih024223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 Jun 2010 13:24:19 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o56BVq0q007140;
	Sun, 6 Jun 2010 13:31:52 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o56BVpY5008044;
	Sun, 6 Jun 2010 13:31:51 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o56BVpN3008043;
	Sun, 6 Jun 2010 13:31:51 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1275823848-7151-4-git-send-email-clement.poulain@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 06 Jun 2010 13:24:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o56BOIih024223
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148517>

Test the correct functionning of textconv with cat-file <sha1:blob> and=
  cat-file HEAD^ <file>.
Test the case when no driver is specified.

Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 t/t8007-cat-file-textconv.sh |   66 ++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100755 t/t8007-cat-file-textconv.sh

diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.s=
h
new file mode 100755
index 0000000..0789912
--- /dev/null
+++ b/t/t8007-cat-file-textconv.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description=3D'git cat-file textconv support'
+. ./test-lib.sh
+
+cat >helper <<'EOF'
+#!/bin/sh
+sed 's/^/converted: /' "$@"
+EOF
+chmod +x helper
+
+test_expect_success 'setup ' '
+	echo test >one.bin &&
+	git add . &&
+	GIT_AUTHOR_NAME=3DNumber1 git commit -a -m First --date=3D"2010-01-01=
 18:00:00" &&
+	echo test version 2 >one.bin &&
+	GIT_AUTHOR_NAME=3DNumber2 git commit -a -m Second --date=3D"2010-01-0=
1 20:00:00"
+'
+
+cat >expected <<EOF
+test version 2
+EOF
+
+test_expect_success 'no filter specified' '
+	git cat-file --textconv :one.bin >result &&
+	test_cmp expected result
+'
+
+test_expect_success 'setup textconv filters' '
+	echo "*.bin diff=3Dtest" >.gitattributes &&
+	git config diff.test.textconv ./helper &&
+	git config diff.test.cachetextconv false
+'
+
+test_expect_success 'cat-file without --textconv' '
+	git cat-file blob :one.bin >result &&
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+test
+EOF
+
+test_expect_success 'cat-file without --textconv on previous commit' '
+	git cat-file -p HEAD^:one.bin >result &&
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+converted: test version 2
+EOF
+
+test_expect_success 'cat-file --textconv on last commit' '
+	git cat-file --textconv :one.bin >result &&
+	test_cmp expected result
+'
+
+cat >expected <<EOF
+converted: test
+EOF
+
+test_expect_success 'cat-file --textconv on previous commit' '
+	git cat-file --textconv HEAD^:one.bin >result &&
+	test_cmp expected result
+'
+test_done
--=20
1.6.6.7.ga5fe3
