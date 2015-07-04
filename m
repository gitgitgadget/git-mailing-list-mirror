From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/23] checkout: retire --to option
Date: Fri,  3 Jul 2015 20:17:27 -0400
Message-ID: <1435969052-540-19-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBBB-0000X2-Rk
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104AbbGDATb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:19:31 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34335 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbbGDASp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:45 -0400
Received: by igcsj18 with SMTP id sj18so196950429igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mHzfD9bvSS455Kf9YqVEyLLZjFLjS4OinpUUnPKFYeY=;
        b=SVm3fyV7tcoS5+S6HKAFkJitOPMLbmUo2NrxzeUNp9V7+5Z8Ibeh7ukweVWnZVQ9E1
         2z4ZTtVwv2XCBzEkeBGGwXWVIbpZtmBYo0oeohPBljXNdkHTD9r6kjhrQH6OVjkZDaR8
         YX+umXfaK5KCQnDSkR6XHuf4Z+N2cLgoHPnFkHxpUIiQ3l5rKXQTTYAmyA+pCuq4DARB
         txIbGqvz1ua0GKyHoNmHPGUIj9udQZICpDLPfu9tqe2yug+IgRsIcyGsnPxTbxUArkyQ
         7IUj/hVy78FjNB1P4dq9Txzu481dJ0y8kBhsPdvuEeArnWcReLqixdsWjwn47bSU01hQ
         U2Lw==
X-Received: by 10.42.226.8 with SMTP id iu8mr21003367icb.17.1435969122562;
        Fri, 03 Jul 2015 17:18:42 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273333>

Now that "git worktree add" has achieved user-facing feature-parity with
"git checkout --to", retire the latter.

Move the actual linked worktree creation functionality,
prepare_linked_checkout() and its helpers, verbatim from checkout.c to
worktree.c.

This effectively reverts changes to checkout.c by 529fef2 (checkout:
support checking out into a new working directory, 2014-11-30) with the
exception of merge_working_tree() and switch_branches() which still
require specialized knowledge that a the checkout is occurring in a
newly-created linked worktree (signaled to them by the private
GIT_CHECKOUT_NEW_WORKTREE environment variable).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c | 156 +----------------------------------------------------
 builtin/worktree.c | 138 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 133 insertions(+), 161 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 30fe786..b1e68b3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -19,8 +19,6 @@
 #include "ll-merge.h"
 #include "resolve-undo.h"
 #include "submodule.h"
-#include "argv-array.h"
-#include "sigchain.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [options] <branch>"),
@@ -51,8 +49,6 @@ struct checkout_opts {
 	struct pathspec pathspec;
 	struct tree *source_tree;
 
-	const char *new_worktree;
-	const char **saved_argv;
 	int new_worktree_mode;
 };
 
@@ -255,9 +251,6 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
-	if (opts->new_worktree)
-		die(_("'%s' cannot be used with updating paths"), "--to");
-
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
@@ -825,137 +818,6 @@ static int switch_branches(const struct checkout_opts *opts,
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
-static int prepare_linked_checkout(const char *path, const char **child_argv)
-{
-	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
-	struct strbuf sb = STRBUF_INIT;
-	const char *name;
-	struct stat st;
-	struct child_process cp;
-	int counter = 0, len, ret;
-	unsigned char rev[20];
-
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
-	if (!resolve_ref_unsafe("HEAD", 0, rev, NULL))
-		die(_("unable to resolve HEAD"));
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
-	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
-	write_file(sb.buf, 1, "../..\n");
-
-	fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
-
-	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
-	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
-	memset(&cp, 0, sizeof(cp));
-	cp.git_cmd = 1;
-	cp.argv = child_argv;
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
@@ -1294,13 +1156,6 @@ static int checkout_branch(struct checkout_opts *opts,
 		free(head_ref);
 	}
 
-	if (opts->new_worktree) {
-		if (!new->commit)
-			die(_("no branch specified"));
-		return prepare_linked_checkout(opts->new_worktree,
-					       opts->saved_argv);
-	}
-
 	if (!new->commit && opts->new_branch) {
 		unsigned char rev[20];
 		int flag;
@@ -1343,8 +1198,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
-		OPT_FILENAME(0, "to", &opts.new_worktree,
-			   N_("check a branch out in a separate working directory")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		OPT_END(),
@@ -1355,9 +1208,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.overwrite_ignore = 1;
 	opts.prefix = prefix;
 
-	opts.saved_argv = xmalloc(sizeof(const char *) * (argc + 2));
-	memcpy(opts.saved_argv, argv, sizeof(const char *) * (argc + 1));
-
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
 
@@ -1366,13 +1216,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
index d461d31..7cfaec6 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "argv-array.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 static const char * const worktree_usage[] = {
 	N_("git worktree add [<options>] <path> <branch>"),
@@ -122,10 +123,139 @@ static int prune(int ac, const char **av, const char *prefix)
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
+static int add_worktree(const char *path, const char **child_argv)
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
+	cp.argv = child_argv;
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
 
 static int add(int ac, const char **av, const char *prefix)
 {
-	struct child_process c;
 	int force = 0, detach = 0;
 	const char *new_branch = NULL, *new_branch_force = NULL;
 	const char *path, *branch;
@@ -150,7 +280,6 @@ static int add(int ac, const char **av, const char *prefix)
 	branch = av[1];
 
 	argv_array_push(&cmd, "checkout");
-	argv_array_pushl(&cmd, "--to", path, NULL);
 	if (force)
 		argv_array_push(&cmd, "--ignore-other-worktrees");
 	if (new_branch)
@@ -161,10 +290,7 @@ static int add(int ac, const char **av, const char *prefix)
 		argv_array_push(&cmd, "--detach");
 	argv_array_push(&cmd, branch);
 
-	memset(&c, 0, sizeof(c));
-	c.git_cmd = 1;
-	c.argv = cmd.argv;
-	return run_command(&c);
+	return add_worktree(path, cmd.argv);
 }
 
 int cmd_worktree(int ac, const char **av, const char *prefix)
-- 
2.5.0.rc1.197.g417e668
