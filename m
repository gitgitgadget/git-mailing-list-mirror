From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 4/7] builtin-merge: allow using a custom strategy
Date: Sat, 26 Jul 2008 13:54:48 +0200
Message-ID: <99c90877657be0ed439a9918f500d6ad132550a2.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org>
 <1217073292-27945-1-git-send-email-vmiklos@frugalware.org>
 <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
 <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:55:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMiNE-0002Vg-M4
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYGZLym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYGZLyi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:54:38 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54449 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbYGZLy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:54:27 -0400
Received: from vmobile.example.net (dsl5401C493.pool.t-online.hu [84.1.196.147])
	by yugo.frugalware.org (Postfix) with ESMTP id D205C1DDC60
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 13:54:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B32191AB593; Sat, 26 Jul 2008 13:54:52 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1217037178.git.vmiklos@frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90214>

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
