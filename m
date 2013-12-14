From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 17/21] prune: strategies for split repositories
Date: Sat, 14 Dec 2013 17:55:03 +0700
Message-ID: <1387018507-21999-18-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrmqD-0001Lo-Po
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab3LNKw6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:52:58 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35961 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab3LNKw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:52:56 -0500
Received: by mail-pd0-f174.google.com with SMTP id y13so3499153pdi.33
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=S63UQKQ5OWq7Kqn5tf1dirwLJYvAADAc6CmXbPXW6EY=;
        b=qnG1RjIkVy8U9b23URD5sTv5wWLwjbkFPESIqIuPl3ZCVe+8xdibvZzIlGaDpUDhxL
         XAG+Ryg8AjQhYXJKic6ewPpk+z8H/67iB5v3yJnvO4BuXQNNw6qqxNef+kLuA68YWIlQ
         w8kPyi64nojdSD661YEawSO8UU6QyM/A6gCQpzpmGLJbNwsjcbZZj7iHPqMN/M54rKlK
         GKUxyjTy7fm8URe/aMom0jSRhVPFcuwRoL1GDi82wKaAEXl13Fj4tO5gM480ODaycygw
         S8EDBKaaZ4GAbNhLCYk22wrHjL2Nl60YGCNnReT43qD//2jTexosTRvCgUyQ3qHXS/im
         yY9Q==
X-Received: by 10.68.211.1 with SMTP id my1mr8837809pbc.55.1387018376477;
        Sat, 14 Dec 2013 02:52:56 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id bh6sm15324980pad.20.2013.12.14.02.52.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:52:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:57:49 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239299>

alias REPO=3D$GIT_SUPER_DIR/repos/<id>

 - split repos are supposed to update mtime of $REPO/gitdir

 - split repos are supposed to keep its location in $REPO/gitdir up to
   date

 - "git checkout --to" is supposed to create $REPO/locked if the new
   repo is on a different partition than the shared one.

 - "git checkout --to" is supposed to make hardlink named $REPO/link
   pointing to the .git file

The pruning rules are:

 - if $REPO/locked exists, repos/<id> is not supposed to be pruned.

 - if $REPO/locked exists and $REPO/gitdir's mtimer is older than a
   really long limit, warn about old unused repo.

 - if $REPO/link exists and its link count is 1, repos/<id> is to be
   pruned.

 - if $REPO/gitdir's mtime is older than a limit, and it points to
   nowhere, repos/<id> is to be pruned. Warn about it some time before
   the prune time.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-prune.txt            |  4 +++
 Documentation/gitrepository-layout.txt | 19 ++++++++++
 builtin/checkout.c                     | 36 ++++++++++++++++++-
 builtin/prune.c                        | 65 ++++++++++++++++++++++++++=
++++++++
 setup.c                                | 13 +++++++
 5 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index bf82410..55a9341 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -46,6 +46,10 @@ OPTIONS
 --expire <time>::
 	Only expire loose objects older than <time>.
=20
+--repos::
+	Prune directories in $GIT_DIR/repos other than `<time>` given
+	by `--expire` (or default 6 months)
+
 <head>...::
 	In addition to objects
 	reachable from any of our references, keep objects
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 3c6149e..a8a0426 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -225,6 +225,25 @@ repos/<id>::
 	repository in question (e.g. HEAD or index). Such .git files
 	are created by `git checkout --to`.
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
index 6353557..aece20d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -856,6 +856,17 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
=20
+static dev_t get_device_or_die(const char *path)
+{
+	struct stat buf;
+	if (stat(path, &buf))
+		die_errno("failed to stat '%s'", path);
+	/* Ah Windows! Make different drives different "partitions" */
+	if (buf.st_dev =3D=3D 0 && has_dos_drive_prefix("c:\\"))
+		buf.st_dev =3D toupper(real_path(path)[0]);
+	return buf.st_dev;
+}
+
 static int checkout_new_worktree(const struct checkout_opts *opts,
 				 struct branch_info *new)
 {
@@ -865,7 +876,7 @@ static int checkout_new_worktree(const struct check=
out_opts *opts,
 	struct stat st;
 	const char *name;
 	struct child_process cp;
-	int counter =3D 0, len, ret;
+	int counter =3D 0, len, keep_locked =3D 0, ret;
=20
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -900,17 +911,35 @@ static int checkout_new_worktree(const struct che=
ckout_opts *opts,
 	junk_git_dir =3D sb_repo.buf;
 	is_junk =3D 1;
=20
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	write_to_file(sb.buf, "initializing\n");
+
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
 	junk_work_tree =3D path;
=20
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
+	write_to_file(sb.buf, "%s\n", real_path(sb_git.buf));
 	write_to_file(sb_git.buf, "gitsuper: %s\ngitdir: %s\n",
 		      real_path(get_git_dir()), name);
+	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 	write_to_file(sb.buf, "%s\n", sha1_to_hex(new->commit->object.sha1));
=20
+	if (get_device_or_die(path) !=3D get_device_or_die(get_git_dir())) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+		write_to_file(sb.buf, "located on a different file system\n");
+		keep_locked =3D 1;
+	} else {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/link", sb_repo.buf);
+		link(sb_git.buf, sb.buf); /* it's ok to fail */
+	}
+
 	if (!opts->quiet)
 		fprintf_ln(stderr, _("Enter %s (identifier %s)"), path, name);
=20
@@ -928,6 +957,11 @@ static int checkout_new_worktree(const struct chec=
kout_opts *opts,
 	ret =3D run_command(&cp);
 	if (!ret)
 		is_junk =3D 0;
+	if (!keep_locked) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+		unlink_or_warn(sb.buf);
+	}
 	strbuf_release(&sb);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
diff --git a/builtin/prune.c b/builtin/prune.c
index 6366917..16eb99c 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -102,6 +102,62 @@ static void prune_object_dir(const char *path)
 	}
 }
=20
+static const char *prune_repo_dir(const char *id)
+{
+	struct stat st;
+	char *path;
+	int fd, len;
+	if (file_exists(git_path("repos/%s/locked", id)))
+		return NULL;
+	if (!stat(git_path("repos/%s/link", id), &st) && st.st_nlink =3D=3D 1=
)
+		return _("hard link count is 1");
+	if (stat(git_path("repos/%s/gitdir", id), &st))
+		return "gitdir does not exist";
+	if (st.st_mtime > expire)
+		return NULL;
+	fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
+	len =3D st.st_size;
+	path =3D xmalloc(len + 1);
+	read_in_full(fd, path, len);
+	close(fd);
+	while (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r')
+		len--;
+	path[len] =3D '\0';
+	if (!file_exists(path)) {
+		free(path);
+		return "gitdir points to non-existing file";
+	}
+	free(path);
+	return NULL;
+}
+
+static void prune_repos_dir(void)
+{
+	const char *reason;
+	DIR *dir =3D opendir(git_path("repos"));
+	struct dirent *d;
+	int removed =3D 0;
+	if (!dir)
+		return;
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		if ((reason =3D prune_repo_dir(d->d_name)) !=3D NULL) {
+			struct strbuf sb =3D STRBUF_INIT;
+			printf(_("Removing repos/%s: %s\n"), d->d_name, reason);
+			if (show_only)
+				continue;
+			strbuf_addstr(&sb, git_path("repos/%s", d->d_name));
+			remove_dir_recursively(&sb, 0);
+			strbuf_release(&sb);
+			removed =3D 1;
+		}
+	}
+	closedir(dir);
+	if (removed)
+		rmdir(git_path("repos"));
+}
+
 /*
  * Write errors (particularly out of space) can result in
  * failed temporary packs (and more rarely indexes and other
@@ -128,10 +184,12 @@ int cmd_prune(int argc, const char **argv, const =
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
@@ -156,6 +214,13 @@ int cmd_prune(int argc, const char **argv, const c=
har *prefix)
 			die("unrecognized argument: %s", name);
 	}
=20
+	if (prune_repos) {
+		if (expire =3D=3D ULONG_MAX)
+			expire =3D time(NULL) - 6 * 30 * 24 * 3600; /* 6 months */
+		prune_repos_dir();
+		return 0;
+	}
+
 	if (show_progress =3D=3D -1)
 		show_progress =3D isatty(2);
 	if (show_progress)
diff --git a/setup.c b/setup.c
index ac7d90c..95a3f40 100644
--- a/setup.c
+++ b/setup.c
@@ -765,6 +765,17 @@ static const char *setup_git_directory_gently_1(in=
t *nongit_ok,
 	}
 }
=20
+static int update_super_gitdir(char *path)
+{
+	FILE *fp =3D fopen(git_path("gitdir"), "w");
+	if (!fp)
+		return error(_("unable to update %s: %s"),
+			     git_path("gitdir"), strerror(errno));
+	fprintf(stderr, "%s\n", path);
+	fclose(fp);
+	return 0;
+}
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	const char *prefix;
@@ -780,6 +791,8 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
 		startup_info->prefix =3D prefix;
 	}
+	if (get_git_super_dir() && gitfile)
+		update_super_gitdir(gitfile);
 	free(gitfile);
 	return prefix;
 }
--=20
1.8.5.1.77.g42c48fa
