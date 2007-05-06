From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] submodule merge support
Date: Sun, 6 May 2007 21:02:24 +0200
Message-ID: <20070506190224.GG30511@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 21:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkm05-0005dU-Lx
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbXEFTC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 15:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755073AbXEFTC0
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:02:26 -0400
Received: from mail.admingilde.org ([213.95.32.147]:45237 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbXEFTCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 15:02:25 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hkm00-0001MP-ET; Sun, 06 May 2007 21:02:24 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46362>

When merge-recursive gets to a dirlink, it starts an automatic submodule merge
and then uses the resulting merge commit for the top-level tree.
The submodule merge is done in another process to decouple object databases.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 .gitignore           |    1 +
 Makefile             |    2 +-
 git-dirlink-merge.sh |   28 ++++++++++++++++++++++++++++
 merge-recursive.c    |   36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletions(-)
 create mode 100644 git-dirlink-merge.sh

diff --git a/.gitignore b/.gitignore
index 8436a83..b076e2f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -38,6 +38,7 @@ git-diff-files
 git-diff-index
 git-diff-tree
 git-dirlink-checkout
+git-dirlink-merge
 git-describe
 git-fast-import
 git-fetch
diff --git a/Makefile b/Makefile
index fcd0125..ff24477 100644
--- a/Makefile
+++ b/Makefile
@@ -196,7 +196,7 @@ SCRIPT_SH = \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
 	git-repack.sh git-request-pull.sh git-reset.sh \
-	git-sh-setup.sh git-dirlink-checkout.sh \
+	git-sh-setup.sh git-dirlink-checkout.sh git-dirlink-merge.sh \
 	git-tag.sh git-verify-tag.sh \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
diff --git a/git-dirlink-merge.sh b/git-dirlink-merge.sh
new file mode 100644
index 0000000..e719b1a
--- /dev/null
+++ b/git-dirlink-merge.sh
@@ -0,0 +1,28 @@
+#!/bin/sh -e
+# Merge a submodule
+# (c) 2006 Martin Waitz
+
+USAGE="submodule orig-sha1 a-sha1 b-sha1"
+
+unset GIT_DIR
+cd "$1"
+
+. git-sh-setup
+
+test $# -eq 4 || usage
+
+orig="$2"
+ours="$3"
+theirs="$4"
+
+base=`git-merge-base "$ours" "$theirs"`
+
+if test `git-merge-base "$orig" "$base"` != "$orig"; then
+	die "$1 cannot be merged: other side switched branches"
+fi
+
+if test `git-rev-parse --verify HEAD` != "$ours"; then
+	die "$1: HEAD != ours"
+fi
+
+exec git-merge $theirs
diff --git a/merge-recursive.c b/merge-recursive.c
index 8f72b2c..4b67cd0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -11,6 +11,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "run-command.h"
+#include "refs.h"
 #include "tag.h"
 #include "unpack-trees.h"
 #include "path-list.h"
@@ -574,6 +575,21 @@ static void update_file_flags(const unsigned char *sha,
 		void *buf;
 		unsigned long size;
 
+		if (S_ISDIRLNK(mode)) {
+			/* defer dirlinks to another process, don't try to */
+			/* read the object "sha" here */
+			const char *dirlink_checkout[] = {
+				"dirlink-checkout", path, sha1_to_hex(sha), NULL
+			};
+			struct child_process cmd = {
+				.argv = dirlink_checkout,
+				.git_cmd = 1,
+			};
+
+			run_command(&cmd);
+			goto update_index;
+		}
+
 		buf = read_sha1_file(sha, &type, &size);
 		if (!buf)
 			die("cannot read object %s '%s'", sha1_to_hex(sha), path);
@@ -1069,6 +1085,26 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
+		} else if (S_ISDIRLNK(a->mode)) {
+			const char *dirlink_merge[] = {
+				"dirlink-merge", a->path,
+				sha1_to_hex(o->sha1),
+				sha1_to_hex(a->sha1),
+				sha1_to_hex(b->sha1),
+				NULL
+			};
+			struct child_process cmd = {
+				.argv = dirlink_merge,
+				.git_cmd = 1,
+			};
+			/* recurse into the submodule in a different process */
+			result.clean = !run_command(&cmd);
+			if (result.clean) {
+				/* get the new merged version */
+				if (resolve_gitlink_ref(a->path, "HEAD",
+				                        result.sha) < 0)
+					result.clean = 0;
+			}
 		} else {
 			if (!(S_ISLNK(a->mode) || S_ISLNK(b->mode)))
 				die("cannot merge modes?");
-- 
1.5.1.2.247.gaef5a


-- 
Martin Waitz
