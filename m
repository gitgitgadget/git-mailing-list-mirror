From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/2] help.c: Add support for htmldir relative to git_exec_path()
Date: Fri,  4 Jul 2008 11:09:25 +0200
Message-ID: <1215162566-16062-1-git-send-email-prohaska@zib.de>
References: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:11:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhJO-0004n1-Oy
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYGDJJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 05:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbYGDJJo
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 05:09:44 -0400
Received: from mailer.zib.de ([130.73.108.11]:61843 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519AbYGDJJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 05:09:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6499RH3008415;
	Fri, 4 Jul 2008 11:09:32 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6499QDX008171;
	Fri, 4 Jul 2008 11:09:26 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87376>

If htmldir (in the Makefile) is a relative path, this path will be
interpreted relative to git_exec_path.  This can be used to create an
installation that can be moved to a different directory without
re-compiling.  The Windows installer (msysgit) is an example for such
a setup.

Note that the Makefile maps htmldir to the define GIT_HTML_PATH.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 help.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index ca9632b..5586e1d 100644
--- a/help.c
+++ b/help.c
@@ -634,12 +634,20 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 {
 	struct stat st;
 
+	const char* html_path = GIT_HTML_PATH;
+	if (!is_absolute_path(html_path)) {
+		struct strbuf d = STRBUF_INIT;
+		strbuf_addf(&d, "%s/%s", git_exec_path(), html_path);
+		html_path = strbuf_detach(&d, NULL);
+	}
+
 	/* Check that we have a git documentation directory. */
-	if (stat(GIT_HTML_PATH "/git.html", &st) || !S_ISREG(st.st_mode))
-		die("'%s': not a documentation directory.", GIT_HTML_PATH);
+	if (stat(mkpath("%s/git.html", html_path), &st)
+	    || !S_ISREG(st.st_mode))
+		die("'%s': not a documentation directory.", html_path);
 
 	strbuf_init(page_path, 0);
-	strbuf_addf(page_path, GIT_HTML_PATH "/%s.html", page);
+	strbuf_addf(page_path, "%s/%s.html", html_path, page);
 }
 
 static void show_html_page(const char *git_cmd)
-- 
1.5.6.1.282.gd8a0d
