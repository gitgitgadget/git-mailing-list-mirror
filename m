From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 6/8] longest_ancestor_length(): require prefix list entries to be normalized
Date: Sun, 21 Oct 2012 07:57:35 +0200
Message-ID: <1350799057-13846-7-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYp-0006i8-JU
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab2JUF6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:36 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:63160 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745Ab2JUF6f (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:35 -0400
X-AuditID: 1207440e-b7f036d0000008b5-6e-50838f0a1551
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 01.06.02229.A0F83805; Sun, 21 Oct 2012 01:58:34 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wt013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:32 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqMvV3xxgcPMkq8WRN0+YLbqudDNZ
	NPReYbZ4Mvcus8XRUxYWt1fMZ7ZY/+4qswO7x9/3H5g83rT3MnrsnHWX3ePhqy52j4uXlD0+
	b5ILYIvitklKLCkLzkzP07dL4M74veIXS8F2vYq+8xPYGxjnqXYxcnJICJhIdC/Ywwhhi0lc
	uLeeDcQWErjMKNG7VbCLkQvIPsMkcaX5BgtIgk1AV2JRTzMTiC0ioCYxse0QC0gRs8AdRomF
	V94wgySEBeIlOha8ASri4GARUJX4coQDJMwr4CJx/cwzdohlihI/vq8BK+cUcJW4smwO1GIX
	iZ0b3zNOYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMk3Ph2MLav
	lznEKMDBqMTDy2TdHCDEmlhWXJl7iFGSg0lJlPdFL1CILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO9uQaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCN7UPqFGwKDU9
	tSItM6cEIc3EwQkiuEA28ABtcAUp5C0uSMwtzkyHKDrFqCglztsEkhAASWSU5sENgCWGV4zi
	QP8I83aCVPEAkwpc9yugwUxAg825G0EGlyQipKQaGJvvsxYZJX+5+XwNb8P/T2c8jh8SiszW
	min0/Zxw4J2neRsZzjLnNBY5CfR+Uqmeqva810zUizc1OjHZRc3qIuvncP4qht+vlt3r5mn9
	tklA0fHn0Q1qtjdq0lezZIv83MW/ZaPqcRfb+5yy9q4LQ8Sjjij+Tm/94FzE6tUd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208106>

Move the responsibility for normalizing the prefixes passed to
longest_ancestor_length() to its caller.  In t0060, only test
longest_ancestor_lengths using normalized paths: remove empty entries
and non-absolute paths, strip trailing slashes from the paths, and
remove tests that thereby become redundant.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c                | 26 +++++++++++---------------
 setup.c               | 23 +++++++++++++++++++++++
 t/t0060-path-utils.sh | 41 +++++++++++++----------------------------
 3 files changed, 47 insertions(+), 43 deletions(-)

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
-- 
1.7.11.3
