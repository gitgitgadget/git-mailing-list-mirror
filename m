From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH 1/2] t/t8006: Demonstrate blame is broken when cachetextconv is on
Date: Sat, 18 Dec 2010 17:54:11 +0300
Message-ID: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 16:22:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTybn-0000dC-4h
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 16:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab0LRPWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Dec 2010 10:22:00 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:34768 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0LRPV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 10:21:59 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 803FD7F1A; Sat, 18 Dec 2010 17:52:36 +0300 (MSK)
Received: from kirr by mini.zxlink with local (Exim 4.72)
	(envelope-from <kirr@mini.zxlink>)
	id 1PTyAx-0001X4-S3; Sat, 18 Dec 2010 17:54:23 +0300
X-Mailer: git-send-email 1.7.3.4.570.g14308
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163914>

I have a git repository with lots of .doc and .pdf files. There diff
works ok, but blaming is painfully slow without textconv cache, and wit=
h
textconv cache, blame says lots of lines are 'Not Yet Committed' which
is wrong.

Here is a test that demonstrates the problem.

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 t/t8006-blame-textconv.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index dbf623b..fe90541 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -73,6 +73,28 @@ test_expect_success 'blame --textconv going through =
revisions' '
 	test_cmp expected result
 '
=20
+test_expect_success 'setup +cachetextconv' '
+	git config diff.test.cachetextconv true
+'
+
+cat >expected_one <<EOF
+(Number2 2010-01-01 20:00:00 +0000 1) converted: test 1 version 2
+EOF
+
+# one.bin is blamed as 'Not Committed yet'
+test_expect_failure 'blame --textconv works with textconvcache' '
+	git blame --textconv two.bin >blame &&
+	find_blame <blame >result &&
+	test_cmp expected result &&
+	git blame --textconv one.bin >blame &&
+	find_blame  <blame >result &&
+	test_cmp expected_one result
+'
+
+test_expect_success 'setup -cachetextconv' '
+	git config diff.test.cachetextconv false
+'
+
 test_expect_success 'make a new commit' '
 	echo "bin: test number 2 version 3" >>two.bin &&
 	GIT_AUTHOR_NAME=3DNumber3 git commit -a -m Third --date=3D"2010-01-01=
 22:00:00"
--=20
1.7.3.4.570.g14308
