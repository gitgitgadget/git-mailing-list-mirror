From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Wed, 28 Nov 2007 00:24:07 +0100
Message-ID: <1196205847-22968-1-git-send-email-robin.rosenberg@dewire.com>
References: <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 28 00:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix9l5-000331-8s
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 00:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760767AbXK0XWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760765AbXK0XWD
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:22:03 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13088 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760761AbXK0XWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:22:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CC9F98027FA;
	Wed, 28 Nov 2007 00:12:42 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05130-04; Wed, 28 Nov 2007 00:12:42 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6D4F2800783;
	Wed, 28 Nov 2007 00:12:42 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id E4ED828FFC; Wed, 28 Nov 2007 00:24:07 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1.gb2df9
In-Reply-To: <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66272>

This patch makes it possible to drag files and directories from
a graphical browser and drop them onto a shell and feed them
to common git operations without editing away the path to the
root of the work tree.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 setup.c               |   19 +++++++++++++++++
 t/t3904-abspatharg.sh |   55 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100755 t/t3904-abspatharg.sh

diff --git a/setup.c b/setup.c
index f512ea0..ffc30bf 100644
--- a/setup.c
+++ b/setup.c
@@ -7,6 +7,25 @@ static int inside_work_tree = -1;
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
+	const char *work_tree = get_git_work_tree();
+	if (is_absolute_path(path) && work_tree) {
+		int n = strlen(work_tree);
+		if (!strncmp(path, work_tree, n) && (path[n] == '/' || !path[n])) {
+			if (path[n])
+				path += n + 1;
+			else
+				path += n;
+
+			if (prefix && !strncmp(path, prefix, len - 1)) {
+				if (path[len - 1] == '/')
+					path += len;
+				else
+					if (!path[len - 1])
+						path += len - 1;
+			}
+		}
+	}
+
 	for (;;) {
 		char c;
 		if (*path != '.')
diff --git a/t/t3904-abspatharg.sh b/t/t3904-abspatharg.sh
new file mode 100755
index 0000000..cd4a52e
--- /dev/null
+++ b/t/t3904-abspatharg.sh
@@ -0,0 +1,55 @@
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
+git-add "$(pwd)/bfile" &&
+test "afile bfile" = "$(echo $(git ls-files))"
+mkdir x &&
+cd x &&
+echo c >cfile &&
+echo d >dfile &&
+git-add cfile &&
+git-add "$(pwd)" &&
+cd .. &&
+test "afile bfile x/cfile x/dfile" = "$(echo $(git ls-files))" &&
+git ls-files x >f1 &&
+git ls-files "$(pwd)/x" >f2 &&
+diff f1 f2
+'
+
+test_expect_success 'commit using absolute path names' '
+git commit -m "foo" &&
+echo aa >>bfile &&
+git commit -m "bb" "$(pwd)/bfile"
+'
+
+test_expect_success 'log using absolute path names' '
+git log afile >f1.txt &&
+git log "$(pwd)/afile" >f2.txt &&
+diff f1.txt f2.txt
+'
+
+test_expect_success 'blame using absolute path names' '
+git blame afile >f1.txt &&
+git blame "$(pwd)/afile" >f2.txt &&
+diff f1.txt f2.txt
+'
+
+test_expect_success 'diff using absolute path names' '
+git diff HEAD^ -- "$(pwd)/afile" >f1.txt &&
+git diff HEAD^ -- afile >f2.txt &&
+diff f1.txt f2.txt
+'
+
+test_done
-- 
1.5.3.5.1.gb2df9
