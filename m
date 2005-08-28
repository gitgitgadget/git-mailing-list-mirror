From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 5/9] New option --force-delete for git-apply.
Date: Sun, 28 Aug 2005 15:24:39 +0000
Message-ID: <11252426793534-git-send-email-robfitz@273k.net>
References: <11252426732064-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:24:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9P02-0006QM-Fp
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVH1PXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVH1PXH
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:23:07 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:36077 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751206AbVH1PXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:23:06 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9Ozf-0004Qk-Ee; Sun, 28 Aug 2005 16:22:55 +0100
In-Reply-To: <11252426732064-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7873>

Allow the user to force a patch that deletes a file to succeed even
though the file might still contain data.  Added a test case.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 Documentation/git-apply.txt  |    8 +++++-
 apply.c                      |   12 ++++++++-
 t/t4106-apply-force-delete.h |   54 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 3 deletions(-)
 create mode 100644 t/t4106-apply-force-delete.h

3fb13d4a86a1af7b545ce5f99904c1a5adae27e7
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -9,7 +9,9 @@ git-apply - Apply patch on a GIT index f
 
 SYNOPSIS
 --------
-'git-apply' [--no-merge] [--stat] [--summary] [--check] [--index] [--show-files] [--apply] [<patch>...]
+'git-apply' [--no-merge] [--stat] [--summary] [--check]
+		[--index] [--show-files] [--apply]
+		[--force-delete] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -61,6 +63,10 @@ OPTIONS
 	patch.  Give this flag after those flags to also apply
 	the patch.
 
+--force-delete::
+	Force a patch which deletes a file to succeed even if
+	file contents would be left behind, lines added or the
+	patch will not apply.
 
 Author
 ------
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -32,8 +32,9 @@ static int summary = 0;
 static int check = 0;
 static int apply = 1;
 static int show_files = 0;
+static int force_delete = 0;
 static const char apply_usage[] =
-"git-apply [--no-merge] [--stat] [--summary] [--check] [--index] [--apply] [--show-files] <patch>...";
+"git-apply [--no-merge] [--stat] [--summary] [--check] [--index] [--apply] [--show-files] [--force-delete] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -641,7 +642,7 @@ static int parse_fragment(char *line, un
 
 	if (patch->is_new && (patch->is_new != !oldlines))
 		return error("new file depends on old contents");
-	if (patch->is_delete && (patch->is_delete != !newlines)) {
+	if (!force_delete && patch->is_delete && (patch->is_delete != !newlines)) {
 		if (newlines)
 			return error("deleted file still has contents");
 		fprintf(stderr, "** warning: file %s becomes empty but is not deleted\n", patch->new_name);
@@ -981,6 +982,9 @@ static int apply_data(struct patch *patc
 	unsigned long size, alloc;
 	struct buffer_desc desc;
 
+	if (force_delete && patch->is_delete)
+		return 0;
+
 	size = 0;
 	alloc = 0;
 	buf = NULL;
@@ -1567,6 +1571,10 @@ int main(int argc, char **argv)
 			show_files = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--force-delete")) {
+			force_delete = 1;
+			continue;
+		}
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
 			usage(apply_usage);
diff --git a/t/t4106-apply-force-delete.h b/t/t4106-apply-force-delete.h
new file mode 100644
--- /dev/null
+++ b/t/t4106-apply-force-delete.h
@@ -0,0 +1,54 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply --force-delete.
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
+@@ -0,0 +1,3 @@
++int main() {
++       return 0;
++}
+EOF
+cat > patch2.patch <<\EOF
+diff --git a/main.c b/main.c
+deleted file mode 100644
+--- a/main.c
++++ /dev/null
+@@ -1,3 +0,0 @@
+-int main() {
+-       return 0;
+-}
+EOF
+cat > patch3.patch <<\EOF
+diff --git a/main.c b/main.c
+deleted file mode 100644
+--- a/main.c
++++ /dev/null
+EOF
+
+test_expect_success "S = new, del" \
+    'git-apply patch1.patch patch2.patch'
+rm -f main.c
+
+test_expect_failure "F = new, del short" \
+    'git-apply patch1.patch patch3.patch'
+rm -f main.c
+
+test_expect_success "S = new, del short (--force-delete)" \
+    'git-apply --force-delete patch1.patch patch3.patch'
+rm -f main.c
+
+test_done
+
