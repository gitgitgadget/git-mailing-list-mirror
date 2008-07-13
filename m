From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] help (Windows): Display HTML in default browser using Windows' shell API
Date: Sun, 13 Jul 2008 22:31:20 +0200
Message-ID: <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
 <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8FB-0005Rf-NP
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbYGMUbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbYGMUba
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:31:30 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:37013 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbYGMUb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:31:28 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 7E65434AAE;
	Sun, 13 Jul 2008 22:31:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.300.ga3a9
In-Reply-To: <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88331>

From: Steffen Prohaska <prohaska@zib.de>

The system's default browser for displaying HTML help pages is now used
directly on Windows, instead of launching git-web--browser, which
requires a Unix shell.  Avoiding MSYS' bash when possible is good
because it avoids potential path translation issues.  In this case it is
not too hard to avoid launching a shell, so let's avoid it.

The Windows-specific code is implemented in compat/mingw.c to avoid
platform-specific code in the main code base.  On Windows, open_html is
provided as a define.  If open_html is not defined, git-web--browse is
used.  This approach avoids platform-specific ifdefs by using
per-function ifdefs.  The "ifndef open_html" together with the
introductory comment should sufficiently warn developers, so that they
hopefully will not break this mechanism.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 compat/mingw.c |   21 +++++++++++++++++++++
 compat/mingw.h |    3 +++
 help.c         |   14 +++++++++++++-
 3 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3a05fe7..0ca73f7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1017,3 +1017,24 @@ sig_handler_t mingw_signal(int sig, sig_handler_t handler)
 	timer_fn = handler;
 	return old;
 }
+
+static const char *make_backslash_path(const char *path) {
+	static char buf[PATH_MAX + 1];
+	char *c;
+
+	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+		die ("Too long path: %.*s", 60, path);
+
+	for (c = buf; *c; c++) {
+		if (*c == '/')
+			*c = '\\';
+	}
+	return buf;
+}
+
+void mingw_open_html(const char *unixpath)
+{
+	const char *htmlpath = make_backslash_path(unixpath);
+	printf("Launching default browser to display HTML ...\n");
+	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index 6bc049a..5a3bcee 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -202,6 +202,9 @@ sig_handler_t mingw_signal(int sig, sig_handler_t handler);
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 
+void mingw_open_html(const char *path);
+#define open_html mingw_open_html
+
 /*
  * helpers
  */
diff --git a/help.c b/help.c
index 0f055bf..52d39b8 100644
--- a/help.c
+++ b/help.c
@@ -644,6 +644,18 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
 }
 
+/*
+ * If open_html is not defined in a platform-specific way (see for
+ * example compat/mingw.h), we use the script web--browse to display
+ * HTML.
+ */
+#ifndef open_html
+void open_html(const char *path)
+{
+	execl_git_cmd("web--browse", "-c", "help.browser", path, NULL);
+}
+#endif
+
 static void show_html_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
@@ -651,7 +663,7 @@ static void show_html_page(const char *git_cmd)
 
 	get_html_page_path(&page_path, page);
 
-	execl_git_cmd("web--browse", "-c", "help.browser", page_path.buf, NULL);
+	open_html(page_path.buf);
 }
 
 void help_unknown_cmd(const char *cmd)
-- 
1.5.6.2.300.ga3a9
