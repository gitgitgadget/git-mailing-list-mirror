From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 22/32] checkout: support checking out into a new working directory
Date: Thu, 11 Sep 2014 05:41:58 +0700
Message-ID: <1410388928-32265-23-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqcR-0002Bb-ST
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbaIJWoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:03 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:46030 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:01 -0400
Received: by mail-pd0-f170.google.com with SMTP id fp1so4201592pdb.29
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RTLPH/Ia3Pgm3eNW7tCoEIFIUmFs88aucjaPufVTRCU=;
        b=z8ZmpvvTiJsk/XR2oq39dOY2I6g1wpnnx2i67DTRF0K8gUrAPu5dXtBo9MjztXyfz0
         lnF/CmkHWFZwe9XzBaUVa/Rw6EYkkbny4l6RztlAM/lBJIzp5wnXmy4srImwtMf3dIyp
         RdSShlq9weGt62j8/8n2uLfYmAxzop+m7dsb60wnu8k6ul6Q4kddb8GKIjeIVkUyvRKJ
         HEX+RLJa3K8RX4Dd3Y1D/nxcF3QKibiPzGS+EGaI5Prfq1KIakBcCIEIqCGwb6x6fSAL
         7h15uPxvGj9dmAvYsmp8R61W8hfXDlzB/lln5UvbnnpFoIu0r8rYczDYDoQvmgjSeIVd
         bGxA==
X-Received: by 10.68.65.73 with SMTP id v9mr169111pbs.164.1410389040861;
        Wed, 10 Sep 2014 15:44:00 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id mn1sm15456410pbc.4.2014.09.10.15.43.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:43:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:44:20 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256799>

"git checkout --to" sets up a new working directory with a .git file
pointing to $GIT_DIR/worktrees/<id>. It then executes "git checkout"
again on the new worktree with the same arguments except "--to" is
taken out. The second checkout execution, which is not contaminated
with any info from the current repository, will actually check out and
everything that normal "git checkout" does.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt         | 43 +++++++++++++++
 Documentation/git.txt                  |  3 +-
 Documentation/gitrepository-layout.txt |  7 +++
 builtin/checkout.c                     | 95 ++++++++++++++++++++++++++=
+++++++-
 path.c                                 |  2 +-
 t/t2025-checkout-to.sh (new +x)        | 63 ++++++++++++++++++++++
 6 files changed, 209 insertions(+), 4 deletions(-)
 create mode 100755 t/t2025-checkout-to.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 33ad2ad..bd0fc1d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -225,6 +225,13 @@ This means that you can use `git checkout -p` to s=
electively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mo=
de.
=20
+--to=3D<path>::
+	Check out a branch in a separate working directory at
+	`<path>`. A new working directory is linked to the current
+	repository, sharing everything except working directory
+	specific files such as HEAD, index... See "MULTIPLE CHECKOUT
+	MODE" section for more information.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
@@ -388,6 +395,42 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
=20
+MULTIPLE CHECKOUT MODE
+----------------------
+Normally a working directory is attached to repository. When "git
+checkout --to" is used, a new working directory is attached to the
+current repository. This new working directory is called "linked
+checkout" as compared to the "main checkout" prepared by "git init" or
+"git clone". A repository has one main checkout and zero or more
+linked checkouts.
+
+Each linked checkout has a private directory in $GIT_DIR/worktrees in
+the main checkout, usually named after the base name of the new
+working directory, optionally with a number added to make it
+unique. For example, the command `git checkout --to ../test-next next`
+running with $GIT_DIR=3D/path/main may create the directory
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
 EXAMPLES
 --------
=20
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 749052f..c0a4940 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -792,7 +792,8 @@ Git so take care if using Cogito etc.
 	If this variable is set to a path, non-worktree files that are
 	normally in $GIT_DIR will be taken from this path
 	instead. Worktree-specific files such as HEAD or index are
-	taken from $GIT_DIR. See linkgit:gitrepository-layout[5] for
+	taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
+	the section 'MULTIPLE CHECKOUT MODE' in linkgit:checkout[1]
 	details. This variable has lower precedence than other path
 	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...
=20
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 1cc33f3..a82780c 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -248,6 +248,13 @@ modules::
 	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/modules" will be used instead.
=20
+worktrees::
+	Contains worktree specific information of linked
+	checkouts. Each subdirectory contains the worktree-related
+	part of a linked checkout. This directory is ignored if
+	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/worktrees" will be
+	used instead.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8023987..1868f69 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -48,6 +48,10 @@ struct checkout_opts {
 	const char *prefix;
 	struct pathspec pathspec;
 	struct tree *source_tree;
+
+	const char *new_worktree;
+	const char **saved_argv;
+	int new_worktree_mode;
 };
=20
 static int post_checkout_hook(struct commit *old, struct commit *new,
@@ -250,6 +254,9 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same tim=
e."),
 		    opts->new_branch);
=20
+	if (opts->new_worktree)
+		die(_("'%s' cannot be used with updating paths"), "--to");
+
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
 					   &opts->pathspec);
@@ -485,7 +492,7 @@ static int merge_working_tree(const struct checkout=
_opts *opts,
 			topts.dir->flags |=3D DIR_SHOW_IGNORED;
 			setup_standard_excludes(topts.dir);
 		}
-		tree =3D parse_tree_indirect(old->commit ?
+		tree =3D parse_tree_indirect(old->commit && !opts->new_worktree_mode=
 ?
 					   old->commit->object.sha1 :
 					   EMPTY_TREE_SHA1_BIN);
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
@@ -796,7 +803,8 @@ static int switch_branches(const struct checkout_op=
ts *opts,
 		return ret;
 	}
=20
-	if (!opts->quiet && !old.path && old.commit && new->commit !=3D old.c=
ommit)
+	if (!opts->quiet && !old.path && old.commit &&
+	    new->commit !=3D old.commit && !opts->new_worktree_mode)
 		orphaned_commit_warning(old.commit, new->commit);
=20
 	update_refs_for_switch(opts, &old, new);
@@ -806,6 +814,76 @@ static int switch_branches(const struct checkout_o=
pts *opts,
 	return ret || writeout_error;
 }
=20
+static int prepare_linked_checkout(const struct checkout_opts *opts,
+				   struct branch_info *new)
+{
+	struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *path =3D opts->new_worktree, *name;
+	struct stat st;
+	struct child_process cp;
+	int counter =3D 0, len;
+
+	if (!new->commit)
+		die(_("no branch specified"));
+	if (file_exists(path))
+		die(_("'%s' already exists"), path);
+
+	len =3D strlen(path);
+	while (len && is_dir_sep(path[len - 1]))
+		len--;
+
+	for (name =3D path + len - 1; name > path; name--)
+		if (is_dir_sep(*name)) {
+			name++;
+			break;
+		}
+	strbuf_addstr(&sb_repo,
+		      git_path("worktrees/%.*s", (int)(path + len - name), name));
+	len =3D sb_repo.len;
+	if (safe_create_leading_directories_const(sb_repo.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_repo.buf);
+	while (!stat(sb_repo.buf, &st)) {
+		counter++;
+		strbuf_setlen(&sb_repo, len);
+		strbuf_addf(&sb_repo, "%d", counter);
+	}
+	name =3D strrchr(sb_repo.buf, '/') + 1;
+	if (mkdir(sb_repo.buf, 0777))
+		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
+
+	strbuf_addf(&sb_git, "%s/.git", path);
+	if (safe_create_leading_directories_const(sb_git.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_git.buf);
+
+	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
+		   real_path(get_git_common_dir()), name);
+	/*
+	 * This is to keep resolve_ref() happy. We need a valid HEAD
+	 * or is_git_directory() will reject the directory. Any valid
+	 * value would do because this value will be ignored and
+	 * replaced at the next (real) checkout.
+	 */
+	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
+	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
+	write_file(sb.buf, 1, "../..\n");
+
+	if (!opts->quiet)
+		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
+
+	setenv("GIT_CHECKOUT_NEW_WORKTREE", "1", 1);
+	setenv(GIT_DIR_ENVIRONMENT, sb_git.buf, 1);
+	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
+	memset(&cp, 0, sizeof(cp));
+	cp.git_cmd =3D 1;
+	cp.argv =3D opts->saved_argv;
+	return run_command(&cp);
+}
+
 static int git_checkout_config(const char *var, const char *value, voi=
d *cb)
 {
 	if (!strcmp(var, "diff.ignoresubmodules")) {
@@ -1067,6 +1145,9 @@ static int checkout_branch(struct checkout_opts *=
opts,
 		die(_("Cannot switch branch to a non-commit '%s'"),
 		    new->name);
=20
+	if (opts->new_worktree)
+		return prepare_linked_checkout(opts, new);
+
 	if (!new->commit && opts->new_branch) {
 		unsigned char rev[20];
 		int flag;
@@ -1109,6 +1190,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
+		OPT_FILENAME(0, "to", &opts.new_worktree,
+			   N_("check a branch out in a separate working directory")),
 		OPT_END(),
 	};
=20
@@ -1117,6 +1200,9 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	opts.overwrite_ignore =3D 1;
 	opts.prefix =3D prefix;
=20
+	opts.saved_argv =3D xmalloc(sizeof(const char *) * (argc + 2));
+	memcpy(opts.saved_argv, argv, sizeof(const char *) * (argc + 1));
+
 	gitmodules_config();
 	git_config(git_checkout_config, &opts);
=20
@@ -1125,6 +1211,11 @@ int cmd_checkout(int argc, const char **argv, co=
nst char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
=20
+	/* recursive execution from checkout_new_worktree() */
+	opts.new_worktree_mode =3D getenv("GIT_CHECKOUT_NEW_WORKTREE") !=3D N=
ULL;
+	if (opts.new_worktree_mode)
+		opts.new_worktree =3D NULL;
+
 	if (conflict_style) {
 		opts.merge =3D 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
diff --git a/path.c b/path.c
index 8a6586c..1fd99f8 100644
--- a/path.c
+++ b/path.c
@@ -92,7 +92,7 @@ static void replace_dir(struct strbuf *buf, int len, =
const char *newdir)
=20
 static const char *common_list[] =3D {
 	"/branches", "/hooks", "/info", "/logs", "/lost-found", "/modules",
-	"/objects", "/refs", "/remotes", "/rr-cache", "/svn",
+	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
 	"config", "gc.pid", "packed-refs", "shallow",
 	NULL
 };
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
new file mode 100755
index 0000000..8c73b18
--- /dev/null
+++ b/t/t2025-checkout-to.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description=3D'test git checkout --to'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init
+'
+
+test_expect_success 'checkout --to not updating paths' '
+	test_must_fail git checkout --to -- init.t
+'
+
+test_expect_success 'checkout --to an existing worktree' '
+	mkdir existing &&
+	test_must_fail git checkout --detach --to existing master
+'
+
+test_expect_success 'checkout --to a new worktree' '
+	git checkout --to here master &&
+	(
+		cd here &&
+		test_cmp ../init.t init.t &&
+		git symbolic-ref HEAD >actual &&
+		echo refs/heads/master >expect &&
+		test_cmp expect actual &&
+		git fsck
+	)
+'
+
+test_expect_success 'checkout --to a new worktree from a subdir' '
+	(
+		mkdir sub &&
+		cd sub &&
+		git checkout --detach --to here master &&
+		cd here &&
+		test_cmp ../../init.t init.t
+	)
+'
+
+test_expect_success 'checkout --to from a linked checkout' '
+	(
+		cd here &&
+		git checkout --to nested-here master
+		cd nested-here &&
+		git fsck
+	)
+'
+
+test_expect_success 'checkout --to a new worktree creating new branch'=
 '
+	git checkout --to there -b newmaster master &&
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
+test_done
--=20
2.1.0.rc0.78.gc0d8480
