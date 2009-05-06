From: Julien Danjou <julien@danjou.info>
Subject: [PATCH] git-remote: make remote name optional for prune operation
Date: Wed,  6 May 2009 16:37:01 +0200
Message-ID: <1241620621-12188-1-git-send-email-julien@danjou.info>
Cc: Julien Danjou <julien@danjou.info>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 06 16:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1iFv-0003sE-D3
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 16:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbZEFOhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 10:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756186AbZEFOhM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 10:37:12 -0400
Received: from prometheus.naquadah.org ([212.85.154.174]:42739 "EHLO
	mx1.naquadah.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbZEFOhL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 10:37:11 -0400
Received: by mx1.naquadah.org (Postfix, from userid 8)
	id EFA675C09C; Wed,  6 May 2009 16:37:10 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	prometheus.naquadah.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from abydos.adm.naquadah.org (abydos.adm.naquadah.org [192.168.2.13])
	by mx1.naquadah.org (Postfix) with ESMTPS id 4ED0C5C088;
	Wed,  6 May 2009 16:37:02 +0200 (CEST)
Received: from jd by abydos.adm.naquadah.org with local (Exim 4.69)
	(envelope-from <jd@abydos.adm.naquadah.org>)
	id 1M1iF3-0003B5-OU; Wed, 06 May 2009 16:37:01 +0200
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118344>

We consider that if `git remote prune` is called without a name, we
actually want to prune all remotes.

Signed-off-by: Julien Danjou <julien@danjou.info>
---
 Documentation/git-remote.txt |    2 +-
 builtin-remote.c             |   26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9e2b4ea..c566061 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git remote rm' <name>
 'git remote set-head' <name> [-a | -d | <branch>]
 'git remote show' [-n] <name>
-'git remote prune' [-n | --dry-run] <name>
+'git remote prune' [-n | --dry-run] [name]
 'git remote update' [-p | --prune] [group | remote]...
 
 DESCRIPTION
diff --git a/builtin-remote.c b/builtin-remote.c
index 2ed752c..053d886 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote rm <name>",
 	"git remote set-head <name> [-a | -d | <branch>]",
 	"git remote show [-n] <name>",
-	"git remote prune [-n | --dry-run] <name>",
+	"git remote prune [-n | --dry-run] [name]",
 	"git remote [-v | --verbose] update [-p | --prune] [group]",
 	NULL
 };
@@ -25,6 +25,7 @@ static const char * const builtin_remote_usage[] = {
 
 static int verbose;
 
+static int get_one_entry(struct remote *remote, void *priv);
 static int show_all(void);
 static int prune_remote(const char *remote, int dry_run);
 
@@ -1133,10 +1134,25 @@ static int prune(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
 	if (argc < 1)
-		usage_with_options(builtin_remote_usage, options);
+	{
+		struct string_list list = { NULL, 0, 0 };
+		int result = for_each_remote(get_one_entry, &list);
+
+		if (!result) {
+			int i;
 
-	for (; argc; argc--, argv++)
-		result |= prune_remote(*argv, dry_run);
+			sort_string_list(&list);
+			for (i = 0; i < list.nr; i++) {
+				struct string_list_item *item = list.items + i;
+				if (i && !strcmp((item - 1)->string, item->string))
+				       continue;
+				result |= prune_remote(item->string, dry_run);
+			}
+		}
+	}
+	else
+		for (; argc; argc--, argv++)
+			result |= prune_remote(*argv, dry_run);
 
 	return result;
 }
-- 
1.6.2.4
