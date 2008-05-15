From: David Reiss <dreiss@facebook.com>
Subject: [PATCH v2] Add support for GIT_CEILING_DIRS
Date: Wed, 14 May 2008 18:35:25 -0700
Message-ID: <482B935D.20105@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 03:36:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwSOO-0000T9-S2
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 03:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYEOBfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 21:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYEOBfe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 21:35:34 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:54800 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbYEOBfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 21:35:32 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4F1ZWXc026192
	for <git@vger.kernel.org>; Wed, 14 May 2008 18:35:32 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 May 2008 18:32:41 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
X-OriginalArrivalTime: 15 May 2008 01:32:41.0999 (UTC) FILETIME=[9170B1F0:01C8B62B]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-15_01:2008-05-14,2008-05-15,2008-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805140209
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82165>

Make git recognize a new environment variable that prevents it from
chdir'ing up into specified directories when looking for a GIT_DIR.
Useful for avoiding slow network directories.

For example, I use git in an environment where homedirs are automounted
and "ls /home/nonexistent" takes about 9 seconds.  Setting
GIT_CEILING_DIRS="/home" allows "git help -a" (for bash completion) and
"git symbolic-ref" (for my shell prompt) to run in a reasonable time.

This also moves the chdir call to after computing the new cwd.
This should be a no-op because the cwd is not read in the interim
and any nonlocal exits either chdir to an absolute path or die.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
Regarding initializing min_offset to -1, it is necessary, given that
code to have the root directory be a git repository.  Setting min_offset,
to 0 would prevent "/.git" and "/objects" from being checked.

Removed all C99-style comments.  Old habits die hard. :)

I moved the prefix-calculating code into a separate function, as you
suggested, and removed the allocation (which actually wasn't really
necessary to begin with).  This also has the nice effect that it is
much easier to test it in isolation.  I added a test for it, #if 0'ed
out.  I wasn't able to find a convention for this sort of test.

Regarding the "big, ugly change", your suggestion has an off-by-one error.
With that code, as soon as "cwd[--offset] != '/'" is false, the loop ends,
and we would not detect that offset is now equal to min_offset.  Getting
this loop right was really tricky because it is basically checking three
things at once (beginning of string, ceiling, directory boundary).  The
key to getting it to look like you suggested was to add 1 to min_offset
in all cases.  I renamed it ceil_offset to reflect the fact that it is
one less than the miinimum offset we are willing to test and added a
comment explaining exactly what it means (because it is a little
counter-intuitive).  I also added a bunch of tests to make sure that this
behavior doesn't break down with single-character directories.

For my tests, you said "I think it would make more sense to write these out."
Could you explain what you mean by this?  Also, I removed the "&& return".
I copied these from t1500, and I obviously wasn't paying close attention.

 Documentation/git.txt   |    8 +++
 cache.h                 |    1 +
 setup.c                 |  116 ++++++++++++++++++++++++++++++++++-
 t/t1504-ceiling-dirs.sh |  156 +++++++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |    1 +
 5 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100755 t/t1504-ceiling-dirs.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6f445b1..8aea331 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -415,6 +415,14 @@ git so take care if using Cogito etc.
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
index 9cee9a5..8300acc 100644
--- a/cache.h
+++ b/cache.h
@@ -300,6 +300,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_LOCAL_ENVIRONMENT "GIT_CONFIG_LOCAL"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
+#define CEILING_DIRS_ENVIRONMENT "GIT_CEILING_DIRS"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
diff --git a/setup.c b/setup.c
index b8fd476..de9e7f1 100644
--- a/setup.c
+++ b/setup.c
@@ -353,16 +353,118 @@ const char *read_gitfile_gently(const char *path)
 }
 
 /*
+ * path = Canonical absolute path
+ * prefix_list = Colon-separated list of canonical absolute paths
+ *
+ * Determines, for each path in parent_list, whether the "prefix" really
+ * is an ancestor directory of path.  Returns the length of the longest
+ * ancestor directory, excluding any trailing slashes, or -1 if no prefix
+ * is an ancestry.  (Note that this means 0 is returned if prefix_list
+ * contains "/".)  "/foo" is not considered an ancestor of "/foobar".
+ * Directories are not considered to be their own ancestors.  Paths must
+ * be in a canonical form: empty components, or "." or ".." components
+ * are not allowed.  prefix_list may be null, which is like "".
+ */
+static int longest_ancestor_length(const char *path, const char *prefix_list)
+{
+	const char *ceil, *colon;
+	int max_len = -1;
+
+	if (prefix_list == NULL)
+		return -1;
+	/* "/" is a tricky edge case.  It should always return -1, though. */
+	if (!strcmp(path, "/"))
+		return -1;
+
+	ceil = prefix_list;
+	for (;;) {
+		int len;
+
+		/* Add strchrnul to compat? */
+		colon = strchr(ceil, ':');
+		if (colon)
+			len = colon - ceil;
+		else
+			len = strlen(ceil);
+
+		/* "" would otherwise be treated like "/". */
+		if (len) {
+			/* Trim trailing slashes. */
+			while (len && ceil[len-1] == '/')
+				len--;
+
+			if (!strncmp(path, ceil, len) &&
+					path[len] == '/' &&
+					len > max_len) {
+				max_len = len;
+			}
+		}
+
+		if (!colon)
+			break;
+		ceil = colon + 1;
+	}
+
+	return max_len;
+}
+
+#if 0
+static void test_longest_ancestor_length()
+{
+	assert(longest_ancestor_length("/", NULL           ) == -1);
+	assert(longest_ancestor_length("/", ""             ) == -1);
+	assert(longest_ancestor_length("/", "/"            ) == -1);
+
+	assert(longest_ancestor_length("/foo", NULL           ) == -1);
+	assert(longest_ancestor_length("/foo", ""             ) == -1);
+	assert(longest_ancestor_length("/foo", ":"            ) == -1);
+	assert(longest_ancestor_length("/foo", "/"            ) ==  0);
+	assert(longest_ancestor_length("/foo", "/fo"          ) == -1);
+	assert(longest_ancestor_length("/foo", "/foo"         ) == -1);
+	assert(longest_ancestor_length("/foo", "/foo/"        ) == -1);
+	assert(longest_ancestor_length("/foo", "/bar"         ) == -1);
+	assert(longest_ancestor_length("/foo", "/bar/"        ) == -1);
+	assert(longest_ancestor_length("/foo", "/foo/bar"     ) == -1);
+	assert(longest_ancestor_length("/foo", "/foo:/bar/"   ) == -1);
+	assert(longest_ancestor_length("/foo", "/foo/:/bar/"  ) == -1);
+	assert(longest_ancestor_length("/foo", "/foo::/bar/"  ) == -1);
+	assert(longest_ancestor_length("/foo", "/:/foo:/bar/" ) ==  0);
+	assert(longest_ancestor_length("/foo", "/foo:/:/bar/" ) ==  0);
+	assert(longest_ancestor_length("/foo", "/:/bar/:/foo" ) ==  0);
+
+	assert(longest_ancestor_length("/foo/bar", NULL           ) == -1);
+	assert(longest_ancestor_length("/foo/bar", ""             ) == -1);
+	assert(longest_ancestor_length("/foo/bar", "/"            ) ==  0);
+	assert(longest_ancestor_length("/foo/bar", "/fo"          ) == -1);
+	assert(longest_ancestor_length("/foo/bar", "/foo"         ) ==  4);
+	assert(longest_ancestor_length("/foo/bar", "/foo/"        ) ==  4);
+	assert(longest_ancestor_length("/foo/bar", "/foo/ba"      ) == -1);
+	assert(longest_ancestor_length("/foo/bar", "/:/fo"        ) ==  0);
+	assert(longest_ancestor_length("/foo/bar", "/foo:/foo/ba" ) ==  4);
+	assert(longest_ancestor_length("/foo/bar", "/bar"         ) == -1);
+	assert(longest_ancestor_length("/foo/bar", "/bar/"        ) == -1);
+	assert(longest_ancestor_length("/foo/bar", "/fo:"         ) == -1);
+	assert(longest_ancestor_length("/foo/bar", ":/fo"         ) == -1);
+	assert(longest_ancestor_length("/foo/bar", "/foo:/bar/"   ) ==  4);
+	assert(longest_ancestor_length("/foo/bar", "/:/foo:/bar/" ) ==  4);
+	assert(longest_ancestor_length("/foo/bar", "/foo:/:/bar/" ) ==  4);
+	assert(longest_ancestor_length("/foo/bar", "/:/bar/:/fo"  ) ==  0);
+	assert(longest_ancestor_length("/foo/bar", "/:/bar/"      ) ==  0);
+}
+#endif
+
+/*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
  */
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
+	const char *env_ceiling_dirs = getenv(CEILING_DIRS_ENVIRONMENT);
 	static char cwd[PATH_MAX+1];
 	const char *gitdirenv;
 	const char *gitfile_dir;
-	int len, offset;
+	int len, offset, ceil_offset;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -415,6 +517,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die("Unable to read current working directory");
 
 	/*
+	 * Compute ceil_offset based on GIT_CEILING_DIRS.  It is actually the offset
+	 * of the first character in cwd after the trailing slash of the ceiling.
+	 * Putting it so far to the right is necessary in order to bail out of the
+	 * "--offset" loop early enough.
+	 */
+	ceil_offset = 1 + longest_ancestor_length(cwd, env_ceiling_dirs);
+
+	/*
 	 * Test in the following order (relative to the cwd):
 	 * - .git (file containing "gitdir: <path>")
 	 * - .git/
@@ -443,9 +553,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
-		chdir("..");
 		do {
-			if (!offset) {
+			if (offset <= ceil_offset) {
 				if (nongit_ok) {
 					if (chdir(cwd))
 						die("Cannot come back to cwd");
@@ -455,6 +564,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				die("Not a git repository");
 			}
 		} while (cwd[--offset] != '/');
+		chdir("..");
 	}
 
 	inside_git_dir = 0;
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
new file mode 100755
index 0000000..091baad
--- /dev/null
+++ b/t/t1504-ceiling-dirs.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+
+test_description='test GIT_CEILING_DIRS'
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
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub/di"
+test_prefix subdir_ceil_at_sub_di "sub/dir/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sub/di"
+test_prefix subdir_ceil_at_sub_di_slash "sub/dir/"
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
+unset GIT_DIR
+
+
+cd ../.. || exit 1
+mkdir -p s/d || exit 1
+cd s/d || exit 1
+
+unset GIT_CEILING_DIRS
+test_prefix sd_no_ceil "s/d/"
+
+export GIT_CEILING_DIRS=""
+test_prefix sd_ceil_empty "s/d/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT"
+test_fail sd_ceil_at_trash
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/"
+test_fail sd_ceil_at_trash_slash
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/s"
+test_fail sd_ceil_at_s
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/s/"
+test_fail sd_ceil_at_s_slash
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/s/d"
+test_prefix sd_ceil_at_sd "s/d/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/s/d/"
+test_prefix sd_ceil_at_sd_slash "s/d/"
+
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/su"
+test_prefix sd_ceil_at_su "s/d/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/su/"
+test_prefix sd_ceil_at_su_slash "s/d/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/s/di"
+test_prefix sd_ceil_at_s_di "s/d/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/s/di"
+test_prefix sd_ceil_at_s_di_slash "s/d/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sdi"
+test_prefix sd_ceil_at_sdi "s/d/"
+
+export GIT_CEILING_DIRS="$TRASH_ROOT/sdi"
+test_prefix sd_ceil_at_sdi_slash "s/d/"
+
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
