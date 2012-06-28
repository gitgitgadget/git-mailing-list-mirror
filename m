From: Chris Webb <chris@arachsys.com>
Subject: [PATCH v3 2/3] Allow help.htmlpath to be a URL prefix
Date: Thu, 28 Jun 2012 07:58:03 +0100
Message-ID: <cebaecfaa217a20794e8278b4db3ce5b8d667834.1340866684.git.chris@arachsys.com>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340866684.git.chris@arachsys.com>
Cc: Chris Webb <chris@arachsys.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 08:58:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk8gG-0007aU-0c
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 08:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455Ab2F1G6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 02:58:16 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:50051 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab2F1G6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 02:58:16 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1Sk8gA-0005ky-AN; Thu, 28 Jun 2012 07:58:14 +0100
X-Mailer: git-send-email 1.7.10
In-Reply-To: <8d3c71d21710c66e4d5560cec958552b69a22338.1340866684.git.chris@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200777>

Setting this to a URL prefix instead of a path to a local directory allows
git-help --web to work even when HTML docs aren't locally installed, by
pointing the browser at a copy accessible on the web. For example,

    [help]
      format = html
      htmlpath = http://git-scm.com/docs

will use the publicly available documentation on the git homepage.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/help.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index b467db2..92f2349 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -399,9 +399,11 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 		html_path = system_path(GIT_HTML_PATH);
 
 	/* Check that we have a git documentation directory. */
-	if (stat(mkpath("%s/git.html", html_path), &st)
-	    || !S_ISREG(st.st_mode))
-		die(_("'%s': not a documentation directory."), html_path);
+	if (!strstr(html_path, "://")) {
+		if (stat(mkpath("%s/git.html", html_path), &st)
+				|| !S_ISREG(st.st_mode))
+			die("'%s': not a documentation directory.", html_path);
+	}
 
 	strbuf_init(page_path, 0);
 	strbuf_addf(page_path, "%s/%s.html", html_path, page);
-- 
1.7.10
