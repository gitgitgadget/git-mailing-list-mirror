From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/4] Refactor skipping DOS drive prefixes
Date: Mon, 11 Jan 2016 19:29:47 +0100 (CET)
Message-ID: <c70ed05f275a44fbfae831b4cb67e59a0ce05724.1452536924.git.johannes.schindelin@gmx.de>
References: <cover.1452270051.git.johannes.schindelin@gmx.de> <cover.1452536924.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:30:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIhEB-0007zk-Nd
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933261AbcAKS37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:29:59 -0500
Received: from mout.gmx.net ([212.227.17.21]:63850 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933244AbcAKS35 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:29:57 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M8JyQ-1ZvvTT2mH4-00vxJ5; Mon, 11 Jan 2016 19:29:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452536924.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:YVyBK/dcfgG1q2meLJgWek2ptetGOv/dSOw//oDpo4zUdnen1hr
 L0zd3t9gTa1wKg+xaQ51W/k07YOFvvPCQrwcidM/jmCA8L5rUqOmIE7yGnI5nyT8wRTxgf+
 ZgxsCFc3AReZ2YI11XO0S3VpW/iBln+plghlD00RkNkM2cUFCd8uL2nfu29bQnRdZ5+zjRi
 hcy1p7A8Ny2xIrfkO4SYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1oIz63/CpRs=:0xMVh7QCYr9NNtx8s+NctE
 rmDNyngpkf641D+agPBy9QPIphPRQdrmbwQnhWbzDl+R0+Lr/c2wslLeBAPsKM63MNFu3Odq/
 +IZNHhf4jzSUZtqTZlqMyDhaL7Ks8OMqalzYdIgguTMu24RSck54mJd4s5/mCoL03Va4QRs2K
 x1hYrRMCe3KUsxwGXu3iNsImb8oXWBxTzPH7lnZAheMlXQhsclZLWQd7+LeT9dwtTBCmIXnnH
 B9nFCxXwNUnnkNfcxwA6pIXuuRVGH/kY/R4FhWHhXdZLyxpMvQ9j6mt+SFvyn4/szGJVQNrIK
 jEXy0HWmrV6iz3y6CD2YHhA4hQvsWL3lvOpG1JSNv11piExjLU1q04SVh+WtKWx87chCZaa6b
 jjAIe0JK4VG71QoQsAjT1c+fQ5lQL+PJihfs9rkKgeBquRb6DnzfBeNVgIUwl0htn6wB+vPg5
 gnZPPgj4phL3ohUx0CwjnZPu2MiurUDwK637hAKzzD3Ew4CCpNfl6h0qwa463Ffdkrpx9MLVB
 rE7WKbOaN76wOmcyZf47wpwJZFdGdwaQC9CZ0n2HIH1338Q1wyWIchJ64soJQY+1Op5CCGJoN
 dmxAAquMhSrCu8LU8oNQD4xQkWWMnd6fU0IWr5984jJBu+oK5zxeP5Golla/m1qB7yytjqxLZ
 auWR1/0jAs0IgmPtvam9zEUb/vzj7MFPYlQctsffmi0ZbMEBq28T2ygDUuWv7a6nC+pnwzHeH
 PIF66nJuz0udk+sbWwTTMqRRJGzmkU/Z3IPeLibVGMiVY5Vn9Fq9ZdGcF4mFZKxcgGos32o3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283690>

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
