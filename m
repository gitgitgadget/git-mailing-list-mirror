From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/6] builtin-merge: allow using a custom strategy
Date: Mon, 28 Jul 2008 03:21:08 +0200
Message-ID: <10c4292de30b5868bd9fb54b557e8dae827f1241.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org>
 <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
 <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 03:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHRL-0007Ey-36
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbYG1BU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbYG1BUz
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:20:55 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41576 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbYG1BUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:20:47 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id C77521DDC61
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:20:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B7BE31AB593; Mon, 28 Jul 2008 03:21:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217207602.git.vmiklos@frugalware.org>
References: <cover.1217207602.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90390>

Allow using a custom strategy, as long as it's named git-merge-foo. The
error handling is now done using is_git_command(). The list of available
strategies is now shown by list_commands().

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e78fa18..cdbc692 100644
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
@@ -86,12 +87,16 @@ static struct strategy *get_strategy(const char *name)
 		if (!strcmp(name, all_strategy[i].name))
 			return &all_strategy[i];
 
-	strbuf_init(&err, 0);
-	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
-		strbuf_addf(&err, " %s", all_strategy[i].name);
-	fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
-	fprintf(stderr, "Available strategies are:%s.\n", err.buf);
-	exit(1);
+	if (!is_git_command(name, "git-merge-")) {
+		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
+		list_commands("git-merge-", "strategies");
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
