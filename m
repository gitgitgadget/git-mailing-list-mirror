From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 7/7] builtin-merge: avoid non-strategy git-merge commands in error message
Date: Sat, 26 Jul 2008 13:54:51 +0200
Message-ID: <65a569c389352c5d0500b8c44c28e5572352e6ba.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
 <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
 <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
 <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org>
 <99c90877657be0ed439a9918f500d6ad132550a2.1217037178.git.vmiklos@frugalware.org>
 <13f39dd6752a34beeb6ecccb51dbc7546ef87182.1217037178.git.vmiklos@frugalware.org>
 <fc448aa651ad9e8e9d1cf5556a665b5bd6074628.1217037178.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:55:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiNC-0002Vg-LZ
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbYGZLyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYGZLyd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:54:33 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54450 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbYGZLy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:54:27 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id D47661DDC62
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:54:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C75251AB596; Sat, 26 Jul 2008 13:54:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <fc448aa651ad9e8e9d1cf5556a665b5bd6074628.1217037178.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90213>

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
 builtin-merge.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index cdbc692..4084e07 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -88,8 +88,19 @@ static struct strategy *get_strategy(const char *name)
 			return &all_strategy[i];
 
 	if (!is_git_command(name, "git-merge-")) {
+		struct cmdnames not_strategies;
+
+		memset(&not_strategies, 0, sizeof(struct cmdnames));
+		for (i = 0; i < main_cmds.cnt; i++) {
+			int j, found = 0;
+			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
+				if (!strcmp(main_cmds.names[i]->name, all_strategy[j].name))
+					found = 1;
+			if (!found)
+				add_cmdname(&not_strategies, main_cmds.names[i]->name, strlen(main_cmds.names[i]->name));
+		}
 		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
-		list_commands("git-merge-", "strategies");
+		list_commands("git-merge-", "strategies", &not_strategies);
 		exit(1);
 	}
 
-- 
1.6.0.rc0.14.g95f8.dirty
