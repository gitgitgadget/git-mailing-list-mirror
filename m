From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow git help work without PATH set
Date: Thu, 28 Aug 2008 19:19:07 +0200
Message-ID: <20080828171907.GD6024@blimp.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 19:26:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYlGD-0007TI-3O
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 19:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbYH1RZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 13:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbYH1RZL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 13:25:11 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:13785 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYH1RZK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 13:25:10 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20xf4EvTSQ==
Received: from tigra.home (Faec3.f.strato-dslnet.de [195.4.174.195])
	by post.webmailer.de (mrclete mo44) (RZmta 16.47)
	with ESMTP id j02f52k7SGrJdn ; Thu, 28 Aug 2008 19:25:07 +0200 (MEST)
	(envelope-from: <fork0@users.sourceforge.net>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 18A52277C6;
	Thu, 28 Aug 2008 19:25:07 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id C2DA036D1A; Thu, 28 Aug 2008 19:19:07 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94091>

Just because we can

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 help.c |   43 ++++++++++++++++++++-----------------------
 1 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/help.c b/help.c
index a17a746..ab2c2ba 100644
--- a/help.c
+++ b/help.c
@@ -178,37 +178,34 @@ void load_command_list(const char *prefix,
 		struct cmdnames *other_cmds)
 {
 	const char *env_path = getenv("PATH");
-	char *paths, *path, *colon;
 	const char *exec_path = git_exec_path();
 
-	if (exec_path)
+	if (exec_path) {
 		list_commands_in_dir(main_cmds, exec_path, prefix);
-
-	if (!env_path) {
-		fprintf(stderr, "PATH not set\n");
-		exit(1);
+		qsort(main_cmds->names, main_cmds->cnt,
+		      sizeof(*main_cmds->names), cmdname_compare);
+		uniq(main_cmds);
 	}
 
-	path = paths = xstrdup(env_path);
-	while (1) {
-		if ((colon = strchr(path, PATH_SEP)))
-			*colon = 0;
-
-		list_commands_in_dir(other_cmds, path, prefix);
+	if (env_path) {
+		char *paths, *path, *colon;
+		path = paths = xstrdup(env_path);
+		while (1) {
+			if ((colon = strchr(path, PATH_SEP)))
+				*colon = 0;
 
-		if (!colon)
-			break;
-		path = colon + 1;
-	}
-	free(paths);
+			list_commands_in_dir(other_cmds, path, prefix);
 
-	qsort(main_cmds->names, main_cmds->cnt,
-	      sizeof(*main_cmds->names), cmdname_compare);
-	uniq(main_cmds);
+			if (!colon)
+				break;
+			path = colon + 1;
+		}
+		free(paths);
 
-	qsort(other_cmds->names, other_cmds->cnt,
-	      sizeof(*other_cmds->names), cmdname_compare);
-	uniq(other_cmds);
+		qsort(other_cmds->names, other_cmds->cnt,
+		      sizeof(*other_cmds->names), cmdname_compare);
+		uniq(other_cmds);
+	}
 	exclude_cmds(other_cmds, main_cmds);
 }
 
-- 
1.6.0.1.150.g5966
