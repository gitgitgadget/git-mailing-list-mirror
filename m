From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Tue, 27 Nov 2007 00:18:29 +0100
Message-ID: <1196119109-27483-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 27 00:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwnBz-0004QW-Nf
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 00:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074AbXKZXQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 18:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbXKZXQY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 18:16:24 -0500
Received: from [83.140.172.130] ([83.140.172.130]:25052 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbXKZXQX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 18:16:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1169914743E1;
	Tue, 27 Nov 2007 00:07:05 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21774-07; Tue, 27 Nov 2007 00:07:05 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 98E8314743E0;
	Tue, 27 Nov 2007 00:07:05 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 919562A4A5; Tue, 27 Nov 2007 00:18:29 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1.gb2df9
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66144>

This patch makes it possible to drag files and directories from
a graphical browser and drop them onto a shell and feed them
to common git operations without editing away the path to the
root of the work tree.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 setup.c               |   16 ++++++++++++++
 t/t3904-abspatharg.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100755 t/t3904-abspatharg.sh

Was it this simple?

diff --git a/setup.c b/setup.c
index 43cd3f9..9b3a9ff 100644
--- a/setup.c
+++ b/setup.c
@@ -6,6 +6,22 @@ static int inside_work_tree = -1;
 
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
+	if (is_absolute_path(path)) {
+		const char *work_tree = get_git_work_tree();
+		int n = strlen(work_tree);
+		if (!strncmp(path, work_tree, n) && (path[n] == '/' || !path[n])) {
+			if (path[n])
+				path += 1;
+			path += n;
+			if (prefix && !strncmp(path, prefix, len - 1)) {
+			    if (path[len - 1] == '/')
+				    path += len;
+			    else
+				    if (!path[len - 1])
+					    path += len - 1;
+			}
+		}
+	}
 	const char *orig = path;
 	for (;;) {
 		char c;
diff --git a/t/t3904-abspatharg.sh b/t/t3904-abspatharg.sh
new file mode 100755
index 0000000..aa47602
--- /dev/null
+++ b/t/t3904-abspatharg.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+#
+# Copyright (C) 2007 Robin Rosenberg
+#
+
+test_description='Test absolute filename arguments to various git
+commands.  Absolute arguments pointing to a location within the git
+work tree should behave the same as relative arguments.  '
+
+. ./test-lib.sh
+
+test_expect_success 'add files using absolute path names' '
+echo a >afile &&
+echo b >bfile &&
+git-add afile &&
+git-add $(pwd)/bfile &&
+test "afile bfile" = "$(echo $(git ls-files))"
+mkdir x &&
+cd x &&
+echo c >cfile &&
+echo d >dfile &&
+git-add cfile &&
+git-add $(pwd) &&
+cd .. &&
+test "afile bfile x/cfile x/dfile" = "$(echo $(git ls-files))" &&
+test "$(echo $(git ls-files x))" = "$(echo $(git ls-files $(pwd)/x))"
+'
+
+test_expect_success 'commit using absolute path names' '
+git commit -m "foo" &&
+echo aa >>bfile &&
+git commit -m "bb" $(pwd)/bfile
+'
+
+test_expect_success 'log using absolute path names' '
+git log afile >f1.txt &&
+git log $(pwd)/afile >f2.txt &&
+diff f1.txt f2.txt
+'
+
+test_expect_success 'blame using absolute path names' '
+git blame afile >f1.txt &&
+git blame $(pwd)/afile >f2.txt &&
+diff f1.txt f2.txt
+'
+
+test_expect_success 'diff using absolute path names' '
+git diff HEAD^ -- $(pwd)/afile >f1.txt &&
+git diff HEAD^ -- afile >f2.txt &&
+diff f1.txt f2.txt
+'
+
+test_done
-- 
1.5.3.5.1.gb2df9
