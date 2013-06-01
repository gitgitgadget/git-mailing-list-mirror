From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 04/11] tests: introduce test_ln_s and test_ln_s_add
Date: Sat,  1 Jun 2013 11:34:23 +0200
Message-ID: <c7be5891891d1eeba540a5a24f07d58514345b2b.1370076477.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 01 11:35:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiiDM-0002Bb-H2
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 11:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015Ab3FAJfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 05:35:00 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:48451 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756271Ab3FAJef (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 05:34:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0D776A7EB5
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2A4FA19F5E4
	for <git@vger.kernel.org>; Sat,  1 Jun 2013 11:34:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226116>

Add new functions that create symbolic links and add them to the index to
be used in cases where a symbolic link is not required on the file system.
We will use them to remove many SYMLINKS prerequisites from test cases.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/README                | 17 +++++++++++++++++
 t/test-lib-functions.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/t/README b/t/README
index e669bb3..bb938f2 100644
--- a/t/README
+++ b/t/README
@@ -592,6 +592,23 @@ library for your script to use.
 		test_cmp expected actual
 	'
 
+ - test_ln_s <path1> <path2>
+   test_ln_s_add <path1> <path2>
+
+   These functions help systems whose filesystem does not support symbolic
+   links. Use them to add a symbolic link entry to the index when it is
+   not important that the file system entry is a symbolic link.
+
+   Use test_ln_s instead of plain "ln -s foo bar" and test_ln_s_add instead
+   of the sequence
+
+	ln -s foo bar &&
+	git add bar
+
+   Sometimes it is possible to split a test in a part that does not need
+   the symbolic link in the file system and a part that does; then only
+   the latter part need be protected by a SYMLINKS prerequisite (see below).
+
 Prerequisites
 -------------
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 5251009..ad7905a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -679,3 +679,33 @@ test_create_repo () {
 		mv .git/hooks .git/hooks-disabled
 	) || exit
 }
+
+# These functions help on symlink challenged file systems when it is not
+# important that the file system entry is a symbolic link:
+#
+# - Use test_ln_s_add instead of "ln -s x y && git add y" to add a
+#   symbolic link entry y to the index.
+#
+# - Use test_ln_s instead of "ln -s x y" when y has been added as a
+#   symbolic link entry earlier.
+
+test_ln_s_add () {
+	if test_have_prereq SYMLINKS
+	then
+		ln -s "$1" "$2" &&
+		git update-index --add "$2"
+	else
+		printf '%s' "$1" >"$2" &&
+		ln_s_obj=$(git hash-object -w "$2") &&
+		git update-index --add --cacheinfo 120000 $ln_s_obj "$2"
+	fi
+}
+
+test_ln_s () {
+	if test_have_prereq SYMLINKS
+	then
+		ln -s "$1" "$2"
+	else
+		printf '%s' "$1" >"$2"
+	fi
+}
-- 
1.8.3.rc1.32.g8b61cbb
