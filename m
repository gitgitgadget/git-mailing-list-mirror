From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH v2 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Sat, 02 Oct 2010 22:32:28 -0600
Message-ID: <20101003043228.1960.88989.stgit@SlamDunk>
References: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 06:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2GFk-0005hQ-5I
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 06:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239Ab0JCEca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 00:32:30 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49483 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0JCEca (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 00:32:30 -0400
Received: (qmail 1263 invoked by uid 399); 2 Oct 2010 22:32:26 -0600
Received: from unknown (HELO ?192.168.56.1?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Oct 2010 22:32:26 -0600
X-Originating-IP: 76.27.116.215
In-Reply-To: <20101003043221.1960.73178.stgit@SlamDunk>
User-Agent: StGit/0.15-60-g0641
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157822>

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
---
 dir.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dir.h |    4 ++++
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index d1e5e5e..ffa410d 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,68 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, in
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
+int fnmatch_casefold(const char *pattern, const char *string, int flags)
+{
+	char lowerPatternBuf[MAX_PATH];
+	char lowerStringBuf[MAX_PATH];
+	char* lowerPattern;
+	char* lowerString;
+	size_t patternLen;
+	size_t stringLen;
+	char* out;
+	int ret;
+
+	/*
+	 * Use the provided stack buffer, if possible.  If the string is too
+	 * large, allocate buffer space.
+	 */
+	patternLen = strlen(pattern);
+	if (patternLen + 1 > sizeof(lowerPatternBuf))
+		lowerPattern = xmalloc(patternLen + 1);
+	else
+		lowerPattern = lowerPatternBuf;
+
+	stringLen = strlen(string);
+	if (stringLen + 1 > sizeof(lowerStringBuf))
+		lowerString = xmalloc(stringLen + 1);
+	else
+		lowerString = lowerStringBuf;
+
+	/* Make the pattern and string lowercase to pass to fnmatch. */
+	for (out = lowerPattern; *pattern; ++out, ++pattern)
+		*out = tolower(*pattern);
+	*out = 0;
+
+	for (out = lowerString; *string; ++out, ++string)
+		*out = tolower(*string);
+	*out = 0;
+
+	ret = fnmatch(lowerPattern, lowerString, flags);
+
+	/* Free the pattern or string if it was allocated. */
+	if (lowerPattern != lowerPatternBuf)
+		free(lowerPattern);
+	if (lowerString != lowerStringBuf)
+		free(lowerString);
+	return ret;
+}
+
+int fnmatch_icase(const char *pattern, const char *string, int flags)
+{
+	return ignore_case ? fnmatch_casefold(pattern, string, flags) : fnmatch(pattern, string, flags);
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
