From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 1/2] Add config variable to set HTML path for git-help --web
Date: Wed, 27 Jun 2012 23:00:31 +0100
Message-ID: <11ff98647b869d4753ffee53c77df5c11f43224d.1340834432.git.chris@arachsys.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 00:00:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk0I0-0002D8-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 00:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319Ab2F0WAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 18:00:37 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:46771 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab2F0WAg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 18:00:36 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Sk0Hr-0006H6-7B; Wed, 27 Jun 2012 23:00:35 +0100
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200764>

If set in git-config, help.htmlpath overrides system_path(GIT_HTML_PATH)
which was compiled in. This allows users to repoint system-wide git at
their own copy of the documentation without recompiling.

When help.htmlpath is explicitly set, it is used without checking it is
a local git docs directory. This means it can instead be set to a URL
prefix, allowing git-help --web to work even when HTML docs aren't
locally installed, using a copy accessible on the web. For example,

    [help]
      format = html
      htmlpath = http://git-scm.com/docs

will use the publicly available documentation on the git homepage.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/help.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8f9cd60..a0bb2bf 100644
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
@@ -387,12 +395,14 @@ static void show_info_page(const char *git_cmd)
 static void get_html_page_path(struct strbuf *page_path, const char *page)
 {
 	struct stat st;
-	const char *html_path = system_path(GIT_HTML_PATH);
+	if (!html_path) {
+		html_path = system_path(GIT_HTML_PATH);
 
-	/* Check that we have a git documentation directory. */
-	if (stat(mkpath("%s/git.html", html_path), &st)
-	    || !S_ISREG(st.st_mode))
-		die(_("'%s': not a documentation directory."), html_path);
+		/* Check that we have a git documentation directory. */
+		if (stat(mkpath("%s/git.html", html_path), &st)
+				|| !S_ISREG(st.st_mode))
+			die("'%s': not a documentation directory.", html_path);
+	}
 
 	strbuf_init(page_path, 0);
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
-- 
1.7.10
