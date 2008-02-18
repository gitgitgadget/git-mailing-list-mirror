From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 2/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 11:44:20 +0100
Message-ID: <1203331463-13857-3-git-send-email-hjemli@gmail.com>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
 <1203331463-13857-2-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 11:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR3W4-0003jG-LY
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 11:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315AbYBRKp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 05:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756993AbYBRKp7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 05:45:59 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:52709 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbYBRKp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 05:45:56 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m1IAjYWK026988;
	Mon, 18 Feb 2008 11:45:37 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
In-Reply-To: <1203331463-13857-2-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74257>

This patch allows .git to be a regular textfile containing the path of
the real git directory (prefixed with "gitdir: "), which can be useful on
platforms lacking support for real symlinks.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/repository-layout.txt |    5 ++-
 cache.h                             |    1 +
 environment.c                       |    2 +
 setup.c                             |   47 ++++++++++++++++++++++
 t/t0002-gitfile.sh                  |   74 +++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+), 1 deletions(-)
 create mode 100755 t/t0002-gitfile.sh

diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 6939130..bbaed2e 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -3,7 +3,10 @@ git repository layout
 
 You may find these things in your git repository (`.git`
 directory for a repository associated with your working tree, or
-`'project'.git` directory for a public 'bare' repository).
+`'project'.git` directory for a public 'bare' repository. It is
+also possible to have a working tree where `.git` is a plain
+ascii file containing `gitdir: <path>`, i.e. the path to the
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
index 3527f16..8058e7b 100644
--- a/environment.c
+++ b/environment.c
@@ -49,6 +49,8 @@ static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
 	if (!git_dir)
+		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 	git_object_dir = getenv(DB_ENVIRONMENT);
 	if (!git_object_dir) {
diff --git a/setup.c b/setup.c
index 4509598..20502be 100644
--- a/setup.c
+++ b/setup.c
@@ -239,6 +239,44 @@ static int check_repository_format_gently(int *nongit_ok)
 }
 
 /*
+ * Try to read the location of the git directory from the .git file,
+ * return path to git directory if found.
+ */
+const char *read_gitfile_gently(const char *path)
+{
+	char *buf;
+	struct stat st;
+	int fd;
+	size_t len;
+
+	if (stat(path, &st))
+		return NULL;
+	if (!S_ISREG(st.st_mode))
+		return NULL;
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		die("Error opening %s: %s", path, strerror(errno));
+	buf = xmalloc(st.st_size + 1);
+	len = read_in_full(fd, buf, st.st_size);
+	close(fd);
+	if (len != st.st_size)
+		die("Error reading %s", path);
+	buf[len] = '\0';
+	if (prefixcmp(buf, "gitdir: "))
+		die("Invalid gitfile format: %s", path);
+	while (buf[len - 1] == '\n' || buf[len - 1] == '\r')
+		len--;
+	if (len < 9)
+		die("No path in gitfile: %s", path);
+	buf[len] = '\0';
+	if (!is_git_directory(buf + 8))
+		die("Not a git repository: %s", buf + 8);
+	path = make_absolute_path(buf + 8);
+	free(buf);
+	return path;
+}
+
+/*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
  */
@@ -247,6 +285,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
+	const char *gitfile_dir;
 	int len, offset;
 
 	/*
@@ -293,8 +332,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	/*
 	 * Test in the following order (relative to the cwd):
+	 * - .git (file containing "gitdir: <path>")
 	 * - .git/
 	 * - ./ (bare)
+	 * - ../.git
 	 * - ../.git/
 	 * - ../ (bare)
 	 * - ../../.git/
@@ -302,6 +343,12 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	offset = len = strlen(cwd);
 	for (;;) {
+		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (gitfile_dir) {
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
1.5.4.1.188.g3ea1f5
