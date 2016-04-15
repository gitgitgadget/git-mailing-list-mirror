From: Michael Weiser <michael.weiser@gmx.de>
Subject: [PATCH] Extend runtime prefix computation
Date: Fri, 15 Apr 2016 16:30:01 +0200
Message-ID: <20160415143001.GA67437@dinsnail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Abdurachmanov <David.Abdurachmanov@cern.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:00:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar5EJ-0007SL-J5
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 17:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbcDOPAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 11:00:12 -0400
Received: from heinz.dinsnail.net ([85.214.155.104]:32794 "EHLO
	heinz.dinsnail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcDOPAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 11:00:11 -0400
X-Greylist: delayed 1777 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Apr 2016 11:00:11 EDT
Received: from localhost (b2b-5-10-190-98.unitymedia.biz [5.10.190.98])
	by heinz.dinsnail.net (8.14.9/8.14.9) with ESMTP id u3FEU9Ow028136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Apr 2016 16:30:09 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-dinsnail.net-MailScanner-ID: u3FEU9Ow028136
X-MailScanner: Found to be clean
X-MailScanner-SpamScore: sss
X-MailScanner-From: michael@dinsnail.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291607>

Make git fully relocatable at runtime extending the runtime prefix
calculation. Handle absolute and relative paths in argv0. Handle no path
at all in argv0 in a system-specific manner.  Replace assertions with
initialised variables and checks that lead to fallback to the static
prefix.
---

Notes:
    Tested-by: David Abdurachmanov <David.Abdurachmanov@cern.ch>
    Pull-Request: https://github.com/git/git/pull/224

 exec_cmd.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 9d5703a..f0db070 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -3,30 +3,27 @@
 #include "quote.h"
 #include "argv-array.h"
 #define MAX_ARGS	32
+#if defined(__APPLE__)
+#include <mach-o/dyld.h>
+#endif
 
 static const char *argv_exec_path;
 static const char *argv0_path;
 
 char *system_path(const char *path)
 {
-#ifdef RUNTIME_PREFIX
-	static const char *prefix;
-#else
 	static const char *prefix = PREFIX;
-#endif
 	struct strbuf d = STRBUF_INIT;
 
 	if (is_absolute_path(path))
 		return xstrdup(path);
 
 #ifdef RUNTIME_PREFIX
-	assert(argv0_path);
-	assert(is_absolute_path(argv0_path));
-
-	if (!prefix &&
-	    !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
-	    !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
-	    !(prefix = strip_path_suffix(argv0_path, "git"))) {
+	if (!argv0_path ||
+	    !is_absolute_path(argv0_path) ||
+	    (!(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
+	     !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
+	     !(prefix = strip_path_suffix(argv0_path, "git")))) {
 		prefix = PREFIX;
 		trace_printf("RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
@@ -41,6 +38,8 @@ char *system_path(const char *path)
 const char *git_extract_argv0_path(const char *argv0)
 {
 	const char *slash;
+	char *to_resolve = NULL;
+	const char *resolved;
 
 	if (!argv0 || !*argv0)
 		return NULL;
@@ -48,11 +47,56 @@ const char *git_extract_argv0_path(const char *argv0)
 	slash = find_last_dir_sep(argv0);
 
 	if (slash) {
-		argv0_path = xstrndup(argv0, slash - argv0);
-		return slash + 1;
+		/* ... it's either an absolute path */
+		if (is_absolute_path(argv0)) {
+			argv0_path = xstrndup(argv0, slash - argv0);
+			return slash + 1;
+		}
+
+		/* ... or a relative path, in which case we have to make it
+		 * absolute first and do the whole thing again */
+		to_resolve = xstrdup(argv0);
+	} else {
+		/* argv0 is no path at all, just a name. Resolve it into a
+		 * path. Unfortunately, this gets system specific. */
+#if defined(__linux__)
+		struct stat st;
+		if (!stat("/proc/self/exe", &st))
+			to_resolve = xstrdup("/proc/self/exe");
+#elif defined(__APPLE__)
+		/* call with len == 0 queries the necessary buffer size */
+		uint32_t len = 0;
+		if(_NSGetExecutablePath(NULL, &len) != 0) {
+			to_resolve = malloc(len);
+			if (to_resolve) {
+				/* get the executable path now we have a buffer
+				 * of proper size */
+				if(_NSGetExecutablePath(to_resolve, &len) != 0) {
+					free(to_resolve);
+					return argv0;
+				}
+			}
+		}
+#endif
+
+		/* if to_resolve is still NULL here, something failed above or
+		 * we are on an unsupported system. system_path() will warn
+		 * and fall back to the static prefix */
+		if (!to_resolve)
+			return argv0;
 	}
 
-	return argv0;
+	/* resolve path from absolute to canonical */
+	resolved = real_path(to_resolve);
+	free(to_resolve);
+
+	slash = find_last_dir_sep(resolved);
+	if (!slash)
+		return argv0;
+
+	argv0_path = xstrndup(resolved, slash - resolved);
+	slash = xstrdup(slash + 1);
+	return slash;
 }
 
 void git_set_argv_exec_path(const char *exec_path)
-- 
2.6.4 (Apple Git-63)
