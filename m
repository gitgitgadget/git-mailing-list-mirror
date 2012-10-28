From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 1/8] Introduce new static function real_path_internal()
Date: Sun, 28 Oct 2012 17:16:20 +0100
Message-ID: <1351440987-26636-2-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVXq-00038u-0s
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab2J1QQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:16:49 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:45470 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752981Ab2J1QQs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:16:48 -0400
X-AuditID: 1207440e-b7f036d0000008b5-63-508d5a6fbf34
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id B8.ED.02229.F6A5D805; Sun, 28 Oct 2012 12:16:47 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJb002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:16:45 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqJsf1Rtg8KZJ2qLrSjeTRUPvFWaL
	J3PvMlscPWVhcXvFfGaLHy09zBbr311ldmD3+Pv+A5PHzll32T0evupi93jWu4fR4+IlZY/P
	m+QC2KK4bZISS8qCM9Pz9O0SuDN+/WxmKdinUtH4/AxbA+MR6S5GTg4JAROJyV0bWCFsMYkL
	99azgdhCApcZJY60KXcxcgHZZ5gkFl28zAiSYBPQlVjU08wEYosIyEp8P7yREaSIWeAuo8Sk
	o1PBuoUFvCTa91wHm8oioCpx8dsFsAZeAReJlac72SC2yUl82POIvYuRg4NTwFXiaL8zxGIX
	iT+r3jFOYORdwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMk3Ph2MLav
	lznEKMDBqMTDe6mgJ0CINbGsuDL3EKMkB5OSKC9zUG+AEF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRHepdxAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG9kJFCjYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgy4ouBsQGS4gHaaw7SzltckJgLFIVoPcWo
	y3H0zdyHjEIsefl5qVLivF0RQEUCIEUZpXlwK2DJ5RWjONDHwrxpIKN4gIkJbtIroCVMQEt0
	+MCWlCQipKQaGD2qV91Yy7LHu6REc8EXG9aY/eKcFv9b9Fbod+zSEjZ7+HMH9yrnU4smLUmQ
	/5h1zmOhevOketErH2oyHKY5F1X9qVB2m1A0U3vDcgMWhjUL9mu1F2aGtJ3ZPOcl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208551>

It accepts a new parameter, die_on_error.  If die_on_error is false,
it simply cleans up after itself and returns NULL rather than dying.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 21 deletions(-)

diff --git a/abspath.c b/abspath.c
index 05f2d79..a7ab8e9 100644
--- a/abspath.c
+++ b/abspath.c
@@ -15,15 +15,26 @@ int is_directory(const char *path)
 #define MAXDEPTH 5
 
 /*
- * Use this to get the real path, i.e. resolve links. If you want an
- * absolute path but don't mind links, use absolute_path.
+ * Return the real path (i.e., absolute path, with symlinks resolved
+ * and extra slashes removed) equivalent to the specified path.  (If
+ * you want an absolute path but don't mind links, use
+ * absolute_path().)  The return value is a pointer to a static
+ * buffer.
+ *
+ * The input and all intermediate paths must be shorter than MAX_PATH.
+ * The directory part of path (i.e., everything up to the last
+ * dir_sep) must denote a valid, existing directory, but the last
+ * component need not exist.  If die_on_error is set, then die with an
+ * informative error message if there is a problem.  Otherwise, return
+ * NULL on errors (without generating any output).
  *
  * If path is our buffer, then return path, as it's already what the
  * user wants.
  */
-const char *real_path(const char *path)
+static const char *real_path_internal(const char *path, int die_on_error)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
+	char *retval = NULL;
 	char cwd[1024] = "";
 	int buf_index = 1;
 
@@ -35,11 +46,19 @@ const char *real_path(const char *path)
 	if (path == buf || path == next_buf)
 		return path;
 
-	if (!*path)
-		die("The empty string is not a valid path");
+	if (!*path) {
+		if (die_on_error)
+			die("The empty string is not a valid path");
+		else
+			goto error_out;
+	}
 
-	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-		die ("Too long path: %.*s", 60, path);
+	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX) {
+		if (die_on_error)
+			die("Too long path: %.*s", 60, path);
+		else
+			goto error_out;
+	}
 
 	while (depth--) {
 		if (!is_directory(buf)) {
@@ -54,20 +73,36 @@ const char *real_path(const char *path)
 		}
 
 		if (*buf) {
-			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
-				die_errno ("Could not get current working directory");
+			if (!*cwd && !getcwd(cwd, sizeof(cwd))) {
+				if (die_on_error)
+					die_errno("Could not get current working directory");
+				else
+					goto error_out;
+			}
 
-			if (chdir(buf))
-				die_errno ("Could not switch to '%s'", buf);
+			if (chdir(buf)) {
+				if (die_on_error)
+					die_errno("Could not switch to '%s'", buf);
+				else
+					goto error_out;
+			}
+		}
+		if (!getcwd(buf, PATH_MAX)) {
+			if (die_on_error)
+				die_errno("Could not get current working directory");
+			else
+				goto error_out;
 		}
-		if (!getcwd(buf, PATH_MAX))
-			die_errno ("Could not get current working directory");
 
 		if (last_elem) {
 			size_t len = strlen(buf);
-			if (len + strlen(last_elem) + 2 > PATH_MAX)
-				die ("Too long path name: '%s/%s'",
-						buf, last_elem);
+			if (len + strlen(last_elem) + 2 > PATH_MAX) {
+				if (die_on_error)
+					die("Too long path name: '%s/%s'",
+					    buf, last_elem);
+				else
+					goto error_out;
+			}
 			if (len && !is_dir_sep(buf[len-1]))
 				buf[len++] = '/';
 			strcpy(buf + len, last_elem);
@@ -77,10 +112,18 @@ const char *real_path(const char *path)
 
 		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
 			ssize_t len = readlink(buf, next_buf, PATH_MAX);
-			if (len < 0)
-				die_errno ("Invalid symlink '%s'", buf);
-			if (PATH_MAX <= len)
-				die("symbolic link too long: %s", buf);
+			if (len < 0) {
+				if (die_on_error)
+					die_errno("Invalid symlink '%s'", buf);
+				else
+					goto error_out;
+			}
+			if (PATH_MAX <= len) {
+				if (die_on_error)
+					die("symbolic link too long: %s", buf);
+				else
+					goto error_out;
+			}
 			next_buf[len] = '\0';
 			buf = next_buf;
 			buf_index = 1 - buf_index;
@@ -89,10 +132,18 @@ const char *real_path(const char *path)
 			break;
 	}
 
+	retval = buf;
+error_out:
+	free(last_elem);
 	if (*cwd && chdir(cwd))
 		die_errno ("Could not change back to '%s'", cwd);
 
-	return buf;
+	return retval;
+}
+
+const char *real_path(const char *path)
+{
+	return real_path_internal(path, 1);
 }
 
 static const char *get_pwd_cwd(void)
-- 
1.8.0
