From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH 3/4] remote prune: print the list of pruned branches
Date: Tue, 10 Jun 2008 16:51:35 +0200
Message-ID: <1213109495-6974-1-git-send-email-dkr+ml.git@free.fr>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65D0-0004Fk-72
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbYFJOvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbYFJOvb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:51:31 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50731 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035AbYFJOva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:51:30 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 68ABD12B6D3;
	Tue, 10 Jun 2008 16:51:29 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D7B4812B758;
	Tue, 10 Jun 2008 16:51:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.160.gd660c
In-Reply-To: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84510>

From: Olivier Marin <dkr@freesurf.fr>

This command is really too quiet which make it unconfortable to use.

Also implement a --dry-run option, in place of the original -n one, to
list stale tracking branches that will be pruned, but do not actually
prune them.

Add a test case for --dry-run.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 Documentation/git-remote.txt |    7 +++----
 builtin-remote.c             |   20 ++++++++++++++++----
 t/t5505-remote.sh            |   18 ++++++++++++++++++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 7bd024e..345943a 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git-remote' rm <name>
 'git-remote' show [-n] <name>
-'git-remote' prune <name>
+'git-remote' prune [-n | --dry-run] <name>
 'git-remote' update [group]
 
 DESCRIPTION
@@ -80,9 +80,8 @@ These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in
 "remotes/<name>".
 +
-With `-n` option, the remote heads are not confirmed first with `git
-ls-remote <name>`; cached information is used instead.  Use with
-caution.
+With `--dry-run` option, report what branches will be pruned, but do no
+actually prune them.
 
 'update'::
 
diff --git a/builtin-remote.c b/builtin-remote.c
index 745a4ee..851bdde 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -521,12 +521,14 @@ static int show(int argc, const char **argv)
 	return result;
 }
 
+#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+
 static int prune(int argc, const char **argv)
 {
-	int no_query = 0, result = 0;
+	int dry_run = 0, result = 0;
 	struct option options[] = {
 		OPT_GROUP("prune specific options"),
-		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
+		OPT__DRY_RUN(&dry_run),
 		OPT_END()
 	};
 	struct ref_states states;
@@ -540,11 +542,21 @@ static int prune(int argc, const char **argv)
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, !no_query);
+		get_remote_ref_states(*argv, &states, 1);
+
+		printf("Pruning %s\n", *argv);
+		if (states.stale.nr)
+			printf("From: %s\n", states.remote->url[0]);
 
 		for (i = 0; i < states.stale.nr; i++) {
 			const char *refname = states.stale.items[i].util;
-			result |= delete_ref(refname, NULL);
+
+			if (!dry_run)
+				result |= delete_ref(refname, NULL);
+
+			printf(" * %-*s %s\n", SUMMARY_WIDTH, "[stale branch]",
+				refname + strlen("refs/remotes/")
+				+ strlen(*argv) + 1);
 		}
 
 		/* NEEDSWORK: free remote */
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c6a7bfb..c27cfad 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -165,6 +165,24 @@ test_expect_success 'prune' '
 	 ! git rev-parse refs/remotes/origin/side)
 '
 
+cat > test/expect << EOF
+Pruning origin
+From: $(pwd)/one/.git
+ * [stale branch]    side2
+EOF
+
+test_expect_success 'prune --dry-run' '
+	(cd one &&
+	 git branch -m side2 side) &&
+	(cd test &&
+	 git remote prune --dry-run origin > output &&
+	 git rev-parse refs/remotes/origin/side2 &&
+	 ! git rev-parse refs/remotes/origin/side &&
+	(cd ../one &&
+	 git branch -m side side2) &&
+	 test_cmp expect output)
+'
+
 test_expect_success 'add --mirror && prune' '
 	(mkdir mirror &&
 	 cd mirror &&
-- 
1.5.6.rc2.160.gd660c
