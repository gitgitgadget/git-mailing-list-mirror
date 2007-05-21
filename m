From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-status: respect core.excludesFile
Date: Mon, 21 May 2007 22:51:50 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705212251300.6410@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon May 21 23:52:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqFnz-00036D-6u
	for gcvg-git@gmane.org; Mon, 21 May 2007 23:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbXEUVwa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 17:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755981AbXEUVwa
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 17:52:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:37923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754992AbXEUVwa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 17:52:30 -0400
Received: (qmail invoked by alias); 21 May 2007 21:52:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 21 May 2007 23:52:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bkip+K0pbtlcWFN2DlnOOnoog2GX5tQdGRuH/C1
	Os/pkueMBWDQMW
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48054>


git-add reads this variable, and honours the contents of that file if that
exists. Match this behaviour in git-status, too.

Noticed by Evan Carroll on IRC.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a055990..4bfe8f1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -22,6 +22,7 @@ static const char use_add_rm_msg[] =
 "use \"git add/rm <file>...\" to update what will be committed";
 static const char use_add_to_include_msg[] =
 "use \"git add <file>...\" to include in what will be committed";
+static const char *excludes_file;
 
 static int parse_status_slot(const char *var, int offset)
 {
@@ -259,6 +260,8 @@ static void wt_status_print_untracked(struct wt_status *s)
 	x = git_path("info/exclude");
 	if (file_exists(x))
 		add_excludes_from_file(&dir, x);
+	if (excludes_file && file_exists(excludes_file))
+		add_excludes_from_file(&dir, excludes_file);
 
 	read_directory(&dir, ".", "", 0, NULL);
 	for(i = 0; i < dir.nr; i++) {
@@ -356,5 +359,11 @@ int git_status_config(const char *k, const char *v)
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
+	if (!strcmp(k, "core.excludesfile")) {
+		if (!v)
+			die("core.excludesfile without value");
+		excludes_file = xstrdup(v);
+		return 0;
+	}
 	return git_default_config(k, v);
 }
-- 
1.5.2.GIT
