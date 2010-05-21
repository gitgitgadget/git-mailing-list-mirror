From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 1/7] Add string comparison functions that respect the ignore_case variable.
Date: Thu, 20 May 2010 22:50:29 -0600
Message-ID: <1274417435-2344-2-git-send-email-jjensen@workspacewhiz.com>
References: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:50:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCC-0007X7-Rx
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0EUEur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:50:47 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39241 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab0EUEup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:45 -0400
Received: (qmail 28852 invoked by uid 399); 20 May 2010 22:50:44 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE
	autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:43 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAMM; 20 May 2010 22:50:43 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
In-Reply-To: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147433>

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
 dir.c |   35 +++++++++++++++++++++++++++++++++++
 dir.h |    5 +++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index cb83332..21d2104 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,41 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, in
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
+int memcmp_icase(const char *a, const char *b, size_t count)
+{
+	if (ignore_case) {
+		int lowera = 0;
+		int lowerb = 0;
+		while (--count) {
+			lowera = tolower(*a++);
+			lowerb = tolower(*b++);
+			if (lowera != lowerb)
+				break;
+		}
+		return lowera - lowerb;
+
+		return 0;
+	} else {
+		return memcmp(a, b, count);
+	}
+}
+
 static int common_prefix(const char **pathspec)
 {
 	const char *path, *slash, *next;
diff --git a/dir.h b/dir.h
index 3bead5f..aced818 100644
--- a/dir.h
+++ b/dir.h
@@ -100,4 +100,9 @@ extern int remove_dir_recursively(struct strbuf *path, int flag);
 /* tries to remove the path with empty directories along it, ignores ENOENT */
 extern int remove_path(const char *path);
 
+extern int strcmp_icase(const char *a, const char *b);
+extern int strncmp_icase(const char *a, const char *b, size_t count);
+extern int fnmatch_icase(const char *pattern, const char *string, int flags);
+extern int memcmp_icase(const char *a, const char *b, size_t count);
+
 #endif
-- 
1.7.1.1930.gca7dd4
