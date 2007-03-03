From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 1/2] Handle core.symlinks=false case in merge-recursive.
Date: Sat, 3 Mar 2007 20:32:46 +0100
Message-ID: <200703032032.47158.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 20:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNZzu-0002SS-4x
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 20:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbXCCTeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 14:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbXCCTeX
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 14:34:23 -0500
Received: from smtp4.noc.eunet-ag.at ([193.154.160.226]:44225 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1030391AbXCCTeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 14:34:22 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 552089781C
	for <git@vger.kernel.org>; Sat,  3 Mar 2007 20:32:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D418F3B47A
	for <git@vger.kernel.org>; Sat,  3 Mar 2007 20:32:47 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41318>

If the file system does not support symbolic links (core.symlinks=false),
merge-recursive must write the merged symbolic link text into a regular
file.

While we are here, fix a tiny memory leak in the if-branch that writes
real symbolic links.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 merge-recursive.c         |    3 +-
 t/t6025-merge-symlinks.sh |   62 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletions(-)
 create mode 100644 t/t6025-merge-symlinks.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 397a7ad..f8be72e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -570,7 +570,7 @@ static void update_file_flags(const unsigned char *sha,
 		if (strcmp(type, blob_type) != 0)
 			die("blob expected for %s '%s'", sha1_to_hex(sha), path);
 
-		if (S_ISREG(mode)) {
+		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
 			if (mkdir_p(path, 0777))
 				die("failed to create path %s: %s", path, strerror(errno));
@@ -591,6 +591,7 @@ static void update_file_flags(const unsigned char *sha,
 			mkdir_p(path, 0777);
 			unlink(path);
 			symlink(lnk, path);
+			free(lnk);
 		} else
 			die("do not know what to do with %06o %s '%s'",
 			    mode, sha1_to_hex(sha), path);
diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
new file mode 100644
index 0000000..3c1a697
--- /dev/null
+++ b/t/t6025-merge-symlinks.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes Sixt
+#
+
+test_description='merging symlinks on filesystem w/o symlink support.
+
+This tests that git-merge-recursive writes merge results as plain files
+if core.symlinks is false.'
+
+. ./test-lib.sh
+
+test_expect_success \
+'setup' '
+git-config core.symlinks false &&
+> file &&
+git-add file &&
+git-commit -m initial &&
+git-branch b-symlink &&
+git-branch b-file &&
+l=$(echo -n file | git-hash-object -t blob -w --stdin) &&
+echo "120000 $l	symlink" | git-update-index --index-info &&
+git-commit -m master &&
+git-checkout b-symlink &&
+l=$(echo -n file-different | git-hash-object -t blob -w --stdin) &&
+echo "120000 $l	symlink" | git-update-index --index-info &&
+git-commit -m b-symlink &&
+git-checkout b-file &&
+echo plain-file > symlink &&
+git-add symlink &&
+git-commit -m b-file'
+
+test_expect_failure \
+'merge master into b-symlink, which has a different symbolic link' '
+! git-checkout b-symlink ||
+git-merge master'
+
+test_expect_success \
+'the merge result must be a file' '
+test -f symlink'
+
+test_expect_failure \
+'merge master into b-file, which has a file instead of a symbolic link' '
+! (git-reset --hard &&
+git-checkout b-file) ||
+git-merge master'
+
+test_expect_success \
+'the merge result must be a file' '
+test -f symlink'
+
+test_expect_failure \
+'merge b-file, which has a file instead of a symbolic link, into master' '
+! (git-reset --hard &&
+git-checkout master) ||
+git-merge b-file'
+
+test_expect_success \
+'the merge result must be a file' '
+test -f symlink'
+
+test_done
-- 
1.5.0.2.4.gdd4e4-dirty
