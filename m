From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 01/14] pull: implement fetch + merge
Date: Mon, 18 May 2015 23:05:58 +0800
Message-ID: <1431961571-20370-2-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:07:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMdl-0004GS-TS
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbbERPHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:32 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36759 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbERPHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:30 -0400
Received: by pdfh10 with SMTP id h10so153204582pdf.3
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vDsptw3CxqN0Ok9qxaCyaSAtbfxO3xk21hqCGDiC9Ko=;
        b=MbTjQiG00ltsaa3NR5WrqEtEHM1XOGjl6dUOR045lfBekiP12uk7w/qCf3f5P9Q8VO
         qe1QjFN9A/8iGnTgk1+MYT8fvc8QFVnhq3wTFeWsbLgfw3A1CSjVeNfBXvWPgx4XjYPk
         hCz00B1t7ZI92Zq0YxhUSUHsjI/SwKNrlEKODR5HN/BAnskqvaFTjP9ByBPoGftVJWeq
         RFwYMN108pVRUy9k4wucdxJ6siMtWQYZ2WOTQdb7rWG4M1KpRIe0i3IeOW0MEgqlfjmv
         nL0C8IgdHmv7dxCj/imEAM5lDs7+deXCtkL6CAo8+QAuZ5fovas5GgO16VqOXS+9EQKc
         NnLA==
X-Received: by 10.68.68.175 with SMTP id x15mr37844426pbt.91.1431961649228;
        Mon, 18 May 2015 08:07:29 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269260>

Start off the rewrite of git-pull.sh to C by implementing a simple
git-pull builtin that:

1. Parses the command line arguments into [<repo> [<refspecs>...]]

2. Runs git-fetch, passing the repo and refspecs to it.

3. Runs git-merge FETCH_HEAD.

Due to missing features, several tests are disabled:

* Passing flags to git fetch, rebase, merge:

  * t5521: verbosity flags -v, -s

* Passing flags to git-merge, git-rebase:

  * t5150, t5572: Pass --ff, --no-ff, --ff-only to git-merge

  * t5520, t5521, t7406: Support --rebase, branch.*.rebase and
    pull.rebase config

  * t6029, t4013: -s/--strategy

  * t6037: -X/--strategy-option

  * t5524: --log

* Passing flags to git-fetch:

  * t5521: --dry-run

  * t5500: --depth

  * t5521: --force

  * t5521: --all

  * t7403: --no-recurse-submodules

* t7601: pull.ff config sets --ff, --no-ff, --ff-only

* t5520: branch.*.rebase or pull.rebase sets --rebase, --rebase=preserve

* t5520: Pulling into void

* t5520: appropriate user-friendly error messages on no merge candidates
  case

* t5520: appropriate user-friendly error messages if index has
  unresolved entries.

* t5520: fast-forward working tree if branch head is updated by
  git-fetch

* t5520: set reflog action to "pull args..."

These features will be re-implemented in succeeding patches.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 Makefile                     |   2 +-
 builtin.h                    |   1 +
 builtin/pull.c               |  83 +++++++++++
 contrib/examples/git-pull.sh | 339 +++++++++++++++++++++++++++++++++++++++++++
 git-pull.sh                  | 339 -------------------------------------------
 git.c                        |   1 +
 t/t4013-diff-various.sh      |   3 +
 t/t5150-request-pull.sh      |   2 +-
 t/t5500-fetch-pack.sh        |  10 +-
 t/t5520-pull.sh              |  68 ++++-----
 t/t5521-pull-options.sh      |  20 +--
 t/t5524-pull-msg.sh          |   2 +-
 t/t5572-pull-submodule.sh    |   4 +
 t/t6029-merge-subtree.sh     |   6 +-
 t/t6037-merge-ours-theirs.sh |   2 +-
 t/t7403-submodule-sync.sh    |   8 +-
 t/t7406-submodule-update.sh  |   2 +
 t/t7601-merge-pull-config.sh |   4 +-
 18 files changed, 495 insertions(+), 401 deletions(-)
 create mode 100644 builtin/pull.c
 create mode 100755 contrib/examples/git-pull.sh
 delete mode 100755 git-pull.sh

diff --git a/Makefile b/Makefile
index 36655d5..51087dc 100644
--- a/Makefile
+++ b/Makefile
@@ -474,7 +474,6 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
@@ -876,6 +875,7 @@ BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
 BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
+BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
diff --git a/builtin.h b/builtin.h
index b87df70..ea3c834 100644
--- a/builtin.h
+++ b/builtin.h
@@ -98,6 +98,7 @@ extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
+extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/pull.c b/builtin/pull.c
new file mode 100644
index 0000000..0b771b9
--- /dev/null
+++ b/builtin/pull.c
@@ -0,0 +1,83 @@
+/*
+ * Builtin "git pull"
+ *
+ * Based on git-pull.sh by Junio C Hamano
+ *
+ * Fetch one or more remote refs and merge it/them into the current HEAD.
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "argv-array.h"
+#include "run-command.h"
+
+static const char * const pull_usage[] = {
+	N_("git pull [options] [<repo> [<refspec>...]]"),
+	NULL
+};
+
+static struct option pull_options[] = {
+	OPT_END()
+};
+
+/**
+ * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
+ * as a string and `refspecs` as a null-terminated array of strings. If `repo`
+ * is not provided in argv, it is set to NULL.
+ */
+static void parse_repo_refspecs(int argc, const char **argv, const char **repo, const char ***refspecs)
+{
+	if (argc > 0) {
+		*repo = *argv++;
+		argc--;
+	} else
+		*repo = NULL;
+	*refspecs = argv;
+}
+
+/**
+ * Runs git-fetch, returning its exit status. `repo` and `refspecs` are the
+ * repository and refspecs to fetch, or NULL if they are not provided.
+ */
+static int run_fetch(const char *repo, const char **refspecs)
+{
+	struct argv_array args = ARGV_ARRAY_INIT;
+	int ret;
+
+	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
+	if (repo)
+		argv_array_push(&args, repo);
+	while (*refspecs)
+		argv_array_push(&args, *refspecs++);
+	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	argv_array_clear(&args);
+	return ret;
+}
+
+/**
+ * Runs git-merge, returning its exit status.
+ */
+static int run_merge(void)
+{
+	int ret;
+	struct argv_array args = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&args, "merge", NULL);
+	argv_array_push(&args, "FETCH_HEAD");
+	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
+	argv_array_clear(&args);
+	return ret;
+}
+
+int cmd_pull(int argc, const char **argv, const char *prefix)
+{
+	const char *repo, **refspecs;
+
+	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
+	parse_repo_refspecs(argc, argv, &repo, &refspecs);
+
+	if (run_fetch(repo, refspecs))
+		return 1;
+
+	return run_merge();
+}
diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
new file mode 100755
index 0000000..5ff4545
--- /dev/null
+++ b/contrib/examples/git-pull.sh
@@ -0,0 +1,339 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# Fetch one or more remote refs and merge it/them into the current HEAD.
+
+USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
+LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+. git-sh-setup
+. git-sh-i18n
+set_reflog_action "pull${1+ $*}"
+require_work_tree_exists
+cd_to_toplevel
+
+
+die_conflict () {
+    git diff-index --cached --name-status -r --ignore-submodules HEAD --
+    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
+	die "$(gettext "Pull is not possible because you have unmerged files.
+Please, fix them up in the work tree, and then use 'git add/rm <file>'
+as appropriate to mark resolution and make a commit.")"
+    else
+	die "$(gettext "Pull is not possible because you have unmerged files.")"
+    fi
+}
+
+die_merge () {
+    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
+	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).
+Please, commit your changes before you can merge.")"
+    else
+	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).")"
+    fi
+}
+
+test -z "$(git ls-files -u)" || die_conflict
+test -f "$GIT_DIR/MERGE_HEAD" && die_merge
+
+bool_or_string_config () {
+	git config --bool "$1" 2>/dev/null || git config "$1"
+}
+
+strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
+log_arg= verbosity= progress= recurse_submodules= verify_signatures=
+merge_args= edit= rebase_args=
+curr_branch=$(git symbolic-ref -q HEAD)
+curr_branch_short="${curr_branch#refs/heads/}"
+rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
+if test -z "$rebase"
+then
+	rebase=$(bool_or_string_config pull.rebase)
+fi
+
+# Setup default fast-forward options via `pull.ff`
+pull_ff=$(git config pull.ff)
+case "$pull_ff" in
+false)
+	no_ff=--no-ff
+	;;
+only)
+	ff_only=--ff-only
+	;;
+esac
+
+
+dry_run=
+while :
+do
+	case "$1" in
+	-q|--quiet)
+		verbosity="$verbosity -q" ;;
+	-v|--verbose)
+		verbosity="$verbosity -v" ;;
+	--progress)
+		progress=--progress ;;
+	--no-progress)
+		progress=--no-progress ;;
+	-n|--no-stat|--no-summary)
+		diffstat=--no-stat ;;
+	--stat|--summary)
+		diffstat=--stat ;;
+	--log|--log=*|--no-log)
+		log_arg="$1" ;;
+	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
+		no_commit=--no-commit ;;
+	--c|--co|--com|--comm|--commi|--commit)
+		no_commit=--commit ;;
+	-e|--edit)
+		edit=--edit ;;
+	--no-edit)
+		edit=--no-edit ;;
+	--sq|--squ|--squa|--squas|--squash)
+		squash=--squash ;;
+	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
+		squash=--no-squash ;;
+	--ff)
+		no_ff=--ff ;;
+	--no-ff)
+		no_ff=--no-ff ;;
+	--ff-only)
+		ff_only=--ff-only ;;
+	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
+		--strateg=*|--strategy=*|\
+	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
+		case "$#,$1" in
+		*,*=*)
+			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
+		1,*)
+			usage ;;
+		*)
+			strategy="$2"
+			shift ;;
+		esac
+		strategy_args="${strategy_args}-s $strategy "
+		;;
+	-X*)
+		case "$#,$1" in
+		1,-X)
+			usage ;;
+		*,-X)
+			xx="-X $(git rev-parse --sq-quote "$2")"
+			shift ;;
+		*,*)
+			xx=$(git rev-parse --sq-quote "$1") ;;
+		esac
+		merge_args="$merge_args$xx "
+		;;
+	-r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*)
+		rebase="${1#*=}"
+		;;
+	-r|--r|--re|--reb|--reba|--rebas|--rebase)
+		rebase=true
+		;;
+	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+		rebase=false
+		;;
+	--recurse-submodules)
+		recurse_submodules=--recurse-submodules
+		;;
+	--recurse-submodules=*)
+		recurse_submodules="$1"
+		;;
+	--no-recurse-submodules)
+		recurse_submodules=--no-recurse-submodules
+		;;
+	--verify-signatures)
+		verify_signatures=--verify-signatures
+		;;
+	--no-verify-signatures)
+		verify_signatures=--no-verify-signatures
+		;;
+	--gpg-sign|-S)
+		gpg_sign_args=-S
+		;;
+	--gpg-sign=*)
+		gpg_sign_args=$(git rev-parse --sq-quote "-S${1#--gpg-sign=}")
+		;;
+	-S*)
+		gpg_sign_args=$(git rev-parse --sq-quote "$1")
+		;;
+	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
+		dry_run=--dry-run
+		;;
+	-h|--help-all)
+		usage
+		;;
+	*)
+		# Pass thru anything that may be meant for fetch.
+		break
+		;;
+	esac
+	shift
+done
+
+case "$rebase" in
+preserve)
+	rebase=true
+	rebase_args=--preserve-merges
+	;;
+true|false|'')
+	;;
+*)
+	echo "Invalid value for --rebase, should be true, false, or preserve"
+	usage
+	exit 1
+	;;
+esac
+
+error_on_no_merge_candidates () {
+	exec >&2
+	for opt
+	do
+		case "$opt" in
+		-t|--t|--ta|--tag|--tags)
+			echo "It doesn't make sense to pull all tags; you probably meant:"
+			echo "  git fetch --tags"
+			exit 1
+		esac
+	done
+
+	if test true = "$rebase"
+	then
+		op_type=rebase
+		op_prep=against
+	else
+		op_type=merge
+		op_prep=with
+	fi
+
+	upstream=$(git config "branch.$curr_branch_short.merge")
+	remote=$(git config "branch.$curr_branch_short.remote")
+
+	if [ $# -gt 1 ]; then
+		if [ "$rebase" = true ]; then
+			printf "There is no candidate for rebasing against "
+		else
+			printf "There are no candidates for merging "
+		fi
+		echo "among the refs that you just fetched."
+		echo "Generally this means that you provided a wildcard refspec which had no"
+		echo "matches on the remote end."
+	elif [ $# -gt 0 ] && [ "$1" != "$remote" ]; then
+		echo "You asked to pull from the remote '$1', but did not specify"
+		echo "a branch. Because this is not the default configured remote"
+		echo "for your current branch, you must specify a branch on the command line."
+	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
+		. git-parse-remote
+		error_on_missing_default_upstream "pull" $op_type $op_prep \
+			"git pull <remote> <branch>"
+	else
+		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
+		echo "from the remote, but no such ref was fetched."
+	fi
+	exit 1
+}
+
+test true = "$rebase" && {
+	if ! git rev-parse -q --verify HEAD >/dev/null
+	then
+		# On an unborn branch
+		if test -f "$(git rev-parse --git-path index)"
+		then
+			die "$(gettext "updating an unborn branch with changes added to the index")"
+		fi
+	else
+		require_clean_work_tree "pull with rebase" "Please commit or stash them."
+	fi
+	oldremoteref= &&
+	test -n "$curr_branch" &&
+	. git-parse-remote &&
+	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch 2>/dev/null)
+}
+orig_head=$(git rev-parse -q --verify HEAD)
+git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
+test -z "$dry_run" || exit 0
+
+curr_head=$(git rev-parse -q --verify HEAD)
+if test -n "$orig_head" && test "$curr_head" != "$orig_head"
+then
+	# The fetch involved updating the current branch.
+
+	# The working tree and the index file is still based on the
+	# $orig_head commit, but we are merging into $curr_head.
+	# First update the working tree to match $curr_head.
+
+	eval_gettextln "Warning: fetch updated the current branch head.
+Warning: fast-forwarding your working tree from
+Warning: commit \$orig_head." >&2
+	git update-index -q --refresh
+	git read-tree -u -m "$orig_head" "$curr_head" ||
+		die "$(eval_gettext "Cannot fast-forward your working tree.
+After making sure that you saved anything precious from
+$ git diff \$orig_head
+output, run
+$ git reset --hard
+to recover.")"
+
+fi
+
+merge_head=$(sed -e '/	not-for-merge	/d' \
+	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
+	tr '\012' ' ')
+
+case "$merge_head" in
+'')
+	error_on_no_merge_candidates "$@"
+	;;
+?*' '?*)
+	if test -z "$orig_head"
+	then
+		die "$(gettext "Cannot merge multiple branches into empty head")"
+	fi
+	if test true = "$rebase"
+	then
+		die "$(gettext "Cannot rebase onto multiple branches")"
+	fi
+	;;
+esac
+
+# Pulling into unborn branch: a shorthand for branching off
+# FETCH_HEAD, for lazy typers.
+if test -z "$orig_head"
+then
+	# Two-way merge: we claim the index is based on an empty tree,
+	# and try to fast-forward to HEAD.  This ensures we will not
+	# lose index/worktree changes that the user already made on
+	# the unborn branch.
+	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	git read-tree -m -u $empty_tree $merge_head &&
+	git update-ref -m "initial pull" HEAD $merge_head "$curr_head"
+	exit
+fi
+
+if test true = "$rebase"
+then
+	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
+	if test "$oldremoteref" = "$o"
+	then
+		unset oldremoteref
+	fi
+fi
+
+case "$rebase" in
+true)
+	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
+	eval="$eval $gpg_sign_args"
+	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
+	;;
+*)
+	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
+	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
+	eval="$eval $gpg_sign_args"
+	eval="$eval FETCH_HEAD"
+	;;
+esac
+eval "exec $eval"
diff --git a/git-pull.sh b/git-pull.sh
deleted file mode 100755
index 5ff4545..0000000
--- a/git-pull.sh
+++ /dev/null
@@ -1,339 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-# Fetch one or more remote refs and merge it/them into the current HEAD.
-
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-. git-sh-setup
-. git-sh-i18n
-set_reflog_action "pull${1+ $*}"
-require_work_tree_exists
-cd_to_toplevel
-
-
-die_conflict () {
-    git diff-index --cached --name-status -r --ignore-submodules HEAD --
-    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
-	die "$(gettext "Pull is not possible because you have unmerged files.
-Please, fix them up in the work tree, and then use 'git add/rm <file>'
-as appropriate to mark resolution and make a commit.")"
-    else
-	die "$(gettext "Pull is not possible because you have unmerged files.")"
-    fi
-}
-
-die_merge () {
-    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
-	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).
-Please, commit your changes before you can merge.")"
-    else
-	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).")"
-    fi
-}
-
-test -z "$(git ls-files -u)" || die_conflict
-test -f "$GIT_DIR/MERGE_HEAD" && die_merge
-
-bool_or_string_config () {
-	git config --bool "$1" 2>/dev/null || git config "$1"
-}
-
-strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity= progress= recurse_submodules= verify_signatures=
-merge_args= edit= rebase_args=
-curr_branch=$(git symbolic-ref -q HEAD)
-curr_branch_short="${curr_branch#refs/heads/}"
-rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
-if test -z "$rebase"
-then
-	rebase=$(bool_or_string_config pull.rebase)
-fi
-
-# Setup default fast-forward options via `pull.ff`
-pull_ff=$(git config pull.ff)
-case "$pull_ff" in
-false)
-	no_ff=--no-ff
-	;;
-only)
-	ff_only=--ff-only
-	;;
-esac
-
-
-dry_run=
-while :
-do
-	case "$1" in
-	-q|--quiet)
-		verbosity="$verbosity -q" ;;
-	-v|--verbose)
-		verbosity="$verbosity -v" ;;
-	--progress)
-		progress=--progress ;;
-	--no-progress)
-		progress=--no-progress ;;
-	-n|--no-stat|--no-summary)
-		diffstat=--no-stat ;;
-	--stat|--summary)
-		diffstat=--stat ;;
-	--log|--log=*|--no-log)
-		log_arg="$1" ;;
-	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		no_commit=--no-commit ;;
-	--c|--co|--com|--comm|--commi|--commit)
-		no_commit=--commit ;;
-	-e|--edit)
-		edit=--edit ;;
-	--no-edit)
-		edit=--no-edit ;;
-	--sq|--squ|--squa|--squas|--squash)
-		squash=--squash ;;
-	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
-		squash=--no-squash ;;
-	--ff)
-		no_ff=--ff ;;
-	--no-ff)
-		no_ff=--no-ff ;;
-	--ff-only)
-		ff_only=--ff-only ;;
-	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
-		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=*)
-			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
-		strategy_args="${strategy_args}-s $strategy "
-		;;
-	-X*)
-		case "$#,$1" in
-		1,-X)
-			usage ;;
-		*,-X)
-			xx="-X $(git rev-parse --sq-quote "$2")"
-			shift ;;
-		*,*)
-			xx=$(git rev-parse --sq-quote "$1") ;;
-		esac
-		merge_args="$merge_args$xx "
-		;;
-	-r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*)
-		rebase="${1#*=}"
-		;;
-	-r|--r|--re|--reb|--reba|--rebas|--rebase)
-		rebase=true
-		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		rebase=false
-		;;
-	--recurse-submodules)
-		recurse_submodules=--recurse-submodules
-		;;
-	--recurse-submodules=*)
-		recurse_submodules="$1"
-		;;
-	--no-recurse-submodules)
-		recurse_submodules=--no-recurse-submodules
-		;;
-	--verify-signatures)
-		verify_signatures=--verify-signatures
-		;;
-	--no-verify-signatures)
-		verify_signatures=--no-verify-signatures
-		;;
-	--gpg-sign|-S)
-		gpg_sign_args=-S
-		;;
-	--gpg-sign=*)
-		gpg_sign_args=$(git rev-parse --sq-quote "-S${1#--gpg-sign=}")
-		;;
-	-S*)
-		gpg_sign_args=$(git rev-parse --sq-quote "$1")
-		;;
-	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
-		dry_run=--dry-run
-		;;
-	-h|--help-all)
-		usage
-		;;
-	*)
-		# Pass thru anything that may be meant for fetch.
-		break
-		;;
-	esac
-	shift
-done
-
-case "$rebase" in
-preserve)
-	rebase=true
-	rebase_args=--preserve-merges
-	;;
-true|false|'')
-	;;
-*)
-	echo "Invalid value for --rebase, should be true, false, or preserve"
-	usage
-	exit 1
-	;;
-esac
-
-error_on_no_merge_candidates () {
-	exec >&2
-	for opt
-	do
-		case "$opt" in
-		-t|--t|--ta|--tag|--tags)
-			echo "It doesn't make sense to pull all tags; you probably meant:"
-			echo "  git fetch --tags"
-			exit 1
-		esac
-	done
-
-	if test true = "$rebase"
-	then
-		op_type=rebase
-		op_prep=against
-	else
-		op_type=merge
-		op_prep=with
-	fi
-
-	upstream=$(git config "branch.$curr_branch_short.merge")
-	remote=$(git config "branch.$curr_branch_short.remote")
-
-	if [ $# -gt 1 ]; then
-		if [ "$rebase" = true ]; then
-			printf "There is no candidate for rebasing against "
-		else
-			printf "There are no candidates for merging "
-		fi
-		echo "among the refs that you just fetched."
-		echo "Generally this means that you provided a wildcard refspec which had no"
-		echo "matches on the remote end."
-	elif [ $# -gt 0 ] && [ "$1" != "$remote" ]; then
-		echo "You asked to pull from the remote '$1', but did not specify"
-		echo "a branch. Because this is not the default configured remote"
-		echo "for your current branch, you must specify a branch on the command line."
-	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
-		. git-parse-remote
-		error_on_missing_default_upstream "pull" $op_type $op_prep \
-			"git pull <remote> <branch>"
-	else
-		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
-		echo "from the remote, but no such ref was fetched."
-	fi
-	exit 1
-}
-
-test true = "$rebase" && {
-	if ! git rev-parse -q --verify HEAD >/dev/null
-	then
-		# On an unborn branch
-		if test -f "$(git rev-parse --git-path index)"
-		then
-			die "$(gettext "updating an unborn branch with changes added to the index")"
-		fi
-	else
-		require_clean_work_tree "pull with rebase" "Please commit or stash them."
-	fi
-	oldremoteref= &&
-	test -n "$curr_branch" &&
-	. git-parse-remote &&
-	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
-	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch 2>/dev/null)
-}
-orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
-test -z "$dry_run" || exit 0
-
-curr_head=$(git rev-parse -q --verify HEAD)
-if test -n "$orig_head" && test "$curr_head" != "$orig_head"
-then
-	# The fetch involved updating the current branch.
-
-	# The working tree and the index file is still based on the
-	# $orig_head commit, but we are merging into $curr_head.
-	# First update the working tree to match $curr_head.
-
-	eval_gettextln "Warning: fetch updated the current branch head.
-Warning: fast-forwarding your working tree from
-Warning: commit \$orig_head." >&2
-	git update-index -q --refresh
-	git read-tree -u -m "$orig_head" "$curr_head" ||
-		die "$(eval_gettext "Cannot fast-forward your working tree.
-After making sure that you saved anything precious from
-$ git diff \$orig_head
-output, run
-$ git reset --hard
-to recover.")"
-
-fi
-
-merge_head=$(sed -e '/	not-for-merge	/d' \
-	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
-	tr '\012' ' ')
-
-case "$merge_head" in
-'')
-	error_on_no_merge_candidates "$@"
-	;;
-?*' '?*)
-	if test -z "$orig_head"
-	then
-		die "$(gettext "Cannot merge multiple branches into empty head")"
-	fi
-	if test true = "$rebase"
-	then
-		die "$(gettext "Cannot rebase onto multiple branches")"
-	fi
-	;;
-esac
-
-# Pulling into unborn branch: a shorthand for branching off
-# FETCH_HEAD, for lazy typers.
-if test -z "$orig_head"
-then
-	# Two-way merge: we claim the index is based on an empty tree,
-	# and try to fast-forward to HEAD.  This ensures we will not
-	# lose index/worktree changes that the user already made on
-	# the unborn branch.
-	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-	git read-tree -m -u $empty_tree $merge_head &&
-	git update-ref -m "initial pull" HEAD $merge_head "$curr_head"
-	exit
-fi
-
-if test true = "$rebase"
-then
-	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
-	if test "$oldremoteref" = "$o"
-	then
-		unset oldremoteref
-	fi
-fi
-
-case "$rebase" in
-true)
-	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
-	eval="$eval $gpg_sign_args"
-	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
-	;;
-*)
-	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
-	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
-	eval="$eval $gpg_sign_args"
-	eval="$eval FETCH_HEAD"
-	;;
-esac
-eval "exec $eval"
diff --git a/git.c b/git.c
index 44374b1..e7a7713 100644
--- a/git.c
+++ b/git.c
@@ -445,6 +445,7 @@ static struct cmd_struct commands[] = {
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
 	{ "receive-pack", cmd_receive_pack },
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6ec6072..a11e48b 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -7,6 +7,9 @@ test_description='Various diff formatting options'
 
 . ./test-lib.sh
 
+skip_all='setup for this test suite requires git pull -s'
+test_done
+
 LF='
 '
 
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 82c33b8..f5ea605 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -132,7 +132,7 @@ test_expect_success 'pull request when forgot to push' '
 
 '
 
-test_expect_success 'pull request after push' '
+test_expect_failure 'pull request after push' '
 
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3a9b775..213b231 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -226,14 +226,14 @@ test_expect_success 'add two more (part 2)' '
 	add B69 $B68
 '
 
-test_expect_success 'deepening pull in shallow repo' '
+test_expect_failure 'deepening pull in shallow repo' '
 	(
 		cd shallow &&
 		git pull --depth 4 .. B
 	)
 '
 
-test_expect_success 'clone shallow object count' '
+test_expect_failure 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
@@ -248,7 +248,7 @@ test_expect_success 'deepening fetch in shallow repo' '
 	)
 '
 
-test_expect_success 'clone shallow object count' '
+test_expect_failure 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
@@ -272,11 +272,11 @@ test_expect_success 'additional simple shallow deepenings' '
 	)
 '
 
-test_expect_success 'clone shallow depth count' '
+test_expect_failure 'clone shallow depth count' '
 	test "`git --git-dir=shallow/.git rev-list --count HEAD`" = 11
 '
 
-test_expect_success 'clone shallow object count' '
+test_expect_failure 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 62dbfb5..f32b8cb 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -26,7 +26,7 @@ test_expect_success 'pulling into void' '
 	test_cmp file cloned/file
 '
 
-test_expect_success 'pulling into void using master:master' '
+test_expect_failure 'pulling into void using master:master' '
 	git init cloned-uho &&
 	(
 		cd cloned-uho &&
@@ -76,7 +76,7 @@ test_expect_success 'pulling into void does not remove new staged files' '
 	)
 '
 
-test_expect_success 'pulling into void must not create an octopus' '
+test_expect_failure 'pulling into void must not create an octopus' '
 	git init cloned-octopus &&
 	(
 		cd cloned-octopus &&
@@ -85,7 +85,7 @@ test_expect_success 'pulling into void must not create an octopus' '
 	)
 '
 
-test_expect_success 'test . as a remote' '
+test_expect_failure 'test . as a remote' '
 	git branch copy master &&
 	git config branch.copy.remote . &&
 	git config branch.copy.merge refs/heads/master &&
@@ -101,7 +101,7 @@ test_expect_success 'test . as a remote' '
 	test_cmp reflog.expected reflog.fuzzy
 '
 
-test_expect_success 'the default remote . should not break explicit pull' '
+test_expect_failure 'the default remote . should not break explicit pull' '
 	git checkout -b second master^ &&
 	echo modified >file &&
 	git commit -a -m modified &&
@@ -116,7 +116,7 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	test_cmp reflog.expected reflog.fuzzy
 '
 
-test_expect_success 'fail if wildcard spec does not match any refs' '
+test_expect_failure 'fail if wildcard spec does not match any refs' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
 	test "$(cat file)" = file &&
@@ -125,7 +125,7 @@ test_expect_success 'fail if wildcard spec does not match any refs' '
 	test "$(cat file)" = file
 '
 
-test_expect_success 'fail if no branches specified with non-default remote' '
+test_expect_failure 'fail if no branches specified with non-default remote' '
 	git remote add test_remote . &&
 	test_when_finished "git remote remove test_remote" &&
 	git checkout -b test copy^ &&
@@ -137,7 +137,7 @@ test_expect_success 'fail if no branches specified with non-default remote' '
 	test "$(cat file)" = file
 '
 
-test_expect_success 'fail if not on a branch' '
+test_expect_failure 'fail if not on a branch' '
 	git remote add origin . &&
 	test_when_finished "git remote remove origin" &&
 	git checkout HEAD^ &&
@@ -148,7 +148,7 @@ test_expect_success 'fail if not on a branch' '
 	test "$(cat file)" = file
 '
 
-test_expect_success 'fail if no configuration for current branch' '
+test_expect_failure 'fail if no configuration for current branch' '
 	git remote add test_remote . &&
 	test_when_finished "git remote remove test_remote" &&
 	git checkout -b test copy^ &&
@@ -160,7 +160,7 @@ test_expect_success 'fail if no configuration for current branch' '
 	test "$(cat file)" = file
 '
 
-test_expect_success 'fail if upstream branch does not exist' '
+test_expect_failure 'fail if upstream branch does not exist' '
 	git checkout -b test copy^ &&
 	test_when_finished "git checkout -f copy && git branch -D test" &&
 	test_config branch.test.remote . &&
@@ -171,7 +171,7 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test "$(cat file)" = file
 '
 
-test_expect_success 'fail if the index has unresolved entries' '
+test_expect_failure 'fail if the index has unresolved entries' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
@@ -191,7 +191,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_cmp expected file
 '
 
-test_expect_success 'fast-forwards working tree if branch head is updated' '
+test_expect_failure 'fast-forwards working tree if branch head is updated' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
@@ -201,7 +201,7 @@ test_expect_success 'fast-forwards working tree if branch head is updated' '
 	test "$(git rev-parse third)" = "$(git rev-parse second)"
 '
 
-test_expect_success 'fast-forward fails with conflicting work tree' '
+test_expect_failure 'fast-forward fails with conflicting work tree' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
 	test "$(cat file)" = file &&
@@ -212,7 +212,7 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 	test "$(git rev-parse third)" = "$(git rev-parse second)"
 '
 
-test_expect_success '--rebase' '
+test_expect_failure '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
 	git commit -m file file &&
@@ -226,7 +226,7 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_success '--rebase fails with multiple branches' '
+test_expect_failure '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
 	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
@@ -234,7 +234,7 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
-test_expect_success 'pull.rebase' '
+test_expect_failure 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
@@ -242,7 +242,7 @@ test_expect_success 'pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
-test_expect_success 'branch.to-rebase.rebase' '
+test_expect_failure 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
@@ -280,7 +280,7 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success 'pull.rebase=true flattens keep-merge' '
+test_expect_failure 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
@@ -288,7 +288,7 @@ test_expect_success 'pull.rebase=true flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
+test_expect_failure 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase 1 &&
 	git pull . copy &&
@@ -296,7 +296,7 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
+test_expect_failure 'pull.rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull . copy &&
@@ -304,13 +304,13 @@ test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
 '
 
-test_expect_success 'pull.rebase=invalid fails' '
+test_expect_failure 'pull.rebase=invalid fails' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase invalid &&
 	! git pull . copy
 '
 
-test_expect_success '--rebase=false create a new merge commit' '
+test_expect_failure '--rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=false . copy &&
@@ -319,7 +319,7 @@ test_expect_success '--rebase=false create a new merge commit' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success '--rebase=true rebases and flattens keep-merge' '
+test_expect_failure '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
@@ -327,7 +327,7 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success '--rebase=preserve rebases and merges keep-merge' '
+test_expect_failure '--rebase=preserve rebases and merges keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=preserve . copy &&
@@ -340,7 +340,7 @@ test_expect_success '--rebase=invalid fails' '
 	! git pull --rebase=invalid . copy
 '
 
-test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
+test_expect_failure '--rebase overrides pull.rebase=preserve and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
@@ -348,7 +348,7 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
-test_expect_success '--rebase with rebased upstream' '
+test_expect_failure '--rebase with rebased upstream' '
 
 	git remote add -f me . &&
 	git checkout copy &&
@@ -366,7 +366,7 @@ test_expect_success '--rebase with rebased upstream' '
 
 '
 
-test_expect_success '--rebase with rebased default upstream' '
+test_expect_failure '--rebase with rebased default upstream' '
 
 	git update-ref refs/remotes/me/copy copy-orig &&
 	git checkout --track -b to-rebase2 me/copy &&
@@ -377,7 +377,7 @@ test_expect_success '--rebase with rebased default upstream' '
 
 '
 
-test_expect_success 'rebased upstream + fetch + pull --rebase' '
+test_expect_failure 'rebased upstream + fetch + pull --rebase' '
 
 	git update-ref refs/remotes/me/copy copy-orig &&
 	git reset --hard to-rebase-orig &&
@@ -390,7 +390,7 @@ test_expect_success 'rebased upstream + fetch + pull --rebase' '
 
 '
 
-test_expect_success 'pull --rebase dies early with dirty working directory' '
+test_expect_failure 'pull --rebase dies early with dirty working directory' '
 
 	git checkout to-rebase &&
 	git update-ref refs/remotes/me/copy copy^ &&
@@ -409,7 +409,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 
 '
 
-test_expect_success 'pull --rebase works on branch yet to be born' '
+test_expect_failure 'pull --rebase works on branch yet to be born' '
 	git rev-parse master >expect &&
 	mkdir empty_repo &&
 	(cd empty_repo &&
@@ -420,7 +420,7 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
-test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
+test_expect_failure 'pull --rebase fails on unborn branch with staged changes' '
 	test_when_finished "rm -rf empty_repo2" &&
 	git init empty_repo2 &&
 	(
@@ -456,14 +456,14 @@ test_expect_success 'setup for detecting upstreamed changes' '
 	)
 '
 
-test_expect_success 'git pull --rebase detects upstreamed changes' '
+test_expect_failure 'git pull --rebase detects upstreamed changes' '
 	(cd dst &&
 	 git pull --rebase &&
 	 test -z "$(git ls-files -u)"
 	)
 '
 
-test_expect_success 'setup for avoiding reapplying old patches' '
+test_expect_failure 'setup for avoiding reapplying old patches' '
 	(cd dst &&
 	 test_might_fail git rebase --abort &&
 	 git reset --hard origin/master
@@ -485,14 +485,14 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 	)
 '
 
-test_expect_success 'git pull --rebase does not reapply old patches' '
+test_expect_failure 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
 	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
 	)
 '
 
-test_expect_success 'git pull --rebase against local branch' '
+test_expect_failure 'git pull --rebase against local branch' '
 	git checkout -b copy2 to-rebase-orig &&
 	git pull --rebase . to-rebase &&
 	test "conflicting modification" = "$(cat file)" &&
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 56e7377..0f6094b 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	 git commit -m one)
 '
 
-test_expect_success 'git pull -q' '
+test_expect_failure 'git pull -q' '
 	mkdir clonedq &&
 	(cd clonedq && git init &&
 	git pull -q "../parent" >out 2>err &&
@@ -19,7 +19,7 @@ test_expect_success 'git pull -q' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -q --rebase' '
+test_expect_failure 'git pull -q --rebase' '
 	mkdir clonedqrb &&
 	(cd clonedqrb && git init &&
 	git pull -q --rebase "../parent" >out 2>err &&
@@ -38,7 +38,7 @@ test_expect_success 'git pull' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull --rebase' '
+test_expect_failure 'git pull --rebase' '
 	mkdir clonedrb &&
 	(cd clonedrb && git init &&
 	git pull --rebase "../parent" >out 2>err &&
@@ -46,7 +46,7 @@ test_expect_success 'git pull --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v' '
+test_expect_failure 'git pull -v' '
 	mkdir clonedv &&
 	(cd clonedv && git init &&
 	git pull -v "../parent" >out 2>err &&
@@ -54,7 +54,7 @@ test_expect_success 'git pull -v' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v --rebase' '
+test_expect_failure 'git pull -v --rebase' '
 	mkdir clonedvrb &&
 	(cd clonedvrb && git init &&
 	git pull -v --rebase "../parent" >out 2>err &&
@@ -62,7 +62,7 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
-test_expect_success 'git pull -v -q' '
+test_expect_failure 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
 	git pull -v -q "../parent" >out 2>err &&
@@ -70,7 +70,7 @@ test_expect_success 'git pull -v -q' '
 	test_must_be_empty err)
 '
 
-test_expect_success 'git pull -q -v' '
+test_expect_failure 'git pull -q -v' '
 	mkdir clonedqv &&
 	(cd clonedqv && git init &&
 	git pull -q -v "../parent" >out 2>err &&
@@ -78,7 +78,7 @@ test_expect_success 'git pull -q -v' '
 	test -s err)
 '
 
-test_expect_success 'git pull --force' '
+test_expect_failure 'git pull --force' '
 	mkdir clonedoldstyle &&
 	(cd clonedoldstyle && git init &&
 	cat >>.git/config <<-\EOF &&
@@ -99,7 +99,7 @@ test_expect_success 'git pull --force' '
 	)
 '
 
-test_expect_success 'git pull --all' '
+test_expect_failure 'git pull --all' '
 	mkdir clonedmulti &&
 	(cd clonedmulti && git init &&
 	cat >>.git/config <<-\EOF &&
@@ -117,7 +117,7 @@ test_expect_success 'git pull --all' '
 	)
 '
 
-test_expect_success 'git pull --dry-run' '
+test_expect_failure 'git pull --dry-run' '
 	test_when_finished "rm -rf clonedry" &&
 	git init clonedry &&
 	(
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index eebb8c9..1ba8054 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 	git commit -m "do not clobber $dollar signs"
 '
 
-test_expect_success pull '
+test_expect_failure pull '
 (
 	cd cloned &&
 	git pull --log &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index accfa5c..408c886 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -5,6 +5,10 @@ test_description='pull can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
+KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
+
 reset_branch_to_HEAD () {
 	git branch -D "$1" &&
 	git checkout -b "$1" HEAD &&
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 73fc240..54af64e 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -61,7 +61,7 @@ test_expect_success 'initial merge' '
 	test_cmp expected actual
 '
 
-test_expect_success 'merge update' '
+test_expect_failure 'merge update' '
 	cd ../git-gui &&
 	echo git-gui2 > git-gui.sh &&
 	o3=$(git hash-object git-gui.sh) &&
@@ -95,7 +95,7 @@ test_expect_success 'initial ambiguous subtree' '
 	test_cmp expected actual
 '
 
-test_expect_success 'merge using explicit' '
+test_expect_failure 'merge using explicit' '
 	cd ../git &&
 	git reset --hard master2 &&
 	git pull -Xsubtree=git-gui gui master2 &&
@@ -108,7 +108,7 @@ test_expect_success 'merge using explicit' '
 	test_cmp expected actual
 '
 
-test_expect_success 'merge2 using explicit' '
+test_expect_failure 'merge2 using explicit' '
 	cd ../git &&
 	git reset --hard master2 &&
 	git pull -Xsubtree=git-gui2 gui master2 &&
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 3889eca..876e23b 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -65,7 +65,7 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 	git diff --exit-code master HEAD -- file
 '
 
-test_expect_success 'pull passes -X to underlying merge' '
+test_expect_failure 'pull passes -X to underlying merge' '
 	git reset --hard master && git pull -s recursive -Xours . side &&
 	git reset --hard master && git pull -s recursive -X ours . side &&
 	git reset --hard master && git pull -s recursive -Xtheirs . side &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..b448562 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -96,7 +96,7 @@ test_expect_success 'change submodule url' '
 	)
 '
 
-test_expect_success '"git submodule sync" should update submodule URLs' '
+test_expect_failure '"git submodule sync" should update submodule URLs' '
 	(
 		cd super-clone &&
 		git pull --no-recurse-submodules &&
@@ -121,7 +121,7 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	)
 '
 
-test_expect_success '"git submodule sync --recursive" should update all submodule URLs' '
+test_expect_failure '"git submodule sync --recursive" should update all submodule URLs' '
 	(
 		cd super-clone &&
 		(
@@ -149,7 +149,7 @@ test_expect_success 'reset submodule URLs' '
 	reset_submodule_urls super-clone
 '
 
-test_expect_success '"git submodule sync" should update submodule URLs - subdirectory' '
+test_expect_failure '"git submodule sync" should update submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		git pull --no-recurse-submodules &&
@@ -177,7 +177,7 @@ test_expect_success '"git submodule sync" should update submodule URLs - subdire
 	)
 '
 
-test_expect_success '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
+test_expect_failure '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		(
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index dda3929..1ffd837 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -11,6 +11,8 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 
 . ./test-lib.sh
 
+skip_all='skipping submodule update tests, requires git pull --rebase'
+test_done
 
 compare_head()
 {
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index f768c90..7a846a2 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -45,7 +45,7 @@ test_expect_success 'fast-forward pull succeeds with "true" in pull.ff' '
 	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
 '
 
-test_expect_success 'fast-forward pull creates merge with "false" in pull.ff' '
+test_expect_failure 'fast-forward pull creates merge with "false" in pull.ff' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 &&
@@ -53,7 +53,7 @@ test_expect_success 'fast-forward pull creates merge with "false" in pull.ff' '
 	test "$(git rev-parse HEAD^2)" = "$(git rev-parse c1)"
 '
 
-test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
+test_expect_failure 'pull prevents non-fast-forward with "only" in pull.ff' '
 	git reset --hard c1 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c3
-- 
2.1.4
