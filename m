From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/2] help (Windows): Display HTML in default browser using Win32 API
Date: Fri,  4 Jul 2008 11:09:26 +0200
Message-ID: <1215162566-16062-2-git-send-email-prohaska@zib.de>
References: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de>
 <1215162566-16062-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:11:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhJO-0004n1-4V
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbYGDJJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 05:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbYGDJJl
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 05:09:41 -0400
Received: from mailer.zib.de ([130.73.108.11]:61839 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbYGDJJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 05:09:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6499Rwk008416;
	Fri, 4 Jul 2008 11:09:32 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6499QDY008171;
	Fri, 4 Jul 2008 11:09:26 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1215162566-16062-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87377>

The Win32 API is now called directly to launch the system's default
browser for displaying HTML help pages instead of launching a shell to
execute git-web--browser.  Avoiding the MSYS' bash when possible is good
because it avoids potential path translation issues.  In this case it is
not too hard to avoid launching a shell, so let's avoid it.

This commit also adds make_native_separator() to convert slashes to
backslashes on Windows.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h |    2 ++
 help.c  |   18 ++++++++++++++++++
 path.c  |   18 ++++++++++++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 35a9132..747581f 100644
--- a/cache.h
+++ b/cache.h
@@ -527,6 +527,8 @@ static inline int is_absolute_path(const char *path)
 const char *make_absolute_path(const char *path);
 const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
+/* Convert slashes to backslashes on Windows.  no-op on other platforms. */
+const char *make_native_separator(const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/help.c b/help.c
index 5586e1d..8fcd644 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "dir.h"
 
 static struct man_viewer_list {
 	struct man_viewer_list *next;
@@ -650,6 +651,19 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
 }
 
+#ifdef __MINGW32__
+static void open_html_win(const char *unixpath)
+{
+	const char *htmlpath = make_native_separator(mkpath("%s",unixpath));
+	if (!file_exists(htmlpath)) {
+		fprintf(stderr, "HTML file '%s' does not exist.\n", htmlpath);
+		exit(1);
+	}
+	printf("Launching default browser to display HTML help ...\n");
+	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
+}
+#endif
+
 static void show_html_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
@@ -657,7 +671,11 @@ static void show_html_page(const char *git_cmd)
 
 	get_html_page_path(&page_path, page);
 
+#ifdef __MINGW32__
+	open_html_win(page_path.buf);
+#else
 	execl_git_cmd("web--browse", "-c", "help.browser", page_path.buf, NULL);
+#endif
 }
 
 void help_unknown_cmd(const char *cmd)
diff --git a/path.c b/path.c
index 496123c..9f2bd91 100644
--- a/path.c
+++ b/path.c
@@ -343,3 +343,21 @@ const char *make_relative_path(const char *abs, const char *base)
 	strcpy(buf, abs + baselen);
 	return buf;
 }
+
+const char *make_native_separator(const char* path) {
+#ifdef __MINGW32__
+	static char buf[PATH_MAX + 1];
+	char* c;
+
+	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+		die ("Too long path: %.*s", 60, path);
+
+	for (c = buf; *c; c++) {
+		if (*c == '/')
+			*c = '\\';
+	}
+	return buf;
+#else
+	return path;
+#endif
+}
-- 
1.5.6.1.282.gd8a0d
