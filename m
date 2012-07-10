From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 3/3] branch: add --unset-upstream option
Date: Tue, 10 Jul 2012 18:53:01 +0200
Message-ID: <1341939181-8962-4-git-send-email-cmn@elego.de>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 18:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SodgN-0004BT-LL
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 18:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440Ab2GJQwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 12:52:47 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56658 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756435Ab2GJQwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 12:52:43 -0400
Received: from centaur.lab.cmartin.tk (p4FC5CD3B.dip.t-dialin.net [79.197.205.59])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 09DAF4614C;
	Tue, 10 Jul 2012 18:52:39 +0200 (CEST)
Received: (nullmailer pid 9006 invoked by uid 1000);
	Tue, 10 Jul 2012 16:53:01 -0000
X-Mailer: git-send-email 1.7.10.2.1.g8c77c3c
In-Reply-To: <1341939181-8962-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201262>

We have ways of setting the upstream information, but if we want to
unset it, we need to resort to modifying the configuration manually.

Teach branch an --unset-upstream option that unsets this information.

---

create_branch() uses install_branch_config() which may also set
branch.foo.rebase, so this version might leave some configuration
laying around.

I wonder if deleting the whole branch.foo section would be better. Can
we be sure that nothing else shows up there?

 Documentation/git-branch.txt |    5 +++++
 builtin/branch.c             |   17 ++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0f33fc7..c7cab08 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
+'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
@@ -180,6 +181,10 @@ start-point is either a local or remote-tracking branch.
 	considered <branchname>'s upstream branch. If no branch is
 	specified it defaults to the current branch.
 
+--unset-upstream::
+	Remove the upstream information for <branchname>. If no branch
+	is specified it defaults to the current branch.
+
 --edit-description::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `request-pull`).
diff --git a/builtin/branch.c b/builtin/branch.c
index 5551227..1d1bf8e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -712,7 +712,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int delete = 0, rename = 0, force_create = 0, list = 0;
 	int verbose = 0, abbrev = -1, detached = 0;
 	int reflog = 0, edit_description = 0;
-	int quiet = 0;
+	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
@@ -728,6 +728,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
+		OPT_BOOLEAN(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
 		OPT__COLOR(&branch_use_color, "use colored output"),
 		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking branches",
 			REF_REMOTE_BRANCH),
@@ -796,10 +797,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && !new_upstream && argc == 0)
+	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream > 1)
+	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (abbrev == -1)
@@ -863,6 +864,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		/* create_branch takes care of setting up the tracking
 		   info and making sure new_upstream is correct */
 		create_branch(head, branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+	} else if (unset_upstream) {
+		struct branch *branch = branch_get(argv[0]);
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_addf(&buf, "branch.%s.remote", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "branch.%s.merge", branch->name);
+		git_config_set_multivar(buf.buf, NULL, NULL, 1);
+		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
 		const char *old_upstream = NULL;
-- 
1.7.10.2.1.g8c77c3c
