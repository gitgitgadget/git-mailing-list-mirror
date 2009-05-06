From: Julien Danjou <julien@danjou.info>
Subject: [PATCH] git-remote: make remote name optional for prune operation
Date: Wed,  6 May 2009 18:58:01 +0200
Message-ID: <1241629081-11122-1-git-send-email-julien@danjou.info>
References: <4A01B7A7.9020308@drmicha.warpmail.net>
Cc: Julien Danjou <julien@danjou.info>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 06 18:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1kRo-0007bU-CI
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 18:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbZEFQ6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 12:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbZEFQ6L
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 12:58:11 -0400
Received: from prometheus.naquadah.org ([212.85.154.174]:37684 "EHLO
	mx1.naquadah.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbZEFQ6K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 12:58:10 -0400
Received: by mx1.naquadah.org (Postfix, from userid 8)
	id 7DFB75C09C; Wed,  6 May 2009 18:58:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	prometheus.naquadah.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from abydos.adm.naquadah.org (abydos.adm.naquadah.org [192.168.2.13])
	by mx1.naquadah.org (Postfix) with ESMTPS id 137F75C071;
	Wed,  6 May 2009 18:58:02 +0200 (CEST)
Received: from jd by abydos.adm.naquadah.org with local (Exim 4.69)
	(envelope-from <jd@abydos.adm.naquadah.org>)
	id 1M1kRV-0002xB-ES; Wed, 06 May 2009 18:58:01 +0200
X-Mailer: git-send-email 1.6.2.4
In-Reply-To: <4A01B7A7.9020308@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118356>

If `git remote prune` is called without a name, prune all remotes.

Signed-off-by: Julien Danjou <julien@danjou.info>
---
 Documentation/git-remote.txt |    4 +++-
 builtin-remote.c             |   26 +++++++++++++++++++++-----
 t/t5505-remote.sh            |   21 +++++++++++++++++++++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9e2b4ea..5c8477e 100644
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
@@ -116,6 +116,8 @@ referenced by <name>, but are still locally available in
 +
 With `--dry-run` option, report what branches will be pruned, but do no
 actually prune them.
+If <name> is not set, all stale branches from all remote repositories will
+be deleted.
 
 'update'::
 
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
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5ec668d..cfb7922 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -223,6 +223,27 @@ test_expect_success 'prune' '
 	 test_must_fail git rev-parse refs/remotes/origin/side)
 '
 
+test_expect_success 'prune-all' '
+	(cd one &&
+	 git branch side3 side2) &&
+        (cd test &&
+         git fetch origin) &&
+        (cd one &&
+         git branch -D side3) &&
+        (cd two &&
+         git branch side2 side) &&
+        (cd test &&
+         git fetch two) &&
+        (cd two &&
+         git branch -D side2) &&
+	(cd test &&
+	 git fetch origin &&
+         git fetch two &&
+	 git remote prune &&
+	 test_must_fail git rev-parse refs/remotes/origin/side3 &&
+	 test_must_fail git rev-parse refs/remotes/two/side2)
+'
+
 test_expect_success 'set-head --delete' '
 	(cd test &&
 	 git symbolic-ref refs/remotes/origin/HEAD &&
-- 
1.6.2.4
