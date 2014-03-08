From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 25/28] prune: strategies for linked checkouts
Date: Sat,  8 Mar 2014 09:48:17 +0700
Message-ID: <1394246900-31535-26-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7LN-0006Fm-IV
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbaCHCu1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:50:27 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34851 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbaCHCuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:50:25 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so4933653pab.24
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wz9GeYHPNnI+YYAZ3E1dxChVc2h+VLAaNOB6YYy+EV8=;
        b=w2xY07U5PXMQOX8R4ZFa94B40R4sOoznUKkpwM0pbmDd4N2uf9rr3ro6Hips+t17Nj
         LkP0cPAgQRUqTceR8fsxFir7qCNjCWC9AKZf9j5F0AJtap9NrtcKQdCP6KkuXiU3DIUl
         iTNIhR2GUEm1rI2+ogJJkTcLtCJy7s/zrJbjW6SAdATibAShmSwQ5GbLMTjamcNd576s
         LDCr4RH+0pFFYUruxOmG4mgasBfE7G5IoA60IEbXvhXo48DOArvMr13ktHHWI5g1ZiH8
         1RYCccVzPxXJgihpRMcHbc1Mw7B8CahK3q5aU12cLQYnqHzm7Isy7qlrR/AUUI7EKEZU
         cMgw==
X-Received: by 10.67.5.39 with SMTP id cj7mr25635185pad.7.1394247025106;
        Fri, 07 Mar 2014 18:50:25 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id ns7sm42326355pbc.32.2014.03.07.18.50.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:50:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:50:58 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243666>

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
 Documentation/git-prune.txt            |  3 ++
 Documentation/gitrepository-layout.txt | 19 +++++++++
 builtin/checkout.c                     | 14 +++++++
 builtin/prune.c                        | 74 ++++++++++++++++++++++++++=
++++++++
 setup.c                                | 13 ++++++
 5 files changed, 123 insertions(+)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 058ac0d..7babf11 100644
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
index 2206f35..dff6c47 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -252,6 +252,25 @@ repos::
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
index 598b43d..9dc80f1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -899,12 +899,22 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
 	junk_git_dir =3D sb_repo.buf;
 	is_junk =3D 1;
=20
+	/*
+	 * lock the incomplete repo so prunt won't delete it, unlock
+	 * after the preparation is over.
+	 */
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	write_file(sb.buf, 1, "initializing\n");
+
 	strbuf_addf(&sb_git, "%s/.git", path);
 	if (safe_create_leading_directories_const(sb_git.buf))
 		die_errno(_("could not create leading directories of '%s'"),
 			  sb_git.buf);
 	junk_work_tree =3D path;
=20
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/gitdir", sb_repo.buf);
+	write_file(sb.buf, 1, "%s\n", real_path(sb_git.buf));
 	write_file(sb_git.buf, 1, "gitdir: %s/repos/%s\n",
 		   real_path(get_git_common_dir()), name);
 	/*
@@ -913,6 +923,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	 * value would do because this value will be ignored and
 	 * replaced at the next (real) checkout.
 	 */
+	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
 	strbuf_reset(&sb);
@@ -931,6 +942,9 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	ret =3D run_command(&cp);
 	if (!ret)
 		is_junk =3D 0;
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+	unlink_or_warn(sb.buf);
 	strbuf_release(&sb);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
diff --git a/builtin/prune.c b/builtin/prune.c
index de43b26..733cb3b 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -112,6 +112,70 @@ static void prune_object_dir(const char *path)
 	}
 }
=20
+static const char *prune_repo_dir(const char *id, struct stat *st)
+{
+	char *path;
+	int fd, len;
+	if (file_exists(git_path("repos/%s/locked", id)))
+		return NULL;
+	if (stat(git_path("repos/%s/gitdir", id), st)) {
+		st->st_mtime =3D expire;
+		return _("gitdir does not exist");
+	}
+	fd =3D open(git_path("repos/%s/gitdir", id), O_RDONLY);
+	len =3D st->st_size;
+	path =3D xmalloc(len + 1);
+	read_in_full(fd, path, len);
+	close(fd);
+	while (path[len - 1] =3D=3D '\n' || path[len - 1] =3D=3D '\r')
+		len--;
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
+			return NULL;
+		return _("gitdir points to non-existing file");
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
+	struct stat st;
+	if (!dir)
+		return;
+	while ((d =3D readdir(dir)) !=3D NULL) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+		if ((reason =3D prune_repo_dir(d->d_name, &st)) !=3D NULL &&
+		    st.st_mtime <=3D expire) {
+			struct strbuf sb =3D STRBUF_INIT;
+			if (show_only || verbose)
+				printf(_("Removing repos/%s: %s\n"), d->d_name, reason);
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
@@ -138,10 +202,12 @@ int cmd_prune(int argc, const char **argv, const =
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
@@ -154,6 +220,14 @@ int cmd_prune(int argc, const char **argv, const c=
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
index 40ce191..5529b26 100644
--- a/setup.c
+++ b/setup.c
@@ -336,6 +336,17 @@ static int check_repository_format_gently(const ch=
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
@@ -384,6 +395,8 @@ const char *read_gitfile(const char *path)
=20
 	if (!is_git_directory(dir))
 		die("Not a git repository: %s", dir);
+
+	update_linked_gitdir(path, dir);
 	path =3D real_path(dir);
=20
 	free(buf);
--=20
1.9.0.40.gaa8c3ea
