From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 4/6] Add is_git_command_or_alias() for checking
 availability of a given git command
Date: Tue, 11 Aug 2009 12:10:24 +0200
Message-ID: <1249985426-13726-5-git-send-email-johan@herland.net>
References: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, benji@silverinsanity.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:12:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mar98-0008GJ-0j
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbZHKNLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZHKNLI
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:11:08 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41143 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752931AbZHKNLD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 09:11:03 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7001ZRIYE8O70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:02 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO7008QYIY6Z330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 11 Aug 2009 12:11:02 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.11.95426
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <alpine.LNX.2.00.0908101205120.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125553>

The transport-helper mechanism requires us to gracefully handle the case
where a git command is not available for some reason.

This patch introduces a simple function for querying the availability of a
git command, without attempting to execute said command.

The new function is very similar to the static is_git_command() function in
builtin-help.c, except that this function also accepts a matching alias.

Signed-off-by: Johan Herland <johan@herland.net>
---
 help.c |   21 +++++++++++++++++++++
 help.h |    2 ++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/help.c b/help.c
index 994561d..a616277 100644
--- a/help.c
+++ b/help.c
@@ -296,6 +296,27 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	old->names = NULL;
 }
 
+int is_git_command_or_alias(const char *cmd)
+{
+	struct cmdnames main_cmds, other_cmds;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	memset(&aliases, 0, sizeof(aliases));
+
+	git_config(git_unknown_cmd_config, NULL);
+
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	add_cmd_list(&main_cmds, &aliases);
+	add_cmd_list(&main_cmds, &other_cmds);
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(main_cmds.names), cmdname_compare);
+	uniq(&main_cmds);
+
+	return is_in_cmdlist(&main_cmds, cmd);
+}
+
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
diff --git a/help.h b/help.h
index 56bc154..6c43452 100644
--- a/help.h
+++ b/help.h
@@ -26,4 +26,6 @@ int is_in_cmdlist(struct cmdnames *c, const char *s);
 void list_commands(const char *title, struct cmdnames *main_cmds,
 		   struct cmdnames *other_cmds);
 
+int is_git_command_or_alias(const char *cmd);
+
 #endif /* HELP_H */
-- 
1.6.4.rc3.138.ga6b98.dirty
