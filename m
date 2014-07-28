From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 05/10] abspath: convert real_path_internal() to strbuf
Date: Mon, 28 Jul 2014 20:28:30 +0200
Message-ID: <53D6964E.1070100@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:30:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpgz-0004CP-9i
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbaG1S2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:28:53 -0400
Received: from mout.web.de ([212.227.17.12]:55557 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbaG1S2s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:28:48 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MIeUW-1XE2aO08vQ-002IfJ; Mon, 28 Jul 2014 20:28:32
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:HUoQZH0FAozRqJORqwVdSnJy00oRI401stVG6i0Sb4eH0HO738G
 +WvNbJiidrWepuy1r/x3x/AS9FytKUXI7PrlGgkg5ci5UmUqJJ2pjMaquC95xiVsFCuQz53
 hkpKh+fjDm//5oWFKCg+UlskoP5UZ7VjvOEHLA6krlf7GmY83EyvjFGPmw8YK1LYJlbZcKa
 qjtnzlEFH76j8AQan2+eA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254339>

Use strbuf instead of fixed-sized buffers in real_path() in order to
avoid the size limitations of the latter.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 abspath.c | 69 +++++++++++++++++++++++----------------------------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/abspath.c b/abspath.c
index 911e931..16e7fa2 100644
--- a/abspath.c
+++ b/abspath.c
@@ -33,7 +33,7 @@ int is_directory(const char *path)
  */
 static const char *real_path_internal(const char *path, int die_on_error)
 {
-	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
+	static struct strbuf sb = STRBUF_INIT;
 	char *retval = NULL;
 
 	/*
@@ -43,14 +43,12 @@ static const char *real_path_internal(const char *path, int die_on_error)
 	 */
 	struct strbuf cwd = STRBUF_INIT;
 
-	int buf_index = 1;
-
 	int depth = MAXDEPTH;
 	char *last_elem = NULL;
 	struct stat st;
 
 	/* We've already done it */
-	if (path == buf || path == next_buf)
+	if (path == sb.buf)
 		return path;
 
 	if (!*path) {
@@ -60,26 +58,22 @@ static const char *real_path_internal(const char *path, int die_on_error)
 			goto error_out;
 	}
 
-	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX) {
-		if (die_on_error)
-			die("Too long path: %.*s", 60, path);
-		else
-			goto error_out;
-	}
+	strbuf_init(&sb, 0);
+	strbuf_addstr(&sb, path);
 
 	while (depth--) {
-		if (!is_directory(buf)) {
-			char *last_slash = find_last_dir_sep(buf);
+		if (!is_directory(sb.buf)) {
+			char *last_slash = find_last_dir_sep(sb.buf);
 			if (last_slash) {
 				last_elem = xstrdup(last_slash + 1);
-				last_slash[1] = '\0';
+				strbuf_setlen(&sb, last_slash - sb.buf + 1);
 			} else {
-				last_elem = xstrdup(buf);
-				*buf = '\0';
+				last_elem = xmemdupz(sb.buf, sb.len);
+				strbuf_reset(&sb);
 			}
 		}
 
-		if (*buf) {
+		if (sb.len) {
 			if (!cwd.len && strbuf_getcwd(&cwd)) {
 				if (die_on_error)
 					die_errno("Could not get current working directory");
@@ -87,14 +81,15 @@ static const char *real_path_internal(const char *path, int die_on_error)
 					goto error_out;
 			}
 
-			if (chdir(buf)) {
+			if (chdir(sb.buf)) {
 				if (die_on_error)
-					die_errno("Could not switch to '%s'", buf);
+					die_errno("Could not switch to '%s'",
+						  sb.buf);
 				else
 					goto error_out;
 			}
 		}
-		if (!getcwd(buf, PATH_MAX)) {
+		if (strbuf_getcwd(&sb)) {
 			if (die_on_error)
 				die_errno("Could not get current working directory");
 			else
@@ -102,44 +97,30 @@ static const char *real_path_internal(const char *path, int die_on_error)
 		}
 
 		if (last_elem) {
-			size_t len = strlen(buf);
-			if (len + strlen(last_elem) + 2 > PATH_MAX) {
-				if (die_on_error)
-					die("Too long path name: '%s/%s'",
-					    buf, last_elem);
-				else
-					goto error_out;
-			}
-			if (len && !is_dir_sep(buf[len - 1]))
-				buf[len++] = '/';
-			strcpy(buf + len, last_elem);
+			if (sb.len && !is_dir_sep(sb.buf[sb.len - 1]))
+				strbuf_addch(&sb, '/');
+			strbuf_addstr(&sb, last_elem);
 			free(last_elem);
 			last_elem = NULL;
 		}
 
-		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
-			ssize_t len = readlink(buf, next_buf, PATH_MAX);
+		if (!lstat(sb.buf, &st) && S_ISLNK(st.st_mode)) {
+			struct strbuf next_sb = STRBUF_INIT;
+			ssize_t len = strbuf_readlink(&next_sb, sb.buf, 0);
 			if (len < 0) {
 				if (die_on_error)
-					die_errno("Invalid symlink '%s'", buf);
-				else
-					goto error_out;
-			}
-			if (PATH_MAX <= len) {
-				if (die_on_error)
-					die("symbolic link too long: %s", buf);
+					die_errno("Invalid symlink '%s'",
+						  sb.buf);
 				else
 					goto error_out;
 			}
-			next_buf[len] = '\0';
-			buf = next_buf;
-			buf_index = 1 - buf_index;
-			next_buf = bufs[buf_index];
+			strbuf_swap(&sb, &next_sb);
+			strbuf_release(&next_sb);
 		} else
 			break;
 	}
 
-	retval = buf;
+	retval = sb.buf;
 error_out:
 	free(last_elem);
 	if (cwd.len && chdir(cwd.buf))
-- 
2.0.2
