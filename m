From: Robert Fitzsmons <robfitz@273k.net>
Subject: [PATCH 3/3] New option --ignore-applied for git-apply.
Date: Tue, 30 Aug 2005 00:01:52 +0000
Message-ID: <11253601123047-git-send-email-robfitz@273k.net>
References: <11253601111257-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsmons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 02:00:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9tY1-0005hh-8w
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 02:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVH3AAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 20:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVH2X77
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 19:59:59 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:18331 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S932093AbVH2X76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 19:59:58 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9tXN-0005h6-B0; Tue, 30 Aug 2005 00:59:37 +0100
In-Reply-To: <11253601111257-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7929>

Allow the user to allow a patch which has some hunks (fragments)
already applied to succeed.  Added test case and documentation.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 Documentation/git-apply.txt     |    7 ++-
 apply.c                         |   12 +++++
 t/t4108-apply-ignore-applied.sh |   94 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 t/t4108-apply-ignore-applied.sh

e8f2ff89f44b0c4d35dea3d86331a5e00fadf27e
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,9 @@ git-apply - Apply patch on a GIT index f
 
 SYNOPSIS
 --------
-'git-apply' [--no-merge] [--stat] [--summary] [--check] [--index] [--show-files] [--apply] [<patch>...]
+'git-apply' [--no-merge] [--stat] [--summary] [--check]
+		[--index] [--show-files] [--apply]
+		[--ignore-applied] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -61,6 +63,9 @@ OPTIONS
 	patch.  Give this flag after those flags to also apply
 	the patch.
 
+--ignore-applied::
+	If a patch hunk (fragment) fails to apply, reverse the
+	hunk and check if the hunk has already been applied.
 
 Author
 ------
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -32,8 +32,9 @@ static int summary = 0;
 static int check = 0;
 static int apply = 1;
 static int show_files = 0;
+static int ignore_applied = 0;
 static const char apply_usage[] =
-"git-apply [--no-merge] [--stat] [--summary] [--check] [--index] [--apply] [--show-files] <patch>...";
+"git-apply [--no-merge] [--stat] [--summary] [--check] [--index] [--apply] [--show-files] [--ignore-applied] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -956,6 +957,11 @@ static int apply_one_fragment(struct buf
 		memmove(buf + offset + newsize, buf + offset + oldsize, size - offset - newsize);
 		memcpy(buf + offset, new, newsize);
 		offset = 0;
+	} else if (ignore_applied) {
+		offset = find_offset(buf, desc->size, new, newsize, frag->newpos);
+		if (offset >= 0) {
+			offset = 0;
+		}
 	}
 
 	free(old);
@@ -1567,6 +1573,10 @@ int main(int argc, char **argv)
 			show_files = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--ignore-applied")) {
+			ignore_applied = 1;
+			continue;
+		}
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
 			usage(apply_usage);
diff --git a/t/t4108-apply-ignore-applied.sh b/t/t4108-apply-ignore-applied.sh
new file mode 100644
--- /dev/null
+++ b/t/t4108-apply-ignore-applied.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply --ignore-applied.
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
+@@ -10,6 +10,8 @@
+ 		print_int(func(i));
+ 	}
+ 
++	printf("\n");
++
+ 	return 0;
+ }
+ 
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
+test_expect_failure "F = test 1" \
+    'cat patch1.patch patch2.patch patch2.patch | git-apply --check'
+
+test_expect_success "S = test 2 (--ignore-applied)" \
+    'cat patch1.patch patch2.patch patch2.patch | git-apply --check --ignore-applied'
+
+test_expect_failure "F = test 3" \
+    'cat patch1.patch patch3.patch patch3.patch | git-apply --check'
+
+test_expect_success "S = test 4 (--ignore-applied)" \
+    'cat patch1.patch patch2.patch patch3.patch | git-apply --check --ignore-applied'
+
+test_done
+
