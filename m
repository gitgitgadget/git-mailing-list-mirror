From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] git-push: add a --delete flag to allow branch deletion
Date: Thu, 19 Jun 2008 16:13:07 +0200
Message-ID: <1213884787-24692-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 16:14:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ktx-0007Pp-BV
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 16:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbYFSONL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 10:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbYFSONL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 10:13:11 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:36239 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754672AbYFSONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 10:13:09 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6204.online.nl (SMTP Server) with ESMTP id 293261C00095;
	Thu, 19 Jun 2008 16:13:08 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6204.online.nl (SMTP Server) with ESMTP id 90E891C00091;
	Thu, 19 Jun 2008 16:13:07 +0200 (CEST)
X-ME-UUID: 20080619141307593.90E891C00091@mwinf6204.online.nl
X-Mailer: git-send-email 1.5.6.rc1.153.gc1d96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85478>

While this is already possible with the :<dst> refspec syntax,
a flag specifically for this action is more userfriendly.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

The question on how to delete remote branches appears frequently in the
irc channel. If we add an explicit option to do this to git push, hopefully
it will be more clear.

 Documentation/git-push.txt |   13 ++++++++++++-
 builtin-push.c             |   37 +++++++++++++++++++++++++++++++++++--
 t/t5516-fetch-push.sh      |   13 +++++++++++++
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 89e0049..6a772a5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -11,6 +11,8 @@ SYNOPSIS
 [verse]
 'git-push' [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>]
            [--repo=all] [-f | --force] [-v | --verbose] [<repository> <refspec>...]
+'git push' --delete <repository> <branchname> [<branch2> ...]
+
 
 DESCRIPTION
 -----------
@@ -18,6 +20,8 @@ DESCRIPTION
 Updates remote refs using local refs, while sending objects
 necessary to complete the given refs.
 
+In the second form, deletes one or more branches on a given repository.
+
 You can make interesting things happen to a repository
 every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
@@ -52,7 +56,7 @@ A parameter <ref> without a colon pushes the <ref> from the source
 repository to the destination repository under the same name.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
-the remote repository.
+the remote repository. The same can be done by using the --delete flag.
 +
 The special refspec `:` (or `+:` to allow non-fast forward updates)
 directs git to push "matching" heads: for every head that exists on
@@ -75,6 +79,10 @@ nor in any Push line of the corresponding remotes file---see below).
 	if the configuration option `remote.<remote>.mirror` is
 	set.
 
+--delete::
+	Does not push anything, but instead deletes <branchname> on the
+	remote repository.
+
 --dry-run::
 	Do everything except actually send the updates.
 
@@ -179,6 +187,9 @@ git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
 
+git push --delete origin experimental::
+	Does the same as the above, but is more friendly.
+
 git push origin master:satellite/master::
 	Find a ref that matches `master` in the source repository
 	(most likely, it would find `refs/heads/master`), and update
diff --git a/builtin-push.c b/builtin-push.c
index b35aad6..81f9a58 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,8 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git-push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push --delete <repository> <branchname> [<branch2> ...]",
 	NULL,
 };
 
@@ -48,6 +49,24 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
+static void set_delete_refspecs(const char **branches, int nr)
+{
+	int i;
+	for (i = 0; i < nr; i++) {
+		const char *branch = branches[i];
+		int len;
+		char *delete_refspec;
+
+		if (strchr(branch, ':'))
+			die("%s is not a valid branchname", branch);
+		len = strlen(branch) + 1;
+		delete_refspec = xmalloc(len);
+		*delete_refspec = ':';
+		strcpy(delete_refspec + 1, branch);
+		add_refspec(delete_refspec);
+	}
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -108,6 +127,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
+	int delete = 0;
 
 	struct option options[] = {
 		OPT__VERBOSE(&verbose),
@@ -118,6 +138,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "dry-run", &dry_run, "dry run"),
 		OPT_BOOLEAN('f', "force", &force, "force updates"),
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
+		OPT_BOOLEAN('d', "delete", &delete, "delete remote branch"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
 		OPT_END()
@@ -125,6 +146,18 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, push_usage, 0);
 
+	if (delete) {
+		if (all || mirror || tags || force || repo)
+			die("--delete cannot be used with --all, --mirror, --tags, --farce or --repo");
+
+		if (argc == 0)
+			die("Need a remote on which to delete a branch");
+		if (argc == 1)
+			die("Need a branch on the remote to delete");
+		repo = argv[0];
+		set_delete_refspecs(argv + 1, argc - 1);
+	}
+
 	if (force)
 		flags |= TRANSPORT_PUSH_FORCE;
 	if (dry_run)
@@ -138,7 +171,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	if (mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
 
-	if (argc > 0) {
+	if (!delete && argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1);
 	}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6805032..42fe89c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -361,6 +361,19 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 	git push testrepo HEAD &&
 	check_push_result $the_commit heads/local
 '
+test_expect_success 'delete with --delete syntax' '
+
+	git push testrepo master:test1 &&
+	git push --delete testrepo test1 &&
+	git push testrepo master:test1 master:test2 &&
+	check_push_result $the_commit heads/test1 &&
+	check_push_result $the_commit heads/test2 &&
+	git push --delete testrepo test1 test2 &&
+	!(check_push_result $the_commit heads/test1) &&
+	!(check_push_result $the_commit heads/test2) &&
+	test_must_fail git push --delete testrepo test1
+
+'
 
 test_expect_success 'push with +HEAD' '
 
-- 
1.5.6.rc1.153.gc1d96
