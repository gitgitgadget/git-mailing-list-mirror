From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 1/4] Refactor skipping DOS drive prefixes
Date: Sun, 24 Jan 2016 13:36:04 +0100
Message-ID: <56A4C534.6040503@kdbg.org>
References: <cover.1452536924.git.johannes.schindelin@gmx.de>
 <cover.1452585382.git.johannes.schindelin@gmx.de>
 <05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
 <56A279DA.8080809@kdbg.org> <xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601230924090.2964@virtualbox> <56A3CE34.20808@kdbg.org>
 <alpine.DEB.2.20.1601241152060.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 13:36:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNJu0-0001IQ-VS
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 13:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbcAXMgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 07:36:10 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:24583 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbcAXMgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 07:36:08 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3ppDMV0Vyhz5tlD;
	Sun, 24 Jan 2016 13:36:06 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E2FCB51F8;
	Sun, 24 Jan 2016 13:36:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <alpine.DEB.2.20.1601241152060.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284647>

Am 24.01.2016 um 11:56 schrieb Johannes Schindelin:
> $ grep -w isalpha /mingw32/i686-w64-mingw32/include/*.h
> /mingw32/i686-w64-mingw32/include/ctype.h:  _CRTIMP int __cdecl isalpha(int _C);
> /mingw32/i686-w64-mingw32/include/ctype.h:#define __iscsymf(_c) (isalpha(_c) || ((_c)=='_'))
> 
> I guess that definition gets pulled in somehow.

Ok, then, Junio, kindly replace js/dirname-basename~4 with this patch.
(I hope I get the patch headers right for git-am.)

---- 8< ----
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Refactor skipping DOS drive prefixes

Junio noticed that there is an implicit assumption in pretty much
all the code calling has_dos_drive_prefix(): it forces all of its
callsites to hardcode the knowledge that the DOS drive prefix is
always two bytes long.

While this assumption is pretty safe, we can still make the code
more readable and less error-prone by introducing a function that
skips the DOS drive prefix safely.

While at it, we change the has_dos_drive_prefix() return value: it
now returns the number of bytes to be skipped if there is a DOS
drive prefix.

[j6t: moved definition of mingw_skip_dos_drive_prefix() out of line]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/basename.c |  4 +---
 compat/mingw.c    | 21 ++++++++++++---------
 compat/mingw.h    |  5 ++++-
 git-compat-util.h |  8 ++++++++
 path.c            | 14 +++++---------
 5 files changed, 30 insertions(+), 22 deletions(-)

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
index f74da23..0cebb61 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1915,28 +1915,31 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	return -1;
 }
 
+int mingw_skip_dos_drive_prefix(char **path)
+{
+	int ret = has_dos_drive_prefix(*path);
+	*path += ret;
+	return ret;
+}
+
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
index 738865c..2099b79 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -358,7 +358,10 @@ HANDLE winansi_get_osfhandle(int fd);
  * git specific compatibility
  */
 
-#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
+#define has_dos_drive_prefix(path) \
+	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
+int mingw_skip_dos_drive_prefix(char **path);
+#define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
 static inline char *mingw_find_last_dir_sep(const char *path)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 0feeae2..38397d7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -335,6 +335,14 @@ static inline int git_has_dos_drive_prefix(const char *path)
 #define has_dos_drive_prefix git_has_dos_drive_prefix
 #endif
 
+#ifndef skip_dos_drive_prefix
+static inline int git_skip_dos_drive_prefix(char **path)
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
index 38f2ebd..747d6da 100644
--- a/path.c
+++ b/path.c
@@ -544,13 +544,10 @@ const char *relative_path(const char *in, const char *prefix,
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
 
@@ -703,11 +700,10 @@ const char *remove_leading_path(const char *in, const char *prefix)
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
2.7.0.118.g90056ae
