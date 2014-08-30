From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/32] prune: strategies for linked checkouts
Date: Sat, 30 Aug 2014 15:33:55 +0700
Message-ID: <1409387642-24492-26-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe98-0003IS-52
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbaH3IgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:14 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:62101 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbaH3IgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:08 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so8079864pab.22
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KIwi/IBLMjkBXH8trQNgbC5bu7+PU1N8Q+MvbUATjrs=;
        b=NYobSI+gBlBzPzbGkuuA13QP/JUAHSShCqVlHLj70inayRFktDdwdmqzEYVomdZ4iS
         MfayGFaVXRB96js2k9QkpDT6jX/E99uFCyOqhFXqSqvuuSkKJc542CAKPlknQZFgWJ73
         mHGU8HvukoyJaU9VjmeWbb8TVy+2LAj5vZwXEiyNugeLbhgSKSQDQv/DttifKtyoP7B9
         KxAumV21WgzWv8T2KQPhJ5caK41UySeCn3jFd71lSGuvi7jSTWjEgKnWPh4J1eC3kCk/
         S9XsECFY/P2/p/sHJkjudfLlpYWy8GFs4NXmMWldYh4MWBWSbopQsQVUpfah54pC35lR
         55nQ==
X-Received: by 10.68.201.138 with SMTP id ka10mr6508104pbc.23.1409387768132;
        Sat, 30 Aug 2014 01:36:08 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id fk10sm7549928pab.29.2014.08.30.01.36.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:17 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256236>

(alias R=3D$GIT_COMMON_DIR/repos/<id>)

 - linked checkouts are supposed to keep its location in $R/gitdir up
   to date. The use case is auto fixup after a manual checkout move.

 - linked checkouts are supposed to update mtime of $R/gitdir. If
   $R/gitdir's mtime is older than a limit, and it points to nowhere,
   repos/<id> is to be pruned.

 - If $R/locked exists, repos/<id> is not supposed to be pruned. If
   $R/locked exists and $R/gitdir's mtime is older than a really long
   limit, warn about old unused repo.

 - "git checkout --to" is supposed to make a hard link named $R/link
   pointing to the .git file on supported file systems to help detect
   the user manually deleting the checkout. If $R/link exists and its
   link count is greated than 1, the repo is kept.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-prune.txt                |  3 +
 Documentation/gitrepository-layout.txt     | 19 ++++++
 builtin/checkout.c                         | 14 +++++
 builtin/prune.c                            | 95 ++++++++++++++++++++++=
++++++++
 setup.c                                    | 13 ++++
 t/t2026-prune-linked-checkouts.sh (new +x) | 84 ++++++++++++++++++++++=
++++
 6 files changed, 228 insertions(+)
 create mode 100755 t/t2026-prune-linked-checkouts.sh

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7a493c8..50e39ec 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -48,6 +48,9 @@ OPTIONS
 --expire <time>::
 	Only expire loose objects older than <time>.
=20
+--repos::
+	Prune directories in $GIT_DIR/repos.
+
 <head>...::
 	In addition to objects
 	reachable from any of our references, keep objects
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index fab398a..c9a7d1a 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -255,6 +255,25 @@ repos::
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/repos" will be
 	used instead.
=20
+repos/<id>/gitdir::
+	A text file containing the absolute path back to the .git file
+	that points to here. This is used to check if the linked
+	repository has been manually removed and there is no need to
+	keep this directory any more. mtime of this file should be
+	updated every time the linked repository is accessed.
+
+repos/<id>/locked::
+	If this file exists, the linked repository may be on a
+	portable device and not available. It does not mean that the
+	linked repository is gone and `repos/<id>` could be
+	removed. The file's content contains a reason string on why
+	the repository is locked.
+
+repos/<id>/link::
+	If this file exists, it is a hard link to the linked .git
+	file. It is used to detect if the linked repository is
+	manually removed.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 614db34..0f28b4a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -895,12 +895,22 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
 	junk_git_dir =3D xstrdup(sb_repo.buf);
 	is_junk =3D 1;
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
 	junk_work_tree =3D xstrdup(path);
=20
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
+	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
 	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
 		   real_path(get_git_common_dir()), name);
 	/*
@@ -909,6 +919,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	 * value would do because this value will be ignored and
 	 * replaced at the next (real) checkout.
 	 */
+	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
 	strbuf_reset(&sb);
@@ -932,6 +943,9 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 		junk_work_tree =3D NULL;
 		junk_git_dir =3D NULL;
 	}
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	unlink_or_warn(sb.buf);
 	strbuf_release(&sb);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
diff --git a/builtin/prune.c b/builtin/prune.c
index 144a3bd..e72c391 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -112,6 +112,91 @@ static void prune_object_dir(const char *path)
 	}
 }
=20
+static int prune_repo_dir(const char *id, struct strbuf *reason)
+{
+	struct stat st;
+	char *path;
+	int fd, len;
+
+	if (!is_directory(git_path("repos/%s", id))) {
+		strbuf_addf(reason, _("Removing repos/%s: not a valid directory"), i=
d);
+		return 1;
+	}
+	if (file_exists(git_path("repos/%s/locked", id)))
+		return 0;
+	if (stat(git_path("repos/%s/gitdir", id), &st)) {
+		strbuf_addf(reason, _("Removing repos/%s: gitdir file does not exist=
"), id);
+		return 1;
+	}
+	fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
+	if (fd < 0) {
+		strbuf_addf(reason, _("Removing repos/%s: unable to read gitdir file=
 (%s)"),
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
+		strbuf_addf(reason, _("Removing repos/%s: invalid gitdir file"), id)=
;
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
+		if (!stat(git_path("repos/%s/link", id), &st_link) &&
+		    st_link.st_nlink > 1)
+			return 0;
+		strbuf_addf(reason, _("Removing repos/%s: gitdir file points to non-=
existent location"), id);
+		return 1;
+	}
+	free(path);
+	return st.st_mtime <=3D expire;
+}
+
+static void prune_repos_dir(void)
+{
+	struct strbuf reason =3D STRBUF_INIT;
+	struct strbuf path =3D STRBUF_INIT;
+	DIR *dir =3D opendir(git_path("repos"));
+	struct dirent *d;
+	int ret;
+	if (!dir)
+		return;
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		strbuf_reset(&reason);
+		if (!prune_repo_dir(d->d_name, &reason))
+			continue;
+		if (show_only || verbose)
+			printf("%s\n", reason.buf);
+		if (show_only)
+			continue;
+		strbuf_reset(&path);
+		strbuf_addstr(&path, git_path("repos/%s", d->d_name));
+		ret =3D remove_dir_recursively(&path, 0);
+		if (ret < 0 && errno =3D=3D ENOTDIR)
+			ret =3D unlink(path.buf);
+		if (ret)
+			error(_("failed to remove: %s"), strerror(errno));
+	}
+	closedir(dir);
+	if (!show_only)
+		rmdir(git_path("repos"));
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
+	int prune_repos =3D 0;
 	const struct option options[] =3D {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned objects")),
 		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
+		OPT_BOOL(0, "repos", &prune_repos, N_("prune .git/repos/")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
 				N_("expire objects older than <time>")),
 		OPT_END()
@@ -154,6 +241,14 @@ int cmd_prune(int argc, const char **argv, const c=
har *prefix)
 	init_revisions(&revs, prefix);
=20
 	argc =3D parse_options(argc, argv, prefix, options, prune_usage, 0);
+
+	if (prune_repos) {
+		if (argc)
+			die(_("--repos does not take extra arguments"));
+		prune_repos_dir();
+		return 0;
+	}
+
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name =3D *argv++;
diff --git a/setup.c b/setup.c
index 8f90bc3..da2d669 100644
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
index 0000000..79d84cb
--- /dev/null
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description=3D'prune $GIT_DIR/repos'
+
+. ./test-lib.sh
+
+test_expect_success 'prune --repos on normal repo' '
+	git prune --repos &&
+	test_must_fail git prune --repos abc
+'
+
+test_expect_success 'prune files inside $GIT_DIR/repos' '
+	mkdir .git/repos &&
+	: >.git/repos/abc &&
+	git prune --repos --verbose >actual &&
+	cat >expect <<EOF &&
+Removing repos/abc: not a valid directory
+EOF
+	test_i18ncmp expect actual &&
+	! test -f .git/repos/abc &&
+	! test -d .git/repos
+'
+
+test_expect_success 'prune directories without gitdir' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	cat >expect <<EOF &&
+Removing repos/def: gitdir file does not exist
+EOF
+	git prune --repos --verbose >actual &&
+	test_i18ncmp expect actual &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success POSIXPERM 'prune directories with unreadable gitdi=
r' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	: >.git/repos/def/gitdir &&
+	chmod u-r .git/repos/def/gitdir &&
+	git prune --repos --verbose >actual &&
+	test_i18ngrep "Removing repos/def: unable to read gitdir file" actual=
 &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success 'prune directories with invalid gitdir' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	: >.git/repos/def/gitdir &&
+	git prune --repos --verbose >actual &&
+	test_i18ngrep "Removing repos/def: invalid gitdir file" actual &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success 'prune directories with gitdir pointing to nowhere=
' '
+	mkdir -p .git/repos/def/abc &&
+	: >.git/repos/def/def &&
+	echo "$TRASH_DIRECTORY"/nowhere >.git/repos/def/gitdir &&
+	git prune --repos --verbose >actual &&
+	test_i18ngrep "Removing repos/def: gitdir file points to non-existent=
 location" actual &&
+	! test -d .git/repos/def &&
+	! test -d .git/repos
+'
+
+test_expect_success 'not prune locked checkout' '
+	test_when_finished rm -r .git/repos
+	mkdir -p .git/repos/ghi &&
+	: >.git/repos/ghi/locked &&
+	git prune --repos &&
+	test -d .git/repos/ghi
+'
+
+test_expect_success 'not prune recent checkouts' '
+	test_when_finished rm -r .git/repos
+	mkdir zz &&
+	mkdir -p .git/repos/jlm &&
+	echo "$TRASH_DIRECTORY"/zz >.git/repos/jlm/gitdir &&
+	git prune --repos --verbose --expire=3D2.days.ago &&
+	test -d .git/repos/jlm
+'
+
+test_done
--=20
2.1.0.rc0.78.gc0d8480
