From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 1/4] Refactor skipping DOS drive prefixes
Date: Tue, 12 Jan 2016 08:57:22 +0100 (CET)
Message-ID: <05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 08:57:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItpl-0000gB-7p
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 08:57:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761764AbcALH5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 02:57:36 -0500
Received: from mout.gmx.net ([212.227.15.18]:55959 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761592AbcALH5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 02:57:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MEFlg-1aPSKy2sh6-00FSuC; Tue, 12 Jan 2016 08:57:24
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452585382.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mymqr2ENjYR3N19ERjQHWYZEUIdLRLSSt1NTl9iOPplhnRxZG2I
 4z76/cw0QTTxvBrWzvkdz9ScxabmQZqEXxG95Iii1FN3YxLd9bPdDiD0WhgTqhyfQjy2Ftj
 rAjcf1pNS5uqQmKXpDZdVRD904LSRICt3ZhVQBy2Nb3c+6GT1ue1qIvehFqx3YNNwj0gRia
 2pw08kHeR5IIsKaE3ljfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yrXiyrKF07U=:zLxrXkATB31pRh070H3EcM
 cpg3WOCeb8RuVWMokL9zgqodXUkgk4c/EuBYfTofOKzDH7sBhARcGAd4/RLiADpype2aywNPa
 1QtbcE4z9TaI5OUhsCCkpWLbbFIeFP1d4n7vvOQtPYobTtUBdj2LLQn95e5O4to8I2yuaI5ol
 T3Ay2Pc4GD/QKEKanSQSWUN17QRZrerAl+QVF5cnnxoS4dYTFNW/N9cBGJO6vOm7KdTeBr50R
 aXs6oZYwIcRGDw5R9yMPYWtWBDHwc6mWTO4Nr8Ac1h9o0lk0NWvZNuT+SLLI9eY7M2Xu3cxk4
 QlLF3ptLU0ItPoGeSsjJFPbcGPdSgqRZPqZ46GvbFJ15I7L0hgV84qJPS27T8O1l/U2pGySkf
 95SF428o3qlLU3d6hCg6hnnmUPnTh++yAfijJyLR7xTDbcOD9iL8jKPiPA7Np0nVuxYmKiXtQ
 F15mQf0iNR/diYEHEracqYsIkZ5+FSq84hv+Ocd6Z/3yBlzCAMtl//9NU/j130ZhbILi7aBpf
 /HUozPioF+lUQPNGAbzNzK1gFcMh0AKM9qzXiKMUKziG4xlan+DMlT0pkILzJXBpz29NybKDB
 bG33pZHej3qYJf3aY1824x9ZgwchuZTceJ1ffgDQNFWailA2C2j+AY7VLs1l1SgPVu7JOXqHj
 Q5A4Fy5dakUHaXsA/kEKszk98gqiTpdUQWYnHHvSZjNLf1iFqNRSfe1Q4Eoe8SXb7aX8/sjhz
 AEEljFqptRTUxu+i+uQ5TnUvrDHnoFfRtBAPr5fM6+g00fUOjDL9HI4ABi6imZl4BVmGGjTD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283771>

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
index 2da0a75..fbb11bb 100644
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
