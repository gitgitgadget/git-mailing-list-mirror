From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/8] Add functions get_relative_cwd() and is_inside_dir()
Date: Fri, 27 Jul 2007 19:56:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271956140.14781@racer.site>
References: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEUzY-0006xY-HP
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759570AbXG0S4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759216AbXG0S4p
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:56:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:48823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758382AbXG0S4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:56:45 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:56:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 27 Jul 2007 20:56:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SZpsLBu0SWiLJM3+zIzOiAh1A55DJXRVH4ys5ww
	lX/VDtvzckB6/q
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707271851370.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53941>


The function get_relative_cwd() works just as getcwd(), only that it
takes an absolute path as additional parameter, returning the prefix
of the current working directory relative to the given path.  If the
cwd is no subdirectory of the given path, it returns NULL.

is_inside_dir() is just a trivial wrapper over get_relative_cwd().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	This patch should be the same as I sent out earlier.  Just to
	make sure that you get the correct version, I send it again.

 dir.c |   30 ++++++++++++++++++++++++++++++
 dir.h |    3 +++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index 8d8faf5..c16a004 100644
--- a/dir.c
+++ b/dir.c
@@ -642,3 +642,33 @@ file_exists(const char *f)
   struct stat sb;
   return stat(f, &sb) == 0;
 }
+
+char *get_relative_cwd(char *buffer, int size, const char *dir)
+{
+	char *cwd = buffer;
+
+	if (!dir)
+		return 0;
+
+	if (!getcwd(buffer, PATH_MAX))
+		return 0;
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
1.5.3.rc3.18.g49a1
