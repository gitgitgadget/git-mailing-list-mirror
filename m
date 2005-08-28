From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 3/9] Fix processing of a patch file which modifies the same file in git-apply.
Date: Sun, 28 Aug 2005 15:24:28 +0000
Message-ID: <11252426681254-git-send-email-robfitz@273k.net>
References: <1125242667404-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:23:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Ozm-0006Ld-1j
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVH1PWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVH1PWv
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:22:51 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:35565 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751204AbVH1PWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:22:50 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9OzU-0004Pb-1y; Sun, 28 Aug 2005 16:22:37 +0100
In-Reply-To: <1125242667404-git-send-email-robfitz@273k.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7872>

A patch file (or stdin) which modifies the same file more then once
will fail to apply the patch correctly.  In the worst case it will
apply some of the patch and leave an invalid output file(s).

apply.c has been changed to search for previously processed files and
use the in memory copy of the data instead of the on disk image.
Added a series of test cases for the processing of complex single
file patches.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 apply.c                  |   64 +++++++++++++-
 t/t4104-apply-complex.sh |  211 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 270 insertions(+), 5 deletions(-)
 create mode 100644 t/t4104-apply-complex.sh

be1277e3531a03441839fd1dc750dad640ebf218
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -67,6 +67,7 @@ struct patch {
 	char *result;
 	unsigned long resultsize;
 	struct patch *next;
+	struct patch *prev;
 };
 
 #define CHUNKSIZE (8192)
@@ -974,7 +975,7 @@ static int apply_fragments(struct buffer
 	return 0;
 }
 
-static int apply_data(struct patch *patch, struct stat *st)
+static int apply_data(struct patch *patch, struct patch *old_patch, struct stat *st)
 {
 	char *buf;
 	unsigned long size, alloc;
@@ -983,7 +984,13 @@ static int apply_data(struct patch *patc
 	size = 0;
 	alloc = 0;
 	buf = NULL;
-	if (patch->old_name) {
+
+	if (patch->old_name && old_patch) {
+		size = old_patch->resultsize;
+		alloc = size + 8192;
+		buf = xmalloc(alloc);
+		memcpy(buf, old_patch->result, size);
+	} else if (patch->old_name) {
 		size = st->st_size;
 		alloc = size + 8192;
 		buf = xmalloc(alloc);
@@ -1010,8 +1017,46 @@ static int check_patch(struct patch *pat
 	struct stat st;
 	const char *old_name = patch->old_name;
 	const char *new_name = patch->new_name;
+	struct patch *old_patch = NULL;
+	struct patch *new_patch = NULL;
 
 	if (old_name) {
+		for (old_patch = patch->prev; old_patch; old_patch = old_patch->prev) {
+			if (old_patch->new_name && !strcmp(old_name, old_patch->new_name)) {
+				break;
+			}
+			if (old_patch->old_name && !strcmp(old_name, old_patch->old_name)) {
+				if (old_patch->is_delete || old_patch->is_rename) {
+					return error("%s: file missing because of previous patch", old_name);
+				}
+				break;
+			}
+		}
+	}
+
+	if (new_name) {
+		for (new_patch = patch->prev; new_patch; new_patch = new_patch->prev) {
+			if (new_patch->new_name && !strcmp(new_name, new_patch->new_name)) {
+				if (patch->is_new || patch->is_rename || patch->is_copy)
+					return error("%s: file exists from previous patch (new)", new_name);
+				break;
+			}
+			if (new_patch->old_name && !strcmp(new_name, new_patch->old_name)) {
+				if (!(patch->is_new || patch->is_delete || patch->is_rename || patch->is_copy))
+					break;
+				if (new_patch->is_delete || new_patch->is_rename)
+					break;
+				return error("%s: file exists from previous patch (old)", new_name);
+			}
+		}
+	}
+
+	if (old_patch) {
+		if (patch->is_new < 0)
+			patch->is_new = 0;
+		if (!patch->old_mode)
+			patch->old_mode = old_patch->new_mode;
+	} else if (old_name) {
 		int changed;
 
 		if (lstat(old_name, &st) < 0)
@@ -1036,7 +1081,14 @@ static int check_patch(struct patch *pat
 				old_name, st.st_mode, patch->old_mode);
 	}
 
-	if (new_name && (patch->is_new | patch->is_rename | patch->is_copy)) {
+	if (new_patch) {
+		if (!patch->new_mode) {
+			if (patch->is_new)
+				patch->new_mode = S_IFREG | 0644;
+			else
+				patch->new_mode = patch->old_mode;
+		}
+	} else if (new_name && (patch->is_new | patch->is_rename | patch->is_copy)) {
 		if (check_index && cache_name_pos(new_name, strlen(new_name)) >= 0)
 			return error("%s: already exists in index", new_name);
 		if (!lstat(new_name, &st))
@@ -1061,7 +1113,7 @@ static int check_patch(struct patch *pat
 				same ? "" : " of ", same ? "" : old_name);
 	}	
 
-	if (apply_data(patch, &st) < 0)
+	if (apply_data(patch, old_patch, &st) < 0)
 		return error("%s: patch does not apply", old_name);
 	return 0;
 }
@@ -1393,6 +1445,7 @@ static int apply_patch(int fd)
 	unsigned long offset, size;
 	char *buffer = read_patch_file(fd, &size);
 	struct patch *list = NULL, **listp = &list;
+	struct patch *list_prev = NULL;
 	int skipped_patch = 0;
 
 	if (!buffer)
@@ -1409,7 +1462,8 @@ static int apply_patch(int fd)
 			break;
 		if (use_patch(patch)) {
 			patch_stats(patch);
-			*listp = patch;
+			patch->prev = list_prev;
+			list_prev = *listp = patch;
 			listp = &patch->next;
 		} else {
 			/* perhaps free it a bit better? */
diff --git a/t/t4104-apply-complex.sh b/t/t4104-apply-complex.sh
new file mode 100644
--- /dev/null
+++ b/t/t4104-apply-complex.sh
@@ -0,0 +1,211 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+# Copyright (c) 2005 Robert Fitzsimons
+#
+
+test_description='git-apply complex patches.
+
+'
+. ./test-lib.sh
+
+# setup
+
+cat > Nx <<\EOF
+diff --git a/x.txt b/x.txt
+new file mode 100644
+--- /dev/null
++++ b/x.txt
+EOF
+cat > Ny <<\EOF
+diff --git a/y.txt b/y.txt
+new file mode 100644
+--- /dev/null
++++ b/y.txt
+EOF
+cat > Rxy <<\EOF
+diff --git a/x.txt b/y.txt
+rename from x.txt
+rename to y.txt
+--- a/x.txt
++++ b/y.txt
+EOF
+cat > Ryx <<\EOF
+diff --git a/y.txt b/x.txt
+rename from y.txt
+rename to x.txt
+--- a/y.txt
++++ b/x.txt
+EOF
+cat > Cxy <<\EOF
+diff --git a/x.txt b/y.txt
+copy from x.txt
+copy to y.txt
+--- a/x.txt
++++ b/y.txt
+EOF
+cat > Cyx <<\EOF
+diff --git a/y.txt b/x.txt
+copy from y.txt
+copy to x.txt
+--- a/y.txt
++++ b/x.txt
+EOF
+cat > Dx <<\EOF
+diff --git a/x.txt b/x.txt
+deleted file mode 100644
+--- a/x.txt
++++ /dev/null
+EOF
+cat > Dy <<\EOF
+diff --git a/y.txt b/y.txt
+deleted file mode 100644
+--- a/y.txt
++++ /dev/null
+EOF
+cat > Px1 <<\EOF
+diff --git a/x.txt b/x.txt
+--- a/x.txt
++++ b/x.txt
+@@ -0,0 +1 @@
++XXX
+EOF
+cat > Px2 <<\EOF
+diff --git a/x.txt b/x.txt
+--- a/x.txt
++++ b/x.txt
+@@ -1 +1,2 @@
+ XXX
++XX
+EOF
+cat > Px3 <<\EOF
+diff --git a/x.txt b/x.txt
+--- a/x.txt
++++ b/x.txt
+@@ -1,2 +0,0 @@
+-XXX
+-XX
+EOF
+
+test_expect_success "S = Nx Cxy Dx Dy Ny Ryx Cxy Dx Dy (files)" \
+    'git-apply Nx Cxy Dx Dy Ny Ryx Cxy Dx Dy'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Cxy Dx Dy Ny Ryx Cxy Dx Dy (stdin)" \
+    'cat Nx Cxy Dx Dy Ny Ryx Cxy Dx Dy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx" \
+    'cat Nx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Dx" \
+    'cat Nx Dx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Px1" \
+    'cat Nx Px1 | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Px1 Px2" \
+    'cat Nx Px1 Px2 | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Px1 Px2 Px3" \
+    'cat Nx Px1 Px2 Px3 | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Px1 Px2 Px3 Dx" \
+    'cat Nx Px1 Px2 Px3 Dx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Rxy" \
+    'cat Nx Rxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Rxy Dy" \
+    'cat Nx Rxy Dy| git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Cxy" \
+    'cat Nx Cxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Rxy Dx Dy" \
+    'cat Nx Cxy Dx Dy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Ny Ryx Px1 Px2 Cxy Px3 Dx" \
+    'cat Ny Ryx Px1 Px2 Cxy Px3 Dx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Ny Ryx Px1 Px2 Cxy Px3 Dx Cyx" \
+    'cat Ny Ryx Px1 Px2 Cxy Px3 Dx Cyx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Ny Cyx Px1 Px2 Px3 Dy Cxy Dx Cyx Dy Rxy Dy" \
+    'cat Ny Cyx Px1 Px2 Px3 Dy Cxy Dx Cyx Dy Rxy Dy| git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Dx" \
+    'cat Dx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Rxy" \
+    'cat Rxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Cxy" \
+    'cat Cxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Nx Dx Dx" \
+    'cat Nx Dx Dx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Nx Ny Rxy" \
+    'cat Nx Ny Rxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Ny Rxy" \
+    'cat Ny Rxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Nx Ny Cxy" \
+    'cat Nx Ny Cxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Ny Cxy" \
+    'cat Ny Cxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Nx Cxy Cxy" \
+    'cat Nx Cxy Cxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Nx Cxy Cyx" \
+    'cat Nx Cxy Cyx | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Nx Rxy Rxy" \
+    'cat Nx Rxy Rxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Nx Rxy Cxy" \
+    'cat Nx Rxy Cxy | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_failure "F = Ny Ryx Px1 Px2 Px3 Dx Cyx Px2" \
+    'cat Ny Ryx Px1 Px2 Px3 Dx Cyx Px2 | git-apply -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Cxy Dx Cyx Dy Rxy Dy Nx Ny Dx Ryx Cxy Dx Dy Nx Rxy Dy Nx Cxy Dy Dx (--check)" \
+    'cat Nx Cxy Dx Cyx Dy Rxy Dy Nx Ny Dx Ryx Cxy Dx Dy Nx Rxy Dy Nx Cxy Dy Dx | git-apply --check -'
+rm -f x.txt y.txt
+
+test_expect_success "S = Nx Cxy Dx Cyx Dy Rxy Dy Nx Ny Dx Ryx Cxy Dx Dy Nx Rxy Dy Nx Cxy Dy Dx" \
+    'cat Nx Cxy Dx Cyx Dy Rxy Dy Nx Ny Dx Ryx Cxy Dx Dy Nx Rxy Dy Nx Cxy Dy Dx | git-apply -'
+rm -f x.txt y.txt
+
+test_done
+
