From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] push: Add "--current", which pushes only the current branch
Date: Mon, 19 Nov 2007 17:51:57 +0100
Message-ID: <11954911172958-git-send-email-prohaska@zib.de>
References: <3FB7B6E8-FC22-4FDF-BDAD-08312202B29A@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 17:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu9x1-0005xl-Mq
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbXKSQ6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbXKSQ6G
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:58:06 -0500
Received: from mailer.zib.de ([130.73.108.11]:50531 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbXKSQ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:58:04 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAJGpvOQ024700;
	Mon, 19 Nov 2007 17:51:57 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAJGpvlZ022115;
	Mon, 19 Nov 2007 17:51:57 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <3FB7B6E8-FC22-4FDF-BDAD-08312202B29A@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65466>

Pushing only the current branch to the default remote was awkward
in the past.  You needed to remember the default remote and type
"git push $remote $current".  A recent commit added support for
"git push $remote HEAD".  But still you need to remember and type
the remote.

This commit teaches push a short-cut: "git push --current" now
pushes the current branch to the default remote.

Note, this commit doesn't save you much if you want to push the
current branch to a remote that is not the default:  You can now
say either "git push --current foo" or "git push foo HEAD".

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-push.txt |    6 +++++-
 builtin-push.c             |   14 ++++++++++++--
 t/t5516-fetch-push.sh      |   25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

Eventually, I gave in.  I accepted that the default is to push
matching branches.  I'll not send further patches that try to
change this.  This is the last patch.

The patch applies on top of sp/refspec-match.

    Steffen

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4a68aab..6ec6078 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
+'git-push' [--all] [--current] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
            [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
 
 DESCRIPTION
@@ -63,6 +63,10 @@ the remote repository.
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
 
+\--current::
+	Instead of naming each ref to push, specifies that only the
+	current branch is pushed.
+
 \--dry-run::
 	Do everything except actually send the updates.
 
diff --git a/builtin-push.c b/builtin-push.c
index 54fba0e..c5243ca 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git-push [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git-push [--all] [--current] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -100,6 +100,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
 	int all = 0;
+	int current = 0;
 	int dry_run = 0;
 	int force = 0;
 	int tags = 0;
@@ -109,6 +110,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
 		OPT_BOOLEAN( 0 , "all", &all, "push all refs"),
+		OPT_BOOLEAN( 0 , "current", &current, "push current branch"),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BOOLEAN( 0 , "dry-run", &dry_run, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force updates"),
@@ -135,8 +137,16 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1);
 	}
-	if ((flags & TRANSPORT_PUSH_ALL) && refspec)
+	if ((all != 0) + (current != 0) > 1) {
+		fprintf(stderr, "--all and --current are mutual exclusive.\n");
 		usage_with_options(push_usage, options);
+	}
+	if ((all || current) && refspec)
+		usage_with_options(push_usage, options);
+	if (current) {
+		const char* head[1] = { "HEAD" };
+		set_refspecs(head, 1);
+	}
 
 	return do_push(repo, flags);
 }
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index fd5f284..11c078a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -100,6 +100,14 @@ test_expect_success 'fetch with wildcard' '
 	)
 '
 
+test_expect_code 129 'push: --current and --all mutual exclusive' '
+	git push --all --current testrepo
+'
+
+test_expect_code 129 'push: --current and refspec mutual exclusive' '
+	git push --current testrepo master
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty &&
 
@@ -271,6 +279,23 @@ test_expect_success 'push with HEAD nonexisting at remote' '
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
1.5.3.5.742.gb61a8b
