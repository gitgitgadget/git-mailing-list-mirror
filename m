From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/8] Introduce new static function real_path_internal()
Date: Wed, 26 Sep 2012 21:34:43 +0200
Message-ID: <1348688090-13648-2-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOS-0004c5-HE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270Ab2IZTf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:26 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:42216 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757645Ab2IZTfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:25 -0400
X-AuditID: 1207440f-b7fde6d00000095c-dd-506358fcfd6e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A1.8E.02396.CF853605; Wed, 26 Sep 2012 15:35:24 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFff010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:23 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqPsnIjnAYOEfTYuuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M7o
	6e9kKjioUnH6SCNTA+Nx6S5GTg4JAROJlVP2MEHYYhIX7q1n62Lk4hASuMwocXLNfijnDJPE
	2QUX2EGq2AR0JRb1NIN1iAioSUxsO8QCUsQsMIlRomfDA7AiYQF3idc357J2MXJwsAioSky9
	wwkS5hVwkXi+oJ8ZYpuixI/va8BsTgFXiS8bLrCB2EJANYdf3WKewMi7gJFhFaNcYk5prm5u
	YmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZIIPHvYOxaL3OIUYCDUYmH18MhOUCINbGsuDL3
	EKMkB5OSKK91GFCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+zrKQAId6UxMqq1KJ8mJQ0B4uS
	OK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBK8GMGKEBItS01Mr0jJzShDSTBycIMO5pESKU/NS
	UosSS0sy4kGxEV8MjA6QFA/Q3nCQdt7igsRcoChE6ylGXY6dJxY8YBRiycvPS5US57UDKRIA
	KcoozYNbAUsbrxjFgT4W5o0FqeIBphy4Sa+AljABLVm6CeS54pJEhJRUA6OHZERKSuOkuwu+
	uanvF+qok634yxeXucEmIuv3/uwOUxlfS5f5b3+n7D9WytbjcG79/clXli7jf/Fr5TerP0sz
	Jj9V2uvkGlP4UczZdcL/Ays4znoaMUZbsK582aEWWBOzmqH8i3ry1QulT2bzTz06 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206433>

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
