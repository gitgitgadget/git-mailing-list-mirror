From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Test that we can add a new file to a non-topmost patch
	with refresh -p
Date: Fri, 18 Jul 2008 19:03:06 +0200
Message-ID: <20080718170225.10086.17504.stgit@yoghurt>
References: <20080718084127.GA7042@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtNN-0008Fu-NU
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbYGRRDP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756625AbYGRRDP
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:03:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2122 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402AbYGRRDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:03:14 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KJthr-0003yW-00; Fri, 18 Jul 2008 18:25:23 +0100
In-Reply-To: <20080718084127.GA7042@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89056>

We currently can't -- this is bug 12038, found by Jon Smirl. See

  https://gna.org/bugs/index.php?12038

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Here's a proper test that demonstrates the bug. It applies to the
stable branch.

 t/t2701-refresh-p.sh |   46 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100755 t/t2701-refresh-p.sh


diff --git a/t/t2701-refresh-p.sh b/t/t2701-refresh-p.sh
new file mode 100755
index 0000000..d42e90f
--- /dev/null
+++ b/t/t2701-refresh-p.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description=3D'Run "stg refresh -p"'
+
+. ./test-lib.sh
+
+# Ignore our own temp files.
+cat >> .git/info/exclude <<EOF
+expected*.txt
+files*.txt
+status*.txt
+EOF
+
+test_expect_success 'Initialize StGit stack' '
+    stg init &&
+    for i in 1 2; do
+        echo x > $i.txt &&
+        git add $i.txt &&
+        stg new p$i -m "Patch $i" &&
+        stg refresh
+    done
+'
+
+touch expected0.txt
+cat > expected1.txt <<EOF
+A 1.txt
+A new.txt
+EOF
+cat > expected2.txt <<EOF
+A 2.txt
+EOF
+test_expect_failure 'Add new file to non-top patch' '
+    stg status > status1.txt &&
+    diff -u expected0.txt status1.txt &&
+    echo y > new.txt &&
+    git add new.txt &&
+    stg refresh -p p1 &&
+    stg status > status2.txt &&
+    diff -u expected0.txt status2.txt &&
+    stg files p1 > files1.txt &&
+    diff -u expected1.txt files1.txt &&
+    stg files p2 > files2.txt &&
+    diff -u expected2.txt files2.txt
+'
+
+test_done
