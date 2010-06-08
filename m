From: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
Subject: [PATCH v2 4/4] t/t8007: test textconv support for cat-file
Date: Tue,  8 Jun 2010 15:49:18 +0200
Message-ID: <1276004958-13540-5-git-send-email-clement.poulain@ensimag.imag.fr>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
 <1276004958-13540-3-git-send-email-clement.poulain@ensimag.imag.fr>
 <1276004958-13540-4-git-send-email-clement.poulain@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 15:50:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzBv-0003aO-TF
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab0FHNtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 09:49:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38063 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138Ab0FHNtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 09:49:43 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o58DfxpC024968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 8 Jun 2010 15:41:59 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o58Dnfr1027967;
	Tue, 8 Jun 2010 15:49:41 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o58DnfG6013691;
	Tue, 8 Jun 2010 15:49:41 +0200
Received: (from poulainc@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o58DnfaU013690;
	Tue, 8 Jun 2010 15:49:41 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276004958-13540-4-git-send-email-clement.poulain@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 08 Jun 2010 15:41:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o58DfxpC024968
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148671>

Test the correct functionning of textconv with cat-file <sha1:blob>
and cat-file HEAD^ <file>. Test the case when no driver is specified

Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>=20
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>=20
---
 t/t8007-cat-file-textconv.sh |   70 ++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)
 create mode 100755 t/t8007-cat-file-textconv.sh

diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.s=
h
new file mode 100755
index 0000000..38ac05e
--- /dev/null
+++ b/t/t8007-cat-file-textconv.sh
@@ -0,0 +1,70 @@
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
+fatal: git cat-file --textconv: unable to run textconv on :one.bin
+EOF
+
+test_expect_success 'no filter specified' '
+	git cat-file --textconv :one.bin 2>result
+	test_cmp expected result
+'
+
+test_expect_success 'setup textconv filters' '
+	echo "*.bin diff=3Dtest" >.gitattributes &&
+	git config diff.test.textconv ./helper &&
+	git config diff.test.cachetextconv false
+'
+
+cat >expected <<EOF
+test version 2
+EOF
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
1.7.1.202.g79415.dirty
