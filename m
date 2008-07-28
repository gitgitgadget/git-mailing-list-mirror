From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: allow using a custom strategy
Date: Tue, 29 Jul 2008 01:48:28 +0200
Message-ID: <1217288908-21124-1-git-send-email-vmiklos@frugalware.org>
References: <alpine.DEB.1.00.0807281505010.2725@eeepc-johanness>
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:49:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcSe-0006dq-6x
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbYG1XsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYG1XsD
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:48:03 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:51705 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYG1XsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:48:01 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 726311DDC5B;
	Tue, 29 Jul 2008 01:47:59 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id A90031AA738; Tue, 29 Jul 2008 01:48:28 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <alpine.DEB.1.00.0807281505010.2725@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90525>

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

On Mon, Jul 28, 2008 at 03:06:09PM +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The change in the signature of list_commands() is not part of this
> patch.  So at least one of your commits should result in an
> uncompileable revision...

Right. I just squashed patch 4 and 5, and this solves the problem: patch
3 changes the signature and fixes all usage (in help.c, it's not used
outside help.c), then the squashed patch introduces the usage of the new
list_commands() in builtin-merge.c.

(Also in the 'merge-custom' branch of vmiklos.git on repo.or.cz.)

 builtin-merge.c |   32 +++++++++++++++++++++++++-------
 1 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e78fa18..29826b1 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -22,6 +22,7 @@
 #include "log-tree.h"
 #include "color.h"
 #include "rerere.h"
+#include "help.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -77,7 +78,7 @@ static int option_parse_message(const struct option *opt,
 static struct strategy *get_strategy(const char *name)
 {
 	int i;
-	struct strbuf err;
+	struct strategy *ret;
 
 	if (!name)
 		return NULL;
@@ -86,12 +87,29 @@ static struct strategy *get_strategy(const char *name)
 		if (!strcmp(name, all_strategy[i].name))
 			return &all_strategy[i];
 
-	strbuf_init(&err, 0);
-	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
-		strbuf_addf(&err, " %s", all_strategy[i].name);
-	fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
-	fprintf(stderr, "Available strategies are:%s.\n", err.buf);
-	exit(1);
+	if (!is_git_command(name, "git-merge-")) {
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
+		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
+		list_commands("git-merge-", "strategies", &not_strategies);
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
