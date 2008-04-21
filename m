From: David Reiss <dreiss@facebook.com>
Subject: [PATCH] Add support for GIT_CEILING_DIRS
Date: Mon, 21 Apr 2008 10:43:08 -0700
Message-ID: <480CD22C.4030109@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 19:49:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo095-0005Yv-8T
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 19:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbYDURsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 13:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbYDURsm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 13:48:42 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:53853 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYDURsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 13:48:41 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Apr 2008 13:48:41 EDT
Received: from SF2PMXF01.TheFacebook.com (sf2pmxf01.thefacebook.com [192.168.16.11])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m3LHh98V000825
	for <git@vger.kernel.org>; Mon, 21 Apr 2008 10:43:10 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by SF2PMXF01.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 21 Apr 2008 10:41:19 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
X-OriginalArrivalTime: 21 Apr 2008 17:41:19.0131 (UTC) FILETIME=[E80946B0:01C8A3D6]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7113:2.4.4,1.2.40,4.0.166 definitions=2008-04-21_06:2008-04-18,2008-04-21,2008-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0804140000 definitions=main-0804210151
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80030>

>From f29e8a524f770596450dbbe338433f0dfc365377 Mon Sep 17 00:00:00 2001
From: David Reiss <dreiss@facebook.com>
Date: Sun, 20 Apr 2008 12:27:52 -0700
Subject: [PATCH] chdir after computing new cwd in check_repository_format_gently

In preparation for adding a check before the chdir.
This should be a no-op because the cwd is not read in the interim
and any nonlocal exits either chdir to an absolute path or die.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 3d2d958..a7b7f56 100644
--- a/setup.c
+++ b/setup.c
@@ -396,7 +396,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
-		chdir("..");
 		do {
 			if (!offset) {
 				if (nongit_ok) {
@@ -408,6 +407,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				die("Not a git repository");
 			}
 		} while (cwd[--offset] != '/');
+		chdir("..");
 	}
 
 	inside_git_dir = 0;
-- 
1.5.4


>From 1543c81e75e7890475331bbae1de98ead45e5245 Mon Sep 17 00:00:00 2001
From: David Reiss <dreiss@facebook.com>
Date: Sun, 20 Apr 2008 22:54:11 -0700
Subject: [PATCH] Add support for GIT_CEILING_DIRS

Make git recognize a new environment variable that prevents it from
chdir'ing up into specified directories when looking for a GIT_DIR.
Useful for avoiding slow network directories.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
Just a bit of context about the motivation for this.  I use git in an
environment where homedirs are automounted and "ls /home/nonexistent"
takes about 9 seconds.  I use the git bash completion, which runs
"git help -a".  As of Git 1.5.5, this calls setup_git_directory_gently,
which searches /home/.git and /home/objects, which takes forever,
delaying all of my logins.  This patch lets me set
"GIT_CEILING_DIRS=/home", which makes this operation fast.  As a bonus,
the "git symbolic-ref HEAD" in my shell prompt now works quickly when
I'm in a non-git directory.

 Documentation/git.txt   |    8 ++++
 cache.h                 |    1 +
 setup.c                 |   67 +++++++++++++++++++++++++-----
 t/t1503-ceiling-dirs.sh |  104 +++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |    1 +
 5 files changed, 170 insertions(+), 11 deletions(-)
 create mode 100755 t/t1503-ceiling-dirs.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 336fe99..cc52f6e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -406,6 +406,14 @@ git so take care if using Cogito etc.
 	This can also be controlled by the '--work-tree' command line
 	option and the core.worktree configuration variable.
 
+'GIT_CEILING_DIRS'::
+	This should be a colon-separated list of absolute paths.
+	If set, it is a list of directories that git should not chdir
+	up into while looking for a repository directory.
+	It will not exclude the current working directory or
+	a GIT_DIR set on the command line or in the environment.
+	(Useful for excluding slow-loading network directories.)
+
 git Commits
 ~~~~~~~~~~~
 'GIT_AUTHOR_NAME'::
diff --git a/cache.h b/cache.h
index 50b28fa..e5e3dba 100644
--- a/cache.h
+++ b/cache.h
@@ -295,6 +295,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
+#define CEILING_DIRS_ENVIRONMENT "GIT_CEILING_DIRS"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
diff --git a/setup.c b/setup.c
index a7b7f56..2f95d68 100644
--- a/setup.c
+++ b/setup.c
@@ -321,9 +321,10 @@ static int check_repository_format_gently(int *nongit_ok)
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	const char *env_ceiling_dirs = getenv(CEILING_DIRS_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
-	int len, offset;
+	int len, offset, max_offset = -1;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -375,6 +376,37 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
 
+	// Compute max_offset based on GIT_CEILING_DIRS.
+	if (env_ceiling_dirs) {
+		char *ceils, *ceil, *colon;
+		ceil = ceils = xstrdup(env_ceiling_dirs);
+		for (;;) {
+			int len;
+
+			if ((colon = strchr(ceil, ':')))
+				*colon = '\0';
+			len = strlen(ceil);
+
+			// "" would otherwise be treated like "/".
+			if (len) {
+				// Trim trailing slashes.
+				while (len && ceil[len-1] == '/')
+					ceil[--len] = '\0';
+
+				if (!strncmp(cwd, ceil, len) &&
+				    cwd[len] == '/' &&
+				    len > max_offset) {
+					max_offset = len;
+				}
+			}
+
+			if (!colon)
+				break;
+			ceil = colon + 1;
+		}
+		free(ceils);
+	}
+
 	/*
 	 * Test in the following order (relative to the cwd):
 	 * - .git/
@@ -386,6 +418,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	offset = len = strlen(cwd);
 	for (;;) {
+		// Check the current directory (.git first).
 		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			break;
 		if (is_git_directory(".")) {
@@ -396,17 +429,29 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
-		do {
-			if (!offset) {
-				if (nongit_ok) {
-					if (chdir(cwd))
-						die("Cannot come back to cwd");
-					*nongit_ok = 1;
-					return NULL;
-				}
-				die("Not a git repository");
+
+		// Did we just check the root dir?
+		if (!offset) {
+		not_a_repo:
+			if (nongit_ok) {
+				if (chdir(cwd))
+					die("Cannot come back to cwd");
+				*nongit_ok = 1;
+				return NULL;
 			}
-		} while (cwd[--offset] != '/');
+			die("Not a git repository");
+		}
+
+		while (cwd[--offset] != '/') {
+			assert(offset > 0);
+		}
+
+		// Don't chdir into the ceiling.
+		if (offset <= max_offset) {
+			assert(offset == max_offset);
+			goto not_a_repo;
+		}
+
 		chdir("..");
 	}
 
diff --git a/t/t1503-ceiling-dirs.sh b/t/t1503-ceiling-dirs.sh
new file mode 100755
index 0000000..d4eaa13
--- /dev/null
+++ b/t/t1503-ceiling-dirs.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+test_description='test GIT_CEILING_DIRS'
+. ./test-lib.sh
+
+test_prefix() {
+	test_expect_success "$1" \
+	"test '$2' = \"\$(git rev-parse --show-prefix)\""
+	shift
+	[ $# -eq 0 ] && return
+}
+
+test_fail() {
+	test_expect_code 128 "$1: prefix" \
+	"git rev-parse --show-prefix"
+	shift
+	[ $# -eq 0 ] && return
+}
+
+TRASH_ROOT="$(pwd)"
+ROOT_PARENT=$(dirname "$TRASH_ROOT")
+
+
+unset GIT_CEILING_DIRS
+test_prefix no_ceil ""
+
+export GIT_CEILING_DIRS=""
+test_prefix ceil_empty ""
+
+export GIT_CEILING_DIRS="$ROOT_PARENT"
+test_prefix ceil_at_parent ""
+
+export GIT_CEILING_DIRS="$ROOT_PARENT/"
+test_prefix ceil_at_parent_slash ""
+
+export GIT_CEILING_DIRS="$TRASH_ROOT"
+test_prefix ceil_at_trash ""
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/"
+test_prefix ceil_at_trash_slash ""
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub"
+test_prefix ceil_at_sub ""
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub/"
+test_prefix ceil_at_sub_slash ""
+
+
+mkdir -p sub/dir || exit 1
+cd sub/dir || exit 1
+
+unset GIT_CEILING_DIRS
+test_prefix subdir_no_ceil "sub/dir/"
+
+export GIT_CEILING_DIRS=""
+test_prefix subdir_ceil_empty "sub/dir/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT"
+test_fail subdir_ceil_at_trash
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/"
+test_fail subdir_ceil_at_trash_slash
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub"
+test_fail subdir_ceil_at_sub
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub/"
+test_fail subdir_ceil_at_sub_slash
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub/dir"
+test_prefix subdir_ceil_at_subdir "sub/dir/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub/dir/"
+test_prefix subdir_ceil_at_subdir_slash "sub/dir/"
+
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/su"
+test_prefix subdir_ceil_at_su "sub/dir/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/su/"
+test_prefix subdir_ceil_at_su_slash "sub/dir/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/subdi"
+test_prefix subdir_ceil_at_subdi "sub/dir/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/subdi"
+test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
+
+
+export GIT_CEILING_DIRS="foo:$TRASH_ROOT/sub"
+test_fail second_of_two
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub:bar"
+test_fail first_of_two
+
+export GIT_CEILING_DIRS="foo:$TRASH_ROOT/sub:bar"
+test_fail second_of_three
+
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub"
+export GIT_DIR=../../.git
+test_prefix git_dir_specified ""
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7c2a8ba..22899c1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,6 +35,7 @@ unset GIT_WORK_TREE
 unset GIT_EXTERNAL_DIFF
 unset GIT_INDEX_FILE
 unset GIT_OBJECT_DIRECTORY
+unset GIT_CEILING_DIRS
 unset SHA1_FILE_DIRECTORIES
 unset SHA1_FILE_DIRECTORY
 GIT_MERGE_VERBOSITY=5
-- 
1.5.4
