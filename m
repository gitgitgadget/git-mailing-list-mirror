From: David Reiss <dreiss@facebook.com>
Subject: [PATCH 3/4] Add support for GIT_CEILING_DIRECTORIES
Date: Mon, 19 May 2008 23:49:26 -0700
Message-ID: <48327476.5040500@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 08:51:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyLh7-0000Pf-Jb
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 08:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbYETGuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 02:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbYETGuj
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 02:50:39 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:33537 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364AbYETGui (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 02:50:38 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4K6obkQ020421
	for <git@vger.kernel.org>; Mon, 19 May 2008 23:50:37 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 May 2008 23:47:33 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-OriginalArrivalTime: 20 May 2008 06:47:33.0662 (UTC) FILETIME=[61D073E0:01C8BA45]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-20_01:2008-05-20,2008-05-20,2008-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805190302
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82468>

Make git recognize a new environment variable that prevents it from
chdir'ing up into specified directories when looking for a GIT_DIR.
Useful for avoiding slow network directories.

For example, I use git in an environment where homedirs are automounted
and "ls /home/nonexistent" takes about 9 seconds.  Setting
GIT_CEILING_DIRS="/home" allows "git help -a" (for bash completion) and
"git symbolic-ref" (for my shell prompt) to run in a reasonable time.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
Changed the name to GIT_CEILING_DIRECTORIES, according to Johannes's version.

Moved the "longest ancestor" function to path.c, for the same reason.

Added path normalization to longest_ancestor_length, per Junio's request.

Moved the tests out of setup.c and into a normal shell script test.

Added tests for a few edge cases per Junio's request.  I only added them to
the test of longest_ancestor_length rather than the full functional test,
because the length is the only interesting input to the setup function.

Tried to simplify things as much as possible.  The diff --stat for setup.c
is 10 lines with git diff -b.

This version uses the original semantics.  Git refuses to look for .git or
object in any of the GIT_CEILING_DIRECTORIES when cd'ing up, but will always
check the current directory, even if it is a ceiling dir.  It remains possible
for the root directory to be a git repo.  I think this is a good compromise
between usability and preventing users who forget about ceiling dirs from
being surprised when they can "ls .git" but Git cannot find the repo.  If
others would prefer different semantics, I'm happy to change them.

I'm happy to help resolve conflicts with the msys branch, if someone wants
to point me in the right direction.  Or, if it is going to be merged soon,
I can just wait and then rebase my changes on top of it.

And if the test suite takes too long, I'm fine commenting most of it out.

 Documentation/git.txt   |    8 ++
 cache.h                 |    2 +
 path.c                  |   43 ++++++++++++
 setup.c                 |   24 ++++---
 t/t0060-path-utils.sh   |   47 ++++++++++++++
 t/t1504-ceiling-dirs.sh |  163 +++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |    1 +
 test-path-utils.c       |    5 ++
 8 files changed, 282 insertions(+), 11 deletions(-)
 create mode 100755 t/t1504-ceiling-dirs.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6f445b1..0c624fc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -415,6 +415,14 @@ git so take care if using Cogito etc.
 	This can also be controlled by the '--work-tree' command line
 	option and the core.worktree configuration variable.
 
+'GIT_CEILING_DIRECTORIES'::
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
index 5fd1e5b..c739a86 100644
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
@@ -515,6 +516,7 @@ static inline int is_absolute_path(const char *path)
 }
 const char *make_absolute_path(const char *path);
 int normalize_absolute_path(char *buf, const char *path);
+int longest_ancestor_length(const char *path, const char *prefix_list);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 17921ac..4176cfb 100644
--- a/path.c
+++ b/path.c
@@ -407,3 +407,46 @@ int normalize_absolute_path(char *buf, const char *path)
 	*dst = '\0';
 	return dst - buf;
 }
+
+/*
+ * path = Canonical absolute path
+ * prefix_list = Colon-separated list of absolute paths
+ *
+ * Determines, for each path in parent_list, whether the "prefix" really
+ * is an ancestor directory of path.  Returns the length of the longest
+ * ancestor directory, excluding any trailing slashes, or -1 if no prefix
+ * is an ancestor.  (Note that this means 0 is returned if prefix_list is
+ * "/".) "/foo" is not considered an ancestor of "/foobar".  Directories
+ * are not considered to be their own ancestors.  path must be in a
+ * canonical form: empty components, or "." or ".." components are not
+ * allowed.  prefix_list may be null, which is like "".
+ */
+int longest_ancestor_length(const char *path, const char *prefix_list)
+{
+	char buf[PATH_MAX+1];
+	const char *ceil, *colon;
+	int len, max_len = -1;
+
+	if (prefix_list == NULL || !strcmp(path, "/"))
+		return -1;
+
+	for (colon = ceil = prefix_list; *colon; ceil = colon+1) {
+		for (colon = ceil; *colon && *colon != ':'; colon++);
+		len = colon - ceil;
+		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
+			continue;
+		strlcpy(buf, ceil, len+1);
+		len = normalize_absolute_path(buf, buf);
+		/* Strip "trailing slashes" from "/". */
+		if (len == 1)
+			len = 0;
+
+		if (!strncmp(path, buf, len) &&
+		    path[len] == '/' &&
+		    len > max_len) {
+			max_len = len;
+		}
+	}
+
+	return max_len;
+}
diff --git a/setup.c b/setup.c
index b8fd476..c14b106 100644
--- a/setup.c
+++ b/setup.c
@@ -359,10 +359,11 @@ const char *read_gitfile_gently(const char *path)
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	const char *gitfile_dir;
-	int len, offset;
+	int len, offset, ceil_offset;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -414,6 +415,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	if (!getcwd(cwd, sizeof(cwd)-1))
 		die("Unable to read current working directory");
 
+	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
+
 	/*
 	 * Test in the following order (relative to the cwd):
 	 * - .git (file containing "gitdir: <path>")
@@ -444,17 +447,16 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			return NULL;
 		}
 		chdir("..");
-		do {
-			if (!offset) {
-				if (nongit_ok) {
-					if (chdir(cwd))
-						die("Cannot come back to cwd");
-					*nongit_ok = 1;
-					return NULL;
-				}
-				die("Not a git repository");
+		while (--offset > ceil_offset && cwd[offset] != '/');
+		if (offset <= ceil_offset) {
+			if (nongit_ok) {
+				if (chdir(cwd))
+					die("Cannot come back to cwd");
+				*nongit_ok = 1;
+				return NULL;
 			}
-		} while (cwd[--offset] != '/');
+			die("Not a git repository");
+		}
 	}
 
 	inside_git_dir = 0;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 9076b3b..6e7501f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -12,6 +12,11 @@ norm_abs() {
 	"test \$(test-path-utils normalize_absolute_path '$1') = '$2'"
 }
 
+ancestor() {
+	test_expect_success "longest ancestor" \
+	"test \$(test-path-utils longest_ancestor_length '$1' '$2') = '$3'"
+}
+
 norm_abs "" /
 norm_abs / /
 norm_abs // /
@@ -37,4 +42,46 @@ norm_abs /d1/s1//../s2/../../d2 /d2
 norm_abs /d1/.../d2 /d1/.../d2
 norm_abs /d1/..././../d2 /d1/d2
 
+ancestor / "" -1
+ancestor / / -1
+ancestor /foo "" -1
+ancestor /foo : -1
+ancestor /foo ::. -1
+ancestor /foo ::..:: -1
+ancestor /foo / 0
+ancestor /foo /fo -1
+ancestor /foo /foo -1
+ancestor /foo /foo/ -1
+ancestor /foo /bar -1
+ancestor /foo /bar/ -1
+ancestor /foo /foo/bar -1
+ancestor /foo /foo:/bar/ -1
+ancestor /foo /foo/:/bar/ -1
+ancestor /foo /foo::/bar/ -1
+ancestor /foo /:/foo:/bar/ 0
+ancestor /foo /foo:/:/bar/ 0
+ancestor /foo /:/bar/:/foo 0
+ancestor /foo/bar "" -1
+ancestor /foo/bar / 0
+ancestor /foo/bar /fo -1
+ancestor /foo/bar foo -1
+ancestor /foo/bar /foo 4
+ancestor /foo/bar /foo/ 4
+ancestor /foo/bar /foo/ba -1
+ancestor /foo/bar /:/fo 0
+ancestor /foo/bar /foo:/foo/ba 4
+ancestor /foo/bar /bar -1
+ancestor /foo/bar /bar/ -1
+ancestor /foo/bar /fo: -1
+ancestor /foo/bar :/fo -1
+ancestor /foo/bar /foo:/bar/ 4
+ancestor /foo/bar /:/foo:/bar/ 4
+ancestor /foo/bar /foo:/:/bar/ 4
+ancestor /foo/bar /:/bar/:/fo 0
+ancestor /foo/bar /:/bar/ 0
+ancestor /foo/bar :://foo/. 4
+ancestor /foo/bar :://foo/.:: 4
+ancestor /foo/bar //foo/./::/bar 4
+ancestor /foo/bar ::/bar -1
+
 test_done
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
new file mode 100755
index 0000000..91b704a
--- /dev/null
+++ b/t/t1504-ceiling-dirs.sh
@@ -0,0 +1,163 @@
+#!/bin/sh
+
+test_description='test GIT_CEILING_DIRECTORIES'
+. ./test-lib.sh
+
+test_prefix() {
+	test_expect_success "$1" \
+	"test '$2' = \"\$(git rev-parse --show-prefix)\""
+}
+
+test_fail() {
+	test_expect_code 128 "$1: prefix" \
+	"git rev-parse --show-prefix"
+}
+
+TRASH_ROOT="$(pwd)"
+ROOT_PARENT=$(dirname "$TRASH_ROOT")
+
+
+unset GIT_CEILING_DIRECTORIES
+test_prefix no_ceil ""
+
+export GIT_CEILING_DIRECTORIES
+
+GIT_CEILING_DIRECTORIES=""
+test_prefix ceil_empty ""
+
+GIT_CEILING_DIRECTORIES="$ROOT_PARENT"
+test_prefix ceil_at_parent ""
+
+GIT_CEILING_DIRECTORIES="$ROOT_PARENT/"
+test_prefix ceil_at_parent_slash ""
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+test_prefix ceil_at_trash ""
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+test_prefix ceil_at_trash_slash ""
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+test_prefix ceil_at_sub ""
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
+test_prefix ceil_at_sub_slash ""
+
+
+mkdir -p sub/dir || exit 1
+cd sub/dir || exit 1
+
+unset GIT_CEILING_DIRECTORIES
+test_prefix subdir_no_ceil "sub/dir/"
+
+export GIT_CEILING_DIRECTORIES
+
+GIT_CEILING_DIRECTORIES=""
+test_prefix subdir_ceil_empty "sub/dir/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+test_fail subdir_ceil_at_trash
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+test_fail subdir_ceil_at_trash_slash
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+test_fail subdir_ceil_at_sub
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
+test_fail subdir_ceil_at_sub_slash
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir"
+test_prefix subdir_ceil_at_subdir "sub/dir/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir/"
+test_prefix subdir_ceil_at_subdir_slash "sub/dir/"
+
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su"
+test_prefix subdir_ceil_at_su "sub/dir/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su/"
+test_prefix subdir_ceil_at_su_slash "sub/dir/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/di"
+test_prefix subdir_ceil_at_sub_di "sub/dir/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/di"
+test_prefix subdir_ceil_at_sub_di_slash "sub/dir/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/subdi"
+test_prefix subdir_ceil_at_subdi "sub/dir/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/subdi"
+test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
+
+
+GIT_CEILING_DIRECTORIES="foo:$TRASH_ROOT/sub"
+test_fail second_of_two
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub:bar"
+test_fail first_of_two
+
+GIT_CEILING_DIRECTORIES="foo:$TRASH_ROOT/sub:bar"
+test_fail second_of_three
+
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+GIT_DIR=../../.git
+export GIT_DIR
+test_prefix git_dir_specified ""
+unset GIT_DIR
+
+
+cd ../.. || exit 1
+mkdir -p s/d || exit 1
+cd s/d || exit 1
+
+unset GIT_CEILING_DIRECTORIES
+test_prefix sd_no_ceil "s/d/"
+
+export GIT_CEILING_DIRECTORIES
+
+GIT_CEILING_DIRECTORIES=""
+test_prefix sd_ceil_empty "s/d/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+test_fail sd_ceil_at_trash
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+test_fail sd_ceil_at_trash_slash
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s"
+test_fail sd_ceil_at_s
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/"
+test_fail sd_ceil_at_s_slash
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/d"
+test_prefix sd_ceil_at_sd "s/d/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/d/"
+test_prefix sd_ceil_at_sd_slash "s/d/"
+
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su"
+test_prefix sd_ceil_at_su "s/d/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su/"
+test_prefix sd_ceil_at_su_slash "s/d/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/di"
+test_prefix sd_ceil_at_s_di "s/d/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/di"
+test_prefix sd_ceil_at_s_di_slash "s/d/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sdi"
+test_prefix sd_ceil_at_sdi "s/d/"
+
+GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sdi"
+test_prefix sd_ceil_at_sdi_slash "s/d/"
+
+
+test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7c2a8ba..302c4bd 100644
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
diff --git a/test-path-utils.c b/test-path-utils.c
index 842b580..a0bcb0e 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -17,5 +17,10 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
+		int len = longest_ancestor_length(argv[2], argv[3]);
+		printf("%d\n", len);
+	}
+
 	return 0;
 }
-- 
1.5.4
