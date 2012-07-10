From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 18:52:59 +0200
Message-ID: <1341939181-8962-2-git-send-email-cmn@elego.de>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 18:53:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SodgO-0004BT-6S
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 18:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412Ab2GJQwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 12:52:51 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56649 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756397Ab2GJQwm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 12:52:42 -0400
Received: from centaur.lab.cmartin.tk (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id BB3EE4614A;
	Tue, 10 Jul 2012 18:52:37 +0200 (CEST)
Received: (nullmailer pid 9002 invoked by uid 1000);
	Tue, 10 Jul 2012 16:53:01 -0000
X-Mailer: git-send-email 1.7.10.2.1.g8c77c3c
In-Reply-To: <1341939181-8962-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201263>

The existing --set-uptream option can cause confusion, as it uses the
usual branch convention of assuming a starting point of HEAD if none
is specified, causing

    git branch --set-upstream origin/master

to create a new local branch 'origin/master' that tracks the current
branch. As --set-upstream already exists, we can't simply change its
behaviour. To work around this, introduce --set-upstream-to which
accepts a compulsory argument indicating what the new upstream branch
should be and one optinal argument indicating which branch to change,
defaulting to HEAD.

The new options allows us to type

    git branch --set-upstream-to origin/master

to set the current branch's upstream to be origin's master.
---
 Documentation/git-branch.txt |    9 ++++++++-
 builtin/branch.c             |   15 +++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 47235be..0f33fc7 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 	[--column[=<options>] | --no-column]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
+'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
@@ -48,7 +49,7 @@ branch so that 'git pull' will appropriately merge from
 the remote-tracking branch. This behavior may be changed via the global
 `branch.autosetupmerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options, and
-changed later using `git branch --set-upstream`.
+changed later using `git branch --set-upstream-to`.
 
 With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
@@ -173,6 +174,12 @@ start-point is either a local or remote-tracking branch.
 	like `--track` would when creating the branch, except that where
 	branch points to is not changed.
 
+-u <upstream>::
+--set-upstream-to=<upstream>::
+	Set up <branchname>'s tracking information so <upstream> is
+	considered <branchname>'s upstream branch. If no branch is
+	specified it defaults to the current branch.
+
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..c886fc0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -713,6 +713,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
 	int quiet = 0;
+	const char *new_upstream = NULL;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -726,6 +727,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
+		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
 		OPT__COLOR(&branch_use_color, "use colored output"),
 		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
@@ -794,10 +796,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && argc == 0)
+	if (!delete && !rename && !edit_description && !new_upstream && argc == 0)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!list > 1)
+	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
@@ -852,6 +854,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
 			usage_with_options(builtin_branch_usage, options);
+	} else if (new_upstream) {
+		struct branch *branch = branch_get(argv[0]);
+
+		if (!ref_exists(branch->refname))
+		  die(_("branch '%s' does not exist"), branch->name);
+
+		/* create_branch takes care of setting up the tracking
+		   info and making sure new_upstream is correct */
+		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
 	} else if (argc > 0 && argc <= 2) {
 		if (kinds != REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
-- 
1.7.10.2.1.g8c77c3c
