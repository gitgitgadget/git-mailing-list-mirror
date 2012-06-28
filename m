From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v3 1/3] Add config variable to set HTML path for git-help --web
Date: Thu, 28 Jun 2012 07:58:02 +0100
Message-ID: <8d3c71d21710c66e4d5560cec958552b69a22338.1340866684.git.chris@arachsys.com>
Cc: Chris Webb <chris@arachsys.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 08:58:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk8gF-0007aU-GA
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 08:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335Ab2F1G6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 02:58:15 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:50046 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab2F1G6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 02:58:14 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Sk8g8-0005ky-Rn; Thu, 28 Jun 2012 07:58:13 +0100
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200778>

If set in git-config, help.htmlpath overrides system_path(GIT_HTML_PATH)
which was compiled in. This allows users to repoint system-wide git at
their own copy of the documentation without recompiling.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/help.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8f9cd60..b467db2 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -34,6 +34,8 @@ enum help_format {
 	HELP_FORMAT_WEB
 };
 
+static char *html_path = NULL;
+
 static int show_all = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
@@ -265,6 +267,12 @@ static int git_help_config(const char *var, const char *value, void *cb)
 		help_format = parse_help_format(value);
 		return 0;
 	}
+	if (!strcmp(var, "help.htmlpath")) {
+		if (!value)
+			return config_error_nonbool(var);
+		html_path = xstrdup(value);
+		return 0;
+	}
 	if (!strcmp(var, "man.viewer")) {
 		if (!value)
 			return config_error_nonbool(var);
@@ -387,7 +395,8 @@ static void show_info_page(const char *git_cmd)
 static void get_html_page_path(struct strbuf *page_path, const char *page)
 {
 	struct stat st;
-	const char *html_path = system_path(GIT_HTML_PATH);
+	if (!html_path)
+		html_path = system_path(GIT_HTML_PATH);
 
 	/* Check that we have a git documentation directory. */
 	if (stat(mkpath("%s/git.html", html_path), &st)
-- 
1.7.10
