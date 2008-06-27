From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] shrink git-shell by avoiding redundant dependencies
Date: Sat, 28 Jun 2008 01:35:38 +0400
Message-ID: <1214602538-7888-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:36:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCLcZ-0008Pi-Bw
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 23:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763910AbYF0Vfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 17:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763919AbYF0Vfq
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 17:35:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:51834 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763885AbYF0Vfo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 17:35:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so325134fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=V5h0Q/vbaaxMTahJqWX/WZ7FZMd7m8yVsxwujLq5GYY=;
        b=IE1VTb2UNqlfqmfcDK6FUuMeQx0FBk162n7ciUaHnhLrCCVSy/bBIDPCjIuG5r0Z4D
         OXlB+j/J1vQfWEa8OR5gB2vdcNhzRtFreFQTcyU2EGATzn/C+gjycHU0gQdBAERh56VH
         aJKL747LbMcdDX5hxvJiBZ6baNku+Ne0nyao8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CpImK8wx5zA4wsMqCvBvOWN9ae9ZnCn8ycabiNUlc3u3xK/UrC0PtByhPZFNBgCtl7
         HsVqMFCj6dTkQj2j8RmOaOSw1lnXHSl+YvWYxcecrMony33ehICB4vQHOvqdlkAYm+Nn
         u7gIfYEnms8a/IyzkmKa+iptFSUsEm+xJG6Wo=
Received: by 10.86.72.3 with SMTP id u3mr2494423fga.35.1214602542270;
        Fri, 27 Jun 2008 14:35:42 -0700 (PDT)
Received: from localhost ( [85.140.169.188])
        by mx.google.com with ESMTPS id e20sm3702957fga.1.2008.06.27.14.35.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 14:35:41 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86636>

A lot of modules that have nothing to do with git-shell functionality
were linked in, bloating git-shell more than 8 times.

This patch cuts off redundant dependencies by:
1. providing stubs for three functions that make no sense for git-shell;
2. moving quote_path_fully from environment.c to quote.c to make the
   later self sufficient;
3. moving make_absolute_path into a new separate file.

The following numbers have been received with the default optimization
settings on master using GCC 4.1.2:

Before:
   text    data     bss     dec     hex filename
 143915    1348   93168  238431   3a35f git-shell

After:
   text    data     bss     dec     hex filename
  17670     788    8232   26690    6842 git-shell
---
 Makefile      |    1 +
 abspath.c     |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 environment.c |    1 -
 path.c        |   67 -----------------------------------------------
 quote.c       |    2 +
 shell.c       |    8 +++++
 6 files changed, 91 insertions(+), 68 deletions(-)
 create mode 100644 abspath.c

diff --git a/Makefile b/Makefile
index 3584b8c..bf77292 100644
--- a/Makefile
+++ b/Makefile
@@ -378,6 +378,7 @@ LIB_H += unpack-trees.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
 
+LIB_OBJS += abspath.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
 LIB_OBJS += archive.o
diff --git a/abspath.c b/abspath.c
new file mode 100644
index 0000000..4becedf
--- /dev/null
+++ b/abspath.c
@@ -0,0 +1,80 @@
+/*
+ * I'm tired of doing "vsnprintf()" etc just to open a
+ * file, so here's a "return static buffer with printf"
+ * interface for paths.
+ *
+ * It's obviously not thread-safe. Sue me. But it's quite
+ * useful for doing things like
+ *
+ *   f = open(mkpath("%s/%s.git", base, name), O_RDONLY);
+ *
+ * which is what it's designed for.
+ */
+#include "cache.h"
+
+/* We allow "recursive" symbolic links. Only within reason, though. */
+#define MAXDEPTH 5
+
+const char *make_absolute_path(const char *path)
+{
+	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
+	char cwd[1024] = "";
+	int buf_index = 1, len;
+
+	int depth = MAXDEPTH;
+	char *last_elem = NULL;
+	struct stat st;
+
+	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+		die ("Too long path: %.*s", 60, path);
+
+	while (depth--) {
+		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
+			char *last_slash = strrchr(buf, '/');
+			if (last_slash) {
+				*last_slash = '\0';
+				last_elem = xstrdup(last_slash + 1);
+			} else {
+				last_elem = xstrdup(buf);
+				*buf = '\0';
+			}
+		}
+
+		if (*buf) {
+			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
+				die ("Could not get current working directory");
+
+			if (chdir(buf))
+				die ("Could not switch to '%s'", buf);
+		}
+		if (!getcwd(buf, PATH_MAX))
+			die ("Could not get current working directory");
+
+		if (last_elem) {
+			int len = strlen(buf);
+			if (len + strlen(last_elem) + 2 > PATH_MAX)
+				die ("Too long path name: '%s/%s'",
+						buf, last_elem);
+			buf[len] = '/';
+			strcpy(buf + len + 1, last_elem);
+			free(last_elem);
+			last_elem = NULL;
+		}
+
+		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
+			len = readlink(buf, next_buf, PATH_MAX);
+			if (len < 0)
+				die ("Invalid symlink: %s", buf);
+			next_buf[len] = '\0';
+			buf = next_buf;
+			buf_index = 1 - buf_index;
+			next_buf = bufs[buf_index];
+		} else
+			break;
+	}
+
+	if (*cwd && chdir(cwd))
+		die ("Could not change back to '%s'", cwd);
+
+	return buf;
+}
diff --git a/environment.c b/environment.c
index 084ac8a..4a88a17 100644
--- a/environment.c
+++ b/environment.c
@@ -13,7 +13,6 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
-int quote_path_fully = 1;
 int has_symlinks = 1;
 int ignore_case;
 int assume_unchanged;
diff --git a/path.c b/path.c
index 6e3df18..496123c 100644
--- a/path.c
+++ b/path.c
@@ -327,9 +327,6 @@ const char *make_nonrelative_path(const char *path)
 	return buf;
 }
 
-/* We allow "recursive" symbolic links. Only within reason, though. */
-#define MAXDEPTH 5
-
 const char *make_relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
@@ -346,67 +343,3 @@ const char *make_relative_path(const char *abs, const char *base)
 	strcpy(buf, abs + baselen);
 	return buf;
 }
-
-const char *make_absolute_path(const char *path)
-{
-	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
-	char cwd[1024] = "";
-	int buf_index = 1, len;
-
-	int depth = MAXDEPTH;
-	char *last_elem = NULL;
-	struct stat st;
-
-	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-		die ("Too long path: %.*s", 60, path);
-
-	while (depth--) {
-		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
-			char *last_slash = strrchr(buf, '/');
-			if (last_slash) {
-				*last_slash = '\0';
-				last_elem = xstrdup(last_slash + 1);
-			} else {
-				last_elem = xstrdup(buf);
-				*buf = '\0';
-			}
-		}
-
-		if (*buf) {
-			if (!*cwd && !getcwd(cwd, sizeof(cwd)))
-				die ("Could not get current working directory");
-
-			if (chdir(buf))
-				die ("Could not switch to '%s'", buf);
-		}
-		if (!getcwd(buf, PATH_MAX))
-			die ("Could not get current working directory");
-
-		if (last_elem) {
-			int len = strlen(buf);
-			if (len + strlen(last_elem) + 2 > PATH_MAX)
-				die ("Too long path name: '%s/%s'",
-						buf, last_elem);
-			buf[len] = '/';
-			strcpy(buf + len + 1, last_elem);
-			free(last_elem);
-			last_elem = NULL;
-		}
-
-		if (!lstat(buf, &st) && S_ISLNK(st.st_mode)) {
-			len = readlink(buf, next_buf, PATH_MAX);
-			if (len < 0)
-				die ("Invalid symlink: %s", buf);
-			next_buf[len] = '\0';
-			buf = next_buf;
-			buf_index = 1 - buf_index;
-			next_buf = bufs[buf_index];
-		} else
-			break;
-	}
-
-	if (*cwd && chdir(cwd))
-		die ("Could not change back to '%s'", cwd);
-
-	return buf;
-}
diff --git a/quote.c b/quote.c
index d5cf9d8..6a52085 100644
--- a/quote.c
+++ b/quote.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "quote.h"
 
+int quote_path_fully = 1;
+
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
diff --git a/shell.c b/shell.c
index b27d01c..91ca7de 100644
--- a/shell.c
+++ b/shell.c
@@ -3,6 +3,14 @@
 #include "exec_cmd.h"
 #include "strbuf.h"
 
+/* Stubs for functions that make no sense for git-shell. These stubs
+ * are provided here to avoid linking in external redundant modules.
+ */
+void release_pack_memory(size_t need, int fd){}
+void trace_argv_printf(const char **argv, const char *fmt, ...){}
+void trace_printf(const char *fmt, ...){}
+
+
 static int do_generic_cmd(const char *me, char *arg)
 {
 	const char *my_argv[4];
-- 
1.5.6.1
