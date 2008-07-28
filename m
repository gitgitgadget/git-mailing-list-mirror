From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 5/6] builtin-merge: avoid non-strategy git-merge commands in error message
Date: Mon, 28 Jul 2008 03:21:09 +0200
Message-ID: <42e8615f6cbd236e40b19f2a754807f08e4b85a6.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org>
 <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
 <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org>
 <10c4292de30b5868bd9fb54b557e8dae827f1241.1217207602.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 03:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHQs-000771-Hz
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbYG1BUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbYG1BUr
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:20:47 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41571 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYG1BUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:20:46 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 78A371DDC5D
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:20:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 9DBC41AB591; Mon, 28 Jul 2008 03:21:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <10c4292de30b5868bd9fb54b557e8dae827f1241.1217207602.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90386>

If an invalid strategy is supplied, like -s foobar, then git-merge
listed all git-merge-* commands. This is not perfect, since for example
git-merge-index is not a valid strategy.

These are now removed from the output by scanning the list of main
commands; if the git-merge-foo command is listed in the all_strategy
list, then it's shown, otherwise excluded. This does not exclude
commands somewhere else in the PATH, where custom strategies are
expected.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index cdbc692..29826b1 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -88,8 +88,21 @@ static struct strategy *get_strategy(const char *name)
 			return &all_strategy[i];
 
 	if (!is_git_command(name, "git-merge-")) {
+		struct cmdnames not_strategies;
+
+		memset(&not_strategies, 0, sizeof(struct cmdnames));
+		for (i = 0; i < main_cmds.cnt; i++) {
+			int j, found = 0;
+			struct cmdname *ent = main_cmds.names[i];
+			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
+				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
+						&& !all_strategy[j].name[ent->len])
+					found = 1;
+			if (!found)
+				add_cmdname(&not_strategies, ent->name, ent->len);
+		}
 		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
-		list_commands("git-merge-", "strategies");
+		list_commands("git-merge-", "strategies", &not_strategies);
 		exit(1);
 	}
 
-- 
1.6.0.rc0.14.g95f8.dirty
