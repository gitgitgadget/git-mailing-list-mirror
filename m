From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/32] nd/multiple-work-trees
Date: Thu, 11 Sep 2014 05:41:36 +0700
Message-ID: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:42:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqaa-00011d-00
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbaIJWmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 18:42:06 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43450 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbaIJWmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:42:04 -0400
Received: by mail-pa0-f51.google.com with SMTP id kx10so8554980pab.38
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UwuCqgdz0UumcmdHBU5qwa/zcFfDhlAiobvyyWw5FRA=;
        b=C+yH1oeqFijr6Yk+VjC2bfCHaSmr/gU1OB/B6vx2mxFzHxZWk0EcWPBjNKQmGF+rF2
         OT+20gtANTHuYCMidS4ZwuwY0GPmaE6nFKHz2ZTe6kGyerS77JF4JpNCUmD5kxj2KgY3
         +64CHiUCHkD1cQ0u2lYeDqY5eN3mUpLSzKgC6odMfPLYqwV2Vs12iLSAo12+0htYKSYk
         etooCiPHNSNaE8YBwCqVMEm8khzum0eNRJf1Qw543sKX1MSDUk2ajF3ky9DzBD/j4QC2
         Ne3oa63R4tGqZFcjm6HeCm7PQKbx+n/mQxizBYlY8fGeN4qtIt6EHMxVvy+Qz5I+H6NX
         9OZQ==
X-Received: by 10.70.134.231 with SMTP id pn7mr54157604pdb.82.1410388922695;
        Wed, 10 Sep 2014 15:42:02 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id fa16sm16345978pac.43.2014.09.10.15.41.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:42:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:42:21 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256777>

Changes since last send (diff below):

 - rename $GIT_DIR/repos to $GIT_DIR/worktrees. update documents and
   command options accordingly
 - rewrite the multiple checkout section in git-checkout.txt
 - reorder some patches to make sure the test suite always pass

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 57999fa..a85f684 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1211,12 +1211,12 @@ gc.pruneexpire::
 	"now" may be used to disable this  grace period and always prune
 	unreachable objects immediately.
 
-gc.prunereposexpire::
+gc.pruneworktreesexpire::
 	When 'git gc' is run, it will call
-	'prune --repos --expire 3.months.ago'.
+	'prune --worktrees --expire 3.months.ago'.
 	Override the grace period with this config variable. The value
 	"now" may be used to disable the grace period and prune
-	$GIT_DIR/repos immediately.
+	$GIT_DIR/worktrees immediately.
 
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 38c70c5..23f0c80 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -226,7 +226,7 @@ edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
 --to=<path>::
-	Check out a new branch in a separate working directory at
+	Check out a branch in a separate working directory at
 	`<path>`. A new working directory is linked to the current
 	repository, sharing everything except working directory
 	specific files such as HEAD, index... See "MULTIPLE CHECKOUT
@@ -404,23 +404,50 @@ checkout" as compared to the "main checkout" prepared by "git init" or
 "git clone". A repository has one main checkout and zero or more
 linked checkouts.
 
-All checkouts share the same repository. Linked checkouts see the
-repository a bit different from the main checkout. When the checkout
-"new" reads the path $GIT_DIR/HEAD for example, the actual path
-returned could be $GIT_DIR/repos/new/HEAD. This ensures checkouts
-won't step on each other.
-
-Each linked checkout has a private space in $GIT_DIR/repos, usually
-named after the base name of the working directory with a number added
-to make it unique. The linked checkout's $GIT_DIR points to this
-private space while $GIT_COMMON_DIR points to the main checkout's
-$GIT_DIR. These settings are done by "git checkout --to".
-
-Because in this mode $GIT_DIR becomes a lightweight virtual file
-system where a path could be rewritten to some place else, accessing
-$GIT_DIR from scripts should use `git rev-parse --git-path` to resolve
-a path instead of using it directly unless the path is known to be
-private to the working directory.
+Each linked checkout has a private directory in $GIT_DIR/worktrees in
+the main checkout, usually named after the base name of the new
+working directory, optionally with a number added to make it
+unique. For example, the command `git checkout --to ../test-next next`
+running with $GIT_DIR=/path/main may create the directory
+`$GIT_DIR/worktrees/test-next` (or `$GIT_DIR/worktrees/test-next1` if
+`test-next` is already taken).
+
+Within a linked checkout, $GIT_DIR is set to point to this private
+directory (e.g. `/path/main/worktrees/test-next` in the example) and
+$GIT_COMMON_DIR is set to point back to the main checkout's $GIT_DIR
+(e.g. `/path/main`). Setting is done via a .git file located at the
+top directory of the linked checkout.
+
+Path resolution via `git rev-parse --git-path` would use either
+$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, the
+linked checkout's `$GIT_DIR/HEAD` resolve to
+`/path/main/worktrees/test-next/HEAD` (not `/path/main/HEAD` which is
+the main checkout's HEAD) while `$GIT_DIR/refs/heads/master` would use
+$GIT_COMMON_DIR and resolve to `/path/main/refs/heads/master`, which
+is shared across checkouts.
+
+See linkgit:gitrepository-layout[5] for more information. The rule of
+thumb is do not make any assumption about whether a path belongs to
+$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
+inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
+
+When you are done, simply deleting the linked working directory would
+suffice. $GIT_DIR/worktrees can be cleaned up using `git prune
+--worktrees`, which is part of automated garbage collection.
+
+After you move a linked working directory to another file system, or
+on a file system that does not support hard link, execute any git
+command (e.g. `git status`) in the new working directory so that it
+could update its location in $GIT_DIR/worktrees and not be
+accidentally pruned.
+
+To stop `git prune --worktrees` from deleting a specific working
+directory (e.g. because it's on a portable device), you could add the
+file 'locked' to $GIT_DIR/worktrees. For example, if `.git` file of
+the new working directory points to `/path/main/worktrees/test-next`,
+the full path of the 'locked' file would be
+`/path/main/worktrees/test-next/locked`. See
+linkgit:gitrepository-layout[5] for details.
 
 EXAMPLES
 --------
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 50e39ec..a0ea381 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -48,8 +48,8 @@ OPTIONS
 --expire <time>::
 	Only expire loose objects older than <time>.
 
---repos::
-	Prune directories in $GIT_DIR/repos.
+--worktrees::
+	Prune dead worktree information in $GIT_DIR/worktrees.
 
 <head>...::
 	In addition to objects
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index c9a7d1a..5ceff51 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -220,7 +220,7 @@ remotes::
 logs::
 	Records of changes made to refs are stored in this directory.
 	See linkgit:git-update-ref[1] for more information. This
-	directory is ignored $GIT_COMMON_DIR is set and
+	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/logs" will be used instead.
 
 logs/refs/heads/`name`::
@@ -248,28 +248,28 @@ modules::
 	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/modules" will be used instead.
 
-repos::
+worktrees::
 	Contains worktree specific information of linked
 	checkouts. Each subdirectory contains the worktree-related
 	part of a linked checkout. This directory is ignored if
-	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/repos" will be
+	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/worktrees" will be
 	used instead.
 
-repos/<id>/gitdir::
+worktrees/<id>/gitdir::
 	A text file containing the absolute path back to the .git file
 	that points to here. This is used to check if the linked
 	repository has been manually removed and there is no need to
 	keep this directory any more. mtime of this file should be
 	updated every time the linked repository is accessed.
 
-repos/<id>/locked::
+worktrees/<id>/locked::
 	If this file exists, the linked repository may be on a
 	portable device and not available. It does not mean that the
-	linked repository is gone and `repos/<id>` could be
+	linked repository is gone and `worktrees/<id>` could be
 	removed. The file's content contains a reason string on why
 	the repository is locked.
 
-repos/<id>/link::
+worktrees/<id>/link::
 	If this file exists, it is a hard link to the linked .git
 	file. It is used to detect if the linked repository is
 	manually removed.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b88c646..6106b81 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -874,7 +874,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 			break;
 		}
 	strbuf_addstr(&sb_repo,
-		      git_path("repos/%.*s", (int)(path + len - name), name));
+		      git_path("worktrees/%.*s", (int)(path + len - name), name));
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -911,7 +911,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
-	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
+	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
@@ -950,7 +950,6 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
 	return ret;
-
 }
 
 static int git_checkout_config(const char *var, const char *value, void *cb)
@@ -1016,7 +1015,7 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 	const char *start, *end;
 
 	if (id)
-		strbuf_addf(&path, "%s/repos/%s/HEAD", get_git_common_dir(), id);
+		strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
 	else
 		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
 
@@ -1032,7 +1031,7 @@ static void check_linked_checkout(struct branch_info *new, const char *id)
 		goto done;
 	if (id) {
 		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/repos/%s/gitdir", get_git_common_dir(), id);
+		strbuf_addf(&path, "%s/worktrees/%s/gitdir", get_git_common_dir(), id);
 		if (strbuf_read_file(&gitdir, path.buf, 0) <= 0)
 			goto done;
 		strbuf_rtrim(&gitdir);
@@ -1051,7 +1050,7 @@ static void check_linked_checkouts(struct branch_info *new)
 	DIR *dir;
 	struct dirent *d;
 
-	strbuf_addf(&path, "%s/repos", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
 	if ((dir = opendir(path.buf)) == NULL) {
 		strbuf_release(&path);
 		return;
diff --git a/builtin/gc.c b/builtin/gc.c
index 0c65808..00239ca 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,13 +33,13 @@ static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int detach_auto = 1;
 static const char *prune_expire = "2.weeks.ago";
-static const char *prune_repos_expire = "3.months.ago";
+static const char *prune_worktrees_expire = "3.months.ago";
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
 static struct argv_array repack = ARGV_ARRAY_INIT;
 static struct argv_array prune = ARGV_ARRAY_INIT;
-static struct argv_array prune_repos = ARGV_ARRAY_INIT;
+static struct argv_array prune_worktrees = ARGV_ARRAY_INIT;
 static struct argv_array rerere = ARGV_ARRAY_INIT;
 
 static char *pidfile;
@@ -99,8 +99,8 @@ static int gc_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "gc.pruneexpire"))
 		return git_config_date_string(&prune_expire, var, value);
-	if (!strcmp(var, "gc.prunereposexpire"))
-		return git_config_date_string(&prune_repos_expire, var, value);
+	if (!strcmp(var, "gc.pruneworktreesexpire"))
+		return git_config_date_string(&prune_worktrees_expire, var, value);
 	return git_default_config(var, value, cb);
 }
 
@@ -308,7 +308,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL);
-	argv_array_pushl(&prune_repos, "prune", "--repos", "--expire", NULL);
+	argv_array_pushl(&prune_worktrees, "prune", "--worktrees", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
 
 	git_config(gc_config, NULL);
@@ -378,10 +378,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			return error(FAILED_RUN, prune.argv[0]);
 	}
 
-	if (prune_repos_expire) {
-		argv_array_push(&prune_repos, prune_repos_expire);
-		if (run_command_v_opt(prune_repos.argv, RUN_GIT_CMD))
-			return error(FAILED_RUN, prune_repos.argv[0]);
+	if (prune_worktrees_expire) {
+		argv_array_push(&prune_worktrees, prune_worktrees_expire);
+		if (run_command_v_opt(prune_worktrees.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, prune_worktrees.argv[0]);
 	}
 
 	if (run_command_v_opt(rerere.argv, RUN_GIT_CMD))
diff --git a/builtin/prune.c b/builtin/prune.c
index e72c391..cf56110 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -112,25 +112,25 @@ static void prune_object_dir(const char *path)
 	}
 }
 
-static int prune_repo_dir(const char *id, struct strbuf *reason)
+static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
 	char *path;
 	int fd, len;
 
-	if (!is_directory(git_path("repos/%s", id))) {
-		strbuf_addf(reason, _("Removing repos/%s: not a valid directory"), id);
+	if (!is_directory(git_path("worktrees/%s", id))) {
+		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"), id);
 		return 1;
 	}
-	if (file_exists(git_path("repos/%s/locked", id)))
+	if (file_exists(git_path("worktrees/%s/locked", id)))
 		return 0;
-	if (stat(git_path("repos/%s/gitdir", id), &st)) {
-		strbuf_addf(reason, _("Removing repos/%s: gitdir file does not exist"), id);
+	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not exist"), id);
 		return 1;
 	}
-	fd = open(git_path("repos/%s/gitdir", id), O_RDONLY);
+	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
 	if (fd < 0) {
-		strbuf_addf(reason, _("Removing repos/%s: unable to read gitdir file (%s)"),
+		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir file (%s)"),
 			    id, strerror(errno));
 		return 1;
 	}
@@ -141,7 +141,7 @@ static int prune_repo_dir(const char *id, struct strbuf *reason)
 	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
 		len--;
 	if (!len) {
-		strbuf_addf(reason, _("Removing repos/%s: invalid gitdir file"), id);
+		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"), id);
 		free(path);
 		return 1;
 	}
@@ -153,21 +153,21 @@ static int prune_repo_dir(const char *id, struct strbuf *reason)
 		 * the repo is moved manually and has not been
 		 * accessed since?
 		 */
-		if (!stat(git_path("repos/%s/link", id), &st_link) &&
+		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
 		    st_link.st_nlink > 1)
 			return 0;
-		strbuf_addf(reason, _("Removing repos/%s: gitdir file points to non-existent location"), id);
+		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
 		return 1;
 	}
 	free(path);
 	return st.st_mtime <= expire;
 }
 
-static void prune_repos_dir(void)
+static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	DIR *dir = opendir(git_path("repos"));
+	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
 	int ret;
 	if (!dir)
@@ -176,14 +176,14 @@ static void prune_repos_dir(void)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 		strbuf_reset(&reason);
-		if (!prune_repo_dir(d->d_name, &reason))
+		if (!prune_worktree(d->d_name, &reason))
 			continue;
 		if (show_only || verbose)
 			printf("%s\n", reason.buf);
 		if (show_only)
 			continue;
 		strbuf_reset(&path);
-		strbuf_addstr(&path, git_path("repos/%s", d->d_name));
+		strbuf_addstr(&path, git_path("worktrees/%s", d->d_name));
 		ret = remove_dir_recursively(&path, 0);
 		if (ret < 0 && errno == ENOTDIR)
 			ret = unlink(path.buf);
@@ -192,7 +192,7 @@ static void prune_repos_dir(void)
 	}
 	closedir(dir);
 	if (!show_only)
-		rmdir(git_path("repos"));
+		rmdir(git_path("worktrees"));
 	strbuf_release(&reason);
 	strbuf_release(&path);
 }
@@ -223,12 +223,12 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct progress *progress = NULL;
-	int prune_repos = 0;
+	int do_prune_worktrees = 0;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
-		OPT_BOOL(0, "repos", &prune_repos, N_("prune .git/repos/")),
+		OPT_BOOL(0, "worktrees", &do_prune_worktrees, N_("prune .git/worktrees")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("expire objects older than <time>")),
 		OPT_END()
@@ -242,10 +242,10 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
 
-	if (prune_repos) {
+	if (do_prune_worktrees) {
 		if (argc)
-			die(_("--repos does not take extra arguments"));
-		prune_repos_dir();
+			die(_("--worktrees does not take extra arguments"));
+		prune_worktrees();
 		return 0;
 	}
 
diff --git a/path.c b/path.c
index b1dd2bc..1f1881a 100644
--- a/path.c
+++ b/path.c
@@ -93,7 +93,7 @@ static void replace_dir(struct strbuf *buf, int len, const char *newdir)
 
 static const char *common_list[] = {
 	"/branches", "/hooks", "/info", "!/logs", "/lost-found", "/modules",
-	"/objects", "/refs", "/remotes", "/repos", "/rr-cache", "/svn",
+	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
 	"config", "!gc.pid", "packed-refs", "shallow",
 	NULL
 };
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index aa24ea8..27384a1 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -20,7 +20,7 @@ test_expect_success 'checkout --to an existing worktree' '
 test_expect_success 'checkout --to refuses to checkout locked branch' '
 	test_must_fail git checkout --to zere master &&
 	! test -d zere &&
-	! test -d .git/repos/zere
+	! test -d .git/worktrees/zere
 '
 
 test_expect_success 'checkout --to a new worktree' '
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index 79d84cb..3622800 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -1,84 +1,84 @@
 #!/bin/sh
 
-test_description='prune $GIT_DIR/repos'
+test_description='prune $GIT_DIR/worktrees'
 
 . ./test-lib.sh
 
-test_expect_success 'prune --repos on normal repo' '
-	git prune --repos &&
-	test_must_fail git prune --repos abc
+test_expect_success 'prune --worktrees on normal repo' '
+	git prune --worktrees &&
+	test_must_fail git prune --worktrees abc
 '
 
-test_expect_success 'prune files inside $GIT_DIR/repos' '
-	mkdir .git/repos &&
-	: >.git/repos/abc &&
-	git prune --repos --verbose >actual &&
+test_expect_success 'prune files inside $GIT_DIR/worktrees' '
+	mkdir .git/worktrees &&
+	: >.git/worktrees/abc &&
+	git prune --worktrees --verbose >actual &&
 	cat >expect <<EOF &&
-Removing repos/abc: not a valid directory
+Removing worktrees/abc: not a valid directory
 EOF
 	test_i18ncmp expect actual &&
-	! test -f .git/repos/abc &&
-	! test -d .git/repos
+	! test -f .git/worktrees/abc &&
+	! test -d .git/worktrees
 '
 
 test_expect_success 'prune directories without gitdir' '
-	mkdir -p .git/repos/def/abc &&
-	: >.git/repos/def/def &&
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
 	cat >expect <<EOF &&
-Removing repos/def: gitdir file does not exist
+Removing worktrees/def: gitdir file does not exist
 EOF
-	git prune --repos --verbose >actual &&
+	git prune --worktrees --verbose >actual &&
 	test_i18ncmp expect actual &&
-	! test -d .git/repos/def &&
-	! test -d .git/repos
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
 '
 
 test_expect_success POSIXPERM 'prune directories with unreadable gitdir' '
-	mkdir -p .git/repos/def/abc &&
-	: >.git/repos/def/def &&
-	: >.git/repos/def/gitdir &&
-	chmod u-r .git/repos/def/gitdir &&
-	git prune --repos --verbose >actual &&
-	test_i18ngrep "Removing repos/def: unable to read gitdir file" actual &&
-	! test -d .git/repos/def &&
-	! test -d .git/repos
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
+	: >.git/worktrees/def/gitdir &&
+	chmod u-r .git/worktrees/def/gitdir &&
+	git prune --worktrees --verbose >actual &&
+	test_i18ngrep "Removing worktrees/def: unable to read gitdir file" actual &&
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
 '
 
 test_expect_success 'prune directories with invalid gitdir' '
-	mkdir -p .git/repos/def/abc &&
-	: >.git/repos/def/def &&
-	: >.git/repos/def/gitdir &&
-	git prune --repos --verbose >actual &&
-	test_i18ngrep "Removing repos/def: invalid gitdir file" actual &&
-	! test -d .git/repos/def &&
-	! test -d .git/repos
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
+	: >.git/worktrees/def/gitdir &&
+	git prune --worktrees --verbose >actual &&
+	test_i18ngrep "Removing worktrees/def: invalid gitdir file" actual &&
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
 '
 
 test_expect_success 'prune directories with gitdir pointing to nowhere' '
-	mkdir -p .git/repos/def/abc &&
-	: >.git/repos/def/def &&
-	echo "$TRASH_DIRECTORY"/nowhere >.git/repos/def/gitdir &&
-	git prune --repos --verbose >actual &&
-	test_i18ngrep "Removing repos/def: gitdir file points to non-existent location" actual &&
-	! test -d .git/repos/def &&
-	! test -d .git/repos
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
+	echo "$TRASH_DIRECTORY"/nowhere >.git/worktrees/def/gitdir &&
+	git prune --worktrees --verbose >actual &&
+	test_i18ngrep "Removing worktrees/def: gitdir file points to non-existent location" actual &&
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
 '
 
 test_expect_success 'not prune locked checkout' '
-	test_when_finished rm -r .git/repos
-	mkdir -p .git/repos/ghi &&
-	: >.git/repos/ghi/locked &&
-	git prune --repos &&
-	test -d .git/repos/ghi
+	test_when_finished rm -r .git/worktrees
+	mkdir -p .git/worktrees/ghi &&
+	: >.git/worktrees/ghi/locked &&
+	git prune --worktrees &&
+	test -d .git/worktrees/ghi
 '
 
 test_expect_success 'not prune recent checkouts' '
-	test_when_finished rm -r .git/repos
+	test_when_finished rm -r .git/worktrees
 	mkdir zz &&
-	mkdir -p .git/repos/jlm &&
-	echo "$TRASH_DIRECTORY"/zz >.git/repos/jlm/gitdir &&
-	git prune --repos --verbose --expire=2.days.ago &&
-	test -d .git/repos/jlm
+	mkdir -p .git/worktrees/jlm &&
+	echo "$TRASH_DIRECTORY"/zz >.git/worktrees/jlm/gitdir &&
+	git prune --worktrees --verbose --expire=2.days.ago &&
+	test -d .git/worktrees/jlm
 '
 
 test_done

-- 
2.1.0.rc0.78.gc0d8480
