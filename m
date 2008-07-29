From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/4] builtin-merge: allow using a custom strategy
Date: Wed, 30 Jul 2008 01:16:59 +0200
Message-ID: <18a8b4aaf4cc4bc720bd673166d4a7722ed79556.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
 <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:17:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyRs-0007ys-0S
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbYG2XQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYG2XQm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:16:42 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55572 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYG2XQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:16:36 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 9879E1DDC5C;
	Wed, 30 Jul 2008 01:16:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 5BEAB1AB590; Wed, 30 Jul 2008 01:17:02 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <a2d2bc675801bb03e3035ec0102eb27f08f27f1b.1217372486.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217372486.git.vmiklos@frugalware.org>
References: <cover.1217372486.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90705>

Allow using a custom strategy, as long as it's named git-merge-foo. The
error handling is now done using is_git_command(). The list of available
strategies is now shown by list_commands().

If an invalid strategy is supplied, like -s foobar, then git-merge would
list all git-merge-* commands. This is not perfect, since for example
git-merge-index is not a valid strategy.

These are removed from the output by scanning the list of main commands;
if the git-merge-foo command is listed in the all_strategy list, then
it's shown, otherwise excluded. This does not exclude commands somewhere
else in the PATH, where custom strategies are expected.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e78fa18..99b307a 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -22,6 +22,7 @@
 #include "log-tree.h"
 #include "color.h"
 #include "rerere.h"
+#include "help.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -77,7 +78,9 @@ static int option_parse_message(const struct option *opt,
 static struct strategy *get_strategy(const char *name)
 {
 	int i;
-	struct strbuf err;
+	struct strategy *ret;
+	static struct cmdnames main_cmds, other_cmds;
+	static int longest = 0;
 
 	if (!name)
 		return NULL;
@@ -86,12 +89,37 @@ static struct strategy *get_strategy(const char *name)
 		if (!strcmp(name, all_strategy[i].name))
 			return &all_strategy[i];
 
-	strbuf_init(&err, 0);
-	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
-		strbuf_addf(&err, " %s", all_strategy[i].name);
-	fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
-	fprintf(stderr, "Available strategies are:%s.\n", err.buf);
-	exit(1);
+	if (!longest) {
+		struct cmdnames not_strategies;
+
+		memset(&main_cmds, 0, sizeof(struct cmdnames));
+		memset(&other_cmds, 0, sizeof(struct cmdnames));
+		memset(&not_strategies, 0, sizeof(struct cmdnames));
+		longest = load_command_list("git-merge-", &main_cmds,
+				&other_cmds);
+		for (i = 0; i < main_cmds.cnt; i++) {
+			int j, found = 0;
+			struct cmdname *ent = main_cmds.names[i];
+			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
+				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
+						&& !all_strategy[j].name[ent->len])
+					found = 1;
+			if (!found)
+				add_cmdname(&not_strategies, ent->name, ent->len);
+			exclude_cmds(&main_cmds, &not_strategies);
+		}
+	}
+	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds, name)) {
+
+		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
+		list_commands("strategies", longest, &main_cmds, &other_cmds);
+		exit(1);
+	}
+
+	ret = xmalloc(sizeof(struct strategy));
+	memset(ret, 0, sizeof(struct strategy));
+	ret->name = xstrdup(name);
+	return ret;
 }
 
 static void append_strategy(struct strategy *s)
-- 
1.6.0.rc0.14.g95f8.dirty
