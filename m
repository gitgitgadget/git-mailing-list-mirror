From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Test that "stg goto" can be called from a
	subdirectory
Date: Wed, 19 Dec 2007 23:19:51 +0100
Message-ID: <20071219221936.29455.99513.stgit@yoghurt>
References: <20071219221848.29455.50676.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57H1-00025e-IP
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbXLSWT4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 17:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbXLSWT4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:19:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3263 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbXLSWTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:19:55 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J57GZ-0003wd-00; Wed, 19 Dec 2007 22:19:51 +0000
In-Reply-To: <20071219221848.29455.50676.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68946>

It currently can't; therefore, the tests are marked as known failures.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t2800-goto-subdir.sh |   59 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 t/t2800-goto-subdir.sh


diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
new file mode 100755
index 0000000..9f3ab26
--- /dev/null
+++ b/t/t2800-goto-subdir.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description=3D'Run "stg goto" in a subdirectory'
+
+. ./test-lib.sh
+
+test_expect_success 'Initialize StGit stack' '
+    stg init &&
+    echo expected1.txt >> .git/info/exclude &&
+    echo expected2.txt >> .git/info/exclude &&
+    echo actual.txt >> .git/info/exclude &&
+    mkdir foo &&
+    for i in 1 2 3; do
+        echo foo$i >> foo/bar &&
+        stg new p$i -m p$i &&
+        git add foo/bar &&
+        stg refresh
+    done
+'
+
+cat > expected1.txt <<EOF
+foo1
+EOF
+cat > expected2.txt <<EOF
+bar
+EOF
+test_expect_failure 'Goto in subdirectory (just pop)' '
+    (cd foo && stg goto p1) &&
+    cat foo/bar > actual.txt &&
+    diff -u expected1.txt actual.txt &&
+    ls foo > actual.txt &&
+    diff -u expected2.txt actual.txt
+'
+
+test_expect_success 'Prepare conflicting goto' '
+    stg delete p2
+'
+
+cat > expected1.txt <<EOF
+foo1
+<<<<<<< current:foo/bar
+=3D=3D=3D=3D=3D=3D=3D
+foo2
+foo3
+>>>>>>> patched:foo/bar
+EOF
+cat > expected2.txt <<EOF
+bar
+EOF
+test_expect_failure 'Goto in subdirectory (conflicting push)' '
+    (cd foo && stg goto p3) ;
+    [ $? -eq 3 ] &&
+    cat foo/bar > actual.txt &&
+    diff -u expected1.txt actual.txt &&
+    ls foo > actual.txt &&
+    diff -u expected2.txt actual.txt
+'
+
+test_done
