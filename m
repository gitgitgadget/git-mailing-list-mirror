From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/8] Introduce new static function real_path_internal()
Date: Sun, 21 Oct 2012 07:57:30 +0200
Message-ID: <1350799057-13846-2-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYW-0006Vm-AB
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553Ab2JUF6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:20 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:57075 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217Ab2JUF6U (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:20 -0400
X-AuditID: 12074412-b7f216d0000008e3-df-50838efbae5f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B9.23.02275.BFE83805; Sun, 21 Oct 2012 01:58:19 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wo013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:17 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqPu7rznAYOJ5QYsjb54wW3Rd6Way
	aOi9wmzxZO5dZoujpywsbq+Yz2yx/t1VZgd2j7/vPzB5vGnvZfTYOesuu8fDV13sHhcvKXt8
	3iQXwBbFbZOUWFIWnJmep2+XwJ3R09/JVHBQpeL0kUamBsbj0l2MnBwSAiYSD+8tYoOwxSQu
	3FsPZHNxCAlcZpS42TOBCcI5wyTR97CVEaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwB1GiYVX
	3jCDJIQFvCQWP/sLNpZFQFXi5exVQDYHB6+Ai8S1VQIQ2xQlfnxfA1bOKeAqcWXZHLByIaCS
	nRvfM05g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyTghHYwrj8p
	d4hRgINRiYc3yrY5QIg1say4MvcQoyQHk5Io74teoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR
	3t2CQDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4OJQleHWBkCQkWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYiO+GBgdICkeoL3sIO28xQWJuUBRiNZTjLoc
	R9/MfcgoxJKXn5cqJc57E+RwAZCijNI8uBWw9PKKURzoY2FeL5BRPMDUBDfpFdASJqAl5tyN
	IEtKEhFSUg2Mws5zvjlNXHp8S2Lc25tTlnTZRc0TZFzerlx1PGuWaPXCOR+LQgRmTBUOqmHw
	tKlfZqh155Pb1u2vbzjuy52qXWy0Lp3/4vl1nof/T6x9bVDJdvLp7WNbjASK7x9k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208104>

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
