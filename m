From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/5] Remove unused normalize_absolute_path()
Date: Sat,  7 Feb 2009 16:08:31 +0100
Message-ID: <1234019311-6449-6-git-send-email-j6t@kdbg.org>
References: <498CAF73.6050409@lsrfire.ath.cx>
 <1234019311-6449-1-git-send-email-j6t@kdbg.org>
 <1234019311-6449-2-git-send-email-j6t@kdbg.org>
 <1234019311-6449-3-git-send-email-j6t@kdbg.org>
 <1234019311-6449-4-git-send-email-j6t@kdbg.org>
 <1234019311-6449-5-git-send-email-j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: rene.scharfe@lsrfire.ath.cx
X-From: git-owner@vger.kernel.org Sat Feb 07 16:17:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVow1-0006Xl-QN
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbZBGPPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbZBGPPm
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:15:42 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:39663 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZBGPPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:15:34 -0500
Received: from localhost.localdomain (unknown [93.83.142.38])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 1AD0610A7DB;
	Sat,  7 Feb 2009 16:08:33 +0100 (CET)
X-Mailer: git-send-email 1.6.1.297.g9b01e
In-Reply-To: <1234019311-6449-5-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108861>

This function is now superseded by normalize_path_copy().

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 cache.h |    1 -
 path.c  |   51 ++++++---------------------------------------------
 2 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/cache.h b/cache.h
index 82fbb80..8dcc53c 100644
--- a/cache.h
+++ b/cache.h
@@ -627,7 +627,6 @@ int is_directory(const char *);
 const char *make_absolute_path(const char *path);
 const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
-int normalize_absolute_path(char *buf, const char *path);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list);
 
diff --git a/path.c b/path.c
index 16628b2..dd22370 100644
--- a/path.c
+++ b/path.c
@@ -363,58 +363,19 @@ const char *make_relative_path(const char *abs, const char *base)
 }
 
 /*
- * path = absolute path
- * buf = buffer of at least max(2, strlen(path)+1) bytes
- * It is okay if buf == path, but they should not overlap otherwise.
+ * It is okay if dst == src, but they should not overlap otherwise.
  *
- * Performs the following normalizations on path, storing the result in buf:
- * - Removes trailing slashes.
- * - Removes empty components.
+ * Performs the following normalizations on src, storing the result in dst:
+ * - Ensures that components are separated by '/' (Windows only)
+ * - Squashes sequences of '/'.
  * - Removes "." components.
  * - Removes ".." components, and the components the precede them.
- * "" and paths that contain only slashes are normalized to "/".
- * Returns the length of the output.
+ * Returns failure (non-zero) if a ".." component appears as first path
+ * component anytime during the normalization. Otherwise, returns success (0).
  *
  * Note that this function is purely textual.  It does not follow symlinks,
  * verify the existence of the path, or make any system calls.
  */
-int normalize_absolute_path(char *buf, const char *path)
-{
-	const char *comp_start = path, *comp_end = path;
-	char *dst = buf;
-	int comp_len;
-	assert(buf);
-	assert(path);
-
-	while (*comp_start) {
-		assert(*comp_start == '/');
-		while (*++comp_end && *comp_end != '/')
-			; /* nothing */
-		comp_len = comp_end - comp_start;
-
-		if (!strncmp("/",  comp_start, comp_len) ||
-		    !strncmp("/.", comp_start, comp_len))
-			goto next;
-
-		if (!strncmp("/..", comp_start, comp_len)) {
-			while (dst > buf && *--dst != '/')
-				; /* nothing */
-			goto next;
-		}
-
-		memmove(dst, comp_start, comp_len);
-		dst += comp_len;
-	next:
-		comp_start = comp_end;
-	}
-
-	if (dst == buf)
-		*dst++ = '/';
-
-	*dst = '\0';
-	return dst - buf;
-}
-
 int normalize_path_copy(char *dst, const char *src)
 {
 	char *dst0;
-- 
1.6.1.297.g9b01e
