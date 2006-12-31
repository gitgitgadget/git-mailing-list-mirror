From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC/PATCH 4/4] Disallow working directory commands in a bare repository.
Date: Sat, 30 Dec 2006 23:32:38 -0500
Message-ID: <20061231043238.GD5823@spearce.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 05:32:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0sNJ-0003MR-OR
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 05:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWLaEcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 23:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWLaEcm
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 23:32:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43067 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbWLaEcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 23:32:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0sN1-00006R-CO; Sat, 30 Dec 2006 23:32:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A069920FB65; Sat, 30 Dec 2006 23:32:38 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35665>

If the user tries to run a porcelainish command which requires
a working directory in a bare repository they may get unexpected
results which are difficult to predict and may differ from command
to command.

Instead we should detect that the current repository is a bare
repository and refuse to run the command there, as there is no
working directory associated with it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is more of an RFC than an actual patch.  I think its a good
 idea (clearly, as I spent the time to write it) but this may break
 users who explicitly set GIT_DIR to some path which doesn't end in
 "/.git" (e.g. GIT_DIR=$HOME/foo.git).

 I've tried to only alter poreclainish and leave plumbing alone,
 under the rationale that a different Porcelain may have different
 behavior with regards to GIT_DIR.

 git-am.sh       |    1 +
 git-checkout.sh |    1 +
 git-clean.sh    |    1 +
 git-commit.sh   |    1 +
 git-merge.sh    |    1 +
 git-pull.sh     |    1 +
 git-rebase.sh   |    1 +
 git-reset.sh    |    1 +
 git-revert.sh   |    1 +
 git-sh-setup.sh |    7 +++++++
 git.c           |   11 +++++++----
 11 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c3bbd78..8487e75 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -7,6 +7,7 @@ USAGE='[--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way]
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 set_reflog_action am
+require_not_bare
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
 
diff --git a/git-checkout.sh b/git-checkout.sh
index 92ec069..b2d2dfa 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -3,6 +3,7 @@
 USAGE='[-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
+require_not_bare
 
 old_name=HEAD
 old=$(git-rev-parse --verify $old_name 2>/dev/null)
diff --git a/git-clean.sh b/git-clean.sh
index 3834323..79c5bad 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -14,6 +14,7 @@ When optional <paths>... arguments are given, the paths
 affected are further limited to those that match them.'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
+require_not_bare
 
 ignored=
 ignoredonly=
diff --git a/git-commit.sh b/git-commit.sh
index 6bce41a..813f41c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -6,6 +6,7 @@
 USAGE='[-a] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit>] [-u] [--amend] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
+require_not_bare
 
 git-rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
 branch=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD)
diff --git a/git-merge.sh b/git-merge.sh
index ba42260..d91ff0d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -7,6 +7,7 @@ USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commi
 
 . git-sh-setup
 set_reflog_action "merge $*"
+require_not_bare
 
 LF='
 '
diff --git a/git-pull.sh b/git-pull.sh
index 28d0819..1d91386 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -8,6 +8,7 @@ USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <rep
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
 set_reflog_action "pull $*"
+require_not_bare
 
 strategy_args= no_summary= no_commit= squash=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
diff --git a/git-rebase.sh b/git-rebase.sh
index 828c59c..fd58e8e 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -29,6 +29,7 @@ Example:       git-rebase master~1 topic
 '
 . git-sh-setup
 set_reflog_action rebase
+require_not_bare
 
 RESOLVEMSG="
 When you have resolved this problem run \"git rebase --continue\".
diff --git a/git-reset.sh b/git-reset.sh
index a969370..90164e1 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -6,6 +6,7 @@ USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action "reset $*"
+require_not_bare
 
 update= reset_type=--mixed
 unset rev
diff --git a/git-revert.sh b/git-revert.sh
index 50cc47b..f0d2829 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -19,6 +19,7 @@ case "$0" in
 	die "What are you talking about?" ;;
 esac
 . git-sh-setup
+require_not_bare
 
 no_commit=
 while case "$#" in 0) break ;; esac
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 87b939c..7e1d024 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -28,6 +28,13 @@ set_reflog_action() {
 	fi
 }
 
+require_not_bare() {
+	case "$GIT_DIR" in
+	.git|*/.git) : ok;;
+	*) die "fatal: $0 cannot be used in a bare git directory."
+	esac
+}
+
 if [ -z "$LONG_USAGE" ]
 then
 	LONG_USAGE="Usage: $0 $USAGE"
diff --git a/git.c b/git.c
index c82ca45..61c6390 100644
--- a/git.c
+++ b/git.c
@@ -199,6 +199,7 @@ const char git_version_string[] = GIT_VERSION;
 
 #define RUN_SETUP	(1<<0)
 #define USE_PAGER	(1<<1)
+#define NOT_BARE 	(1<<2)
 
 static void handle_internal_command(int argc, const char **argv, char **envp)
 {
@@ -208,7 +209,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		int (*fn)(int, const char **, const char *);
 		int option;
 	} commands[] = {
-		{ "add", cmd_add, RUN_SETUP },
+		{ "add", cmd_add, RUN_SETUP | NOT_BARE },
 		{ "annotate", cmd_annotate, },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
@@ -238,7 +239,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge-file", cmd_merge_file },
-		{ "mv", cmd_mv, RUN_SETUP },
+		{ "mv", cmd_mv, RUN_SETUP | NOT_BARE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "pickaxe", cmd_blame, RUN_SETUP | USE_PAGER },
@@ -251,8 +252,8 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
-		{ "rm", cmd_rm, RUN_SETUP },
-		{ "runstatus", cmd_runstatus, RUN_SETUP },
+		{ "rm", cmd_rm, RUN_SETUP | NOT_BARE },
+		{ "runstatus", cmd_runstatus, RUN_SETUP | NOT_BARE },
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
@@ -289,6 +290,8 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 			prefix = setup_git_directory();
 		if (p->option & USE_PAGER)
 			setup_pager();
+		if (p->option & NOT_BARE && is_bare_git_dir(get_git_dir()))
+			die("%s cannot be used in a pare git directory", cmd);
 		trace_argv_printf(argv, argc, "trace: built-in: git");
 
 		exit(p->fn(argc, argv, prefix));
-- 
1.5.0.rc0.g6bb1
