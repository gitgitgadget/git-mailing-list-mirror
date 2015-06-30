From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Tue, 30 Jun 2015 00:56:42 -0400
Message-ID: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 07:00:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9neN-0008Ol-I7
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 07:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbbF3E5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 00:57:46 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36431 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbbF3E5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 00:57:14 -0400
Received: by igrv9 with SMTP id v9so43572066igr.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 21:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=ZM4EAKHo4BhH1SKiun5649XuerlpCuP3vyY6zt++2yo=;
        b=WdbUCfql7COisAClD6hvqt7/TeNH5RR/fglfpoKvrRo+4PcIbZe87CZaKqW0UQklTR
         ptsWM7yMQbCiMzkrKiEo6Vc4xz8K0Wpz9rytz2iTlMnhKkI9vlNsL9BKhEZLyvxosuBu
         jk5hcct9UBbTPtesgntJ/7r5TfyKoFh7qQVs5J62u1wEzCyXp2N50vw4zqtmqVED0bFq
         Gl0JMuMb53O8VhDavKVkPwne/ESEhUtfcJ1WynWp8Hn3dOu3OkI2utrdVG2wfwZGCwPf
         i9VqA1NzqL2MwofWKK88MaHl5fAo58rZIC5700nF2HwU4vEf0G5DCWu10pCclaktM+E9
         2MTA==
X-Received: by 10.107.25.15 with SMTP id 15mr26147039ioz.11.1435640233404;
        Mon, 29 Jun 2015 21:57:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id v3sm7071738igk.1.2015.06.29.21.57.12
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 21:57:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.5.ga130864
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273032>

The command "git checkout --to <path>" is something of an anachronism,
encompassing functionality somewhere between "checkout" and "clone".
The introduction of the git-worktree command, however, provides a proper
and intuitive place to house such functionality. Consequently,
re-implement "git checkout --to" as "git worktree new".

As a side-effect, linked worktree creation becomes much more
discoverable with its own dedicated command, whereas `--to` was easily
overlooked amid the plethora of options recognized by git-checkout.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I've long felt that Duy's linked-worktree functionality was a bit oddly
named as "git checkout --to", but, since I could never come up with a
better name, I never made mention of it. However, with Duy's
introduction of the git-worktree command[1], we now have a much more
appropriate and discoverable place to house the "git checkout --to"
functionality, and upon seeing his patch, I was ready to reply with the
suggestion to relocate "git checkout --to" to "git worktree new",
however, Junio beat me to it[2]. So, in response, this patch does
exactly that. It applies atop [1].

This is primarily a code and documentation relocation patch, with minor
new code added to builtin/worktree.c. Specifically:

* git-checkout.txt:"--to" description moved to git-worktree.txt:"new".

* git-checkout.txt:"MULTIPLE WORKING TREES" moved to
  git-worktree.txt:"DESCRIPTION", with "checkout --to" replaced by
  "worktree new" as necessary. git-worktree.txt could probably use a bit
  of reorganization, but that can be done as a separate patch.

* builtin/checkout.c:remove_junk() and remove_junk_on_signal() moved
  verbatim to builtin/worktree.c.

* builtin/checkout.c:prepare_linked_checkout() moved to
  builtin/worktree.c:new_worktree() nearly verbatim. The following small
  changes were needed (which might possibly be better done as separate
  preparatory patches):

  - The "no branch specified" check was dropped since git-worktree lacks
    the machinery for parsing git-checkout command-line arguments, and
    thus simply doesn't know if a branch/ref was provided, or in what
    form.  I'm not sure yet how to replace this check.

  - checkout.c:prepare_linked_checkout() (temporarily) fakes up a HEAD
    ref with a valid object-id in the new worktree to pacify
    is_git_directory(). It does so using the branch/ref from the
    command-line which it already resolved. worktree.c, however, doesn't
    have access to this information, so I instead added code to resolve
    and use HEAD for the fakement.

  - The "Enter %s (identifier %s)" message is suppressed in checkout.c
    if --quiet is specified, however, worktree.c does not have a --quiet
    option, so the message is printed unconditionally.

  - argv[] for the sub git-checkout invocation is hand-crafted in
    worktree.c rather than merely being re-used from the original "git
    checkout --to" as it was in checkout.c.

* builtin/worktree.c:new() is new. It recognizes a --force option ("git
  worktree new --force <path> <branch>") which allows a branch to be
  checked out in a new worktree even if already checked out in some
  other worktree (thus, mirroring the functionality of "git checkout
  --ignore-other-worktrees").

* t2025-checkout-to.sh became t2025-worktree-new.sh. I'm not sure if the
  test number still makes sense or if it should be changed, however, it
  resides alongside its t2026-prune-linked-checkouts.sh counterpart.

[1]: http://git.661346.n2.nabble.com/PATCH-worktree-new-place-for-git-prune-worktrees-tp7634619.html
[2]: http://git.661346.n2.nabble.com/PATCH-worktree-new-place-for-git-prune-worktrees-tp7634619p7634638.html


 Documentation/git-checkout.txt                    |  72 ----------
 Documentation/git-worktree.txt                    |  79 ++++++++++-
 builtin/checkout.c                                | 152 +--------------------
 builtin/worktree.c                                | 157 ++++++++++++++++++++++
 t/{t2025-checkout-to.sh => t2025-worktree-new.sh} |  44 +++---
 t/t2026-prune-linked-checkouts.sh                 |   2 +-
 6 files changed, 260 insertions(+), 246 deletions(-)
 rename t/{t2025-checkout-to.sh => t2025-worktree-new.sh} (56%)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d263a56..e19f03a 100644
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
index 41103e5..8f13281 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,16 +9,85 @@ git-worktree - Manage multiple worktrees
 SYNOPSIS
 --------
 [verse]
+'git worktree new' [-f] <path> [<checkout-options>] <branch>
 'git worktree prune' [-n] [-v] [--expire <expire>]
 
 DESCRIPTION
 -----------
 
-Manage multiple worktrees attached to the same repository. These are
-created by the command `git checkout --to`.
+Manage multiple worktrees attached to the same repository.
+
+A git repository can support multiple working trees, allowing you to check
+out more than one branch at a time.  With `git worktree new` a new working
+tree is associated with the repository.  This new working tree is called a
+"linked working tree" as opposed to the "main working tree" prepared by "git
+init" or "git clone".  A repository has one main working tree (if it's not a
+bare repository) and zero or more linked working trees.
+
+Each linked working tree has a private sub-directory in the repository's
+$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
+the base name of the linked working tree's path, possibly appended with a
+number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
+command `git worktree new /path/other/test-next next` creates the linked
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
+new::
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
+	By default, `git worktree new` refuses to create a new worktree when
+	<branch> is already checked out by another worktree. This option
+	overrides that safeguard.
+
 -n::
 --dry-run::
 	Do not remove anything; just report what it would
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b49f0e..3dd5694 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -51,8 +51,6 @@ struct checkout_opts {
 	struct pathspec pathspec;
 	struct tree *source_tree;
 
-	const char *new_worktree;
-	const char **saved_argv;
 	int new_worktree_mode;
 };
 
@@ -273,8 +271,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
-	if (opts->new_worktree)
-		die(_("'%s' cannot be used with updating paths"), "--to");
+	if (opts->new_worktree_mode)
+		die(_("'%s' cannot be used with updating paths"), "git worktree new");
 
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=checkout",
@@ -850,138 +848,6 @@ static int switch_branches(const struct checkout_opts *opts,
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
@@ -1321,9 +1187,6 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new->name);
 
-	if (opts->new_worktree)
-		return prepare_linked_checkout(opts, new);
-
 	if (!new->commit && opts->new_branch) {
 		unsigned char rev[20];
 		int flag;
@@ -1366,8 +1229,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout <no-such-branch>'")),
-		OPT_FILENAME(0, "to", &opts.new_worktree,
-			   N_("check a branch out in a separate working directory")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END(),
@@ -1378,9 +1239,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
 
-	opts.saved_argv = xmalloc(sizeof(const char *) * (argc + 2));
-	memcpy(opts.saved_argv, argv, sizeof(const char *) * (argc + 1));
-
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
 
@@ -1389,13 +1247,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
index 2a729c6..6486f09 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -2,8 +2,11 @@
 #include "builtin.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "run-command.h"
+#include "sigchain.h"
 
 static const char * const worktree_usage[] = {
+	N_("git worktree new [<options>] <path> [<checkout-options>] <branch>"),
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
+static int new_worktree(const char *path, int force, const char **av)
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
+static int new(int ac, const char **av, const char *prefix)
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
+	return new_worktree(path, force, av + 1);
+}
+
 int cmd_worktree(int ac, const char **av, const char *prefix)
 {
 	struct option options[] = {
@@ -127,6 +282,8 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
 
 	if (ac < 2)
 		usage_with_options(worktree_usage, options);
+	if (!strcmp(av[1], "new"))
+		return new(ac - 1, av + 1, prefix);
 	if (!strcmp(av[1], "prune"))
 		return prune(ac - 1, av + 1, prefix);
 	usage_with_options(worktree_usage, options);
diff --git a/t/t2025-checkout-to.sh b/t/t2025-worktree-new.sh
similarity index 56%
rename from t/t2025-checkout-to.sh
rename to t/t2025-worktree-new.sh
index f8e4df4..d43b352 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-worktree-new.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test git checkout --to'
+test_description='test git worktree new'
 
 . ./test-lib.sh
 
@@ -8,29 +8,29 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_success 'checkout --to not updating paths' '
-	test_must_fail git checkout --to -- init.t
+test_expect_success '"new" not updating paths' '
+	test_must_fail git worktree new -- init.t
 '
 
-test_expect_success 'checkout --to an existing worktree' '
+test_expect_success '"new" an existing worktree' '
 	mkdir -p existing/subtree &&
-	test_must_fail git checkout --detach --to existing master
+	test_must_fail git worktree new existing --detach master
 '
 
-test_expect_success 'checkout --to an existing empty worktree' '
+test_expect_success '"new" an existing empty worktree' '
 	mkdir existing_empty &&
-	git checkout --detach --to existing_empty master
+	git worktree new existing_empty --detach master
 '
 
-test_expect_success 'checkout --to refuses to checkout locked branch' '
-	test_must_fail git checkout --to zere master &&
+test_expect_success '"new" refuses to checkout locked branch' '
+	test_must_fail git worktree new zere master &&
 	! test -d zere &&
 	! test -d .git/worktrees/zere
 '
 
-test_expect_success 'checkout --to a new worktree' '
+test_expect_success '"new" worktree' '
 	git rev-parse HEAD >expect &&
-	git checkout --detach --to here master &&
+	git worktree new here --detach master &&
 	(
 		cd here &&
 		test_cmp ../init.t init.t &&
@@ -41,27 +41,27 @@ test_expect_success 'checkout --to a new worktree' '
 	)
 '
 
-test_expect_success 'checkout --to a new worktree from a subdir' '
+test_expect_success '"new" worktree from a subdir' '
 	(
 		mkdir sub &&
 		cd sub &&
-		git checkout --detach --to here master &&
+		git worktree new here --detach master &&
 		cd here &&
 		test_cmp ../../init.t init.t
 	)
 '
 
-test_expect_success 'checkout --to from a linked checkout' '
+test_expect_success '"new" from a linked checkout' '
 	(
 		cd here &&
-		git checkout --detach --to nested-here master &&
+		git worktree new nested-here --detach master &&
 		cd nested-here &&
 		git fsck
 	)
 '
 
-test_expect_success 'checkout --to a new worktree creating new branch' '
-	git checkout --to there -b newmaster master &&
+test_expect_success '"new" worktree creating new branch' '
+	git worktree new there -b newmaster master &&
 	(
 		cd there &&
 		test_cmp ../init.t init.t &&
@@ -82,7 +82,7 @@ test_expect_success 'die the same branch is already checked out' '
 test_expect_success 'not die the same branch is already checked out' '
 	(
 		cd here &&
-		git checkout --ignore-other-worktrees --to anothernewmaster newmaster
+		git worktree new --force anothernewmaster newmaster
 	)
 '
 
@@ -93,15 +93,15 @@ test_expect_success 'not die on re-checking out current branch' '
 	)
 '
 
-test_expect_success 'checkout --to from a bare repo' '
+test_expect_success '"new" from a bare repo' '
 	(
 		git clone --bare . bare &&
 		cd bare &&
-		git checkout --to ../there2 -b bare-master master
+		git worktree new ../there2 -b bare-master master
 	)
 '
 
-test_expect_success 'checkout from a bare repo without --to' '
+test_expect_success 'checkout from a bare repo without "worktree new"' '
 	(
 		cd bare &&
 		test_must_fail git checkout master
@@ -121,7 +121,7 @@ test_expect_success 'checkout with grafts' '
 	EOF
 	git log --format=%s -2 >actual &&
 	test_cmp expected actual &&
-	git checkout --detach --to grafted master &&
+	git worktree new grafted --detach master &&
 	git --git-dir=grafted/.git log --format=%s -2 >actual &&
 	test_cmp expected actual
 '
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index e872f02..d50688c 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -88,7 +88,7 @@ test_expect_success 'not prune recent checkouts' '
 
 test_expect_success 'not prune proper checkouts' '
 	test_when_finished rm -r .git/worktrees &&
-	git checkout "--to=$PWD/nop" --detach master &&
+	git worktree new "$PWD/nop" --detach master &&
 	git worktree prune &&
 	test -d .git/worktrees/nop
 '
-- 
2.5.0.rc0.203.gd595659
