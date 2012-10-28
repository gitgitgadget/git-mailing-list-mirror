From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 6/8] longest_ancestor_length(): require prefix list entries to be normalized
Date: Sun, 28 Oct 2012 17:16:25 +0100
Message-ID: <1351440987-26636-7-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVYF-0003Ww-JE
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab2J1QRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:17:11 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:58804 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab2J1QRJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:17:09 -0400
X-AuditID: 12074414-b7f846d0000008b8-2e-508d5a843238
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.9F.02232.48A5D805; Sun, 28 Oct 2012 12:17:08 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJg002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:17:07 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqNsS1RtgsOaNrkXXlW4mi4beK8wW
	T+beZbY4esrC4vaK+cwWP1p6mC3Wv7vK7MDu8ff9ByaPnbPusns8fNXF7vGsdw+jx8VLyh6f
	N8kFsEVx2yQllpQFZ6bn6dslcGc0nTnAWPDFs+L8ni8sDYwXrLsYOTkkBEwk7h6ezgJhi0lc
	uLeerYuRi0NI4DKjxOX3X9khnDNMErOmHQarYhPQlVjU08wEYosIyEp8P7yREaSIWeAuo8Sk
	o1PZQBLCAvESz840MILYLAKqEh/ffQGzeQVcJN4/fcYKsU5O4sOeR0AbODg4BVwljvY7g4SF
	gEr+rHrHOIGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkIAT2cF4
	5KTcIUYBDkYlHt5LBT0BQqyJZcWVuYcYJTmYlER5mYN6A4T4kvJTKjMSizPii0pzUosPMUpw
	MCuJ8C7lBsrxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwXogEahQs
	Sk1PrUjLzClBSDNxcIIILpANPEAb1oEU8hYXJOYWZ6ZDFJ1iVJQS5z0WAZQQAElklObBDYCl
	hleM4kD/CPNuBGnnAaYVuO5XQIOZgAbr8IENLklESEk1MHK8/rjeomPq7cgzp377JWoWMFrc
	OXHGwPrZFG/uzVfcOHhuliSHXNZivXjigtW7mLWX/R8W2b5lY5Hi4Zr6MqJ6yv9pjebSnEZ2
	GmWTrP5+/5UfWfXj7UutpJ0Xj3fsXL6Af3/9zfQlNQ0Kq/fuunvXxv1vzVbNWdES 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208556>

Move the responsibility for normalizing prefixes from
longest_ancestor_length() to its callers. Use slightly different
normalizations at the two callers:

In setup_git_directory_gently_1(), use the old normalization, which
ignores paths that are not usable.  In the next commit we will change
this caller to also resolve symlinks in the paths from
GIT_CEILING_DIRECTORIES as part of the normalization.

In "test-path-utils longest_ancestor_length", use the old
normalization, but die() if any paths are unusable.  Also change t0060
to only pass normalized paths to the test program (no empty entries or
non-absolute paths, strip trailing slashes from the paths, and remove
tests that thereby become redundant).

The point of this change is to reduce the scope of the ancestor_length
tests in t0060 from testing normalization+longest_prefix to testing
only mostly longest_prefix.  This is necessary because when
setup_git_directory_gently_1() starts resolving symlinks as part of
its normalization, it will not be reasonable to do the same in the
test suite, because that would make the test results depend on the
contents of the root directory of the filesystem on which the test is
run.  HOWEVER: under Windows, bash mangles arguments that look like
absolute POSIX paths into DOS paths.  So we have to retain the level
of normalization done by normalize_path_copy() to convert the
bash-mangled DOS paths (which contain backslashes) into paths that use
forward slashes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c                | 26 +++++++++++---------------
 setup.c               | 23 +++++++++++++++++++++++
 t/t0060-path-utils.sh | 41 +++++++++++++----------------------------
 test-path-utils.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 91 insertions(+), 44 deletions(-)

diff --git a/path.c b/path.c
index b80d2e6..d3d3f8b 100644
--- a/path.c
+++ b/path.c
@@ -570,20 +570,20 @@ int normalize_path_copy(char *dst, const char *src)
 
 /*
  * path = Canonical absolute path
- * prefixes = string_list containing absolute paths
+ * prefixes = string_list containing normalized, absolute paths without
+ * trailing slashes (except for the root directory, which is denoted by "/").
  *
- * Determines, for each path in prefixes, whether the "prefix" really
+ * Determines, for each path in prefixes, whether the "prefix"
  * is an ancestor directory of path.  Returns the length of the longest
  * ancestor directory, excluding any trailing slashes, or -1 if no prefix
  * is an ancestor.  (Note that this means 0 is returned if prefixes is
  * ["/"].) "/foo" is not considered an ancestor of "/foobar".  Directories
  * are not considered to be their own ancestors.  path must be in a
  * canonical form: empty components, or "." or ".." components are not
- * allowed.  Empty strings in prefixes are ignored.
+ * allowed.
  */
 int longest_ancestor_length(const char *path, struct string_list *prefixes)
 {
-	char buf[PATH_MAX+1];
 	int i, max_len = -1;
 
 	if (!strcmp(path, "/"))
@@ -593,19 +593,15 @@ int longest_ancestor_length(const char *path, struct string_list *prefixes)
 		const char *ceil = prefixes->items[i].string;
 		int len = strlen(ceil);
 
-		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
-			continue;
-		if (normalize_path_copy(buf, ceil) < 0)
-			continue;
-		len = strlen(buf);
-		if (len > 0 && buf[len-1] == '/')
-			buf[--len] = '\0';
+		if (len == 1 && ceil[0] == '/')
+			len = 0; /* root matches anything, with length 0 */
+		else if (!strncmp(path, ceil, len) && path[len] == '/')
+			; /* match of length len */
+		else
+			continue; /* no match */
 
-		if (!strncmp(path, buf, len) &&
-		    path[len] == '/' &&
-		    len > max_len) {
+		if (len > max_len)
 			max_len = len;
-		}
 	}
 
 	return max_len;
diff --git a/setup.c b/setup.c
index b4cd356..df97ad3 100644
--- a/setup.c
+++ b/setup.c
@@ -622,6 +622,28 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 }
 
 /*
+ * A "string_list_each_func_t" function that normalizes an entry from
+ * GIT_CEILING_DIRECTORIES or discards it if unusable.
+ */
+static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
+{
+	const char *ceil = item->string;
+	int len = strlen(ceil);
+	char buf[PATH_MAX+1];
+
+	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
+		return 0;
+	if (normalize_path_copy(buf, ceil) < 0)
+		return 0;
+	len = strlen(buf);
+	if (len > 1 && buf[len-1] == '/')
+		buf[--len] = '\0';
+	free(item->string);
+	item->string = xstrdup(buf);
+	return 1;
+}
+
+/*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
  */
@@ -659,6 +681,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 
 	if (env_ceiling_dirs) {
 		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
+		filter_string_list(&ceiling_dirs, 0, normalize_ceiling_entry, NULL);
 		ceil_offset = longest_ancestor_length(cwd, &ceiling_dirs);
 		string_list_clear(&ceiling_dirs, 0);
 	}
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4ef2345..09a42a4 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -93,47 +93,32 @@ norm_path /d1/s1//../s2/../../d2 /d2 POSIX
 norm_path /d1/.../d2 /d1/.../d2 POSIX
 norm_path /d1/..././../d2 /d1/d2 POSIX
 
-ancestor / "" -1
 ancestor / / -1
-ancestor /foo "" -1
-ancestor /foo : -1
-ancestor /foo ::. -1
-ancestor /foo ::..:: -1
 ancestor /foo / 0
 ancestor /foo /fo -1
 ancestor /foo /foo -1
-ancestor /foo /foo/ -1
 ancestor /foo /bar -1
-ancestor /foo /bar/ -1
 ancestor /foo /foo/bar -1
-ancestor /foo /foo:/bar/ -1
-ancestor /foo /foo/:/bar/ -1
-ancestor /foo /foo::/bar/ -1
-ancestor /foo /:/foo:/bar/ 0
-ancestor /foo /foo:/:/bar/ 0
-ancestor /foo /:/bar/:/foo 0
-ancestor /foo/bar "" -1
+ancestor /foo /foo:/bar -1
+ancestor /foo /:/foo:/bar 0
+ancestor /foo /foo:/:/bar 0
+ancestor /foo /:/bar:/foo 0
 ancestor /foo/bar / 0
 ancestor /foo/bar /fo -1
-ancestor /foo/bar foo -1
 ancestor /foo/bar /foo 4
-ancestor /foo/bar /foo/ 4
 ancestor /foo/bar /foo/ba -1
 ancestor /foo/bar /:/fo 0
 ancestor /foo/bar /foo:/foo/ba 4
 ancestor /foo/bar /bar -1
-ancestor /foo/bar /bar/ -1
-ancestor /foo/bar /fo: -1
-ancestor /foo/bar :/fo -1
-ancestor /foo/bar /foo:/bar/ 4
-ancestor /foo/bar /:/foo:/bar/ 4
-ancestor /foo/bar /foo:/:/bar/ 4
-ancestor /foo/bar /:/bar/:/fo 0
-ancestor /foo/bar /:/bar/ 0
-ancestor /foo/bar .:/foo/. 4
-ancestor /foo/bar .:/foo/.:.: 4
-ancestor /foo/bar /foo/./:.:/bar 4
-ancestor /foo/bar .:/bar -1
+ancestor /foo/bar /fo -1
+ancestor /foo/bar /foo:/bar 4
+ancestor /foo/bar /:/foo:/bar 4
+ancestor /foo/bar /foo:/:/bar 4
+ancestor /foo/bar /:/bar:/fo 0
+ancestor /foo/bar /:/bar 0
+ancestor /foo/bar /foo 4
+ancestor /foo/bar /foo:/bar 4
+ancestor /foo/bar /bar -1
 
 test_expect_success 'strip_path_suffix' '
 	test c:/msysgit = $(test-path-utils strip_path_suffix \
diff --git a/test-path-utils.c b/test-path-utils.c
index acb0560..0092cbf 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -1,6 +1,33 @@
 #include "cache.h"
 #include "string-list.h"
 
+/*
+ * A "string_list_each_func_t" function that normalizes an entry from
+ * GIT_CEILING_DIRECTORIES.  If the path is unusable for some reason,
+ * die with an explanation.
+ */
+static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
+{
+	const char *ceil = item->string;
+	int len = strlen(ceil);
+	char buf[PATH_MAX+1];
+
+	if (len == 0)
+		die("Empty path is not supported");
+	if (len > PATH_MAX)
+		die("Path \"%s\" is too long", ceil);
+	if (!is_absolute_path(ceil))
+		die("Path \"%s\" is not absolute", ceil);
+	if (normalize_path_copy(buf, ceil) < 0)
+		die("Path \"%s\" could not be normalized", ceil);
+	len = strlen(buf);
+	if (len > 1 && buf[len-1] == '/')
+		die("Normalized path \"%s\" ended with slash", buf);
+	free(item->string);
+	item->string = xstrdup(buf);
+	return 1;
+}
+
 int main(int argc, char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
@@ -33,10 +60,26 @@ int main(int argc, char **argv)
 	if (argc == 4 && !strcmp(argv[1], "longest_ancestor_length")) {
 		int len;
 		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
+		char *path = xstrdup(argv[2]);
 
+		/*
+		 * We have to normalize the arguments because under
+		 * Windows, bash mangles arguments that look like
+		 * absolute POSIX paths or colon-separate lists of
+		 * absolute POSIX paths into DOS paths (e.g.,
+		 * "/foo:/foo/bar" might be converted to
+		 * "D:\Src\msysgit\foo;D:\Src\msysgit\foo\bar"),
+		 * whereas longest_ancestor_length() requires paths
+		 * that use forward slashes.
+		 */
+		if (normalize_path_copy(path, path))
+			die("Path \"%s\" could not be normalized", argv[2]);
 		string_list_split(&ceiling_dirs, argv[3], PATH_SEP, -1);
-		len = longest_ancestor_length(argv[2], &ceiling_dirs);
+		filter_string_list(&ceiling_dirs, 0,
+				   normalize_ceiling_entry, NULL);
+		len = longest_ancestor_length(path, &ceiling_dirs);
 		string_list_clear(&ceiling_dirs, 0);
+		free(path);
 		printf("%d\n", len);
 		return 0;
 	}
-- 
1.8.0
