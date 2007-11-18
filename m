From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/2] push: Add '--matching' option and print warning if it should be used
Date: Sun, 18 Nov 2007 17:13:07 +0100
Message-ID: <11954023881802-git-send-email-prohaska@zib.de>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 17:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itmm5-00070z-LG
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 17:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXKRQNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 11:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbXKRQNO
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 11:13:14 -0500
Received: from mailer.zib.de ([130.73.108.11]:41036 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbXKRQNO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 11:13:14 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAIGD9Fv028306;
	Sun, 18 Nov 2007 17:13:09 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAIGD8oQ009426;
	Sun, 18 Nov 2007 17:13:08 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <Pine.LNX.4.64.0711121501500.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65373>

This on the road to
1) "git push --matching" pushes matching branches.
2) "git push --current" pushes only current branch.
3) "git push" reports error if the config does not contain a Push line.
   (after it reported a warning for a while).

Maybe in two years (that's twice an eternity in git time scales):

4) make "git push --current" the default.

This commit adds '--matching', which is a no-op at this point.
If appropriate, a warning is printed to tell the user that the
default will change in the future.

Thanks to Dscho for suggesting this.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-push.txt |    8 +++++++-
 builtin-push.c             |   13 +++++++++++--
 t/t5516-fetch-push.sh      |   13 +++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

So here is '--matching'. And PATCH 2/2 will bring '--current'.
They apply on top of sp/refspec-match.

    Steffen

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4a68aab..d2417f3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
+'git-push' [--all] [--matching] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
            [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
 
 DESCRIPTION
@@ -63,6 +63,12 @@ the remote repository.
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
 
+\--matching::
+	Instead of naming each ref to push, specifies that matching
+	refs under `$GIT_DIR/refs/heads/` be pushed.  Matching means
+	the branch exists locally and at the remote under the same name.
+	Currently, this is the default.  But this will change in the future.
+
 \--dry-run::
 	Do everything except actually send the updates.
 
diff --git a/builtin-push.c b/builtin-push.c
index 54fba0e..7e9dcf1 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git-push [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git-push [--all] [--matching] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -100,6 +100,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
 	int all = 0;
+	int matching = 0;
 	int dry_run = 0;
 	int force = 0;
 	int tags = 0;
@@ -109,6 +110,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BOOLEAN( 0 , "all", &all, "push all refs"),
+		OPT_BOOLEAN( 0 , "matching", &matching, "push matching refs"),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BOOLEAN( 0 , "dry-run", &dry_run, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force updates"),
@@ -135,8 +137,15 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1);
 	}
-	if ((flags & TRANSPORT_PUSH_ALL) && refspec)
+	if ((all != 0) + (matching != 0) > 1) {
+		fprintf(stderr, "--all and --matching are mutual exclusive.\n");
 		usage_with_options(push_usage, options);
+	}
+	if ((all || matching) && refspec)
+		usage_with_options(push_usage, options);
+	if (!all && !matching && !refspec)
+		fprintf(stderr, "Warning: assuming '--matching'."
+		                " This default will change in the future.\n");
 
 	return do_push(repo, flags);
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fd5f284..21aa7c3 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -100,6 +100,19 @@ test_expect_success 'fetch with wildcard' '
 	)
 '
 
+test_expect_code 129 'push command line options (1)' '
+	git push --all --matching testrepo
+'
+
+test_expect_code 129 'push command line options (2)' '
+	git push --matching testrepo master
+'
+
+test_expect_success 'push command line options (3)' '
+	git push testrepo 2>stderr.txt &&
+	grep -q "Warning: assuming.*--matching" stderr.txt
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty &&
 
-- 
1.5.3.5.743.g87c5c
