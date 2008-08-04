From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Add some tests of refreshing removed files
Date: Mon, 04 Aug 2008 15:41:48 +0200
Message-ID: <20080804134050.19457.96613.stgit@yoghurt>
References: <9e4733910807311902nd3a02bep68c8a26a7e6303cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:42:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0Ku-0007vG-1G
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbYHDNly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 09:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbYHDNly
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:41:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4236 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbYHDNlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 09:41:53 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KQ0fM-0003VW-00; Mon, 04 Aug 2008 15:04:04 +0100
In-Reply-To: <9e4733910807311902nd3a02bep68c8a26a7e6303cd@mail.gmail.com>
User-Agent: StGIT/0.14.3.211.g7374
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91351>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

These four tests all pass on Catalin's current master. Do they fail
for you, or did I miss something in your problem description?

 t/t2702-refresh-rm.sh |  101 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100755 t/t2702-refresh-rm.sh


diff --git a/t/t2702-refresh-rm.sh b/t/t2702-refresh-rm.sh
new file mode 100755
index 0000000..896ebf3
--- /dev/null
+++ b/t/t2702-refresh-rm.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description=3D'"stg refresh" with removed files'
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
+reset () {
+    stg pop -a > /dev/null
+    git reset --hard > /dev/null
+}
+
+test_expect_success 'Initialize StGit stack' '
+    stg init &&
+    echo x > x.txt &&
+    echo y > y.txt &&
+    git add x.txt y.txt &&
+    git commit -m "Add some files"
+'
+
+cat > expected0.txt <<EOF
+D y.txt
+EOF
+printf '' > expected1.txt
+test_expect_success 'git-rm a file' '
+    stg new -m p0 &&
+    git rm y.txt &&
+    stg status > status0.txt &&
+    test_cmp expected0.txt status0.txt &&
+    stg refresh &&
+    stg status > status1.txt &&
+    test_cmp expected1.txt status1.txt &&
+    stg files | sort > files.txt &&
+    test_cmp expected0.txt files.txt
+'
+
+reset
+
+cat > expected0.txt <<EOF
+D y.txt
+M x.txt
+EOF
+printf '' > expected1.txt
+test_expect_success 'git-rm a file together with other changes' '
+    stg new -m p1 &&
+    echo x2 >> x.txt &&
+    git rm y.txt &&
+    stg status > status0.txt &&
+    test_cmp expected0.txt status0.txt &&
+    stg refresh &&
+    stg status > status1.txt &&
+    test_cmp expected1.txt status1.txt &&
+    stg files | sort > files.txt &&
+    test_cmp expected0.txt files.txt
+'
+
+reset
+
+cat > expected0.txt <<EOF
+D y.txt
+EOF
+printf '' > expected1.txt
+test_expect_success 'rm a file' '
+    stg new -m p2 &&
+    rm y.txt &&
+    stg status > status0.txt &&
+    test_cmp expected0.txt status0.txt &&
+    stg refresh &&
+    stg status > status1.txt &&
+    test_cmp expected1.txt status1.txt &&
+    stg files | sort > files.txt &&
+    test_cmp expected0.txt files.txt
+'
+
+reset
+
+cat > expected0.txt <<EOF
+D y.txt
+M x.txt
+EOF
+printf '' > expected1.txt
+test_expect_success 'rm a file together with other changes' '
+    stg new -m p3 &&
+    echo x2 >> x.txt &&
+    rm y.txt &&
+    stg status > status0.txt &&
+    test_cmp expected0.txt status0.txt &&
+    stg refresh &&
+    stg status > status1.txt &&
+    test_cmp expected1.txt status1.txt &&
+    stg files | sort > files.txt &&
+    test_cmp expected0.txt files.txt
+'
+
+test_done
