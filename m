From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Fri, 16 May 2008 00:27:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805160012310.30431@racer>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com, David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Fri May 16 01:28:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwmry-0004ah-5f
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 01:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbYEOX11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 19:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbYEOX10
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 19:27:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:50904 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753491AbYEOX1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 19:27:25 -0400
Received: (qmail invoked by alias); 15 May 2008 23:27:23 -0000
Received: from R322b.r.pppool.de (EHLO racer.local) [89.54.50.43]
  by mail.gmx.net (mp037) with SMTP; 16 May 2008 01:27:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kvZkAtpSkKQ0UZAdT+JfgGlriBMZI2aKT0B+BNM
	Dl8SlT1t0WWeg9
X-X-Sender: gene099@racer
In-Reply-To: <482CBCF2.6030202@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82242>


In certain setups, trying to access a non-existing .git/ can take quite
some time, for example when the directory is an automount directory.

Allow the user to specify directories where Git would stop looking for
a .git/ directory: GIT_CEILING_DIRECTORIES, if set, is expected to be
a colon delimited list of such barrier directories.

Note: if GIT_CEILING_DIRECTORIES=/a/b and your current working directory
is /a, Git will _not_ stop looking.

Note2: you must not specify the directories with trailing slashes.

Initial implementation by David Reiss.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 15 May 2008, David Reiss wrote:

	> This meets my needs.
	> 
	> Junio, if you'd like, I can incorporate your suggestions of 
	> normalizing paths internally and testing more corner cases.  But
	> if you just want to take this version, I'll be fine.

	For your pleasure, the combined patch of my work (so that it is 
	easier to hack on normalizing paths, if you still want that --
	you might want to look at get_pathspec() and its history in that 
	case).

 Documentation/git.txt          |    6 ++++
 cache.h                        |    2 +
 path.c                         |   25 ++++++++++++++++++
 setup.c                        |   11 ++++++-
 t/t1504-ceiling-directories.sh |   54 ++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                  |    1 +
 6 files changed, 97 insertions(+), 2 deletions(-)
 create mode 100644 t/t1504-ceiling-directories.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index adcd3e0..e4413bf 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -415,6 +415,12 @@ git so take care if using Cogito etc.
 	This can also be controlled by the '--work-tree' command line
 	option and the core.worktree configuration variable.
 
+'GIT_CEILING_DIRECTORIES'::
+	If set (to a colon delimited list of absolute directories), Git
+	will refuse to look for the .git/ directory further when hitting
+	one of those directories (otherwise it would traverse the parent
+	directories until hitting the root directory).
+
 git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/cache.h b/cache.h
index a8638b1..c31b4c7 100644
--- a/cache.h
+++ b/cache.h
@@ -300,6 +300,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
+#define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -522,6 +523,7 @@ static inline int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 const char *make_absolute_path(const char *path);
+int longest_prefix(const char *path, const char *prefix_list);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index b7c24a2..a097ecc 100644
--- a/path.c
+++ b/path.c
@@ -357,3 +357,28 @@ const char *make_absolute_path(const char *path)
 
 	return buf;
 }
+
+static int is_separator(char c)
+{
+	return !c || c == '/';
+}
+
+int longest_prefix(const char *path, const char *prefix_list)
+{
+	int max_length = 0, length = 0, i;
+
+	for (i = 0; prefix_list[i]; i++)
+		if (prefix_list[i] == ':') {
+			if (length > max_length && is_separator(path[length]))
+				max_length = length;
+			length = 0;
+		}
+		else if (length >= 0) {
+			if (prefix_list[i] == path[length])
+				length++;
+			else
+				length = -1;
+		}
+	return max_length > length || !is_separator(path[length]) ?
+		max_length : length;
+}
diff --git a/setup.c b/setup.c
index 9e9a2b1..cece3e4 100644
--- a/setup.c
+++ b/setup.c
@@ -365,10 +365,13 @@ const char *read_gitfile_gently(const char *path)
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	const char *ceiling_directories =
+		getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	const char *gitfile_dir;
 	int len, offset;
+	int min_offset = 0;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -422,6 +425,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
 
+	if (ceiling_directories)
+		min_offset = longest_prefix(cwd, ceiling_directories);
+
 	/*
 	 * Test in the following order (relative to the cwd):
 	 * - .git (file containing "gitdir: <path>")
@@ -453,7 +459,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		}
 		chdir("..");
 		do {
-			if (!offset) {
+			if (offset <= min_offset) {
 				if (nongit_ok) {
 					if (chdir(cwd))
 						die("Cannot come back to cwd");
@@ -462,7 +468,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				}
 				die("Not a git repository");
 			}
-		} while (cwd[--offset] != '/');
+		} while (offset > min_offset &&
+				--offset >=0 && cwd[offset] != '/');
 	}
 
 	inside_git_dir = 0;
diff --git a/t/t1504-ceiling-directories.sh b/t/t1504-ceiling-directories.sh
new file mode 100644
index 0000000..6c8757d
--- /dev/null
+++ b/t/t1504-ceiling-directories.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='test limiting with GIT_CEILING_DIRECTORIES'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	CWD="$(pwd -P)" &&
+	mkdir subdir
+
+'
+
+test_expect_success 'without GIT_CEILING_DIRECTORIES' '
+
+	test .git = "$(git rev-parse --git-dir)" &&
+	(cd subdir && git rev-parse --git-dir) &&
+	echo "$CWD" &&
+	test "$CWD/.git" = "$(cd subdir && git rev-parse --git-dir)"
+
+'
+
+test_expect_success 'with non-matching ceiling directory' '
+
+	test "$(GIT_CEILING_DIRECTORIES="$CWD/X" \
+		git rev-parse --git-dir)" = .git
+
+'
+
+test_expect_success 'with matching ceiling directories' '
+
+	GIT_CEILING_DIRECTORIES="$CWD/X:$CWD/subdir" &&
+	export GIT_CEILING_DIRECTORIES &&
+	(cd subdir && test_must_fail git rev-parse --git-dir) &&
+	git rev-parse --git-dir &&
+	GIT_CEILING_DIRECTORIES="$CWD/subdir:$CWD/X" &&
+	export GIT_CEILING_DIRECTORIES &&
+	(cd subdir && test_must_fail git rev-parse --git-dir) &&
+	git rev-parse --git-dir
+
+'
+
+test_expect_success 'with non-directory prefix' '
+
+	GIT_CEILING_DIRECTORIES="$CWD/sub" &&
+	export GIT_CEILING_DIRECTORIES &&
+	(cd subdir && git rev-parse --git-dir)
+
+'
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 5002fb0..c3a3167 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,6 +35,7 @@ unset GIT_WORK_TREE
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
+unset GIT_CEILING_DIRECTORIES
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
 GIT_MERGE_VERBOSITY=5
-- 
1.5.5.1.425.g5f464.dirty
