From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 09/10] abspath: convert absolute_path() to strbuf
Date: Mon, 28 Jul 2014 20:33:55 +0200
Message-ID: <53D69793.3010307@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpkT-0005eB-6n
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbaG1SeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:34:09 -0400
Received: from mout.web.de ([212.227.17.11]:60307 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbaG1SeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:34:07 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MZDP6-1WvPM818HM-00KvQh; Mon, 28 Jul 2014 20:33:56
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:BpuX4w6yep4DPIwAZPE0vltCIMbZr4B672z55mkyKJHp9ByZmvd
 jkwI8uSESZjbM6pSNbt1CsMCs14Xa/8UrcVXCkPF6VxXWFVYNzIbB+mpL4QHNjazOjUdU2o
 c15Hx1h5IW63xtjhDtkMC6TDvC0HT10EtF8+IkQzw7o8F7hKdLfM9YuXd8Hf7UWXVps8U5o
 2r2/3MBOfQNIZLj2jq4Hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254342>

Move most of the code of absolute_path() into the new function
strbuf_add_absolute_path() and in the process transform it to use
struct strbuf and xgetcwd() instead of a PATH_MAX-sized buffer,
which can be too small on some file systems.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-strbuf.txt |  6 +++++
 abspath.c                              | 46 +++-------------------------------
 strbuf.c                               | 25 ++++++++++++++++++
 strbuf.h                               |  2 ++
 4 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 49e477d..430302c 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -311,6 +311,12 @@ same behaviour as well.
 
 	Set the buffer to the path of the current working directory.
 
+`strbuf_add_absolute_path`
+
+	Add a path to a buffer, converting a relative path to an
+	absolute one in the process.  Symbolic links are not
+	resolved.
+
 `stripspace`::
 
 	Strip whitespace from a buffer. The second parameter controls if
diff --git a/abspath.c b/abspath.c
index 16e7fa2..197af68 100644
--- a/abspath.c
+++ b/abspath.c
@@ -140,54 +140,16 @@ const char *real_path_if_valid(const char *path)
 	return real_path_internal(path, 0);
 }
 
-static const char *get_pwd_cwd(void)
-{
-	static char cwd[PATH_MAX + 1];
-	char *pwd;
-	struct stat cwd_stat, pwd_stat;
-	if (getcwd(cwd, PATH_MAX) == NULL)
-		return NULL;
-	pwd = getenv("PWD");
-	if (pwd && strcmp(pwd, cwd)) {
-		stat(cwd, &cwd_stat);
-		if ((cwd_stat.st_dev || cwd_stat.st_ino) &&
-		    !stat(pwd, &pwd_stat) &&
-		    pwd_stat.st_dev == cwd_stat.st_dev &&
-		    pwd_stat.st_ino == cwd_stat.st_ino) {
-			strlcpy(cwd, pwd, PATH_MAX);
-		}
-	}
-	return cwd;
-}
-
 /*
  * Use this to get an absolute path from a relative one. If you want
  * to resolve links, you should use real_path.
- *
- * If the path is already absolute, then return path. As the user is
- * never meant to free the return value, we're safe.
  */
 const char *absolute_path(const char *path)
 {
-	static char buf[PATH_MAX + 1];
-
-	if (!*path) {
-		die("The empty string is not a valid path");
-	} else if (is_absolute_path(path)) {
-		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-			die("Too long path: %.*s", 60, path);
-	} else {
-		size_t len;
-		const char *fmt;
-		const char *cwd = get_pwd_cwd();
-		if (!cwd)
-			die_errno("Cannot determine the current working directory");
-		len = strlen(cwd);
-		fmt = (len > 0 && is_dir_sep(cwd[len - 1])) ? "%s%s" : "%s/%s";
-		if (snprintf(buf, PATH_MAX, fmt, cwd, path) >= PATH_MAX)
-			die("Too long path: %.*s", 60, path);
-	}
-	return buf;
+	static struct strbuf sb;
+	strbuf_init(&sb, 0);
+	strbuf_add_absolute_path(&sb, path);
+	return sb.buf;
 }
 
 /*
diff --git a/strbuf.c b/strbuf.c
index 2bf4dfa..4d31443 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -576,6 +576,31 @@ void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 	}
 }
 
+void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
+{
+	if (!*path)
+		die("The empty string is not a valid path");
+	if (!is_absolute_path(path)) {
+		struct stat cwd_stat, pwd_stat;
+		size_t orig_len = sb->len;
+		char *cwd = xgetcwd();
+		char *pwd = getenv("PWD");
+		if (pwd && strcmp(pwd, cwd) &&
+		    !stat(cwd, &cwd_stat) &&
+		    (cwd_stat.st_dev || cwd_stat.st_ino) &&
+		    !stat(pwd, &pwd_stat) &&
+		    pwd_stat.st_dev == cwd_stat.st_dev &&
+		    pwd_stat.st_ino == cwd_stat.st_ino)
+			strbuf_addstr(sb, pwd);
+		else
+			strbuf_addstr(sb, cwd);
+		if (sb->len > orig_len && !is_dir_sep(sb->buf[sb->len - 1]))
+			strbuf_addch(sb, '/');
+		free(cwd);
+	}
+	strbuf_addstr(sb, path);
+}
+
 int printf_ln(const char *fmt, ...)
 {
 	int ret;
diff --git a/strbuf.h b/strbuf.h
index bc38bb9..7bdc1da 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -190,6 +190,8 @@ extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
 				    int reserved);
 extern void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes);
 
+extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
+
 __attribute__((format (printf,1,2)))
 extern int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
-- 
2.0.2
