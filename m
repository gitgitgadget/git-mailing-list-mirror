From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Tue, 18 Feb 2014 20:40:13 +0700
Message-ID: <1392730814-19656-25-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:43:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkxb-0002Ii-7v
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787AbaBRNnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:43:00 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:51500 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbaBRNmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:42:38 -0500
Received: by mail-pb0-f54.google.com with SMTP id uo5so16792772pbc.13
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HwtAEuZpDMDrbg8F4bMHcxsD8xwivMtvcrv1k7F4if0=;
        b=DaVohXY//QZlMlm2KIpEFTL7JdBBHuKgkqbOc/QQKwsTh4LlbyRMLQkCUb/EDy0lax
         LhnUbUoKHbo02+X4bdTpp/JU/OlsTSCurNANpZYhfqQeQ2tvjncJAnOvCk1OEk2Vrz98
         S27YECl0IWfyXG2D/JewTClMwhn9tNnZkqnVy7Cfi6yzrcLQ9Ub158kbflEtiuOq8qTs
         Mq0/YJ5Ae+uJun5edpxh3Qo0cS9Y+SNOXOfxXAZbu1HbLufo3EBYBPDLfPSIm9UTwJKe
         Aaod6mMEIlcysBjZDC/ZEHi7HJw925AZb/Lk3+h+ZCjCg/u5ZbQW2Qqnd2lEBy46rlmF
         B1zg==
X-Received: by 10.66.249.202 with SMTP id yw10mr32368672pac.111.1392730957504;
        Tue, 18 Feb 2014 05:42:37 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id cz3sm56122947pbc.9.2014.02.18.05.42.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:42:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:42:50 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242325>

alias REPO=3D$GIT_COMMON_DIR/repos/<id>

 - linked checkouts are supposed to update mtime of $REPO/gitdir

 - linked checkouts are supposed to keep its location in $REPO/gitdir u=
p to
   date

 - "git checkout --to" is supposed to create $REPO/locked if the new
   repo is on a different partition than the shared one.

 - "git checkout --to" is supposed to make hardlink named $REPO/link
   pointing to the .git file

The pruning rules are:

 - if $REPO/locked exists, repos/<id> is not supposed to be pruned.

 - if $REPO/locked exists and $REPO/gitdir's mtimer is older than a
   really long limit, warn about old unused repo.

 - if $REPO/link exists and its link count is greated than 1, the repo
   is kept.

 - if $REPO/gitdir's mtime is older than a limit, and it points to
   nowhere, repos/<id> is to be pruned.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-prune.txt            |  3 ++
 Documentation/gitrepository-layout.txt | 19 +++++++++
 builtin/checkout.c                     | 36 +++++++++++++++-
 builtin/prune.c                        | 75 ++++++++++++++++++++++++++=
++++++++
 setup.c                                | 13 ++++++
 5 files changed, 145 insertions(+), 1 deletion(-)

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
index 495a937..784d0a5 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -221,6 +221,25 @@ modules::
 repos::
 	Contains worktree specific information of linked checkouts.
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
index 7b86f2b..c501e9c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -854,6 +854,17 @@ static void remove_junk_on_signal(int signo)
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
 static int prepare_linked_checkout(const struct checkout_opts *opts,
 				   struct branch_info *new)
 {
@@ -863,7 +874,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	struct stat st;
 	const char *name;
 	struct child_process cp;
-	int counter =3D 0, len, ret;
+	int counter =3D 0, len, keep_locked =3D 0, ret;
=20
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -898,12 +909,18 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
 	junk_git_dir =3D sb_repo.buf;
 	is_junk =3D 1;
=20
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
 		   real_path(get_git_dir()), name);
 	/*
@@ -912,12 +929,24 @@ static int prepare_linked_checkout(const struct c=
heckout_opts *opts,
 	 * value would do because this value will be ignored and
 	 * replaced at the next (real) checkout.
 	 */
+	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
 	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
=20
+	if (get_device_or_die(path) !=3D get_device_or_die(get_git_dir())) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+		write_file(sb.buf, 1, "located on a different file system\n");
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
@@ -930,6 +959,11 @@ static int prepare_linked_checkout(const struct ch=
eckout_opts *opts,
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
index de43b26..87a6d21 100644
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
@@ -166,6 +240,7 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 			die("unrecognized argument: %s", name);
 	}
=20
+
 	if (show_progress =3D=3D -1)
 		show_progress =3D isatty(2);
 	if (show_progress)
diff --git a/setup.c b/setup.c
index d4ac878..2772cdd 100644
--- a/setup.c
+++ b/setup.c
@@ -329,6 +329,17 @@ static int check_repository_format_gently(const ch=
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
@@ -377,6 +388,8 @@ const char *read_gitfile(const char *path)
=20
 	if (!is_git_directory(dir))
 		die("Not a git repository: %s", dir);
+
+	update_linked_gitdir(path, dir);
 	path =3D real_path(dir);
=20
 	free(buf);
--=20
1.8.5.2.240.g8478abd
