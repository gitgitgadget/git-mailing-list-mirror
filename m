From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/8] Add is_absolute_path() and make_absolute_path()
Date: Fri, 27 Jul 2007 19:56:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271955450.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEUz6-0006nR-OY
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760058AbXG0S4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759216AbXG0S4S
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:56:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:56682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757348AbXG0S4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:56:17 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:56:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 27 Jul 2007 20:56:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19SQIRwOklSTKRXTd/NOwrUHUl+CViC1tRxGQ32Xi
	Fvr2bwlrqKkGuH
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707271851370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53940>


This patch adds convenience functions to work with absolute paths.
The function is_absolute_path() should help the efforts to integrate
the MinGW fork.

Note that make_absolute_path() returns a pointer to a static buffer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Okay, gone is normalize_path().  In contrast, "make_absolute_path()"
	does the getcwd() && chdir() && getcwd() && chdir(back) mantra, to
	follow symlinks.

	AFAICT, make_absolute_path() would be a Good Thing to use for the
	recent lockfile stuff.

 Makefile             |    2 +-
 cache.h              |    5 ++++
 path.c               |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0000-basic.sh     |   16 +++++++++++++
 test-absolute-path.c |   11 +++++++++
 5 files changed, 95 insertions(+), 1 deletions(-)
 create mode 100644 test-absolute-path.c

diff --git a/Makefile b/Makefile
index d8100ad..546e008 100644
--- a/Makefile
+++ b/Makefile
@@ -936,7 +936,7 @@ endif
 
 ### Testing rules
 
-TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X test-date$X test-delta$X test-sha1$X test-match-trees$X test-absolute-path$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/cache.h b/cache.h
index 53801b8..98af530 100644
--- a/cache.h
+++ b/cache.h
@@ -358,6 +358,11 @@ int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
+static inline int is_absolute_path(const char *path)
+{
+	return path[0] == '/';
+}
+const char *make_absolute_path(const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index c4ce962..0f7012f 100644
--- a/path.c
+++ b/path.c
@@ -292,3 +292,65 @@ int adjust_shared_perm(const char *path)
 		return -2;
 	return 0;
 }
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
+			*last_slash = '\0';
+			last_elem = xstrdup(last_slash + 1);
+		}
+
+		if (*buf) {
+			if (!*cwd && getcwd(cwd, sizeof(cwd)) < 0)
+				die ("Could not get current working directory");
+
+			if (chdir(buf))
+				die ("Could not switch to '%s'", buf);
+		}
+		if (getcwd(buf, PATH_MAX) < 0)
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
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4bba9c0..4e49d59 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -281,4 +281,20 @@ test_expect_success 'update-index D/F conflict' '
 	test $numpath0 = 1
 '
 
+test_expect_success 'absolute path works as expected' '
+	mkdir first &&
+	ln -s ../.git first/.git &&
+	mkdir second &&
+	ln -s ../first second/other &&
+	mkdir third &&
+	dir="$(cd .git; pwd -P)" &&
+	dir2=third/../second/other/.git &&
+	test "$dir" = "$(test-absolute-path $dir2)" &&
+	file="$dir"/index &&
+	test "$file" = "$(test-absolute-path $dir2/index)" &&
+	ln -s ../first/file .git/syml &&
+	sym="$(cd first; pwd -P)"/file &&
+	test "$sym" = "$(test-absolute-path $dir2/syml)"
+'
+
 test_done
diff --git a/test-absolute-path.c b/test-absolute-path.c
new file mode 100644
index 0000000..c959ea2
--- /dev/null
+++ b/test-absolute-path.c
@@ -0,0 +1,11 @@
+#include "cache.h"
+
+int main(int argc, char **argv)
+{
+	while (argc > 1) {
+		puts(make_absolute_path(argv[1]));
+		argc--;
+		argv++;
+	}
+	return 0;
+}
-- 
1.5.3.rc3.18.g49a1
