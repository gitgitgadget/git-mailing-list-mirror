From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/5] Move sanitary_path_copy() to path.c and rename it to normalize_path_copy()
Date: Sat,  7 Feb 2009 16:08:28 +0100
Message-ID: <1234019311-6449-3-git-send-email-j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx>
 <1234019311-6449-1-git-send-email-j6t@kdbg.org>
 <1234019311-6449-2-git-send-email-j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Feb 07 16:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVovX-0006PA-OP
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbZBGPPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbZBGPPi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:15:38 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:39629 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZBGPPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:15:33 -0500
Received: from localhost.localdomain (unknown [93.83.142.38])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 79BB610A73B;
	Sat,  7 Feb 2009 16:08:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.297.g9b01e
In-Reply-To: <1234019311-6449-2-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108859>

This function and normalize_absolute_path() do almost the same thing. The
former already works on Windows, but the latter crashes.

In subsequent changes we will remove normalize_absolute_path(). Here we
make the replacement function reusable. On the way we rename it to reflect
that it does some path normalization. Apart from that this is only moving
around code.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 cache.h |    1 +
 path.c  |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 setup.c |   88 +--------------------------------------------------------------
 3 files changed, 88 insertions(+), 87 deletions(-)

diff --git a/cache.h b/cache.h
index 2d889de..82fbb80 100644
--- a/cache.h
+++ b/cache.h
@@ -628,6 +628,7 @@ const char *make_absolute_path(const char *path);
 const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
 int normalize_absolute_path(char *buf, const char *path);
+int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
diff --git a/path.c b/path.c
index 108d9e9..d0a3519 100644
--- a/path.c
+++ b/path.c
@@ -415,6 +415,92 @@ int normalize_absolute_path(char *buf, const char *path)
 	return dst - buf;
 }
 
+int normalize_path_copy(char *dst, const char *src)
+{
+	char *dst0;
+
+	if (has_dos_drive_prefix(src)) {
+		*dst++ = *src++;
+		*dst++ = *src++;
+	}
+	dst0 = dst;
+
+	if (is_dir_sep(*src)) {
+		*dst++ = '/';
+		while (is_dir_sep(*src))
+			src++;
+	}
+
+	for (;;) {
+		char c = *src;
+
+		/*
+		 * A path component that begins with . could be
+		 * special:
+		 * (1) "." and ends   -- ignore and terminate.
+		 * (2) "./"           -- ignore them, eat slash and continue.
+		 * (3) ".." and ends  -- strip one and terminate.
+		 * (4) "../"          -- strip one, eat slash and continue.
+		 */
+		if (c == '.') {
+			if (!src[1]) {
+				/* (1) */
+				src++;
+			} else if (is_dir_sep(src[1])) {
+				/* (2) */
+				src += 2;
+				while (is_dir_sep(*src))
+					src++;
+				continue;
+			} else if (src[1] == '.') {
+				if (!src[2]) {
+					/* (3) */
+					src += 2;
+					goto up_one;
+				} else if (is_dir_sep(src[2])) {
+					/* (4) */
+					src += 3;
+					while (is_dir_sep(*src))
+						src++;
+					goto up_one;
+				}
+			}
+		}
+
+		/* copy up to the next '/', and eat all '/' */
+		while ((c = *src++) != '\0' && !is_dir_sep(c))
+			*dst++ = c;
+		if (is_dir_sep(c)) {
+			*dst++ = '/';
+			while (is_dir_sep(c))
+				c = *src++;
+			src--;
+		} else if (!c)
+			break;
+		continue;
+
+	up_one:
+		/*
+		 * dst0..dst is prefix portion, and dst[-1] is '/';
+		 * go up one level.
+		 */
+		dst -= 2; /* go past trailing '/' if any */
+		if (dst < dst0)
+			return -1;
+		while (1) {
+			if (dst <= dst0)
+				break;
+			c = *dst--;
+			if (c == '/') {	/* MinGW: cannot be '\\' anymore */
+				dst += 2;
+				break;
+			}
+		}
+	}
+	*dst = '\0';
+	return 0;
+}
+
 /*
  * path = Canonical absolute path
  * prefix_list = Colon-separated list of absolute paths
diff --git a/setup.c b/setup.c
index dfda532..6c2deda 100644
--- a/setup.c
+++ b/setup.c
@@ -4,92 +4,6 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-static int sanitary_path_copy(char *dst, const char *src)
-{
-	char *dst0;
-
-	if (has_dos_drive_prefix(src)) {
-		*dst++ = *src++;
-		*dst++ = *src++;
-	}
-	dst0 = dst;
-
-	if (is_dir_sep(*src)) {
-		*dst++ = '/';
-		while (is_dir_sep(*src))
-			src++;
-	}
-
-	for (;;) {
-		char c = *src;
-
-		/*
-		 * A path component that begins with . could be
-		 * special:
-		 * (1) "." and ends   -- ignore and terminate.
-		 * (2) "./"           -- ignore them, eat slash and continue.
-		 * (3) ".." and ends  -- strip one and terminate.
-		 * (4) "../"          -- strip one, eat slash and continue.
-		 */
-		if (c == '.') {
-			if (!src[1]) {
-				/* (1) */
-				src++;
-			} else if (is_dir_sep(src[1])) {
-				/* (2) */
-				src += 2;
-				while (is_dir_sep(*src))
-					src++;
-				continue;
-			} else if (src[1] == '.') {
-				if (!src[2]) {
-					/* (3) */
-					src += 2;
-					goto up_one;
-				} else if (is_dir_sep(src[2])) {
-					/* (4) */
-					src += 3;
-					while (is_dir_sep(*src))
-						src++;
-					goto up_one;
-				}
-			}
-		}
-
-		/* copy up to the next '/', and eat all '/' */
-		while ((c = *src++) != '\0' && !is_dir_sep(c))
-			*dst++ = c;
-		if (is_dir_sep(c)) {
-			*dst++ = '/';
-			while (is_dir_sep(c))
-				c = *src++;
-			src--;
-		} else if (!c)
-			break;
-		continue;
-
-	up_one:
-		/*
-		 * dst0..dst is prefix portion, and dst[-1] is '/';
-		 * go up one level.
-		 */
-		dst -= 2; /* go past trailing '/' if any */
-		if (dst < dst0)
-			return -1;
-		while (1) {
-			if (dst <= dst0)
-				break;
-			c = *dst--;
-			if (c == '/') {	/* MinGW: cannot be '\\' anymore */
-				dst += 2;
-				break;
-			}
-		}
-	}
-	*dst = '\0';
-	return 0;
-}
-
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
@@ -101,7 +15,7 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 			memcpy(sanitized, prefix, len);
 		strcpy(sanitized + len, path);
 	}
-	if (sanitary_path_copy(sanitized, sanitized))
+	if (normalize_path_copy(sanitized, sanitized))
 		goto error_out;
 	if (is_absolute_path(orig)) {
 		const char *work_tree = get_git_work_tree();
-- 
1.6.1.297.g9b01e
