From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Sun, 18 Nov 2007 17:13:08 +0100
Message-ID: <119540238994-git-send-email-prohaska@zib.de>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>
 <11954023881802-git-send-email-prohaska@zib.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 17:13:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itmm6-00070z-AJ
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 17:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXKRQNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 11:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbXKRQNR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 11:13:17 -0500
Received: from mailer.zib.de ([130.73.108.11]:41040 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbXKRQNP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 11:13:15 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAIGD9CM028307;
	Sun, 18 Nov 2007 17:13:09 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAIGD8oR009426;
	Sun, 18 Nov 2007 17:13:09 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <11954023881802-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65374>

Often you want to push only the current branch to the default
remote.  This was awkward to do in the past.  You needed to
remember the default remote and type "git push $remote HEAD".

This commit teaches push to do this if you use '--current'.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-push.txt |    6 +++++-
 builtin-push.c             |   16 +++++++++++-----
 t/t5516-fetch-push.sh      |   29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index d2417f3..2dfaf50 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git-push' [--all] [--matching] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
+'git-push' [--all] [--matching] [--current] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
            [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
 
 DESCRIPTION
@@ -69,6 +69,10 @@ the remote repository.
 	the branch exists locally and at the remote under the same name.
 	Currently, this is the default.  But this will change in the future.
 
+\--current::
+	Instead of naming each ref to push, specifies that only the
+	current branch be pushed.
+
 \--dry-run::
 	Do everything except actually send the updates.
 
diff --git a/builtin-push.c b/builtin-push.c
index 7e9dcf1..e5646d4 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git-push [--all] [--matching] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git-push [--all] [--matching] [--current] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -101,6 +101,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int flags = 0;
 	int all = 0;
 	int matching = 0;
+	int current = 0;
 	int dry_run = 0;
 	int force = 0;
 	int tags = 0;
@@ -111,6 +112,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BOOLEAN( 0 , "all", &all, "push all refs"),
 		OPT_BOOLEAN( 0 , "matching", &matching, "push matching refs"),
+		OPT_BOOLEAN( 0 , "current", &current, "push current branch"),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BOOLEAN( 0 , "dry-run", &dry_run, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force updates"),
@@ -137,15 +139,19 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1);
 	}
-	if ((all != 0) + (matching != 0) > 1) {
-		fprintf(stderr, "--all and --matching are mutual exclusive.\n");
+	if ((all != 0) + (matching != 0) + (current != 0) > 1) {
+		fprintf(stderr, "--all, --matching, and --current are mutual exclusive.\n");
 		usage_with_options(push_usage, options);
 	}
-	if ((all || matching) && refspec)
+	if ((all || matching || current) && refspec)
 		usage_with_options(push_usage, options);
-	if (!all && !matching && !refspec)
+	if (!all && !matching && !current && !refspec)
 		fprintf(stderr, "Warning: assuming '--matching'."
 		                " This default will change in the future.\n");
+	if (current) {
+		const char* head[1] = { "HEAD" };
+		set_refspecs(head, 1);
+	}
 
 	return do_push(repo, flags);
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 21aa7c3..20e0796 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -113,6 +113,18 @@ test_expect_success 'push command line options (3)' '
 	grep -q "Warning: assuming.*--matching" stderr.txt
 '
 
+test_expect_code 129 'push command line options (4)' '
+	git push --all --current testrepo
+'
+
+test_expect_code 129 'push command line options (5)' '
+	git push --matching --current testrepo
+'
+
+test_expect_code 129 'push command line options (6)' '
+	git push --current testrepo master
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty &&
 
@@ -284,6 +296,23 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 	check_push_result $the_commit heads/local
 '
 
+test_expect_success 'push with --current' '
+
+	mk_test heads/master &&
+	git checkout master &&
+	git push --current testrepo &&
+	check_push_result $the_commit heads/master
+
+'
+
+test_expect_success 'push with --current nonexisting at remote' '
+
+	mk_test heads/master &&
+	git checkout local &&
+	git push --current testrepo &&
+	check_push_result $the_commit heads/local
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-- 
1.5.3.5.743.g87c5c
