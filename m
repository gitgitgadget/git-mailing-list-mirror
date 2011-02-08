From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] mergetool: don't skip modify/remove conflicts
Date: Mon,  7 Feb 2011 22:08:38 -0500
Message-ID: <1297134518-4387-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 04:09:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmdwr-0007TM-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 04:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab1BHDIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 22:08:55 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47154 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127Ab1BHDIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 22:08:54 -0500
Received: by vxb37 with SMTP id 37so2059223vxb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 19:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=klZyKkxx6J3o2RfVxRUa+6XuYejmH6MtzfVMnJvLJWw=;
        b=TRLljjtHnKJFc+Z3zt1K0wcFxx0k9rf/R6iHf/EHXpvnakDizxMBkerUvy30MCbXq8
         097w5HeNQ4Hg6Huob+bOkrPKl9FPgmDM6IdY1dsx2Qzq1EztONLn49qSH2x6iIJqiHQb
         UyZESHa9TzfsXMck8cz8CPG5W30heYTBxnqjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qJRMyLs5H4g+SyZvuUc5NXAoz5FMKo70QKPy2DT6hQoubP7Brsobs5ls1zA4JOYjvd
         Iat/5Vz6COMQrsL7I9ubEjXLodorrhROIQvXU1TrjFnJ0eHNr2wHVzyaXJMGnfT7waS6
         AQmVNt2/Y/+1pAJx5krgECagwIX7R8UeAbTRU=
Received: by 10.220.175.139 with SMTP id ba11mr1616766vcb.145.1297134532477;
        Mon, 07 Feb 2011 19:08:52 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id i1sm3768205vby.11.2011.02.07.19.08.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 19:08:51 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166329>

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
This applies on top of jc/rerere-remaining.

This is my first patch that touches any C code and I haven't written
anything in C for about 10 years. I hope it doesn't look too bad.

I also have another version of this patch that doesn't modify 'git
rerere remaining', but instead combines the output with the output
from 'git ls-files'. Tell me if you think that is better.

Is it correct to call "yes" with multiple arguments in the test script
the way I did?


 builtin/rerere.c     |   10 +++++++---
 git-mergetool.sh     |    2 +-
 rerere.c             |   31 ++++++++++++++++++++-----------
 rerere.h             |    3 +++
 t/t7610-mergetool.sh |   40 ++++++++++++++++++++++++++++++++++------
 5 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 081fccc..9cbab27 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -147,7 +147,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	if (!strcmp(argv[0], "clear")) {
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *name = (const char *)merge_rr.items[i].util;
-			if (!name)
+			if (name == RERERE_UTIL_PUNTED || name == RERERE_UTIL_STAGED)
 				continue;
 			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
@@ -162,13 +162,17 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			printf("%s\n", merge_rr.items[i].string);
 		}
 	else if (!strcmp(argv[0], "remaining"))
-		for (i = 0; i < merge_rr.nr; i++)
+		for (i = 0; i < merge_rr.nr; i++) {
+			const char *name = (const char *)merge_rr.items[i].util;
+			if (name == RERERE_UTIL_STAGED)
+				continue;
 			printf("%s\n", merge_rr.items[i].string);
+		}
 	else if (!strcmp(argv[0], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
-			if (!name)
+			if (name == RERERE_UTIL_PUNTED || name == RERERE_UTIL_STAGED)
 				continue;
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
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
index eb47f97..61cac54 100644
--- a/rerere.c
+++ b/rerere.c
@@ -7,6 +7,10 @@
 #include "ll-merge.h"
 #include "attr.h"
 
+#define RERERE_UTIL_ELIGIBLE NULL
+void *RERERE_UTIL_PUNTED = &RERERE_UTIL_PUNTED;
+void *RERERE_UTIL_STAGED = &RERERE_UTIL_STAGED;
+
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
 
@@ -352,18 +356,20 @@ static int find_conflict(struct string_list *conflict)
 		return error("Could not read index");
 
 	/*
-	 * Collect paths with conflict, mark them with NULL (punted) or
-	 * !NULL (eligible) in their ->util field.
+	 * Collect paths with conflict, mark them according to type in
+	 * their ->util field.
 	 */
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *e = active_cache[i];
 		struct string_list_item *it;
 
-		if (!ce_stage(e))
+		if (!ce_stage(e)) {
 			continue;
+		}
 		it = string_list_insert(conflict, (const char *)e->name);
-		it->util = NULL;
+		it->util = RERERE_UTIL_PUNTED;
 		if (ce_stage(e) == 1) {
+			it->util = RERERE_UTIL_STAGED;
 			if (active_nr <= ++i)
 				break;
 		}
@@ -377,7 +383,7 @@ static int find_conflict(struct string_list *conflict)
 			    ce_same_name(e, e3) &&
 			    S_ISREG(e2->ce_mode) &&
 			    S_ISREG(e3->ce_mode))
-				it->util = (void *) 1;
+				it->util = RERERE_UTIL_ELIGIBLE;
 		}
 
 		/* Skip the entries with the same name */
@@ -395,9 +401,10 @@ static void add_punted(struct string_list *merge_rr)
 
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
-		if (conflict.items[i].util)
+		if (conflict.items[i].util == RERERE_UTIL_ELIGIBLE)
 			continue;
-		string_list_insert(merge_rr, conflict.items[i].string);
+		string_list_insert(merge_rr, conflict.items[i].string)->util =
+			conflict.items[i].util;
 	}
 }
 
@@ -487,8 +494,9 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 
 	for (i = 0; i < conflict.nr; i++) {
 		const char *path = conflict.items[i].string;
-		if (!conflict.items[i].util)
-			continue; /* punted */
+		if (conflict.items[i].util == RERERE_UTIL_PUNTED ||
+			conflict.items[i].util == RERERE_UTIL_STAGED)
+			continue;
 		if (!string_list_has_string(rr, path)) {
 			unsigned char sha1[20];
 			char *hex;
@@ -648,8 +656,9 @@ int rerere_forget(const char **pathspec)
 	find_conflict(&conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
-		if (!conflict.items[i].util)
-			continue; /* punted */
+		if (conflict.items[i].util == RERERE_UTIL_PUNTED ||
+			conflict.items[i].util == RERERE_UTIL_STAGED)
+			continue;
 		if (!match_pathspec(pathspec, it->string, strlen(it->string),
 				    0, NULL))
 			continue;
diff --git a/rerere.h b/rerere.h
index eaa9004..107a2bc 100644
--- a/rerere.h
+++ b/rerere.h
@@ -6,6 +6,9 @@
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 
+extern void *RERERE_UTIL_PUNTED;
+extern void *RERERE_UTIL_STAGED;
+
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
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
