From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 6/9] New option --ignore-whitespace for git-apply.
Date: Sun, 28 Aug 2005 15:24:52 +0000
Message-ID: <1125242692932-git-send-email-robfitz@273k.net>
References: <11252426793534-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:25:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9P07-0006Sz-Rt
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVH1PXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVH1PXL
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:23:11 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:36589 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751208AbVH1PXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:23:09 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9Ozo-0004SA-54; Sun, 28 Aug 2005 16:23:00 +0100
In-Reply-To: <11252426793534-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7876>

Allow the user to force a patch to be applied even though there might
be whitespace differences.  Added a test case for the new option.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 Documentation/git-apply.txt        |    7 +++-
 apply.c                            |   38 ++++++++++++++++++-
 t/t4107-apply-ignore-whitespace.sh |   72 ++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 4 deletions(-)
 create mode 100644 t/t4107-apply-ignore-whitespace.sh

a928441d83ccc347b1d57fc561d413da56b93197
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 --------
 'git-apply' [--no-merge] [--stat] [--summary] [--check]
 		[--index] [--show-files] [--apply]
-		[--force-delete] [<patch>...]
+		[--force-delete] [--ignore-whitespace]
+		[<patch>...]
 
 DESCRIPTION
 -----------
@@ -68,6 +69,10 @@ OPTIONS
 	file contents would be left behind, lines added or the
 	patch will not apply.
 
+--ignore-whitespace::
+	When matching the patch to the file contents ignore
+	sequences of tabs or spaces.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -33,8 +33,9 @@ static int check = 0;
 static int apply = 1;
 static int show_files = 0;
 static int force_delete = 0;
+static int ignore_whitespace = 0;
 static const char apply_usage[] =
-"git-apply [--no-merge] [--stat] [--summary] [--check] [--index] [--apply] [--show-files] [--force-delete] <patch>...";
+"git-apply [--no-merge] [--stat] [--summary] [--check] [--index] [--apply] [--show-files] [--force-delete] [--ignore-whitespace] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -109,6 +110,27 @@ static void *read_patch_file(int fd, uns
 	return buffer;
 }
 
+static int memcmp_ignore_whitespace(const char *s1, const char *s2, size_t n)
+{
+	const char *stop = s1 + n;
+	int result;
+
+	if (!n)
+		return 0;
+
+	do {
+		if (((*s1 == ' ') || (*s1 == '\t')) && ((*s2 == ' ') || (*s2 == '\t'))) {
+			while ((*s1 == ' ') || (*s1 == '\t'))
+				s1++;
+			while ((*s2 == ' ') || (*s2 == '\t'))
+				s2++;
+		}
+		result = *s1++ - *s2++;
+	} while (!result && (s1 < stop));
+
+	return result;
+}
+
 static unsigned long linelen(const char *buffer, unsigned long size)
 {
 	unsigned long len = 0;
@@ -839,7 +861,10 @@ static int find_offset(const char *buf, 
 	}
 
 	/* Exact line number? */
-	if (!memcmp(buf + start, fragment, fragsize))
+	if (ignore_whitespace) {
+		if (!memcmp_ignore_whitespace(buf + start, fragment, fragsize))
+			return start;
+	} else if (!memcmp(buf + start, fragment, fragsize))
 		return start;
 
 	/*
@@ -873,7 +898,10 @@ static int find_offset(const char *buf, 
 
 		if (try + fragsize > size)
 			continue;
-		if (memcmp(buf + try, fragment, fragsize))
+		if (ignore_whitespace) {
+			if (memcmp_ignore_whitespace(buf + try, fragment, fragsize))
+				continue;
+		} else if (memcmp(buf + try, fragment, fragsize))
 			continue;
 		n = (i >> 1)+1;
 		if (i & 1)
@@ -1575,6 +1603,10 @@ int main(int argc, char **argv)
 			force_delete = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--ignore-whitespace")) {
+			ignore_whitespace = 1;
+			continue;
+		}
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
 			usage(apply_usage);
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
new file mode 100644
--- /dev/null
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply --ignore-whitespace.
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
++       int i;
++
++       for (i = 0; i < 10; i++) {
++               print_int(func(i));
++       }
++
++       return 0;
++}
++
++int func(int num) {
++       return num * num;
++}
++
++void print_int(int num) {
++       printf("%d", num);
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
+EOF
+
+test_expect_success "S = patch1" \
+    'git-apply patch1.patch'
+
+test_expect_failure "F = patch2" \
+    'git-apply patch2.patch'
+
+test_expect_success "S = patch2 (--ignore-whitespace)" \
+    'git-apply --ignore-whitespace patch2.patch'
+
+rm -f main.c
+test_expect_success "S = patch1 (--ignore-whitespace)" \
+    'git-apply --ignore-whitespace patch1.patch'
+
+test_done
+
