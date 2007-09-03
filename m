From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Test "stg status" more thoroughly
Date: Mon, 03 Sep 2007 02:00:00 +0200
Message-ID: <20070902235947.23866.81320.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:00:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzMy-0000ev-MH
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbXICAAK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 20:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755954AbXICAAK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:00:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3530 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbXICAAH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:00:07 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IRzMG-0008FL-00; Mon, 03 Sep 2007 01:00:00 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57408>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t0002-status.sh |  114 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 files changed, 112 insertions(+), 2 deletions(-)


diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index c088d56..ce3b688 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -8,8 +8,118 @@ test_description=3D'Basic stg status
 Test that "stg status" works.'
=20
 . ./test-lib.sh
+stg init
=20
-test_expect_success 'Run status on empty' \
-  'stg status'
+# Ignore our own output files.
+cat > .git/info/exclude <<EOF
+/expected.txt
+/output.txt
+EOF
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Run status on empty' '
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+? foo
+EOF
+test_expect_success 'Status with an untracked file' '
+    touch foo &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+rm -f foo
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Status with an empty directory' '
+    mkdir foo &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+? foo/
+EOF
+test_expect_success 'Status with an untracked file in a subdir' '
+    touch foo/bar &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+A foo/bar
+EOF
+test_expect_success 'Status with an added file' '
+    stg add foo &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Status after refresh' '
+    stg new -m "first patch" &&
+    stg refresh &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+M foo/bar
+EOF
+test_expect_success 'Status after modification' '
+    echo "wee" >> foo/bar &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Status after refresh' '
+    stg new -m "second patch" && stg refresh &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+test_expect_success 'Make a conflicting patch' '
+    stg pop &&
+    stg new -m "third patch" &&
+    echo "woo" >> foo/bar &&
+    stg refresh
+'
+
+cat > expected.txt <<EOF
+? foo/bar.ancestor
+? foo/bar.current
+? foo/bar.patched
+C foo/bar
+EOF
+test_expect_success 'Status after conflicting push' '
+    ! stg push &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+M foo/bar
+EOF
+test_expect_success 'Status after resolving the push' '
+    stg resolved -a &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
+
+cat > expected.txt <<EOF
+D foo/bar
+EOF
+test_expect_success 'Status after deleting a file' '
+    rm foo/bar &&
+    stg status > output.txt &&
+    diff -u expected.txt output.txt
+'
=20
 test_done
