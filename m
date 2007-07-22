From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Add is_absolute_path() and make_absolute_path() functions
Date: Sun, 22 Jul 2007 19:55:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221955280.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 22 20:56:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgbH-0005yZ-M6
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 20:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763698AbXGVS4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763683AbXGVS4J
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 14:56:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:56782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763203AbXGVS4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 14:56:07 -0400
Received: (qmail invoked by alias); 22 Jul 2007 18:56:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 22 Jul 2007 20:56:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9fRc1qMz9cYec8uv+XwMp7qHC8FVSt66DNjuNJJ
	HRQvSAs1WWTQCD
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53290>


This patch adds convenience functions to work with absolute paths.
The function is_absolute_path() should help the efforts to integrate
the MinGW fork.

Note that make_absolute_path() returns a pointer to a static buffer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	I am in the middle of so many things, otherwise I would have
	tried to find all places that can use these functions.  But
	maybe a helpful soul out there wants to do that?

 cache.h |    5 +++++
 path.c  |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

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
index c4ce962..b5b1959 100644
--- a/path.c
+++ b/path.c
@@ -292,3 +292,21 @@ int adjust_shared_perm(const char *path)
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
+	len = strlen(buf);
+	if (snprintf(buf + len, size - len, "/%s", path) > size - 1)
+		die ("Could not make absolute path from '%s'", path);
+	return buf;
+}
+
-- 
1.5.3.rc2.29.gc4640f
