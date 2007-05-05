From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] simple submodule checkout support
Date: Sat, 5 May 2007 21:16:21 +0200
Message-ID: <20070505191621.GC30511@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 21:16:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkPk2-00049K-VS
	for gcvg-git@gmane.org; Sat, 05 May 2007 21:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbXEETQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 15:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933165AbXEETQY
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 15:16:24 -0400
Received: from mail.admingilde.org ([213.95.32.147]:41064 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161AbXEETQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 15:16:23 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HkPjx-0006Ss-CV; Sat, 05 May 2007 21:16:21 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46281>

Add the ability to move a submodule to a commit which is referenced by a
new supermodule version.

This is not yet a full submodule checkout support -- you can't checkout any
commit which is not yet available in the submodule object database.
This means you can't create new submodules yet.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 .gitignore                      |    1 +
 Makefile                        |    2 +-
 entry.c                         |   16 +++++++++++-----
 git-dirlink-checkout.sh         |   27 +++++++++++++++++++++++++++
 t/t3041-subprojects-checkout.sh |   39 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+), 6 deletions(-)
 create mode 100644 git-dirlink-checkout.sh
 create mode 100755 t/t3041-subprojects-checkout.sh

diff --git a/.gitignore b/.gitignore
index 4dc0c39..8436a83 100644
--- a/.gitignore
+++ b/.gitignore
@@ -37,6 +37,7 @@ git-diff
 git-diff-files
 git-diff-index
 git-diff-tree
+git-dirlink-checkout
 git-describe
 git-fast-import
 git-fetch
diff --git a/Makefile b/Makefile
index 2fea115..fcd0125 100644
--- a/Makefile
+++ b/Makefile
@@ -196,7 +196,7 @@ SCRIPT_SH = \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
-	git-sh-setup.sh \
+	git-sh-setup.sh git-dirlink-checkout.sh \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
diff --git a/entry.c b/entry.c
index 82bf725..6e85e81 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "blob.h"
+#include "run-command.h"
 
 static void create_directories(const char *path, const struct checkout *state)
 {
@@ -79,6 +80,13 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 {
 	int fd;
 	long wrote;
+	const char *dirlink_checkout[] = {
+		"dirlink-checkout", path, sha1_to_hex(ce->sha1), NULL
+	};
+	struct child_process cmd = {
+		.argv = dirlink_checkout,
+		.git_cmd = 1
+	};
 
 	switch (ntohl(ce->ce_mode) & S_IFMT) {
 		char *buf, *new;
@@ -148,7 +156,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 	case S_IFDIRLNK:
 		if (to_tempfile)
 			return error("git-checkout-index: cannot create temporary subproject %s", path);
-		if (mkdir(path, 0777) < 0)
+		if (run_command(&cmd) != 0)
 			return error("git-checkout-index: cannot create subproject directory %s", path);
 		break;
 	default:
@@ -192,10 +200,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 		 * just do the right thing)
 		 */
 		unlink(path);
-		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
-			if (S_ISDIRLNK(ntohl(ce->ce_mode)))
-				return 0;
+		if (S_ISDIR(st.st_mode) &&
+		    access(mkpath("%s/.git/HEAD", path), R_OK)!=0) {
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
diff --git a/git-dirlink-checkout.sh b/git-dirlink-checkout.sh
new file mode 100644
index 0000000..2e63970
--- /dev/null
+++ b/git-dirlink-checkout.sh
@@ -0,0 +1,27 @@
+#!/bin/sh -e
+
+USAGE="<dirlink-path> <new-ref>"
+
+path="$1"
+sha1="$2"
+
+test -n "$sha1" || usage
+unset GIT_DIR
+
+if test ! -d "$path/.git"; then
+	mkdir "$path"
+	cd "$path"
+	# FIXME talk about what the user can do here
+	echo "This git submodule has not been populated yet." > README.git
+	exit 0
+fi
+
+cd "$path"
+. git-sh-setup
+
+if git rev-parse --verify "$sha1" >/dev/null 2>&1; then
+	git checkout "$sha1"
+else
+	# FIXME try to fetch it
+	echo >&2 "Cannot checkout $sha1 for $path."
+fi
diff --git a/t/t3041-subprojects-checkout.sh b/t/t3041-subprojects-checkout.sh
new file mode 100755
index 0000000..4b3cea9
--- /dev/null
+++ b/t/t3041-subprojects-checkout.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='submodule checkout'
+. ./test-lib.sh
+
+test_expect_success 'submodule creation' \
+    '(mkdir A && cd A &&
+      git init &&
+      echo 1 > a &&
+      git add a &&
+      git commit -m "create submodule" || exit $? )'
+
+test_expect_success 'Super module creation' \
+    'git add A &&
+     git commit -m "supermodule creation" &&
+     git branch one'
+
+test_expect_success 'submodule change' \
+    '(cd A &&
+      echo 2 > a &&
+      git add a &&
+      git commit -m "create submodule" || exit $? )'
+
+test_expect_success 'supermodule change' \
+    'git add A &&
+     git commit -m "supermodule creation"'
+
+test_expect_success 'supermodule switching branch' \
+    'git checkout one &&
+     echo 1 > expected &&
+     git diff expected A/a'
+
+test_expect_success 'supermodule reset' \
+    'git reset --hard master &&
+     echo 2 > expected &&
+     git diff expected A/a'
+
+
+test_done
-- 
1.5.1.2.247.gaef5a

-- 
Martin Waitz
