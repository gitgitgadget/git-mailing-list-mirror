From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/6] Add string comparison functions that respect the ignore_case variable.
Date: Mon, 16 Aug 2010 21:38:09 +0200
Message-ID: <513deaf9e8915473f7fc7f32401b17e383cb7d3a.1281985411.git.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 21:39:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol5Wn-0007Pw-Ee
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab0HPTid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:38:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59071 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164Ab0HPTic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:38:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 25EC12C400B;
	Mon, 16 Aug 2010 21:38:29 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6B6B019F7CC;
	Mon, 16 Aug 2010 21:38:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.402.gf1eeb
In-Reply-To: <cover.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153669>

From: Joshua Jensen <jjensen@workspacewhiz.com>

Multiple locations within this patch series alter a case sensitive
string comparison call such as strcmp() to be a call to a string
comparison call that selects case comparison based on the global
ignore_case variable. Behaviorally, when core.ignorecase=false, the
*_icase() versions are functionally equivalent to their C runtime
counterparts.  When core.ignorecase=true, the *_icase() versions perform
a case insensitive comparison.

Like Linus' earlier ignorecase patch, these may ignore filename
conventions on certain file systems. By isolating filename comparisons
to certain functions, support for those filename conventions may be more
easily met.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 dir.c |   16 ++++++++++++++++
 dir.h |    4 ++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 133f472..4d001fd 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,22 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, in
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
+/* helper string functions with support for the ignore_case flag */
+int strcmp_icase(const char *a, const char *b)
+{
+	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
+}
+
+int strncmp_icase(const char *a, const char *b, size_t count)
+{
+	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
+}
+
+int fnmatch_icase(const char *pattern, const char *string, int flags)
+{
+	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD : 0));
+}
+
 static int common_prefix(const char **pathspec)
 {
 	const char *path, *slash, *next;
diff --git a/dir.h b/dir.h
index 278d84c..b3e2104 100644
--- a/dir.h
+++ b/dir.h
@@ -101,4 +101,8 @@ extern int remove_dir_recursively(struct strbuf *path, int flag);
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
 
+extern int strcmp_icase(const char *a, const char *b);
+extern int strncmp_icase(const char *a, const char *b, size_t count);
+extern int fnmatch_icase(const char *pattern, const char *string, int flags);
+
 #endif
-- 
1.7.1.402.gf1eeb
