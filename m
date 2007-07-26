From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/5] Add is_absolute_path(), make_absolute_path() and
 normalize_path()
Date: Thu, 26 Jul 2007 07:24:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260724010.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 26 08:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwm5-000364-Mo
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXGZGYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbXGZGYd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:24:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:33683 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751584AbXGZGYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:24:32 -0400
Received: (qmail invoked by alias); 26 Jul 2007 06:24:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 26 Jul 2007 08:24:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1883jwcFRs8flFjC21lG0MgrXqABBVJmXeDwN5ilJ
	xUNqpD33q2TPPS
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53776>


This patch adds convenience functions to work with absolute paths.
The function is_absolute_path() should help the efforts to integrate
the MinGW fork.

Note that make_absolute_path() returns a pointer to a static buffer.

Given a path which possibly contains "/../" and "/./", or which end
in "/", normalize_path() returns a normalized path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |    6 ++++++
 path.c  |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 53801b8..b242147 100644
--- a/cache.h
+++ b/cache.h
@@ -358,6 +358,12 @@ int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
 char *enter_repo(char *path, int strict);
+static inline int is_absolute_path(const char *path)
+{
+	return path[0] == '/';
+}
+const char *make_absolute_path(const char *path);
+char *normalize_path(char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index c4ce962..92ce688 100644
--- a/path.c
+++ b/path.c
@@ -292,3 +292,57 @@ int adjust_shared_perm(const char *path)
 		return -2;
 	return 0;
 }
+
+const char *make_absolute_path(const char *path)
+{
+	static char buf[PATH_MAX];
+	const int size = sizeof(buf);
+	int len;
+
+	if (is_absolute_path(path))
+		return path;
+
+	if (!getcwd(buf, size))
+		die ("Could not get current working directory");
+	if (!strcmp(path, "."))
+		return buf;
+
+	len = strlen(buf);
+	if (snprintf(buf + len, size - len, "/%s", path) > size - 1)
+		die ("Could not make absolute path from '%s'", path);
+	return normalize_path(buf);
+}
+
+/* strip out .. and . */
+char *normalize_path(char *path)
+{
+	int i, j;
+
+	for (i = 0, j = 0; path[i]; i++, j++) {
+		if (path[i] == '.') {
+			if (path[i + 1] == '/') {
+				i++; j--;
+				continue;
+			}
+			if (path[i + 1] == '.' && (path[i + 2] == '/' ||
+						!path[i + 2])) {
+				i += 1 + !!path[i + 2];
+				j--;
+				while (j > 0 && path[--j] != '/')
+					; /* do nothing */
+				continue;
+			}
+		}
+		for (; path[i + 1]; i++, j++) {
+			path[j] = path[i];
+			if (path[i] == '/')
+				break;
+		}
+		path[j] = path[i];
+	}
+	if (j > 0 && path[j - 1] == '/')
+		j--;
+	path[j] = '\0';
+
+	return path;
+}
-- 
1.5.3.rc2.42.gda8d-dirty
