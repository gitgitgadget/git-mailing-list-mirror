From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 23/32] prune: strategies for linked checkouts
Date: Sun, 28 Sep 2014 08:22:37 +0700
Message-ID: <1411867366-3821-24-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3EU-0002fZ-3j
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbaI1BY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:24:57 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53530 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:24:57 -0400
Received: by mail-pa0-f44.google.com with SMTP id et14so513471pad.31
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=We/ot2KAR6XXabYZ//uL/NbIK3TO9BsC5kxj7d4SRUY=;
        b=OTpEX9eRVwShufWyO4a9VJqfvGYuqlGoRzvaXFEbQ1HtV5Zd/TyCV/t34EieXaFb6m
         Mt8P1LBM8S6pDielDVCxL6XQApDh5cfqSMbZyurbPrOMqhnvrDWI6ryjlbIWdTbJ5iQQ
         VUERtJTNigHLJxFAUkupBgyACwTfDDEcgMyStFdGzyqNx7WhTCDjUeO6mj9cah2FW54l
         yDLUGzgEskZcOXjdD5n9GE+0dbz8WFPwsDGwMbOwMcHeCJV1HP35CxmmT1rmGH8v5TM2
         MLwImgnISU9EPPLKLyAj5JeRE0wpqiIdZvlWgMoMrT7krfJzmHVvgUkaPJ6qan7fzLaU
         mI9A==
X-Received: by 10.70.87.169 with SMTP id az9mr58246373pdb.63.1411867496573;
        Sat, 27 Sep 2014 18:24:56 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id cz1sm8522332pdb.85.2014.09.27.18.24.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:24:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:24:59 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257582>

(alias R=3D$GIT_COMMON_DIR/worktrees/<id>)

 - linked checkouts are supposed to keep its location in $R/gitdir up
   to date. The use case is auto fixup after a manual checkout move.

 - linked checkouts are supposed to update mtime of $R/gitdir. If
   $R/gitdir's mtime is older than a limit, and it points to nowhere,
   worktrees/<id> is to be pruned.

 - If $R/locked exists, worktrees/<id> is not supposed to be pruned. If
   $R/locked exists and $R/gitdir's mtime is older than a really long
   limit, warn about old unused repo.

 - "git checkout --to" is supposed to make a hard link named $R/link
   pointing to the .git file on supported file systems to help detect
   the user manually deleting the checkout. If $R/link exists and its
   link count is greated than 1, the repo is kept.

Helped-by: Marc Branchaud <marcnarc@xiplink.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt             | 20 +++++++
 Documentation/git-prune.txt                |  3 +
 Documentation/gitrepository-layout.txt     | 19 ++++++
 builtin/checkout.c                         | 19 +++++-
 builtin/prune.c                            | 95 ++++++++++++++++++++++=
++++++++
 setup.c                                    | 13 ++++
 t/t2026-prune-linked-checkouts.sh (new +x) | 84 ++++++++++++++++++++++=
++++
 7 files changed, 251 insertions(+), 2 deletions(-)
 create mode 100755 t/t2026-prune-linked-checkouts.sh

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index c101575..35675da 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -434,6 +434,26 @@ thumb is do not make any assumption about whether =
a path belongs to
 $GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
 inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
=20
+When you are done with a linked working tree you can simply delete it.
+You can clean up any stale $GIT_DIR/worktrees entries via `git prune
+--worktrees` in the main or any linked working tree.
+
+If you move a linked working directory to another file system, or
+within a file system that does not support hard links, you need to run
+at least one git command inside the linked working directory
+(e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
+so that it does not get automatically removed.
+
+To prevent `git prune --worktrees` from deleting a $GIT_DIR/worktrees
+entry (which can be useful in some situations, such as when the
+entry's working tree is stored on a portable device), add a file named
+'locked' to the entry's directory. The file contains the reason in
+plain text. For example, if a linked working tree's `.git` file points
+to `/path/main/.git/worktrees/test-next` then a file named
+`/path/main/.git/worktrees/test-next/locked` will prevent the
+`test-next` entry from being pruned.  See
+linkgit:gitrepository-layout[5] for details.
+
 EXAMPLES
 --------
=20
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7a493c8..1cf3bed 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -48,6 +48,9 @@ OPTIONS
 --expire <time>::
 	Only expire loose objects older than <time>.
=20
+--worktrees::
+	Prune dead working tree information in $GIT_DIR/worktrees.
+
 <head>...::
 	In addition to objects
 	reachable from any of our references, keep objects
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 8228450..2b30a92 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -259,6 +259,25 @@ worktrees::
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/worktrees" will be
 	used instead.
=20
+worktrees/<id>/gitdir::
+	A text file containing the absolute path back to the .git file
+	that points to here. This is used to check if the linked
+	repository has been manually removed and there is no need to
+	keep this directory any more. mtime of this file should be
+	updated every time the linked repository is accessed.
+
+worktrees/<id>/locked::
+	If this file exists, the linked repository may be on a
+	portable device and not available. It does not mean that the
+	linked repository is gone and `worktrees/<id>` could be
+	removed. The file's content contains a reason string on why
+	the repository is locked.
+
+worktrees/<id>/link::
+	If this file exists, it is a hard link to the linked .git
+	file. It is used to detect if the linked repository is
+	manually removed.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ad10f99..ab46af9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -826,7 +826,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	const char *path =3D opts->new_worktree, *name;
 	struct stat st;
 	struct child_process cp;
-	int counter =3D 0, len;
+	int counter =3D 0, len, ret;
=20
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -857,11 +857,21 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
 	if (mkdir(sb_repo.buf, 0777))
 		die_errno(_("could not create directory of '%s'"), sb_repo.buf);
=20
+	/*
+	 * lock the incomplete repo so prune won't delete it, unlock
+	 * after the preparation is over.
+	 */
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	write_file(sb.buf, 1, "initializing\n");
+
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
=20
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
+	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
 	write_file(sb_git.buf, 1, "gitdir: %s/worktrees/%s\n",
 		   real_path(get_git_common_dir()), name);
 	/*
@@ -870,6 +880,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	 * value would do because this value will be ignored and
 	 * replaced at the next (real) checkout.
 	 */
+	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
 	strbuf_reset(&sb);
@@ -885,7 +896,11 @@ static int prepare_linked_checkout(const struct ch=
eckout_opts *opts,
 	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd =3D 1;
 	cp.argv =3D opts->saved_argv;
-	return run_command(&cp);
+	ret =3D run_command(&cp);
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	unlink_or_warn(sb.buf);
+	return ret;
 }
=20
 static int git_checkout_config(const char *var, const char *value, voi=
d *cb)
diff --git a/builtin/prune.c b/builtin/prune.c
index 144a3bd..cf56110 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -112,6 +112,91 @@ static void prune_object_dir(const char *path)
 	}
 }
=20
+static int prune_worktree(const char *id, struct strbuf *reason)
+{
+	struct stat st;
+	char *path;
+	int fd, len;
+
+	if (!is_directory(git_path("worktrees/%s", id))) {
+		strbuf_addf(reason, _("Removing worktrees/%s: not a valid directory"=
), id);
+		return 1;
+	}
+	if (file_exists(git_path("worktrees/%s/locked", id)))
+		return 0;
+	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file does not e=
xist"), id);
+		return 1;
+	}
+	fd =3D open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
+	if (fd < 0) {
+		strbuf_addf(reason, _("Removing worktrees/%s: unable to read gitdir =
file (%s)"),
+			    id, strerror(errno));
+		return 1;
+	}
+	len =3D st.st_size;
+	path =3D xmalloc(len + 1);
+	read_in_full(fd, path, len);
+	close(fd);
+	while (len && (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r'=
))
+		len--;
+	if (!len) {
+		strbuf_addf(reason, _("Removing worktrees/%s: invalid gitdir file"),=
 id);
+		free(path);
+		return 1;
+	}
+	path[len] =3D '\0';
+	if (!file_exists(path)) {
+		struct stat st_link;
+		free(path);
+		/*
+		 * the repo is moved manually and has not been
+		 * accessed since?
+		 */
+		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
+		    st_link.st_nlink > 1)
+			return 0;
+		strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to =
non-existent location"), id);
+		return 1;
+	}
+	free(path);
+	return st.st_mtime <=3D expire;
+}
+
+static void prune_worktrees(void)
+{
+	struct strbuf reason =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	DIR *dir =3D opendir(git_path("worktrees"));
+	struct dirent *d;
+	int ret;
+	if (!dir)
+		return;
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		strbuf_reset(&reason);
+		if (!prune_worktree(d->d_name, &reason))
+			continue;
+		if (show_only || verbose)
+			printf("%s\n", reason.buf);
+		if (show_only)
+			continue;
+		strbuf_reset(&path);
+		strbuf_addstr(&path, git_path("worktrees/%s", d->d_name));
+		ret =3D remove_dir_recursively(&path, 0);
+		if (ret < 0 && errno =3D=3D ENOTDIR)
+			ret =3D unlink(path.buf);
+		if (ret)
+			error(_("failed to remove: %s"), strerror(errno));
+	}
+	closedir(dir);
+	if (!show_only)
+		rmdir(git_path("worktrees"));
+	strbuf_release(&reason);
+	strbuf_release(&path);
+}
+
 /*
  * Write errors (particularly out of space) can result in
  * failed temporary packs (and more rarely indexes and other
@@ -138,10 +223,12 @@ int cmd_prune(int argc, const char **argv, const =
char *prefix)
 {
 	struct rev_info revs;
 	struct progress *progress =3D NULL;
+	int do_prune_worktrees =3D 0;
 	const struct option options[] =3D {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+		OPT_BOOL(0, "worktrees", &do_prune_worktrees, N_("prune .git/worktre=
es")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("expire objects older than <time>")),
 		OPT_END()
@@ -154,6 +241,14 @@ int cmd_prune(int argc, const char **argv, const c=
har *prefix)
 	init_revisions(&revs, prefix);
=20
 	argc =3D parse_options(argc, argv, prefix, options, prune_usage, 0);
+
+	if (do_prune_worktrees) {
+		if (argc)
+			die(_("--worktrees does not take extra arguments"));
+		prune_worktrees();
+		return 0;
+	}
+
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name =3D *argv++;
diff --git a/setup.c b/setup.c
index b99bdd3..fb61860 100644
--- a/setup.c
+++ b/setup.c
@@ -390,6 +390,17 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 	return ret;
 }
=20
+static void update_linked_gitdir(const char *gitfile, const char *gitd=
ir)
+{
+	struct strbuf path =3D STRBUF_INIT;
+	struct stat st;
+
+	strbuf_addf(&path, "%s/gitfile", gitdir);
+	if (stat(path.buf, &st) || st.st_mtime + 24 * 3600 < time(NULL))
+		write_file(path.buf, 0, "%s\n", gitfile);
+	strbuf_release(&path);
+}
+
 /*
  * Try to read the location of the git directory from the .git file,
  * return path to git directory if found.
@@ -438,6 +449,8 @@ const char *read_gitfile(const char *path)
=20
 	if (!is_git_directory(dir))
 		die("Not a git repository: %s", dir);
+
+	update_linked_gitdir(path, dir);
 	path =3D real_path(dir);
=20
 	free(buf);
diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-c=
heckouts.sh
new file mode 100755
index 0000000..3622800
--- /dev/null
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description=3D'prune $GIT_DIR/worktrees'
+
+. ./test-lib.sh
+
+test_expect_success 'prune --worktrees on normal repo' '
+	git prune --worktrees &&
+	test_must_fail git prune --worktrees abc
+'
+
+test_expect_success 'prune files inside $GIT_DIR/worktrees' '
+	mkdir .git/worktrees &&
+	: >.git/worktrees/abc &&
+	git prune --worktrees --verbose >actual &&
+	cat >expect <<EOF &&
+Removing worktrees/abc: not a valid directory
+EOF
+	test_i18ncmp expect actual &&
+	! test -f .git/worktrees/abc &&
+	! test -d .git/worktrees
+'
+
+test_expect_success 'prune directories without gitdir' '
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
+	cat >expect <<EOF &&
+Removing worktrees/def: gitdir file does not exist
+EOF
+	git prune --worktrees --verbose >actual &&
+	test_i18ncmp expect actual &&
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
+'
+
+test_expect_success POSIXPERM 'prune directories with unreadable gitdi=
r' '
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
+	: >.git/worktrees/def/gitdir &&
+	chmod u-r .git/worktrees/def/gitdir &&
+	git prune --worktrees --verbose >actual &&
+	test_i18ngrep "Removing worktrees/def: unable to read gitdir file" ac=
tual &&
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
+'
+
+test_expect_success 'prune directories with invalid gitdir' '
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
+	: >.git/worktrees/def/gitdir &&
+	git prune --worktrees --verbose >actual &&
+	test_i18ngrep "Removing worktrees/def: invalid gitdir file" actual &&
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
+'
+
+test_expect_success 'prune directories with gitdir pointing to nowhere=
' '
+	mkdir -p .git/worktrees/def/abc &&
+	: >.git/worktrees/def/def &&
+	echo "$TRASH_DIRECTORY"/nowhere >.git/worktrees/def/gitdir &&
+	git prune --worktrees --verbose >actual &&
+	test_i18ngrep "Removing worktrees/def: gitdir file points to non-exis=
tent location" actual &&
+	! test -d .git/worktrees/def &&
+	! test -d .git/worktrees
+'
+
+test_expect_success 'not prune locked checkout' '
+	test_when_finished rm -r .git/worktrees
+	mkdir -p .git/worktrees/ghi &&
+	: >.git/worktrees/ghi/locked &&
+	git prune --worktrees &&
+	test -d .git/worktrees/ghi
+'
+
+test_expect_success 'not prune recent checkouts' '
+	test_when_finished rm -r .git/worktrees
+	mkdir zz &&
+	mkdir -p .git/worktrees/jlm &&
+	echo "$TRASH_DIRECTORY"/zz >.git/worktrees/jlm/gitdir &&
+	git prune --worktrees --verbose --expire=3D2.days.ago &&
+	test -d .git/worktrees/jlm
+'
+
+test_done
--=20
2.1.0.rc0.78.gc0d8480
