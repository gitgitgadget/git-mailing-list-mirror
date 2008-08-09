From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] checkout --track: make up a sensible branch name if '-b'
 was omitted
Date: Sat, 9 Aug 2008 16:00:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 09 15:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRowM-0000z5-B3
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 15:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYHINzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbYHINzi
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 09:55:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:54049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751800AbYHINzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 09:55:37 -0400
Received: (qmail invoked by alias); 09 Aug 2008 13:55:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 09 Aug 2008 15:55:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ms39b4nhMR4C3FDXD5rQ2TR2OI2ellJ0lqrOaEm
	P6vcGJSLD2wddb
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91768>


What does the user most likely want with this command?

	$ git checkout --track origin/next

Exactly.  A branch called 'next', that tracks origin's branch 'next'.
Make it so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This comes in the wake for Shawn's call for more user-friendliness.

 Documentation/git-checkout.txt |   10 +++++++++-
 builtin-checkout.c             |   21 ++++++++++++++++++---
 t/t7201-co.sh                  |   11 +++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 5aa69c0..43d4502 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout a branch or paths to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [[--track | --no-track] -b <new_branch> [-l]] [-m] [<branch>]
+'git checkout' [-q] [-f] [--track | --no-track] [-b <new_branch> [-l]] [-m] [<branch>]
 'git checkout' [<tree-ish>] [--] <paths>...
 
 DESCRIPTION
@@ -21,6 +21,10 @@ specified, <new_branch>.  Using -b will cause <new_branch> to
 be created; in this case you can use the --track or --no-track
 options, which will be passed to `git branch`.
 
+As a convenience, --track will default to create a branch whose
+name is constructed from the specified branch name by stripping
+the first namespace level.
+
 When <paths> are given, this command does *not* switch
 branches.  It updates the named paths in the working tree from
 the index file (i.e. it runs `git checkout-index -f -u`), or
@@ -59,6 +63,10 @@ OPTIONS
 	'git-checkout' and 'git-branch' to always behave as if '--no-track' were
 	given. Set it to `always` if you want this behavior when the
 	start-point is either a local or remote branch.
++
+If no '-b' option was given, a name will be made up for you, by stripping
+the part up to the first slash of the tracked branch.  For example, if you
+called 'git checkout --track origin/next', the branch name will be 'next'.
 
 --no-track::
 	Ignore the branch.autosetupmerge configuration variable.
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 411cc51..e95eab9 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -437,13 +437,28 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	opts.track = git_branch_track;
+	opts.track = -1;
 
 	argc = parse_options(argc, argv, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	if (!opts.new_branch && (opts.track != git_branch_track))
-		die("git checkout: --track and --no-track require -b");
+	/* --track without -b should DWIM */
+	if (opts.track && opts.track != -1 && !opts.new_branch) {
+		char *slash;
+		if (!argc || !strcmp(argv[0], "--"))
+			die ("--track needs a branch name");
+		slash = strchr(argv[0], '/');
+		if (slash && !prefixcmp(argv[0], "refs/"))
+			slash = strchr(slash + 1, '/');
+		if (slash && !prefixcmp(argv[0], "remotes/"))
+			slash = strchr(slash + 1, '/');
+		if (!slash || !slash[1])
+			die ("Missing branch name; try -b");
+		opts.new_branch = slash + 1;
+	}
+
+	if (opts.track == -1)
+		opts.track = git_branch_track;
 
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9ad5d63..943dd57 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -337,4 +337,15 @@ test_expect_success \
     test refs/heads/delete-me = "$(git symbolic-ref HEAD)" &&
     test_must_fail git checkout --track -b track'
 
+test_expect_success \
+    'checkout with --track fakes a sensible -b <name>' '
+    git update-ref refs/remotes/origin/koala/bear renamer &&
+    git checkout --track origin/koala/bear &&
+    test "refs/heads/koala/bear" = "$(git symbolic-ref HEAD)" &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"'
+
+test_expect_success \
+    'checkout with --track, but without -b, fails with too short tracked name' '
+    test_must_fail git checkout --track renamer'
+
 test_done
-- 
1.6.0.rc2.26.g0d7ea
