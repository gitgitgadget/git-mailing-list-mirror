From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] Add functions get_relative_cwd() and is_inside_dir()
Date: Wed, 1 Aug 2007 01:29:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708010129090.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Wed Aug 01 02:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG25x-00057p-5E
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbXHAA3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 20:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755912AbXHAA3m
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:29:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:46886 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754950AbXHAA3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:29:41 -0400
Received: (qmail invoked by alias); 01 Aug 2007 00:29:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 01 Aug 2007 02:29:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iAjVGrnaivuBOL/Lx7yNTkNbbK3V+rF+zQ5sw4z
	Si+BVCWFEiNeBJ
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0708010058130.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54386>


The function get_relative_cwd() works just as getcwd(), only that it
takes an absolute path as additional parameter, returning the prefix
of the current working directory relative to the given path.  If the
cwd is no subdirectory of the given path, it returns NULL.

is_inside_dir() is just a trivial wrapper over get_relative_cwd().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c |   32 ++++++++++++++++++++++++++++++++
 dir.h |    3 +++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 8d8faf5..5ea269a 100644
--- a/dir.c
+++ b/dir.c
@@ -642,3 +642,35 @@ file_exists(const char *f)
   struct stat sb;
   return stat(f, &sb) == 0;
 }
+
+/*
+ * get_relative_cwd() gets the prefix of the current working directory
+ * relative to 'dir'.  If we are not inside 'dir', it returns NULL.
+ * As a convenience, it also returns NULL if 'dir' is already NULL.
+ */
+char *get_relative_cwd(char *buffer, int size, const char *dir)
+{
+	char *cwd = buffer;
+
+	if (!dir || !getcwd(buffer, size))
+		return NULL;
+
+	if (!is_absolute_path(dir))
+		dir = make_absolute_path(dir);
+
+	while (*dir && *dir == *cwd) {
+		dir++;
+		cwd++;
+	}
+	if (*dir)
+		return NULL;
+	if (*cwd == '/')
+		return cwd + 1;
+	return cwd;
+}
+
+int is_inside_dir(const char *dir)
+{
+	char buffer[PATH_MAX];
+	return get_relative_cwd(buffer, sizeof(buffer), dir) != NULL;
+}
diff --git a/dir.h b/dir.h
index ec0e8ab..f55a87b 100644
--- a/dir.h
+++ b/dir.h
@@ -61,4 +61,7 @@ extern void add_exclude(const char *string, const char *base,
 extern int file_exists(const char *);
 extern struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len);
 
+extern char *get_relative_cwd(char *buffer, int size, const char *dir);
+extern int is_inside_dir(const char *dir);
+
 #endif
-- 
1.5.3.rc3.94.g3024

#
