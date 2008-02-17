From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/5] Add platform-independent .git "symlink"
Date: Sun, 17 Feb 2008 23:50:10 +0100
Message-ID: <1203288610-5924-1-git-send-email-hjemli@gmail.com>
References: <8c5c35580802171437x5c952c32we38f9a62288d6c84@mail.gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQsMk-0005cy-7h
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbYBQWvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbYBQWvf
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:51:35 -0500
Received: from mail46.e.nsc.no ([193.213.115.46]:61204 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105AbYBQWve (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:51:34 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id m1HMpMsL003959;
	Sun, 17 Feb 2008 23:51:22 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.gfde78
In-Reply-To: <8c5c35580802171437x5c952c32we38f9a62288d6c84@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74202>

This patch allows .git to be a regular textfile containing the path of
the real git directory (formatted like "gitdir: <path>\n"), which is
useful on platforms lacking support for real symlinks.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/repository-layout.txt |    5 ++-
 cache.h                             |    1 +
 environment.c                       |   38 ++++++++++++++++++
 setup.c                             |    9 ++++
 t/t0002-gitfile.sh                  |   74 +++++++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletions(-)
 create mode 100755 t/t0002-gitfile.sh

diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 6939130..e9db3a1 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -3,7 +3,10 @@ git repository layout
 
 You may find these things in your git repository (`.git`
 directory for a repository associated with your working tree, or
-`'project'.git` directory for a public 'bare' repository).
+`'project'.git` directory for a public 'bare' repository. It is
+also possible to have a working tree where `.git` is a plain
+ascii file containing `gitdir: <path>\n`, i.e. the path to the
+real git repository).
 
 objects::
 	Object store associated with this repository.  Usually
diff --git a/cache.h b/cache.h
index e1000bc..1ad822a 100644
--- a/cache.h
+++ b/cache.h
@@ -277,6 +277,7 @@ extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
+extern const char *read_gitfile_gently(const char *path);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/environment.c b/environment.c
index 3527f16..d120e8f 100644
--- a/environment.c
+++ b/environment.c
@@ -45,10 +45,48 @@ static const char *work_tree;
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
 
+/*
+ * Try to read the location of the git directory from the .git file,
+ * return path to git directory if found.
+ * Format of the .git file is
+ *    gitdir: <path>\n
+ */
+const char *read_gitfile_gently(const char *path)
+{
+	static char buf[PATH_MAX + 9];  /* "gitdir: " + "\n" */
+	struct stat st;
+	int fd;
+	size_t len;
+
+	if (stat(path, &st))
+		return NULL;
+	if (!S_ISREG(st.st_mode) || st.st_size >= sizeof(buf))
+		return NULL;
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return NULL;
+	len = read_in_full(fd, buf, sizeof(buf));
+	close(fd);
+	if (len != st.st_size)
+		return NULL;
+	if (!len || buf[len - 1] != '\n')
+		return NULL;
+	buf[len - 1] = '\0';
+	if (prefixcmp(buf, "gitdir: "))
+		return NULL;
+/*
+	if (!is_git_directory(buf + 8))
+		return NULL;
+*/
+	return make_absolute_path(buf + 8);
+}
+
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
+		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	git_object_dir = getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
diff --git a/setup.c b/setup.c
index 4509598..f8ebaf5 100644
--- a/setup.c
+++ b/setup.c
@@ -247,6 +247,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
+	const char *gitfile_dir;
 	int len, offset;
 
 	/*
@@ -293,8 +294,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	/*
 	 * Test in the following order (relative to the cwd):
+	 * - .git (file containing "gitdir: <path>\n")
 	 * - .git/
 	 * - ./ (bare)
+	 * - ../.git (file containing "gitdir: <path>\n")
 	 * - ../.git/
 	 * - ../ (bare)
 	 * - ../../.git/
@@ -302,6 +305,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	offset = len = strlen(cwd);
 	for (;;) {
+		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (gitfile_dir && is_git_directory(gitfile_dir)) {
+			if (set_git_dir(gitfile_dir))
+				die("Repository setup failed");
+			break;
+		}
 		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			break;
 		if (is_git_directory(".")) {
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
new file mode 100755
index 0000000..d280663
--- /dev/null
+++ b/t/t0002-gitfile.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='.git file
+
+Verify that plumbing commands work when .git is a file
+'
+. ./test-lib.sh
+
+objpath() {
+    echo "$1" | sed -e 's|\(..\)|\1/|'
+}
+
+objck() {
+	p=$(objpath "$1")
+	if test ! -f "$REAL/objects/$p"
+	then
+		echo "Object not found: $REAL/objects/$p"
+		false
+	fi
+}
+
+test_expect_success 'setup' '
+	REAL="$(pwd)/.real" &&
+	mv .git "$REAL" &&
+	echo "gitdir: $REAL" >.git
+'
+
+test_expect_success 'check rev-parse --git-dir' '
+	test "$REAL" = "$(git rev-parse --git-dir)"
+'
+
+test_expect_success 'check hash-object' '
+	echo "foo" >bar &&
+	SHA=$(cat bar | git hash-object -w --stdin) &&
+	objck $SHA
+'
+
+test_expect_success 'check cat-file' '
+	git cat-file blob $SHA >actual &&
+	diff -u bar actual
+'
+
+test_expect_success 'check update-index' '
+	if test -f "$REAL/index"
+	then
+		echo "Hmm, $REAL/index exists?"
+		false
+	fi &&
+	rm -f "$REAL/objects/$(objpath $SHA)" &&
+	git update-index --add bar &&
+	if ! test -f "$REAL/index"
+	then
+		echo "$REAL/index not found"
+		false
+	fi &&
+	objck $SHA
+'
+
+test_expect_success 'check write-tree' '
+	SHA=$(git write-tree) &&
+	objck $SHA
+'
+
+test_expect_success 'check commit-tree' '
+	SHA=$(echo "commit bar" | git commit-tree $SHA) &&
+	objck $SHA
+'
+
+test_expect_success 'check rev-list' '
+	echo $SHA >"$REAL/HEAD" &&
+	test "$SHA" = "$(git rev-list HEAD)"
+'
+
+test_done
-- 
1.5.4.1.188.gfde78
