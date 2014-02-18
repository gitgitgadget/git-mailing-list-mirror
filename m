From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 21/25] checkout: support checking out into a new working directory
Date: Tue, 18 Feb 2014 20:40:10 +0700
Message-ID: <1392730814-19656-22-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkwh-0000pO-B7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbaBRNmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:42:22 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:63551 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbaBRNmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:42:20 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so16677041pbc.22
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ny+JxG+BeoCr1qYkOx/plArQPCDvK06a5Tl6KWUzhTA=;
        b=vHBs0qUbw6ES3ENy1P+wMDTe5F76AaNheJWabH4ekWXiCV5ijYCxeALGk2QbNwW7Zz
         NI3iiLciwRZoeHKnnbwWegJkcP0o5pBQqkzh/xCubQWuVg67mEC+LJFBGKRVqatpokGI
         PP71SdhVh0WHqG5/O3WoG0119ahI/+SKge2gsBjRUV0NVjKWfIJlklhyJarVKWnpVqog
         m8LNTznRV0g1SpwldKQUXwnUq1YN0wg8VbpW69mBBFHORh+EUvwpMnFcDAbJryavvzdl
         bON0fel3ptprDHy5MSiN9ztWEz7uN+N/W2h7gykYKq2pByTkrkDvF4lB34a28wAmW8jd
         aE+A==
X-Received: by 10.66.164.165 with SMTP id yr5mr32679608pab.63.1392730940185;
        Tue, 18 Feb 2014 05:42:20 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id yg4sm24135383pab.19.2014.02.18.05.42.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:42:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:33 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242318>

"git checkout --to" sets up a new working directory with a .git file
pointing to $GIT_DIR/repos/<id>. It then executes "git checkout" again
on the new worktree with the same arguments except "--to" is taken
out. The second checkout execution, which is not contaminated with any
info from the current repository, will actually check out and
everything that normal "git checkout" does.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt         | 34 +++++++++++++
 Documentation/gitrepository-layout.txt |  3 ++
 builtin/checkout.c                     | 93 ++++++++++++++++++++++++++=
+++++++-
 t/t2025-checkout-to.sh (new +x)        | 39 ++++++++++++++
 4 files changed, 167 insertions(+), 2 deletions(-)
 create mode 100755 t/t2025-checkout-to.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 33ad2ad..fcf73b2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -225,6 +225,13 @@ This means that you can use `git checkout -p` to s=
electively discard
 edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mo=
de.
=20
+--to=3D<path>::
+	Check out a new branch in a separate working directory at
+	`<path>`. A new working directory is linked to the current
+	repository, sharing everything except working directory
+	specific files such as HEAD, index... See "MULTIPLE CHECKOUT
+	MODE" section for more information.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
@@ -388,6 +395,33 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
=20
+MULTIPLE CHECKOUT MODE
+-------------------------------
+Normally a working directory is attached to repository. When "git
+checkout --to" is used, a new working directory is attached to the
+current repository. This new working directory is called "linked
+checkout" as compared to the "main checkout" prepared by "git init" or
+"git clone". A repository has one main checkout and zero or more
+linked checkouts.
+
+All checkouts share the same repository. Linked checkouts see the
+repository a bit different from the main checkout. When the checkout
+"new" reads the path $GIT_DIR/HEAD for example, the actual path
+returned could be $GIT_DIR/repos/new/HEAD. This ensures checkouts
+won't step on each other.
+
+Each linked checkout has a private space in $GIT_DIR/repos, usually
+named after the base name of the working directory with a number added
+to make it unique. The linked checkout's $GIT_DIR points to this
+private space while $GIT_COMMON_DIR points to the main checkout's
+$GIT_DIR. These settings are done by "git checkout --to".
+
+Because in this mode $GIT_DIR becomes a lightweight virtual file
+system where a path could be rewritten to some place else, accessing
+$GIT_DIR from scripts should use `git rev-parse --git-path` to resolve
+a path instead of using it directly unless the path is known to be
+private to the working directory.
+
 EXAMPLES
 --------
=20
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 9bfe0f1..495a937 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -218,6 +218,9 @@ commondir::
 modules::
 	Contains the git-repositories of the submodules.
=20
+repos::
+	Contains worktree specific information of linked checkouts.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0570e41..2b856a6 100644
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
@@ -486,7 +493,7 @@ static int merge_working_tree(const struct checkout=
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
@@ -806,6 +814,74 @@ static int switch_branches(const struct checkout_o=
pts *opts,
 	return ret || writeout_error;
 }
=20
+static int prepare_linked_checkout(const struct checkout_opts *opts,
+				   struct branch_info *new)
+{
+	struct strbuf sb_git =3D STRBUF_INIT, sb_repo =3D STRBUF_INIT;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *path =3D opts->new_worktree;
+	struct stat st;
+	const char *name;
+	struct child_process cp;
+	int counter =3D 0, len;
+
+	if (!new->commit)
+		die(_("no branch specified"));
+
+	len =3D strlen(path);
+	if (!len || is_dir_sep(path[len - 1]))
+		die(_("'--to' argument '%s' cannot end with a slash"), path);
+
+	for (name =3D path + len - 1; name > path; name--)
+		if (is_dir_sep(*name)) {
+			name++;
+			break;
+		}
+	strbuf_addstr(&sb_repo, git_path("repos/%s", name));
+	len =3D sb_repo.len;
+	if (safe_create_leading_directories_const(sb_repo.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_repo.buf);
+	while (!stat(sb_repo.buf, &st)) {
+		counter++;
+		strbuf_setlen(&sb_repo, len);
+		strbuf_addf(&sb_repo, "%d", counter);
+	}
+	name =3D sb_repo.buf + len - strlen(name);
+	if (mkdir(sb_repo.buf, 0777))
+		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
+
+	strbuf_addf(&sb_git, "%s/.git", path);
+	if (safe_create_leading_directories_const(sb_git.buf))
+		die_errno(_("could not create leading directories of '%s'"),
+			  sb_git.buf);
+
+	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
+		   real_path(get_git_dir()), name);
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
@@ -1067,6 +1143,9 @@ static int checkout_branch(struct checkout_opts *=
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
@@ -1109,6 +1188,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout no-such-branch'")),
+		OPT_STRING(0, "to", &opts.new_worktree, N_("path"),
+			   N_("check a branch out in a separate working directory")),
 		OPT_END(),
 	};
=20
@@ -1117,6 +1198,9 @@ int cmd_checkout(int argc, const char **argv, con=
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
@@ -1125,6 +1209,11 @@ int cmd_checkout(int argc, const char **argv, co=
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
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
new file mode 100755
index 0000000..76eae4a
--- /dev/null
+++ b/t/t2025-checkout-to.sh
@@ -0,0 +1,39 @@
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
1.8.5.2.240.g8478abd
