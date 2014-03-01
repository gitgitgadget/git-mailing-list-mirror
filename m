From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 24/27] prune: strategies for linked checkouts
Date: Sat,  1 Mar 2014 19:13:00 +0700
Message-ID: <1393675983-3232-25-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:23:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiwx-0002kU-Gg
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbaCAMXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:23:21 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:46036 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbaCAMXT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:23:19 -0500
Received: by mail-pd0-f173.google.com with SMTP id z10so1860609pdj.18
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=j45D4om3PhW/btWEGAsr76KsvHeRt8Uob7v12hfm0sc=;
        b=rCKoMbhhq5u25PKIlyAod/786JHY205g4noF802ZorkqvT1jtHV3t5HZmT2cau9nWk
         tWdhrdJwRvmbvOvixIsOpqGGeHBx90poqqgBoerNS/GcKJRUEsYiF9rTOeeldDnSXgEP
         XQX/FhRAoJ/Id735JqaX5s0xVzA9TriSfE/Ui/w0+rq7A6Up8IcQbbYBmekLoM09eUnk
         txziDYGI4MZ+dq3ybHwziTsfO8OkSJFQhP/Qv4CmeWathRnXqfMSFv236hfsMxjvdoZd
         1w8OU6Yid1Xa55Ujp3euDWT0utZ8vrX0DNYGR4ahEMfg89ThCPhtzszE3BB4wOnCjk85
         IBpA==
X-Received: by 10.67.5.7 with SMTP id ci7mr9147235pad.99.1393676598817;
        Sat, 01 Mar 2014 04:23:18 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id bz4sm15934231pbb.12.2014.03.01.04.23.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:23:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:23:43 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243088>

(alias R=3D$GIT_COMMON_DIR/repos/<id>)

 - linked checkouts are supposed to keep its location in $R/gitdir up
   to date. The use case is auto fixup after a manual checkout move.

 - linked checkouts are supposed to update mtime of $R/gitdir. If
   $R/gitdir's mtime is older than a limit, and it points to nowhere,
   repos/<id> is to be pruned.

 - "git checkout --to" is supposed to create $R/locked if the new repo
   is on a different partition than the shared one. The main use case
   is when the checkout is on a portable device and may not be
   available at prune time.

   If $R/locked exists, repos/<id> is not supposed to be pruned. If
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
 builtin/checkout.c                     | 36 ++++++++++++++++-
 builtin/prune.c                        | 74 ++++++++++++++++++++++++++=
++++++++
 compat/mingw.h                         |  1 +
 git-compat-util.h                      |  4 ++
 setup.c                                | 13 ++++++
 7 files changed, 149 insertions(+), 1 deletion(-)

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
index 418e5c8..2dc6901 100644
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
index 1675808..1fc85d3 100644
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
+	if (is_windows())
+		buf.st_dev =3D toupper(real_path(path)[0]);
+	return buf.st_dev;
+}
+
 static int prepare_linked_checkout(const struct checkout_opts *opts,
 				   struct branch_info *new)
 {
@@ -862,7 +873,7 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
 	const char *path =3D opts->new_worktree, *name;
 	struct stat st;
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
 		   real_path(get_git_common_dir()), name);
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
+		(void)link(sb_git.buf, sb.buf);
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
diff --git a/compat/mingw.h b/compat/mingw.h
index e033e72..18323c1 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -328,6 +328,7 @@ int winansi_fprintf(FILE *stream, const char *forma=
t, ...) __attribute__((format
  * git specific compatibility
  */
=20
+#define is_windows() 1
 #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] =3D=3D=
 ':')
 #define is_dir_sep(c) ((c) =3D=3D '/' || (c) =3D=3D '\\')
 static inline char *mingw_find_last_dir_sep(const char *path)
diff --git a/git-compat-util.h b/git-compat-util.h
index cbd86c3..41f1b74 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -266,6 +266,10 @@ extern char *gitbasename(char *);
 #define STRIP_EXTENSION ""
 #endif
=20
+#ifndef is_windows
+#define is_windows() 0
+#endif
+
 #ifndef has_dos_drive_prefix
 #define has_dos_drive_prefix(path) 0
 #endif
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
