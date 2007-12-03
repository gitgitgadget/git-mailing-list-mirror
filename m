From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Mon, 3 Dec 2007 21:53:30 +0100
Message-ID: <200712032153.31322.robin.rosenberg.lists@dewire.com>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com> <20071203024916.GA11003@coredump.intra.peff.net> <200712030755.37038.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Anatol Pomozov" <anatol.pomozov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 21:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzIGb-000845-TL
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 21:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbXLCUv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 15:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbXLCUv3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 15:51:29 -0500
Received: from [83.140.172.130] ([83.140.172.130]:7415 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbXLCUv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 15:51:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DC4D8802ABA;
	Mon,  3 Dec 2007 21:42:04 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22119-06; Mon,  3 Dec 2007 21:42:04 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 15E2F8026DC;
	Mon,  3 Dec 2007 21:42:04 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200712030755.37038.robin.rosenberg@dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66954>

This patch makes it possible to drag files and directories from
a graphical browser and drop them onto a shell and feed them
to common git operations without editing away the path to the
root of the work tree.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

I will not surrender to the fierce competion on this subject. Here is an update
with hopefully correct test cases this time. (Linus. your code did not pass). Like Linus,
this code does not resolve symlinks, but I forgot to state that it is by design. It
solves my problem and happens to solve Anatols problem (actually the same since
passing absolute file names to blame is my most important use case).

-- robin

 builtin-blame.c       |    4 +-
 setup.c               |   53 +++++++++++++++++++++++
 t/t3904-abspatharg.sh |  112 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 3 deletions(-)
 create mode 100755 t/t3904-abspatharg.sh

diff --git a/builtin-blame.c b/builtin-blame.c
index c158d31..b905dcf 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1880,9 +1880,7 @@ static unsigned parse_score(const char *arg)
 
 static const char *add_prefix(const char *prefix, const char *path)
 {
-	if (!prefix || !prefix[0])
-		return path;
-	return prefix_path(prefix, strlen(prefix), path);
+	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
 
 /*
diff --git a/setup.c b/setup.c
index 2c7b5cb..1f0ec79 100644
--- a/setup.c
+++ b/setup.c
@@ -4,9 +4,62 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
+static
+const char *strip_work_tree_path(const char *prefix, int len, const char *path)
+{
+	const char *work_tree = get_git_work_tree();
+	int n = strlen(work_tree);
+
+	if (strncmp(path, work_tree, n))
+		return path;
+
+	if (!prefix && !path[n])
+		return path + n;
+
+	if (!prefix) {
+		if (path[n] == '/')
+			return path + n + 1;
+		else
+			if (path[n])
+				return path;
+			else
+				return path + n;
+	}
+
+	if (prefix && !path[n])
+		return path;
+
+	if (strncmp(path + n + 1, prefix, len - 1)) {
+		fprintf(stderr,"prefix mismatch\n");
+		char *np;
+		int i;
+		int d=0;
+		for (i = 0; i < len; ++i)
+			if (prefix[i] == '/')
+				d++;
+		np = xmalloc(strlen(path + n) + d * 3 + 1);
+		for (i=0; i < d * 3; i += 3)
+			strcpy(np + i, "../");
+		strcpy(np + i, path + n + 1);
+		path = np;
+		return np;
+	}
+
+	if (path[len + n] == '/')
+		return path + len + n + 1;
+	else
+		if (path[len + n])
+			return path;
+		else
+			return path + len + n;
+}
+
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
+	if (is_absolute_path(path))
+		path = strip_work_tree_path(prefix, len, path);
+
 	for (;;) {
 		char c;
 		if (*path != '.')
diff --git a/t/t3904-abspatharg.sh b/t/t3904-abspatharg.sh
new file mode 100755
index 0000000..47f1222
--- /dev/null
+++ b/t/t3904-abspatharg.sh
@@ -0,0 +1,112 @@
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
+	echo a >afile &&
+	echo b >bfile &&
+	git-add afile &&
+	git-add "$(pwd)/bfile" &&
+	test "afile bfile" = "$(echo $(git ls-files))"
+	mkdir x &&
+	(
+		cd x &&
+		echo c >cfile &&
+		echo d >dfile &&
+		git-add cfile &&
+		git-add "$(pwd)"
+	) &&
+	test "afile bfile x/cfile x/dfile" = "$(echo $(git ls-files))" &&
+	git ls-files x >f1 &&
+	git ls-files "$(pwd)/x" >f2 &&
+	diff -u f1 f2
+'
+
+test_expect_success 'commit using absolute path names' '
+	git commit -m "foo" &&
+	echo aa >>bfile &&
+	git commit -m "aa" "$(pwd)/bfile"
+'
+
+test_expect_success 'log using absolute path names' '
+	echo bb >>bfile &&
+	git commit -m "bb" $(pwd)/bfile &&
+
+	git log bfile >f1.txt &&
+	git log "$(pwd)/bfile" >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_success 'blame using absolute path names' '
+	git blame bfile >f1.txt &&
+	git blame "$(pwd)/bfile" >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_success 'diff using absolute path names' '
+	git diff HEAD HEAD^ -- "$(pwd)/bfile" >f1.txt &&
+	git diff HEAD HEAD^ -- bfile >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_success 'rm using absolute path names' '
+	git rm "$(pwd)/afile" "$(pwd)/x/cfile" &&
+	test "bfile x/dfile" = "$(echo $(git ls-files))"
+'
+
+test_expect_success 'mv using absolute path names' '
+	git reset --hard &&
+	git mv "$(pwd)/afile" "$(pwd)/dfile" &&
+	test "bfile dfile x/cfile x/dfile" = "$(echo $(git ls-files))" &&
+	git mv "$(pwd)/dfile" afile &&
+	test "afile bfile x/cfile x/dfile" = "$(echo $(git ls-files))"
+'
+
+test_expect_success 'show using absolute path names' '
+	git reset --hard &&
+	git show "$(pwd)/bfile" >f1.txt &&
+	git show bfile >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_success 'add path in parent directory' '
+	(
+		d1="$(pwd)/x"
+		d2="$(pwd)/x/y"
+		mkdir -p x/y &&
+		echo hello1 >x/fa &&
+		echo hello2 >x/y/fb &&
+		cd x/y &&
+		git add "$d1/fa" "$d2/fb"
+	) &&
+	test "afile bfile x/cfile x/dfile x/fa x/y/fb" = "$(echo $(git ls-files))"
+'
+
+test_expect_success 'add a parent directory' '
+	(
+		d1="$(pwd)/a"
+		d2="$(pwd)/a/b"
+		d3="$(pwd)/a/b/c"
+		mkdir -p a/b/c
+		echo helloa >a/a1 &&
+		echo hellob >a/b/b1 &&
+		echo helloc >a/b/c/c1 &&
+		cd a/b/c &&
+		git add "$d2"
+	) &&
+	test "a/b/b1 a/b/c/c1 afile bfile x/cfile x/dfile x/fa x/y/fb" = "$(echo $(git ls-files))"
+'
+
+test_expect_failure 'add a directory outside the work tree' '
+	d1="(cd .. ; pwd)" &&
+	git add "$d1"
+'
+
+test_done
-- 
1.5.3.5.1.gb2df9
