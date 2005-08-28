From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 8/9] New git-apply test cases for patches with mulitple fragments.
Date: Sun, 28 Aug 2005 15:25:06 +0000
Message-ID: <11252427062184-git-send-email-robfitz@273k.net>
References: <11252426961236-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:25:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9P0J-0006Xc-Dp
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVH1PXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVH1PXX
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:23:23 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:37101 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751213AbVH1PXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:23:22 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9P02-0004TW-95; Sun, 28 Aug 2005 16:23:13 +0100
In-Reply-To: <11252426961236-git-send-email-robfitz@273k.net>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7877>

Added a test case for patches with multiple fragments.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 t/t4109-apply-multifrag.sh |  176 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 176 insertions(+), 0 deletions(-)
 create mode 100644 t/t4109-apply-multifrag.sh

28b46271270ad79ba8720a3fde1f40724493fdfe
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
new file mode 100644
--- /dev/null
+++ b/t/t4109-apply-multifrag.sh
@@ -0,0 +1,176 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply test patches with multiple fragments.
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat > patch1.patch <<\EOF
+diff --git a/main.c b/main.c
+new file mode 100644
+--- /dev/null
++++ b/main.c
+@@ -0,0 +1,23 @@
++#include <stdio.h>
++
++int func(int num);
++void print_int(int num);
++
++int main() {
++	int i;
++
++	for (i = 0; i < 10; i++) {
++		print_int(func(i));
++	}
++
++	return 0;
++}
++
++int func(int num) {
++	return num * num;
++}
++
++void print_int(int num) {
++	printf("%d", num);
++}
++
+EOF
+cat > patch2.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -1,7 +1,9 @@
++#include <stdlib.h>
+ #include <stdio.h>
+ 
+ int func(int num);
+ void print_int(int num);
++void print_ln();
+ 
+ int main() {
+ 	int i;
+@@ -10,6 +12,8 @@
+ 		print_int(func(i));
+ 	}
+ 
++	print_ln();
++
+ 	return 0;
+ }
+ 
+@@ -21,3 +25,7 @@
+ 	printf("%d", num);
+ }
+ 
++void print_ln() {
++	printf("\n");
++}
++
+EOF
+cat > patch3.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -1,9 +1,7 @@
+-#include <stdlib.h>
+ #include <stdio.h>
+ 
+ int func(int num);
+ void print_int(int num);
+-void print_ln();
+ 
+ int main() {
+ 	int i;
+@@ -12,8 +10,6 @@
+ 		print_int(func(i));
+ 	}
+ 
+-	print_ln();
+-
+ 	return 0;
+ }
+ 
+@@ -25,7 +21,3 @@
+ 	printf("%d", num);
+ }
+ 
+-void print_ln() {
+-	printf("\n");
+-}
+-
+EOF
+cat > patch4.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -1,13 +1,14 @@
+ #include <stdio.h>
+ 
+ int func(int num);
+-void print_int(int num);
++int func2(int num);
+ 
+ int main() {
+ 	int i;
+ 
+ 	for (i = 0; i < 10; i++) {
+-		print_int(func(i));
++		printf("%d", func(i));
++		printf("%d", func3(i));
+ 	}
+ 
+ 	return 0;
+@@ -17,7 +18,7 @@
+ 	return num * num;
+ }
+ 
+-void print_int(int num) {
+-	printf("%d", num);
++int func2(int num) {
++	return num * num * num;
+ }
+ 
+EOF
+
+test_expect_success "S = git-apply (1)" \
+    'git-apply patch1.patch patch2.patch'
+mv main.c main.c.git
+
+test_expect_success "S = patch (1)" \
+    'cat patch1.patch patch2.patch | patch -p1'
+
+test_expect_success "S = cmp (1)" \
+    'cmp main.c.git main.c'
+
+rm -f main.c main.c.git
+
+test_expect_success "S = git-apply (2)" \
+    'git-apply patch1.patch patch2.patch patch3.patch'
+mv main.c main.c.git
+
+test_expect_success "S = patch (2)" \
+    'cat patch1.patch patch2.patch patch3.patch | patch -p1'
+
+test_expect_success "S = cmp (2)" \
+    'cmp main.c.git main.c'
+
+rm -f main.c main.c.git
+
+test_expect_success "S = git-apply (3)" \
+    'git-apply patch1.patch patch4.patch'
+mv main.c main.c.git
+
+test_expect_success "S = patch (3)" \
+    'cat patch1.patch patch4.patch | patch -p1'
+
+test_expect_success "S = cmp (3)" \
+    'cmp main.c.git main.c'
+
+test_done
+
