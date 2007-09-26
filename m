From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Add --no-rename to git-apply
Date: Wed, 26 Sep 2007 23:26:44 +0200
Message-ID: <11908420041596-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 26 23:25:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaeNG-0007HM-Rp
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 23:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761206AbXIZVYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 17:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760987AbXIZVYk
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 17:24:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:8111 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbXIZVYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 17:24:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 63D298028BC;
	Wed, 26 Sep 2007 23:16:21 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32760-09; Wed, 26 Sep 2007 23:16:20 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id D577780286A;
	Wed, 26 Sep 2007 23:16:20 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 8CC5A29985; Wed, 26 Sep 2007 23:26:44 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1.g80926
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59249>

With this option git-apply can apply a patch with a rename
onto the original file(s).

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-apply.txt       |    6 ++-
 builtin-apply.c                   |   17 +++++++-
 t/t4123-apply-renames-norename.sh |   85 +++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100755 t/t4123-apply-renames-norename.sh

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 4c7e3a2..b691c55 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
-	  [--apply] [--no-add] [--index-info] [-R | --reverse]
+	  [--apply] [--no-add] [--no-rename] [--index-info] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
 	  [--whitespace=<nowarn|warn|error|error-all|strip>]
@@ -121,6 +121,10 @@ discouraged.
 	the result with this option, which would apply the
 	deletion part but not addition part.
 
+--no-rename::
+	When applying patches with renames, this patch applies
+	the patch to the original file.
+
 --allow-binary-replacement, --binary::
 	Historically we did not allow binary patch applied
 	without an explicit permission from the user, and this
diff --git a/builtin-apply.c b/builtin-apply.c
index 25b1447..73134e8 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -41,11 +41,12 @@ static int apply_in_reverse;
 static int apply_with_reject;
 static int apply_verbosely;
 static int no_add;
+static int no_rename;
 static int show_index_info;
 static int line_termination = '\n';
 static unsigned long p_context = ULONG_MAX;
 static const char apply_usage[] =
-"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
+"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--no-rename] [--index-info]   [--allow-binary-replacement] [--reverse [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>]  <patch>...";
 
 static enum whitespace_eol {
 	nowarn_whitespace,
@@ -495,6 +496,8 @@ static int gitdiff_copydst(const char *line, struct patch *patch)
 
 static int gitdiff_renamesrc(const char *line, struct patch *patch)
 {
+	if (no_rename)
+		return 0;
 	patch->is_rename = 1;
 	patch->old_name = find_name(line, NULL, 0, 0);
 	return 0;
@@ -502,6 +505,8 @@ static int gitdiff_renamesrc(const char *line, struct patch *patch)
 
 static int gitdiff_renamedst(const char *line, struct patch *patch)
 {
+	if (no_rename)
+		return 0;
 	patch->is_rename = 1;
 	patch->new_name = find_name(line, NULL, 0, 0);
 	return 0;
@@ -2103,6 +2108,11 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 	struct cache_entry *ce = NULL;
 	int ok_if_exists;
 
+	if (no_rename) {
+		new_name = old_name;
+		patch->new_name = old_name;
+	}
+
 	patch->rejected = 1; /* we will drop this after we succeed */
 
 	/*
@@ -2843,6 +2853,11 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			no_add = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-rename")) {
+			no_rename = 1;
+			continue;
+		}
+
 		if (!strcmp(arg, "--stat")) {
 			apply = 0;
 			diffstat = 1;
diff --git a/t/t4123-apply-renames-norename.sh b/t/t4123-apply-renames-norename.sh
new file mode 100755
index 0000000..8c0d523
--- /dev/null
+++ b/t/t4123-apply-renames-norename.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Robin Rosenberg
+#
+
+test_description='git apply --no-rename.
+
+'
+
+. ./test-lib.sh
+
+# setup
+
+mkdir -p klibc/arch/x86_64/include/klibc
+
+cat >klibc/arch/x86_64/include/klibc/archsetjmp.h <<\EOF
+/*
+ * arch/x86_64/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+  unsigned long __rbx;
+  unsigned long __rsp;
+  unsigned long __rbp;
+  unsigned long __r12;
+  unsigned long __r13;
+  unsigned long __r14;
+  unsigned long __r15;
+  unsigned long __rip;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif /* _SETJMP_H */
+EOF
+
+cat >patch <<\EOF
+diff --git a/klibc/arch/x86_64/include/klibc/archsetjmp.h b/include/arch/m32r/klibc/archsetjmp.h
+similarity index 66%
+rename from klibc/arch/x86_64/include/klibc/archsetjmp.h
+rename to include/arch/m32r/klibc/archsetjmp.h
+--- a/klibc/arch/x86_64/include/klibc/archsetjmp.h
++++ b/include/arch/m32r/klibc/archsetjmp.h
+@@ -1,21 +1,21 @@
+ /*
+- * arch/x86_64/include/klibc/archsetjmp.h
++ * arch/m32r/include/klibc/archsetjmp.h
+  */
+
+ #ifndef _KLIBC_ARCHSETJMP_H
+ #define _KLIBC_ARCHSETJMP_H
+
+ struct __jmp_buf {
+-  unsigned long __rbx;
+-  unsigned long __rsp;
+-  unsigned long __rbp;
++  unsigned long __r8;
++  unsigned long __r9;
++  unsigned long __r10;
++  unsigned long __r11;
+   unsigned long __r12;
+   unsigned long __r13;
+   unsigned long __r14;
+   unsigned long __r15;
+-  unsigned long __rip;
+ };
+
+ typedef struct __jmp_buf jmp_buf[1];
+
+-#endif /* _SETJMP_H */
++#endif /* _KLIBC_ARCHSETJMP_H */
+EOF
+
+find klibc -type f -print | xargs git update-index --add --
+
+test_expect_success 'apply rename patch, without doing rename' \
+'git apply --no-rename patch &&
+git diff --numstat >stat.diff &&
+test "$(cat stat.diff)" = "6	6	klibc/arch/x86_64/include/klibc/archsetjmp.h"
+'
+
+test_done
-- 
1.5.3.1.g80926
