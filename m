From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/4] Refactor skipping DOS drive prefixes
Date: Fri, 8 Jan 2016 17:21:11 +0100 (CET)
Message-ID: <c70ed05f275a44fbfae831b4cb67e59a0ce05724.1452270051.git.johannes.schindelin@gmx.de>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <cover.1452270051.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:21:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZn4-0006u2-Ea
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbcAHQVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:21:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:54090 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755838AbcAHQVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:21:18 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M4CB5-1Zywjz2GyB-00rqcx; Fri, 08 Jan 2016 17:21:12
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452270051.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gl5h4LgMO8s7MZMSdSmZ81iUEtyxG3Jjn/A3HStNyh7fn6/w+BG
 cZBXkUbsXnrg5dnZdxpLQ8fJFGcGDa6yD0YaM3FdDdnNs4ECdOPiWsYD7sZ9814OiJcT/h4
 1bRaYk5IRP7/INVGOFaO4fub8kwAiyiUoDQckM/ljPmRp8gP1IXcYNA8vUH13foShwxx4PB
 AogwfaRYScf9mz8sqfgZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SCamzmctqtI=:plgx89rMf5O1b5dzkNfMlZ
 Z0thi6e0rnc2yQ+G+qDjvcH8JqjmzfeJfCMJYX6QSJPGKPACNkadCZtTRO4zl5iH+BddnMAL6
 GpiuNrG81mIV4L8qDNLktrBzZ2yYcMaJu3lrjsZilSzeiSUw1KhOHMWOt7GW3qShbM7o2SI5o
 XW7bvLVCAFxgrZgKVwiS0AY9i+0FWtlqGhajZZHIY+lwwdG2tHHnFol+7jLBVJDRESur//UQ/
 qDFzvb6YH6cvx7lB87/i6DqwgtGkU6ZIxCES94mFYgvrk8/53uluWYmrNZRmTORi164mIyo0d
 oFv3nrwUAi58FNEbBjwBC6utuU68jwL7KKvXIW2hAQmRyYx7zBld9WFdSYKA8fbLZZPyhGbcd
 InYcdHQhXJWYUfWMWxN4bDj/gys7uG7usi7LLVdm8RUkP1EQVWUKDxNzeP3r5/63CCf9etHlg
 Y/NA1TQLq4leP4FHEmJ0CUHSCF+1Yw8PjlmfnYjqFzUAVDDkA7Ny8rNbDA9vL6px+cJ7gbyM9
 bMLWVpGrq4sfu4DZdwc41kDQ7+t6ma195nEkWRg5WLBJMZpGXJb0jQsHpjLpqPkskvLRHkzAY
 d9/TofACBUnhjZ+KvFtm3LUbxCqhMws0Rc4t9gjLmA/q6aDLf3O+GReSyVas2zmWvxb9gIJmg
 2+cVaHkMT1ymdaYlz/KG1aVtMxFOTTvZcw8tLqYxbu4jo4XzyVEhqhh6z530fSSfldQkmJCx1
 ORwDDsilDW9Nkt4H0b5c1zcVXh18Kc8jwBPUVVa3f+5hiW7h29DApAsyi1NqsAUvBYtMnFs1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283563>

Junio Hamano pointed out that there is an implicit assumption in pretty
much all the code calling has_dos_drive_prefix(): it assumes that the
DOS drive prefix is always two bytes long.

While this assumption is pretty safe, we can still make the code more
readable and less error-prone by introducing a function that skips the
DOS drive prefix safely.

While at it, we change the has_dos_drive_prefix() return value: it now
returns the number of bytes to be skipped if there is a DOS drive prefix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/basename.c |  4 +---
 compat/mingw.c    | 14 +++++---------
 compat/mingw.h    | 10 +++++++++-
 git-compat-util.h |  8 ++++++++
 path.c            | 14 +++++---------
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/compat/basename.c b/compat/basename.c
index d8f8a3c..9f00421 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -4,9 +4,7 @@
 char *gitbasename (char *path)
 {
 	const char *base;
-	/* Skip over the disk name in MSDOS pathnames. */
-	if (has_dos_drive_prefix(path))
-		path += 2;
+	skip_dos_drive_prefix(&path);
 	for (base = path; *path; path++) {
 		if (is_dir_sep(*path))
 			base = path + 1;
diff --git a/compat/mingw.c b/compat/mingw.c
index 5edea29..1b3530a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1934,26 +1934,22 @@ pid_t waitpid(pid_t pid, int *status, int options)
 
 int mingw_offset_1st_component(const char *path)
 {
-	int offset = 0;
-	if (has_dos_drive_prefix(path))
-		offset = 2;
+	char *pos = (char *)path;
 
 	/* unc paths */
-	else if (is_dir_sep(path[0]) && is_dir_sep(path[1])) {
-
+	if (!skip_dos_drive_prefix(&pos) &&
+			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
 		/* skip server name */
-		char *pos = strpbrk(path + 2, "\\/");
+		pos = strpbrk(pos + 2, "\\/");
 		if (!pos)
 			return 0; /* Error: malformed unc path */
 
 		do {
 			pos++;
 		} while (*pos && !is_dir_sep(*pos));
-
-		offset = pos - path;
 	}
 
-	return offset + is_dir_sep(path[offset]);
+	return pos + is_dir_sep(*pos) - path;
 }
 
 int xutftowcsn(wchar_t *wcs, const char *utfs, size_t wcslen, int utflen)
diff --git a/compat/mingw.h b/compat/mingw.h
index 57ca477..b3e5044 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -361,7 +361,15 @@ HANDLE winansi_get_osfhandle(int fd);
  * git specific compatibility
  */
 
-#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
+static inline int mingw_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+#define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 static inline char *mingw_find_last_dir_sep(const char *path)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 2da0a75..0d66f3a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -335,6 +335,14 @@ static inline int git_has_dos_drive_prefix(const char *path)
 #define has_dos_drive_prefix git_has_dos_drive_prefix
 #endif
 
+#ifndef skip_dos_drive_prefix
+static inline int git_skip_dos_drive_prefix(const char **path)
+{
+	return 0;
+}
+#define skip_dos_drive_prefix git_skip_dos_drive_prefix
+#endif
+
 #ifndef is_dir_sep
 static inline int git_is_dir_sep(int c)
 {
diff --git a/path.c b/path.c
index 3cd155e..8b7e168 100644
--- a/path.c
+++ b/path.c
@@ -782,13 +782,10 @@ const char *relative_path(const char *in, const char *prefix,
 	else if (!prefix_len)
 		return in;
 
-	if (have_same_root(in, prefix)) {
+	if (have_same_root(in, prefix))
 		/* bypass dos_drive, for "c:" is identical to "C:" */
-		if (has_dos_drive_prefix(in)) {
-			i = 2;
-			j = 2;
-		}
-	} else {
+		i = j = has_dos_drive_prefix(in);
+	else {
 		return in;
 	}
 
@@ -943,11 +940,10 @@ const char *remove_leading_path(const char *in, const char *prefix)
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
 {
 	char *dst0;
+	int i;
 
-	if (has_dos_drive_prefix(src)) {
+	for (i = has_dos_drive_prefix(src); i > 0; i--)
 		*dst++ = *src++;
-		*dst++ = *src++;
-	}
 	dst0 = dst;
 
 	if (is_dir_sep(*src)) {
-- 
2.6.3.windows.1.300.g1c25e49
