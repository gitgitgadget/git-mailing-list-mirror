From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] git wrapper: also uses aliases to suggest mistyped commands
Date: Wed, 10 Sep 2008 17:54:28 +0200
Message-ID: <1221062068-5660-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdS2o-0000KL-3z
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYIJPyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbYIJPyl
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:54:41 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:54777 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbYIJPyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:54:40 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6201.online.nl (SMTP Server) with ESMTP id 659D51C00084;
	Wed, 10 Sep 2008 17:54:34 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6201.online.nl (SMTP Server) with ESMTP id B97FF1C00083;
	Wed, 10 Sep 2008 17:54:29 +0200 (CEST)
X-ME-UUID: 20080910155433759.B97FF1C00083@mwinf6201.online.nl
X-Mailer: git-send-email 1.6.0.1.346.g880d9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95536>


Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 help.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/help.c b/help.c
index 300cd38..24904d4 100644
--- a/help.c
+++ b/help.c
@@ -262,11 +262,15 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 }
 
 static int autocorrect;
+static struct cmdnames aliases;
 
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "help.autocorrect"))
 		autocorrect = git_config_int(var,value);
+	/* Also use aliases for command lookup */
+	if (!prefixcmp(var, "alias."))
+		add_cmdname(&aliases, var + 6, strlen(var + 6));
 
 	return git_default_config(var, value, cb);
 }
@@ -280,6 +284,15 @@ static int levenshtein_compare(const void *p1, const void *p2)
 	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
 }
 
+static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
+{
+	int i;
+	ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
+
+	for (i = 0; i < old->cnt; i++)
+		cmds->names[cmds->cnt++] = old->names[i];
+}
+
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
@@ -287,11 +300,13 @@ const char *help_unknown_cmd(const char *cmd)
 
 	memset(&main_cmds, 0, sizeof(main_cmds));
 	memset(&other_cmds, 0, sizeof(main_cmds));
+	memset(&aliases, 0, sizeof(aliases));
 
 	git_config(git_unknown_cmd_config, NULL);
 
 	load_command_list("git-", &main_cmds, &other_cmds);
 
+	add_cmd_list(&main_cmds, &aliases);
 	ALLOC_GROW(main_cmds.names, main_cmds.cnt + other_cmds.cnt,
 		   main_cmds.alloc);
 	memcpy(main_cmds.names + main_cmds.cnt, other_cmds.names,
-- 
1.6.0.1.346.g880d9.dirty
