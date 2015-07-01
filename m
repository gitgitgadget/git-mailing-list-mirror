From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 01 Jul 2015 09:53:58 -0700
Message-ID: <xmqqr3orakex.fsf@gitster.dls.corp.google.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:54:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZALH1-0006wo-Kn
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 18:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903AbbGAQyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 12:54:06 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36382 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbbGAQyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 12:54:02 -0400
Received: by iecvh10 with SMTP id vh10so38918338iec.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5zrI5hv+rT8ejmYuxnyFWy3e3Fa9Z01dfU/ZQHdRcYs=;
        b=OL3DNMvfhU2wtxBr/9QFr7zcWqgXIlVQ1rS64+WfacYLs2KGFGWjcbwnykZ5HoDLzQ
         OBPrbBfL8T2SJisTYxdvQXdBySr2QcoHeBVXtgT5qApnmakNBB5deiRw6OpJI5J1Aclf
         Aorx6pFZjhvxaG/SodoYpvYoxLEAiB/zsTSJtwWnKqfbdQr8MFTElUhs0hFTgurILmNc
         xBC7cokuBVS3nyWh/wuoVEkUUbu82q2tqRlz7c3kvKUj4CLBAB1eVZzUq99IYSzuX5cQ
         YDaVrRMk2ACJHFhX966Nhy5T8z6NNMQYmOjW7Glo2zmXvHH2JueL5nvfFrGrVxuwFzWE
         BI4g==
X-Received: by 10.50.225.35 with SMTP id rh3mr33403272igc.29.1435769641818;
        Wed, 01 Jul 2015 09:54:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id e69sm1753959ioe.11.2015.07.01.09.53.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 09:53:59 -0700 (PDT)
In-Reply-To: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 30 Jun 2015 00:56:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273163>

From: Eric Sunshine <sunshine@sunshineco.com>

The command "git checkout --to <path>" is something of an anachronism,
encompassing functionality somewhere between "checkout" and "clone".
The introduction of the git-worktree command, however, provides a proper
and intuitive place to house such functionality. Consequently,
re-implement "git checkout --to" as "git worktree add".

As a side-effect, linked worktree creation becomes much more
discoverable with its own dedicated command, whereas `--to` was easily
overlooked amid the plethora of options recognized by git-checkout.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Duy seems to think "worktree add" is coming, too, so here is a
   trivial tweak of your patch from the last month, with test
   adjustments to 7410 I sent earlier squashed in.

   I noticed GIT_CHECKOUT_NEW_WORKTREE environment variabl that does
   not seem to be documented.  Is this something we still need?

   The log message of 529fef20 (checkout: support checking out into
   a new working directory, 2014-11-30) does not tell us much.

 Documentation/git-checkout.txt    |  72 -----------------
 Documentation/git-worktree.txt    |  79 ++++++++++++++++++-
 builtin/checkout.c                | 152 +-----------------------------------
 builtin/worktree.c                | 157 ++++++++++++++++++++++++++++++++++++++
 t/t2025-checkout-to.sh            | 137 ---------------------------------
 t/t2025-worktree-add.sh           | 137 +++++++++++++++++++++++++++++++++
 t/t2026-prune-linked-checkouts.sh |   2 +-
 t/t7410-submodule-checkout-to.sh  |   4 +-
 8 files changed, 377 insertions(+), 363 deletions(-)
 delete mode 100755 t/t2025-checkout-to.sh
 create mode 100755 t/t2025-worktree-add.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 72def5b..efe6a02 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -225,13 +225,6 @@ This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
---to=<path>::
-	Check out a branch in a separate working directory at
-	`<path>`. A new working directory is linked to the current
-	repository, sharing everything except working directory
-	specific files such as HEAD, index... See "MULTIPLE WORKING
-	TREES" section for more information.
-
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted ref is already checked
 	out by another worktree. This option makes it check the ref
@@ -401,71 +394,6 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
 
-MULTIPLE WORKING TREES
-----------------------
-
-A git repository can support multiple working trees, allowing you to check
-out more than one branch at a time.  With `git checkout --to` a new working
-tree is associated with the repository.  This new working tree is called a
-"linked working tree" as opposed to the "main working tree" prepared by "git
-init" or "git clone".  A repository has one main working tree (if it's not a
-bare repository) and zero or more linked working trees.
-
-Each linked working tree has a private sub-directory in the repository's
-$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
-the base name of the linked working tree's path, possibly appended with a
-number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
-command `git checkout --to /path/other/test-next next` creates the linked
-working tree in `/path/other/test-next` and also creates a
-`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
-if `test-next` is already taken).
-
-Within a linked working tree, $GIT_DIR is set to point to this private
-directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
-$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
-(e.g. `/path/main/.git`). These settings are made in a `.git` file located at
-the top directory of the linked working tree.
-
-Path resolution via `git rev-parse --git-path` uses either
-$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
-linked working tree `git rev-parse --git-path HEAD` returns
-`/path/main/.git/worktrees/test-next/HEAD` (not
-`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
-rev-parse --git-path refs/heads/master` uses
-$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all working trees.
-
-See linkgit:gitrepository-layout[5] for more information. The rule of
-thumb is do not make any assumption about whether a path belongs to
-$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
-inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
-
-When you are done with a linked working tree you can simply delete it.
-The working tree's entry in the repository's $GIT_DIR/worktrees
-directory will eventually be removed automatically (see
-`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
-`git prune --worktrees` in the main or any linked working tree to
-clean up any stale entries in $GIT_DIR/worktrees.
-
-If you move a linked working directory to another file system, or
-within a file system that does not support hard links, you need to run
-at least one git command inside the linked working directory
-(e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
-so that it does not get automatically removed.
-
-To prevent a $GIT_DIR/worktrees entry from from being pruned (which
-can be useful in some situations, such as when the
-entry's working tree is stored on a portable device), add a file named
-'locked' to the entry's directory. The file contains the reason in
-plain text. For example, if a linked working tree's `.git` file points
-to `/path/main/.git/worktrees/test-next` then a file named
-`/path/main/.git/worktrees/test-next/locked` will prevent the
-`test-next` entry from being pruned.  See
-linkgit:gitrepository-layout[5] for details.
-
-Multiple checkout support for submodules is incomplete. It is NOT
-recommended to make multiple checkouts of a superproject.
-
 EXAMPLES
 --------
 
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 41103e5..94dce6d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,16 +9,85 @@ git-worktree - Manage multiple worktrees
 SYNOPSIS
 --------
 [verse]
+'git worktree add' [-f] <path> [<checkout-options>] <branch>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
 DESCRIPTION
 -----------
 
-Manage multiple worktrees attached to the same repository. These are
-created by the command `git checkout --to`.
+Manage multiple worktrees attached to the same repository.
+
+A git repository can support multiple working trees, allowing you to check
+out more than one branch at a time.  With `git worktree add` a new working
+tree is created and gets associated with the repository.  This new working tree is called a
+"linked working tree" as opposed to the "main working tree" prepared by "git
+init" or "git clone".  A repository has one main working tree (if it's not a
+bare repository) and zero or more linked working trees.
+
+Each linked working tree has a private sub-directory in the repository's
+$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
+the base name of the linked working tree's path, possibly appended with a
+number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
+command `git worktree add /path/other/test-next next` creates the linked
+working tree in `/path/other/test-next` and also creates a
+`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
+if `test-next` is already taken).
+
+Within a linked working tree, $GIT_DIR is set to point to this private
+directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
+$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
+(e.g. `/path/main/.git`). These settings are made in a `.git` file located at
+the top directory of the linked working tree.
+
+Path resolution via `git rev-parse --git-path` uses either
+$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
+linked working tree `git rev-parse --git-path HEAD` returns
+`/path/main/.git/worktrees/test-next/HEAD` (not
+`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
+rev-parse --git-path refs/heads/master` uses
+$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
+since refs are shared across all working trees.
+
+See linkgit:gitrepository-layout[5] for more information. The rule of
+thumb is do not make any assumption about whether a path belongs to
+$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
+inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
+
+When you are done with a linked working tree you can simply delete it.
+The working tree's entry in the repository's $GIT_DIR/worktrees
+directory will eventually be removed automatically (see
+`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
+`git prune --worktrees` in the main or any linked working tree to
+clean up any stale entries in $GIT_DIR/worktrees.
+
+If you move a linked working directory to another file system, or
+within a file system that does not support hard links, you need to run
+at least one git command inside the linked working directory
+(e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
+so that it does not get automatically removed.
+
+To prevent a $GIT_DIR/worktrees entry from from being pruned (which
+can be useful in some situations, such as when the
+entry's working tree is stored on a portable device), add a file named
+'locked' to the entry's directory. The file contains the reason in
+plain text. For example, if a linked working tree's `.git` file points
+to `/path/main/.git/worktrees/test-next` then a file named
+`/path/main/.git/worktrees/test-next/locked` will prevent the
+`test-next` entry from being pruned.  See
+linkgit:gitrepository-layout[5] for details.
+
+Multiple checkout support for submodules is incomplete. It is NOT
+recommended to make multiple checkouts of a superproject.
 
 COMMANDS
 --------
+add::
+
+Check out a branch in a separate working directory at
+`<path>`. A new working directory is linked to the current
+repository, sharing everything except working directory
+specific files such as HEAD, index, etc.
+
 prune::
 
 Prune working tree information in $GIT_DIR/worktrees.
@@ -26,6 +95,12 @@ Prune working tree information in $GIT_DIR/worktrees.
 OPTIONS
 -------
 
+-f::
+--force::
+	By default, `git worktree add` refuses to create a new worktree when
+	<branch> is already checked out by another worktree. This option
+	overrides that safeguard.
+
 -n::
 --dry-run::
 	Do not remove anything; just report what it would
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2079aa4..439c061 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -51,8 +51,6 @@ struct checkout_opts {
 	struct pathspec pathspec;
 	struct tree *source_tree;
 
-	const char *new_worktree;
-	const char **saved_argv;
 	int new_worktree_mode;
 };
 
@@ -255,8 +253,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
-	if (opts->new_worktree)
-		die(_("'%s' cannot be used with updating paths"), "--to");
+	if (opts->new_worktree_mode)
+		die(_("'%s' cannot be used with updating paths"), "git worktree add");
 
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=checkout",
@@ -825,138 +823,6 @@ static int switch_branches(const struct checkout_opts *opts,
 	return ret || writeout_error;
 }
 
-static char *junk_work_tree;
-static char *junk_git_dir;
-static int is_junk;
-static pid_t junk_pid;
-
-static void remove_junk(void)
-{
-	struct strbuf sb = STRBUF_INIT;
-	if (!is_junk || getpid() != junk_pid)
-		return;
-	if (junk_git_dir) {
-		strbuf_addstr(&sb, junk_git_dir);
-		remove_dir_recursively(&sb, 0);
-		strbuf_reset(&sb);
-	}
-	if (junk_work_tree) {
-		strbuf_addstr(&sb, junk_work_tree);
-		remove_dir_recursively(&sb, 0);
-	}
-	strbuf_release(&sb);
-}
-
-static void remove_junk_on_signal(int signo)
-{
-	remove_junk();
-	sigchain_pop(signo);
-	raise(signo);
-}
-
-static int prepare_linked_checkout(const struct checkout_opts *opts,
-				   struct branch_info *new)
-{
-	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT;
-	const char *path = opts->new_worktree, *name;
-	struct stat st;
-	struct child_process cp;
-	int counter = 0, len, ret;
-
-	if (!new->commit)
-		die(_("no branch specified"));
-	if (file_exists(path) && !is_empty_dir(path))
-		die(_("'%s' already exists"), path);
-
-	len = strlen(path);
-	while (len && is_dir_sep(path[len - 1]))
-		len--;
-
-	for (name = path + len - 1; name > path; name--)
-		if (is_dir_sep(*name)) {
-			name++;
-			break;
-		}
-	strbuf_addstr(&sb_repo,
-		      git_path("worktrees/%.*s", (int)(path + len - name), name));
-	len = sb_repo.len;
-	if (safe_create_leading_directories_const(sb_repo.buf))
-		die_errno(_("could not create leading directories of '%s'"),
-			  sb_repo.buf);
-	while (!stat(sb_repo.buf, &st)) {
-		counter++;
-		strbuf_setlen(&sb_repo, len);
-		strbuf_addf(&sb_repo, "%d", counter);
-	}
-	name = strrchr(sb_repo.buf, '/') + 1;
-
-	junk_pid = getpid();
-	atexit(remove_junk);
-	sigchain_push_common(remove_junk_on_signal);
-
-	if (mkdir(sb_repo.buf, 0777))
-		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
-	junk_git_dir = xstrdup(sb_repo.buf);
-	is_junk = 1;
-
-	/*
-	 * lock the incomplete repo so prune won't delete it, unlock
-	 * after the preparation is over.
-	 */
-	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	write_file(sb.buf, 1, "initializing\n");
-
-	strbuf_addf(&sb_git, "%s/.git", path);
-	if (safe_create_leading_directories_const(sb_git.buf))
-		die_errno(_("could not create leading directories of '%s'"),
-			  sb_git.buf);
-	junk_work_tree = xstrdup(path);
-
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
-	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
-		   real_path(get_git_common_dir()), name);
-	/*
-	 * This is to keep resolve_ref() happy. We need a valid HEAD
-	 * or is_git_directory() will reject the directory. Any valid
-	 * value would do because this value will be ignored and
-	 * replaced at the next (real) checkout.
-	 */
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
-	write_file(sb.buf, 1, "../..\n");
-
-	if (!opts->quiet)
-		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
-
-	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
-	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
-	memset(&cp, 0, sizeof(cp));
-	cp.git_cmd = 1;
-	cp.argv = opts->saved_argv;
-	ret = run_command(&cp);
-	if (!ret) {
-		is_junk = 0;
-		free(junk_work_tree);
-		free(junk_git_dir);
-		junk_work_tree = NULL;
-		junk_git_dir = NULL;
-	}
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	unlink_or_warn(sb.buf);
-	strbuf_release(&sb);
-	strbuf_release(&sb_repo);
-	strbuf_release(&sb_git);
-	return ret;
-}
-
 static int git_checkout_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "diff.ignoresubmodules")) {
@@ -1295,9 +1161,6 @@ static int checkout_branch(struct checkout_opts *opts,
 		free(head_ref);
 	}
 
-	if (opts->new_worktree)
-		return prepare_linked_checkout(opts, new);
-
 	if (!new->commit && opts->new_branch) {
 		unsigned char rev[20];
 		int flag;
@@ -1340,8 +1203,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
-		OPT_FILENAME(0, "to", &opts.new_worktree,
-			   N_("check a branch out in a separate working directory")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END(),
@@ -1352,9 +1213,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
 
-	opts.saved_argv = xmalloc(sizeof(const char *) * (argc + 2));
-	memcpy(opts.saved_argv, argv, sizeof(const char *) * (argc + 1));
-
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
 
@@ -1363,13 +1221,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	/* recursive execution from checkout_new_worktree() */
 	opts.new_worktree_mode = getenv("GIT_CHECKOUT_NEW_WORKTREE") != NULL;
-	if (opts.new_worktree_mode)
-		opts.new_worktree = NULL;
 
-	if (!opts.new_worktree)
-		setup_work_tree();
+	setup_work_tree();
 
 	if (conflict_style) {
 		opts.merge = 1; /* implied */
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2a729c6..0983003 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -2,8 +2,11 @@
 #include "builtin.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "run-command.h"
+#include "sigchain.h"
 
 static const char * const worktree_usage[] = {
+	N_("git worktree add [<options>] <path> [<checkout-options>] <branch>"),
 	N_("git worktree prune [<options>]"),
 	NULL
 };
@@ -119,6 +122,158 @@ static int prune(int ac, const char **av, const char *prefix)
 	return 0;
 }
 
+static char *junk_work_tree;
+static char *junk_git_dir;
+static int is_junk;
+static pid_t junk_pid;
+
+static void remove_junk(void)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (!is_junk || getpid() != junk_pid)
+		return;
+	if (junk_git_dir) {
+		strbuf_addstr(&sb, junk_git_dir);
+		remove_dir_recursively(&sb, 0);
+		strbuf_reset(&sb);
+	}
+	if (junk_work_tree) {
+		strbuf_addstr(&sb, junk_work_tree);
+		remove_dir_recursively(&sb, 0);
+	}
+	strbuf_release(&sb);
+}
+
+static void remove_junk_on_signal(int signo)
+{
+	remove_junk();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static int add_worktree(const char *path, int force, const char **av)
+{
+	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *name;
+	struct stat st;
+	struct child_process cp;
+	int counter = 0, len, ret;
+	unsigned char rev[20];
+
+	if (file_exists(path) && !is_empty_dir(path))
+		die(_("'%s' already exists"), path);
+
+	len = strlen(path);
+	while (len && is_dir_sep(path[len - 1]))
+		len--;
+
+	for (name = path + len - 1; name > path; name--)
+		if (is_dir_sep(*name)) {
+			name++;
+			break;
+		}
+	strbuf_addstr(&sb_repo,
+		      git_path("worktrees/%.*s", (int)(path + len - name), name));
+	len = sb_repo.len;
+	if (safe_create_leading_directories_const(sb_repo.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_repo.buf);
+	while (!stat(sb_repo.buf, &st)) {
+		counter++;
+		strbuf_setlen(&sb_repo, len);
+		strbuf_addf(&sb_repo, "%d", counter);
+	}
+	name = strrchr(sb_repo.buf, '/') + 1;
+
+	junk_pid = getpid();
+	atexit(remove_junk);
+	sigchain_push_common(remove_junk_on_signal);
+
+	if (mkdir(sb_repo.buf, 0777))
+		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
+	junk_git_dir = xstrdup(sb_repo.buf);
+	is_junk = 1;
+
+	/*
+	 * lock the incomplete repo so prune won't delete it, unlock
+	 * after the preparation is over.
+	 */
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	write_file(sb.buf, 1, "initializing\n");
+
+	strbuf_addf(&sb_git, "%s/.git", path);
+	if (safe_create_leading_directories_const(sb_git.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_git.buf);
+	junk_work_tree = xstrdup(path);
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
+	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
+	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
+		   real_path(get_git_common_dir()), name);
+	/*
+	 * This is to keep resolve_ref() happy. We need a valid HEAD
+	 * or is_git_directory() will reject the directory. Any valid
+	 * value would do because this value will be ignored and
+	 * replaced at the next (real) checkout.
+	 */
+	if (!resolve_ref_unsafe("HEAD", 0, rev, NULL))
+		die(_("unable to resolve HEAD"));
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+	write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
+	write_file(sb.buf, 1, "../..\n");
+
+	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+
+	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
+	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
+	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd = 1;
+	argv_array_push(&cp.args, "checkout");
+	if (force)
+		argv_array_push(&cp.args, "--ignore-other-worktrees");
+	for (; *av; av++)
+		argv_array_push(&cp.args, *av);
+	ret = run_command(&cp);
+	if (!ret) {
+		is_junk = 0;
+		free(junk_work_tree);
+		free(junk_git_dir);
+		junk_work_tree = NULL;
+		junk_git_dir = NULL;
+	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	unlink_or_warn(sb.buf);
+	strbuf_release(&sb);
+	strbuf_release(&sb_repo);
+	strbuf_release(&sb_git);
+	return ret;
+}
+
+static int add(int ac, const char **av, const char *prefix)
+{
+	int force = 0;
+	const char *path;
+	struct option options[] = {
+		OPT__FORCE(&force, N_("checkout <branch> even if already checked out in other worktree")),
+		OPT_END()
+	};
+
+	ac = parse_options(ac, av, prefix, options, worktree_usage,
+			   PARSE_OPT_STOP_AT_NON_OPTION);
+	if (ac < 2)
+		usage_with_options(worktree_usage, options);
+	path = prefix ? prefix_filename(prefix, strlen(prefix), av[0]) : av[0];
+	return add_worktree(path, force, av + 1);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -127,6 +282,8 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
+	if (!strcmp(av[1], "add"))
+		return add(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
deleted file mode 100755
index a8d9336..0000000
--- a/t/t2025-checkout-to.sh
+++ /dev/null
@@ -1,137 +0,0 @@
-#!/bin/sh
-
-test_description='test git checkout --to'
-
-. ./test-lib.sh
-
-test_expect_success 'setup' '
-	test_commit init
-'
-
-test_expect_success 'checkout --to not updating paths' '
-	test_must_fail git checkout --to -- init.t
-'
-
-test_expect_success 'checkout --to an existing worktree' '
-	mkdir -p existing/subtree &&
-	test_must_fail git checkout --detach --to existing master
-'
-
-test_expect_success 'checkout --to an existing empty worktree' '
-	mkdir existing_empty &&
-	git checkout --detach --to existing_empty master
-'
-
-test_expect_success 'checkout --to refuses to checkout locked branch' '
-	test_must_fail git checkout --to zere master &&
-	! test -d zere &&
-	! test -d .git/worktrees/zere
-'
-
-test_expect_success 'checking out paths not complaining about linked checkouts' '
-	(
-	cd existing_empty &&
-	echo dirty >>init.t &&
-	git checkout master -- init.t
-	)
-'
-
-test_expect_success 'checkout --to a new worktree' '
-	git rev-parse HEAD >expect &&
-	git checkout --detach --to here master &&
-	(
-		cd here &&
-		test_cmp ../init.t init.t &&
-		test_must_fail git symbolic-ref HEAD &&
-		git rev-parse HEAD >actual &&
-		test_cmp ../expect actual &&
-		git fsck
-	)
-'
-
-test_expect_success 'checkout --to a new worktree from a subdir' '
-	(
-		mkdir sub &&
-		cd sub &&
-		git checkout --detach --to here master &&
-		cd here &&
-		test_cmp ../../init.t init.t
-	)
-'
-
-test_expect_success 'checkout --to from a linked checkout' '
-	(
-		cd here &&
-		git checkout --detach --to nested-here master &&
-		cd nested-here &&
-		git fsck
-	)
-'
-
-test_expect_success 'checkout --to a new worktree creating new branch' '
-	git checkout --to there -b newmaster master &&
-	(
-		cd there &&
-		test_cmp ../init.t init.t &&
-		git symbolic-ref HEAD >actual &&
-		echo refs/heads/newmaster >expect &&
-		test_cmp expect actual &&
-		git fsck
-	)
-'
-
-test_expect_success 'die the same branch is already checked out' '
-	(
-		cd here &&
-		test_must_fail git checkout newmaster
-	)
-'
-
-test_expect_success 'not die the same branch is already checked out' '
-	(
-		cd here &&
-		git checkout --ignore-other-worktrees --to anothernewmaster newmaster
-	)
-'
-
-test_expect_success 'not die on re-checking out current branch' '
-	(
-		cd there &&
-		git checkout newmaster
-	)
-'
-
-test_expect_success 'checkout --to from a bare repo' '
-	(
-		git clone --bare . bare &&
-		cd bare &&
-		git checkout --to ../there2 -b bare-master master
-	)
-'
-
-test_expect_success 'checkout from a bare repo without --to' '
-	(
-		cd bare &&
-		test_must_fail git checkout master
-	)
-'
-
-test_expect_success 'checkout with grafts' '
-	test_when_finished rm .git/info/grafts &&
-	test_commit abc &&
-	SHA1=`git rev-parse HEAD` &&
-	test_commit def &&
-	test_commit xyz &&
-	echo "`git rev-parse HEAD` $SHA1" >.git/info/grafts &&
-	cat >expected <<-\EOF &&
-	xyz
-	abc
-	EOF
-	git log --format=%s -2 >actual &&
-	test_cmp expected actual &&
-	git checkout --detach --to grafted master &&
-	git --git-dir=grafted/.git log --format=%s -2 >actual &&
-	test_cmp expected actual
-'
-
-test_done
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
new file mode 100755
index 0000000..a757988
--- /dev/null
+++ b/t/t2025-worktree-add.sh
@@ -0,0 +1,137 @@
+#!/bin/sh
+
+test_description='test git worktree add'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init
+'
+
+test_expect_success '"add" not updating paths' '
+	test_must_fail git worktree add -- init.t
+'
+
+test_expect_success '"add" an existing worktree' '
+	mkdir -p existing/subtree &&
+	test_must_fail git worktree add existing --detach master
+'
+
+test_expect_success '"add" an existing empty worktree' '
+	mkdir existing_empty &&
+	git worktree add existing_empty --detach master
+'
+
+test_expect_success '"add" refuses to checkout locked branch' '
+	test_must_fail git worktree add zere master &&
+	! test -d zere &&
+	! test -d .git/worktrees/zere
+'
+
+test_expect_success 'checking out paths not complaining about linked checkouts' '
+	(
+	cd existing_empty &&
+	echo dirty >>init.t &&
+	git checkout master -- init.t
+	)
+'
+
+test_expect_success '"add" worktree' '
+	git rev-parse HEAD >expect &&
+	git worktree add here --detach master &&
+	(
+		cd here &&
+		test_cmp ../init.t init.t &&
+		test_must_fail git symbolic-ref HEAD &&
+		git rev-parse HEAD >actual &&
+		test_cmp ../expect actual &&
+		git fsck
+	)
+'
+
+test_expect_success '"add" worktree from a subdir' '
+	(
+		mkdir sub &&
+		cd sub &&
+		git worktree add here --detach master &&
+		cd here &&
+		test_cmp ../../init.t init.t
+	)
+'
+
+test_expect_success '"add" from a linked checkout' '
+	(
+		cd here &&
+		git worktree add nested-here --detach master &&
+		cd nested-here &&
+		git fsck
+	)
+'
+
+test_expect_success '"add" worktree creating new branch' '
+	git worktree add there -b newmaster master &&
+	(
+		cd there &&
+		test_cmp ../init.t init.t &&
+		git symbolic-ref HEAD >actual &&
+		echo refs/heads/newmaster >expect &&
+		test_cmp expect actual &&
+		git fsck
+	)
+'
+
+test_expect_success 'die the same branch is already checked out' '
+	(
+		cd here &&
+		test_must_fail git checkout newmaster
+	)
+'
+
+test_expect_success 'not die the same branch is already checked out' '
+	(
+		cd here &&
+		git worktree add --force anothernewmaster newmaster
+	)
+'
+
+test_expect_success 'not die on re-checking out current branch' '
+	(
+		cd there &&
+		git checkout newmaster
+	)
+'
+
+test_expect_success '"add" from a bare repo' '
+	(
+		git clone --bare . bare &&
+		cd bare &&
+		git worktree add ../there2 -b bare-master master
+	)
+'
+
+test_expect_success 'checkout from a bare repo without "worktree add"' '
+	(
+		cd bare &&
+		test_must_fail git checkout master
+	)
+'
+
+test_expect_success 'checkout with grafts' '
+	test_when_finished rm .git/info/grafts &&
+	test_commit abc &&
+	SHA1=`git rev-parse HEAD` &&
+	test_commit def &&
+	test_commit xyz &&
+	echo "`git rev-parse HEAD` $SHA1" >.git/info/grafts &&
+	cat >expected <<-\EOF &&
+	xyz
+	abc
+	EOF
+	git log --format=%s -2 >actual &&
+	test_cmp expected actual &&
+	git worktree add grafted --detach master &&
+	git --git-dir=grafted/.git log --format=%s -2 >actual &&
+	test_cmp expected actual
+'
+
+test_done
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index e872f02..c74c935 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -88,7 +88,7 @@ test_expect_success 'not prune recent checkouts' '
 
 test_expect_success 'not prune proper checkouts' '
 	test_when_finished rm -r .git/worktrees &&
-	git checkout "--to=$PWD/nop" --detach master &&
+	git worktree add "$PWD/nop" --detach master &&
 	git worktree prune &&
 	test -d .git/worktrees/nop
 '
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index 8f30aed..3f609e8 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -33,7 +33,7 @@ rev1_hash_sub=$(git --git-dir=origin/sub/.git show --pretty=format:%h -q "HEAD~1
 test_expect_success 'checkout main' \
     'mkdir default_checkout &&
     (cd clone/main &&
-	git checkout --to "$base_path/default_checkout/main" "$rev1_hash_main")'
+	git worktree add "$base_path/default_checkout/main" "$rev1_hash_main")'
 
 test_expect_failure 'can see submodule diffs just after checkout' \
     '(cd default_checkout/main && git diff --submodule master"^!" | grep "file1 updated")'
@@ -41,7 +41,7 @@ test_expect_failure 'can see submodule diffs just after checkout' \
 test_expect_success 'checkout main and initialize independed clones' \
     'mkdir fully_cloned_submodule &&
     (cd clone/main &&
-	git checkout --to "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
+	git worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main") &&
     (cd fully_cloned_submodule/main && git submodule update)'
 
 test_expect_success 'can see submodule diffs after independed cloning' \
-- 
2.5.0-rc0-209-g5e1f148
