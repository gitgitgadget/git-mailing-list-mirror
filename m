From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 4/9] Fix the procssing of multiple patch files with --check in git-apply.
Date: Sun, 28 Aug 2005 15:24:33 +0000
Message-ID: <11252426732064-git-send-email-robfitz@273k.net>
References: <11252426681254-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:22:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Ozr-0006MR-2R
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVH1PWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVH1PWx
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:22:53 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:35821 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751205AbVH1PWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:22:53 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9OzZ-0004Pr-FT; Sun, 28 Aug 2005 16:22:43 +0100
In-Reply-To: <11252426681254-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7869>

When the --check option was used with multiple patch files which
modify the same files, the patch can fail because the previously
modified contents aren't written to the disk.

So save the in memory patch contents across the processing of multiple
patch files.  Added a new test case for --check with multiple patch
files.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 apply.c                |   10 ++++-
 t/t4105-apply-check.sh |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 t/t4105-apply-check.sh

80ed0622e31bd52cedd073f54c9a9364b5289c89
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1439,13 +1439,16 @@ static int use_patch(struct patch *p)
 	return 1;
 }
 
+struct patch *master_list = NULL;
+struct patch *master_list_prev = NULL;
+
 static int apply_patch(int fd)
 {
 	int newfd;
 	unsigned long offset, size;
 	char *buffer = read_patch_file(fd, &size);
-	struct patch *list = NULL, **listp = &list;
-	struct patch *list_prev = NULL;
+	struct patch *list = master_list, **listp = &list;
+	struct patch *list_prev = master_list_prev;
 	int skipped_patch = 0;
 
 	if (!buffer)
@@ -1504,6 +1507,9 @@ static int apply_patch(int fd)
 	if (summary)
 		summary_patch_list(list);
 
+	master_list = list;
+	master_list_prev = list_prev;
+
 	free(buffer);
 	return 0;
 }
diff --git a/t/t4105-apply-check.sh b/t/t4105-apply-check.sh
new file mode 100644
--- /dev/null
+++ b/t/t4105-apply-check.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply --check with multiple files.
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
++void print_int(int num);
++int func(int num);
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
+@@ -10,6 +10,8 @@
+ 		print_int(func(i));
+ 	}
+ 
++	printf("\n");
++
+ 	return 0;
+ }
+ 
+EOF
+cat > patch3.patch <<\EOF
+diff --git a/main.c b/main.c
+--- a/main.c
++++ b/main.c
+@@ -18,6 +20,6 @@
+ }
+ 
+ void print_int(int num) {
+-	printf("%d", num);
++	printf("%d ", num);
+ }
+ 
+EOF
+
+test_expect_success "S = test 1" \
+    'git-apply patch1.patch patch2.patch patch3.patch'
+rm -f main.c
+
+test_expect_success "S = test 2" \
+    'git-apply --check patch1.patch patch2.patch patch3.patch'
+rm -f main.c
+
+test_expect_success "S = test 3" \
+    'cat patch1.patch patch2.patch patch3.patch | git-apply'
+rm -f main.c
+
+test_expect_success "S = test 4" \
+    'cat patch1.patch patch2.patch patch3.patch | git-apply --check'
+rm -f main.c
+
+test_done
+
