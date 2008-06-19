From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] Add option to git-branch to set up automatic rebasing
Date: Thu, 19 Jun 2008 02:53:22 +0200
Message-ID: <1213836802-3163-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 02:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K98Pw-0002SI-Lu
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 02:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867AbYFSAxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 20:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756705AbYFSAx3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 20:53:29 -0400
Received: from smtp-2.orange.nl ([193.252.22.242]:10680 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754730AbYFSAx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 20:53:29 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6108.online.nl (SMTP Server) with ESMTP id BE9E17000085;
	Thu, 19 Jun 2008 02:53:27 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6108.online.nl (SMTP Server) with ESMTP id 2D2917000084;
	Thu, 19 Jun 2008 02:53:23 +0200 (CEST)
X-ME-UUID: 20080619005325185.2D2917000084@mwinf6108.online.nl
X-Mailer: git-send-email 1.5.6.rc1.153.gc1d96
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85438>

This functionality was actually introduced in
 0a02186f924aee1bd69f18ed01f645aa332ce0d1, but can only be activated by the
configuration flag. Now we can also setup auto rebasing using the --rebase
flag in git-branch or git-checkout, similar to how --track works.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 Documentation/git-branch.txt   |   12 ++++++++++--
 Documentation/git-checkout.txt |   11 ++++++++---
 builtin-branch.c               |   10 ++++++++--
 builtin-checkout.c             |    9 ++++++++-
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0fd5808..81144d1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -11,7 +11,8 @@ SYNOPSIS
 'git-branch' [--color | --no-color] [-r | -a] [--merged | --no-merged]
 	   [-v [--abbrev=<length> | --no-abbrev]]
 	   [--contains <commit>]
-'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git-branch' [--track | --no-track | --rebase] [-l] [-f]
+	   <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
 
@@ -40,7 +41,9 @@ When a local branch is started off a remote branch, git sets up the
 branch so that linkgit:git-pull[1] will appropriately merge from
 the remote branch. This behavior may be changed via the global
 `branch.autosetupmerge` configuration flag. That setting can be
-overridden by using the `--track` and `--no-track` options.
+overridden by using the `--track` and `--no-track` options. If you use
+--rebase, the branch will be set up to rebase instead of merge on pull.
+This can also be set to the default by the 'branch.autosetuprebase' flag.
 
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
@@ -121,6 +124,11 @@ OPTIONS
 --no-track::
 	Ignore the branch.autosetupmerge configuration variable.
 
+--rebase::
+	Does the same as --track, with the exception that subsequent pulls
+	will do a rebase, not a pull. This is the same as using "git pull
+	--rebase" to update the branch.
+
 --contains <commit>::
 	Only list branches which contain the specified commit.
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 3ad9760..eb114a2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-q] [-f] [[--track | --no-track] -b <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-q] [-f] [[--track | --no-track | --rebase] -b <new_branch> [-l]] [-m] [<branch>]
 'git-checkout' [<tree-ish>] <paths>...
 
 DESCRIPTION
@@ -18,8 +18,8 @@ When <paths> are not given, this command switches branches by
 updating the index and working tree to reflect the specified
 branch, <branch>, and updating HEAD to be <branch> or, if
 specified, <new_branch>.  Using -b will cause <new_branch> to
-be created; in this case you can use the --track or --no-track
-options, which will be passed to `git branch`.
+be created; in this case you can use the --track, --no-track
+and --rebase options, which will be passed to `git branch`.
 
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
@@ -63,6 +63,11 @@ OPTIONS
 --no-track::
 	Ignore the branch.autosetupmerge configuration variable.
 
+--rebase::
+	Does the same as --track, with the exception that subsequent pulls
+	will do a rebase, not a pull. This is the same as using "git pull
+	--rebase" to update the branch.
+
 -l::
 	Create the new branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
diff --git a/builtin-branch.c b/builtin-branch.c
index d279702..b1ba920 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -18,7 +18,7 @@ static const char * const builtin_branch_usage[] = {
 	"git-branch [options] [-r | -a] [--merged | --no-merged]",
 	"git-branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git-branch [options] [-r] (-d | -D) <branchname>",
-	"git-branch [options] (-m | -M) [<oldbranch>] <newbranch>",
+	"git-branch [options] [--track | --no-track | --rebase] (-m | -M) [<oldbranch>] <newbranch>",
 	NULL
 };
 
@@ -425,7 +425,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0;
+	int reflog = 0, rebase = 0;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -457,6 +457,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already exists)"),
+		OPT_BOOLEAN(0, "rebase", &rebase, "Setup automatic rebasing. Implies --track"),
 		OPT_SET_INT(0, "merged", &mergefilter, "list only merged branches", 1),
 		OPT_END(),
 	};
@@ -471,6 +472,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
 
+	if (rebase) {
+		autorebase = AUTOREBASE_ALWAYS;
+		track = BRANCH_TRACK_EXPLICIT;
+	}
+
 	head = resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 93ea69b..ee4fb09 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -500,6 +500,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts opts;
 	unsigned char rev[20];
 	const char *arg;
+	int rebase = 0;
 	struct branch_info new;
 	struct tree *source_tree = NULL;
 	struct option options[] = {
@@ -508,6 +509,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
 		OPT_SET_INT('t', "track",  &opts.track, "track",
 			BRANCH_TRACK_EXPLICIT),
+		OPT_BOOLEAN(0, "rebase", &rebase, "Setup automatic rebasing. Implies --track"),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
 		OPT_END(),
@@ -521,6 +523,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.track = git_branch_track;
 
 	argc = parse_options(argc, argv, options, checkout_usage, 0);
+	if (rebase) {
+		autorebase = AUTOREBASE_ALWAYS;
+		opts.track = BRANCH_TRACK_EXPLICIT;
+	}
+
 	if (argc) {
 		arg = argv[0];
 		if (get_sha1(arg, rev))
@@ -548,7 +555,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!opts.new_branch && (opts.track != git_branch_track))
-		die("git checkout: --track and --no-track require -b");
+		die("git checkout: --track, --no-track and --rebase require -b");
 
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
-- 
1.5.6.rc1.153.gc1d96
