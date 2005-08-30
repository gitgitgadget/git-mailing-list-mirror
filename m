From: Robert Fitzsmons <robfitz@273k.net>
Subject: [PATCH 2/3] Fix the processing of multiple patch files with --check in git-apply.
Date: Tue, 30 Aug 2005 00:01:51 +0000
Message-ID: <11253601111257-git-send-email-robfitz@273k.net>
References: <1125360111916-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsmons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 02:00:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9tY0-0005hh-6u
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 02:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVH2X74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 19:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVH2X74
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 19:59:56 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:17819 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S932092AbVH2X7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 19:59:55 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9tXM-0005h5-U3; Tue, 30 Aug 2005 00:59:37 +0100
In-Reply-To: <1125360111916-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7928>

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

797cc1bdcc647b9fb744784969c814145803407d
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
+test_expect_success "S = test 1 (files)" \
+    'git-apply patch1.patch patch2.patch patch3.patch'
+rm -f main.c
+
+test_expect_success "S = test 2 (files --check)" \
+    'git-apply --check patch1.patch patch2.patch patch3.patch'
+rm -f main.c
+
+test_expect_success "S = test 3 (stdin)" \
+    'cat patch1.patch patch2.patch patch3.patch | git-apply'
+rm -f main.c
+
+test_expect_success "S = test 4 (stdin --check)" \
+    'cat patch1.patch patch2.patch patch3.patch | git-apply --check'
+rm -f main.c
+
+test_done
+
