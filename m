From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 1/2] mergetool: don't skip modify/remove conflicts
Date: Sat, 12 Feb 2011 23:09:57 -0500
Message-ID: <1297570198-21103-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 05:10:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoTIJ-0006L3-6g
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 05:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab1BMEKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 23:10:40 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57724 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab1BMEKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 23:10:34 -0500
Received: by mail-vw0-f46.google.com with SMTP id 16so2440224vws.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 20:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qecPZrA07ndYsWjUlFh0KggJMb2tjZcX3fkvkpQjCH0=;
        b=C+DwiZwv40nbZ8jHiyuD5vVAj2onFdWmnQRIh4/36R7m3LTiKW8J+qeNE+t/QrLtnG
         jGVWmGqnIwcxVi08BOAGP2hxscw+2+CF7xcwVRxQUobBLepmXcpVeLK8btue9UFwrCqH
         tlth6f+VkSvb9xiF0EuTd5qBjM0RkBhV0keCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eLMpWEk3QPaU6wY7XKWve/Yth3RMPY1vCi93dQ6hmq6F9arGD0lKQy102jeMlevCxT
         6zo66wv/UNVRWwsAevQo/PNpZpX4up5aWlHyELaamJMA5eZh0oGG33vdtOax8Wihavx2
         zk2L2j2tknZM2g0xde8MYyXgi7EyrOjG5W54k=
Received: by 10.220.178.69 with SMTP id bl5mr3002175vcb.50.1297570233571;
        Sat, 12 Feb 2011 20:10:33 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id i1sm823215vby.11.2011.02.12.20.10.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 20:10:32 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297570198-21103-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166638>

Since bb0a484 (mergetool: Skip autoresolved paths, 2010-08-17),
mergetool uses different ways of figuring out the list of files with
merge conflicts depending on whether rerere is active. If rerere is
active, mergetool will use 'git rerere status' to list the files with
remaining conflicts. However, the output from that command does not
list conflicts of types that rerere does not handle, such as
modify/remove conflicts.

Another problem with solely relying on the output from 'git rerere
status' is that, for new conflicts that are not yet known to rerere,
the output from the command will list the files even after adding them
to the index. This means that if the conflicts in some files have been
resolved and 'git mergetool' is run again, it will ask the user
something like the following for each of those files.

 file1: file does not need merging
 Continue merging other unresolved paths (y/n) ?

Solve the first of these problems by replacing the call to 'git rerere
status' with a call to the new 'git rerere remaining' that was
introduced in the previous commit. Solve the second problem by
modifying 'git rerere remaining' not to output files that have already
been staged.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Ideally, I would have liked to just remove the resolved elements from
the string_list, but since there is no function that drops an element,
I marked it by pointing its util field to a special address. Is this a
good way of doing it or can/should I manually unlink the element from
the list instead?

 builtin/rerere.c     |   21 +++++++++++----------
 git-mergetool.sh     |    2 +-
 rerere.c             |   24 ++++++++++++++++++++----
 rerere.h             |    8 ++++++++
 t/t7610-mergetool.sh |   40 ++++++++++++++++++++++++++++++++++------
 5 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 081fccc..7b9fe18 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -147,8 +147,6 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[0], "clear")) {
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *name = (const char *)merge_rr.items[i].util;
-			if (!name)
-				continue;
 			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
 		}
@@ -157,19 +155,22 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[0], "status"))
 		for (i = 0; i < merge_rr.nr; i++) {
-			if (!merge_rr.items[i].util)
-				continue;
 			printf("%s\n", merge_rr.items[i].string);
 		}
-	else if (!strcmp(argv[0], "remaining"))
-		for (i = 0; i < merge_rr.nr; i++)
-			printf("%s\n", merge_rr.items[i].string);
-	else if (!strcmp(argv[0], "diff"))
+	else if (!strcmp(argv[0], "remaining")) {
+		rerere_remaining(&merge_rr);
+		for (i = 0; i < merge_rr.nr; i++) {
+			if (merge_rr.items[i].util != RERERE_RESOLVED)
+				printf("%s\n", merge_rr.items[i].string);
+			else
+				/* prepare for later call to
+				 * string_list_clear() */
+				merge_rr.items[i].util = NULL;
+		}
+	} else if (!strcmp(argv[0], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
-			if (!name)
-				continue;
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
 	else
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 2f8dc44..bacbda2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -269,7 +269,7 @@ rerere=false
 files_to_merge() {
     if test "$rerere" = true
     then
-	git rerere status
+	git rerere remaining
     else
 	git ls-files -u | sed -e 's/^[^	]*	//' | sort -u
     fi
diff --git a/rerere.c b/rerere.c
index eb47f97..e5bccd5 100644
--- a/rerere.c
+++ b/rerere.c
@@ -7,6 +7,8 @@
 #include "ll-merge.h"
 #include "attr.h"
 
+void *RERERE_RESOLVED = &RERERE_RESOLVED;
+
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
 
@@ -388,16 +390,31 @@ static int find_conflict(struct string_list *conflict)
 	return 0;
 }
 
-static void add_punted(struct string_list *merge_rr)
+void rerere_remaining(struct string_list *merge_rr)
 {
 	int i;
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 
+	/* Add punted paths */
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
-		if (conflict.items[i].util)
+		if (!conflict.items[i].util)
+			string_list_insert(merge_rr, conflict.items[i].string);
+	}
+
+	/* Mark already resolved paths */
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *e = active_cache[i];
+
+		if (!ce_stage(e)) {
+			struct string_list_item *it;
+			it = string_list_lookup(merge_rr, (const char *)e->name);
+			if (it != NULL) {
+				free(it->util);
+				it->util = RERERE_RESOLVED;
+			}
 			continue;
-		string_list_insert(merge_rr, conflict.items[i].string);
+		}
 	}
 }
 
@@ -592,7 +609,6 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 	fd = hold_lock_file_for_update(&write_lock, merge_rr_path,
 				       LOCK_DIE_ON_ERROR);
 	read_rr(merge_rr);
-	add_punted(merge_rr);
 	return fd;
 }
 
diff --git a/rerere.h b/rerere.h
index eaa9004..ea2618b 100644
--- a/rerere.h
+++ b/rerere.h
@@ -6,11 +6,19 @@
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 
+/*
+ * Marks paths that have been hand-resolved and added to the
+ * index. Set in the util field of such paths after calling
+ * rerere_remaining.
+ */
+extern void *RERERE_RESOLVED;
+
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
 extern int rerere_forget(const char **);
+extern void rerere_remaining(struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	"update the index with reused conflict resolution if possible")
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index d78bdec..dc838c9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -16,23 +16,33 @@ Testing basic merge tool invocation'
 test_expect_success 'setup' '
     git config rerere.enabled true &&
     echo master >file1 &&
+    echo master file11 >file11 &&
+    echo master file12 >file12 &&
+    echo master file13 >file13 &&
+    echo master file14 >file14 &&
     mkdir subdir &&
     echo master sub >subdir/file3 &&
-    git add file1 subdir/file3 &&
-    git commit -m "added file1" &&
+    git add file1 file1[1-4] subdir/file3 &&
+    git commit -m "add initial versions" &&
 
     git checkout -b branch1 master &&
     echo branch1 change >file1 &&
     echo branch1 newfile >file2 &&
+    echo branch1 change file11 >file11 &&
+    echo branch1 change file13 >file13 &&
     echo branch1 sub >subdir/file3 &&
-    git add file1 file2 subdir/file3 &&
+    git add file1 file11 file13 file2 subdir/file3 &&
+    git rm file12 &&
     git commit -m "branch1 changes" &&
 
     git checkout master &&
     echo master updated >file1 &&
     echo master new >file2 &&
+    echo master updated file12 >file12 &&
+    echo master updated file14 >file14 &&
     echo master new sub >subdir/file3 &&
-    git add file1 file2 subdir/file3 &&
+    git add file1 file12 file14 file2 subdir/file3 &&
+    git rm file11 &&
     git commit -m "master updates" &&
 
     git config merge.tool mytool &&
@@ -46,6 +56,8 @@ test_expect_success 'custom mergetool' '
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     test "$(cat file1)" = "master updated" &&
     test "$(cat file2)" = "master new" &&
     test "$(cat subdir/file3)" = "master new sub" &&
@@ -59,6 +71,8 @@ test_expect_success 'mergetool crlf' '
     ( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
     ( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
     test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
     test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
@@ -82,6 +96,8 @@ test_expect_success 'mergetool on file in parent dir' '
 	cd subdir &&
 	( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool ../file2 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
+	( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
 	test "$(cat ../file1)" = "master updated" &&
 	test "$(cat ../file2)" = "master new" &&
 	git commit -m "branch1 resolved with mergetool - subdir"
@@ -92,6 +108,8 @@ test_expect_success 'mergetool skips autoresolved' '
     git checkout -b test4 branch1 &&
     test_must_fail git merge master &&
     test -n "$(git ls-files -u)" &&
+    ( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
+    ( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
     output="$(git mergetool --no-prompt)" &&
     test "$output" = "No files need merging" &&
     git reset --hard
@@ -102,13 +120,23 @@ test_expect_success 'mergetool merges all from subdir' '
 	cd subdir &&
 	git config rerere.enabled false &&
 	test_must_fail git merge master &&
-	git mergetool --no-prompt &&
+	( yes "d" "d" | git mergetool --no-prompt ) &&
 	test "$(cat ../file1)" = "master updated" &&
 	test "$(cat ../file2)" = "master new" &&
 	test "$(cat file3)" = "master new sub" &&
-	git add ../file1 ../file2 file3 &&
 	git commit -m "branch2 resolved by mergetool from subdir"
     )
 '
 
+test_expect_success 'mergetool skips resolved paths when rerere is active' '
+    git config rerere.enabled true &&
+    rm -rf .git/rr-cache &&
+    git checkout -b test5 branch1
+    test_must_fail git merge master >/dev/null 2>&1 &&
+    ( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
+    output="$(yes "n" | git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging" &&
+    git reset --hard
+'
+
 test_done
-- 
1.7.4.rc2.33.g8a14f
