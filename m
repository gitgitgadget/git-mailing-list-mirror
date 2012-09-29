From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/9] Introduce new static function real_path_internal()
Date: Sat, 29 Sep 2012 08:15:54 +0200
Message-ID: <1348899362-4057-2-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqLo-0002M0-FV
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab2I2GQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:22 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:46523 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753070Ab2I2GQV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:21 -0400
X-AuditID: 12074411-b7fa36d0000008cc-0d-506692335736
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 70.F2.02252.33296605; Sat, 29 Sep 2012 02:16:19 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G73w026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:18 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqGs8KS3AYG6jrkXXlW4mi4beK8wW
	R09ZWNxeMZ/ZYv27q8wOrB5/339g8tg56y67x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGf0
	9HcyFRxUqTh9pJGpgfG4dBcjJ4eEgInEio3LmSBsMYkL99azdTFycQgJXGaUmPLrEiOEc5ZJ
	onHTF7AqNgFdiUU9zWC2iICaxMS2QywgRcwCkxglejY8YAdJCAt4SbRvWc8MYrMIqEr8PHKa
	BcTmFXCW+PLuCBvEOkWJH9/XgNVwCrhI/O6ZzgpiCwHVPNp7h3UCI+8CRoZVjHKJOaW5urmJ
	mTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCGhJLiDccZJuUOMAhyMSjy8WsdTA4RYE8uKK3MP
	MUpyMCmJ8n6ekBYgxJeUn1KZkVicEV9UmpNafIhRgoNZSYQ3oxionDclsbIqtSgfJiXNwaIk
	zsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwWs4EWioYFFqempFWmZOCUKaiYMTZDiXlEhxal5K
	alFiaUlGPCg64ouB8QGS4gHaawvSzltckJgLFIVoPcWoy7HzxIIHjEIsefl5qVLivCIgRQIg
	RRmleXArYInjFaM40MfCvIEgVTzApAM36RXQEiagJUs3JYEsKUlESEk1MCoVmhX32LNMVKl6
	7iQ+/6OEgd3rOfV+cqzbl35aqTLzRbNS9rSrbKdOX6h3PXRg8mXju0acL2IuTdLWE1/TJf3c
	NY2zqIPVtt6pUTltXfnpgI61u9Q1rRym75iXMVF82fqefe5a+99uP8P4xULd/o7y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206634>

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
1.7.11.3
