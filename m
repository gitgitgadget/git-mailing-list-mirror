From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] git-help: Try to find html pages without the git- prefix
Date: Mon, 28 Apr 2008 12:13:31 +0200
Message-ID: <1209377611-90005-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:14:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqQNM-000426-9v
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 12:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbYD1KNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 06:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbYD1KNf
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 06:13:35 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:58146 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbYD1KNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 06:13:34 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6309.orange.nl (SMTP Server) with ESMTP id F3E6D1C000B7;
	Mon, 28 Apr 2008 12:13:32 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6309.orange.nl (SMTP Server) with ESMTP id 9EA211C000B6;
	Mon, 28 Apr 2008 12:13:32 +0200 (CEST)
X-ME-UUID: 20080428101332649.9EA211C000B6@mwinf6309.orange.nl
X-Mailer: git-send-email 1.5.5.1.174.g32fa0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80521>

Some html documentation does not have the git- prefix, for example hooks.html.
If the git-command.html page does not exist, try to find the command.html
file. This allows commands like `git help -w hooks' to work
---
 help.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/help.c b/help.c
index 10298fb..633bfc9 100644
--- a/help.c
+++ b/help.c
@@ -488,11 +488,15 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 
 static void show_html_page(const char *git_cmd)
 {
+	struct stat st;
 	const char *page = cmd_to_page(git_cmd);
 	struct strbuf page_path; /* it leaks but we exec bellow */
 
 	get_html_page_path(&page_path, page);
 
+	if (stat(page_path.buf, &st) || !S_ISREG(st.st_mode))
+		get_html_page_path(&page_path, git_cmd);
+
 	execl_git_cmd("web--browse", "-c", "help.browser", page_path.buf, NULL);
 }
 
-- 
1.5.5.1.174.g32fa0.dirty
