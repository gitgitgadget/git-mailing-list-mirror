From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 17/26] file-watcher: inotify support, watching part
Date: Mon,  3 Feb 2014 11:29:05 +0700
Message-ID: <1391401754-15347-18-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBW-0001OJ-5E
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbaBCEa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:58 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38549 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbaBCEa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:57 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so6570531pbb.31
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3gD3DHmPCmLeV748QRi/4DpCwfNDIB1hpxZB7rJNRf4=;
        b=nInRSDmB5Hnzllxpe/c1HSygNSzntH2+C3B36dcZ5/cK4ySXV6MBepNhl550Y+n0QT
         eFZjr9z00SfxutcG2GIuPflgI48z2WStBPNyXt7/KIDRMnphIgWgjzNgGELUM7MhkInD
         l3ZY5tkqzeBnecHKOAluVXlMIfX0y6EyOSogt1Bmt+wdZWR9+VzTqIj9DglNymenRYC+
         s8cNM3o72p7bNvIyn+W4JwFRbqK88cYLjkaoVppQd5K20clQHs1VoGw88veKBLTwsz3h
         MuJNQ7X5y0MQy/vkkKIWRlXcF4sWNLJAo4LxDV7JS0ifVHwJtjV7a6cOgfgb2PO9Qov3
         Zixg==
X-Received: by 10.66.162.74 with SMTP id xy10mr35244406pab.4.1391401856658;
        Sun, 02 Feb 2014 20:30:56 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id y9sm134267984pas.10.2014.02.02.20.30.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:54 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241412>

"struct dir" manages inotify file descriptor and forms a tree. "struct
file" manages a file. When a file is watched, all dirs up to the file
is watched. Any changes on a directory impacts all subdirs and files.

The way data structure is made might be inotify-specific. I haven't
thought of how other file notification mechanisms may be
implemented. So there may be some refactoring later when a new OS is
supported.

Room for improvement: consecutive watched paths likely share the same
directory part (even though they are sorted by mtime, not name). Try
remember the last "dir" sequence and reduce lookups.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-file-watcher.txt |  13 +++
 file-watcher.c                     | 226 +++++++++++++++++++++++++++++=
+++++++-
 2 files changed, 238 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-file-watcher.txt b/Documentation/git-fil=
e-watcher.txt
index d91caf3..d694fea 100644
--- a/Documentation/git-file-watcher.txt
+++ b/Documentation/git-file-watcher.txt
@@ -18,11 +18,24 @@ lstat(2) to detect that itself. Config key filewatc=
her.path needs to
 be set to `<socket directory>` so Git knows how to contact to the file
 watcher.
=20
+This program is only supported under Linux with inotify(7) support.
+
 OPTIONS
 -------
 --detach::
 	Run in background.
=20
+BUGS
+----
+On Linux, file watcher may fail to detect changes if you move the work
+tree from outside. For example if you have work tree at
+`/tmp/foo/work`, you move `/tmp/foo` to `/tmp/bar`, make some changes
+in `/tmp/bar/work` and move `/tmp/bar` back to `/tmp/foo`, changes
+won't get noticed. Moving `/tmp/foo/work` to something else is fine.
+
+inotify may not work well with network filesystems and a few special
+others. Check inotify documents.
+
 SEE ALSO
 --------
 linkgit:git-update-index[1],
diff --git a/file-watcher.c b/file-watcher.c
index aa2daf6..d0762e6 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -11,6 +11,28 @@ static const char *const file_watcher_usage[] =3D {
 	NULL
 };
=20
+struct dir;
+struct repository;
+
+struct file {
+	char *name;
+	struct dir *parent;
+	struct repository *repo;
+	struct file *next;
+};
+
+struct dir {
+	char *name;
+	struct dir *parent;
+	struct dir **subdirs;
+	struct file **files;
+	struct repository *repo; /* only for root note */
+	int wd, nr_subdirs, nr_files;
+};
+
+static struct dir **wds;
+static int wds_alloc;
+
 struct repository {
 	char *work_tree;
 	char index_signature[41];
@@ -25,6 +47,7 @@ struct repository {
 	struct string_list updated;
 	int updated_sorted;
 	int updating;
+	struct dir *root;
 };
=20
 const char *invalid_signature =3D "00000000000000000000000000000000000=
00000";
@@ -42,10 +65,199 @@ struct connection {
 static struct connection **conns;
 static struct pollfd *pfd;
 static int conns_alloc, pfd_nr, pfd_alloc;
+static int inotify_fd;
+
+/*
+ * IN_DONT_FOLLOW does not matter now as we do not monitor
+ * symlinks. See ce_watchable().
+ */
+#define INOTIFY_MASKS (IN_DELETE_SELF | IN_MOVE_SELF | \
+		       IN_CREATE | IN_ATTRIB | IN_DELETE | IN_MODIFY |	\
+		       IN_MOVED_FROM | IN_MOVED_TO)
+static struct dir *create_dir(struct dir *parent, const char *path,
+			      const char *basename)
+{
+	struct dir *d;
+	int wd =3D inotify_add_watch(inotify_fd, path, INOTIFY_MASKS);
+	if (wd < 0)
+		return NULL;
+
+	d =3D xmalloc(sizeof(*d));
+	memset(d, 0, sizeof(*d));
+	d->wd =3D wd;
+	d->parent =3D parent;
+	d->name =3D xstrdup(basename);
+
+	ALLOC_GROW(wds, wd + 1, wds_alloc);
+	wds[wd] =3D d;
+	return d;
+}
+
+static int get_dir_pos(struct dir *d, const char *name)
+{
+	int first, last;
+
+	first =3D 0;
+	last =3D d->nr_subdirs;
+	while (last > first) {
+		int next =3D (last + first) >> 1;
+		int cmp =3D strcmp(name, d->subdirs[next]->name);
+		if (!cmp)
+			return next;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+
+	return -first-1;
+}
+
+static void free_file(struct dir *d, int pos, int topdown);
+static void free_dir(struct dir *d, int topdown)
+{
+	struct dir *p =3D d->parent;
+	int pos;
+	if (!topdown && p && (pos =3D get_dir_pos(p, d->name)) < 0)
+		die("How come this directory is not registered in its parent?");
+	if (d->repo)
+		d->repo->root =3D NULL;
+	wds[d->wd] =3D NULL;
+	inotify_rm_watch(inotify_fd, d->wd);
+	if (topdown) {
+		int i;
+		for (i =3D 0; i < d->nr_subdirs; i++)
+			free_dir(d->subdirs[i], topdown);
+		for (i =3D 0; i < d->nr_files; i++)
+			free_file(d, i, topdown);
+	}
+	free(d->name);
+	free(d->subdirs);
+	free(d->files);
+	free(d);
+	if (p && !topdown) {
+		p->nr_subdirs--;
+		memmove(p->subdirs + pos, p->subdirs + pos + 1,
+			(p->nr_subdirs - pos) * sizeof(*p->subdirs));
+		if (!p->nr_subdirs && !p->nr_files)
+			free_dir(p, topdown);
+	}
+}
+
+static int get_file_pos(struct dir *d, const char *name)
+{
+	int first, last;
+
+	first =3D 0;
+	last =3D d->nr_files;
+	while (last > first) {
+		int next =3D (last + first) >> 1;
+		int cmp =3D strcmp(name, d->files[next]->name);
+		if (!cmp)
+			return next;
+		if (cmp < 0) {
+			last =3D next;
+			continue;
+		}
+		first =3D next+1;
+	}
+
+	return -first-1;
+}
+
+static void free_file(struct dir *d, int pos, int topdown)
+{
+	struct file *f =3D d->files[pos];
+	free(f->name);
+	free(f);
+	if (!topdown) {
+		d->nr_files--;
+		memmove(d->files + pos, d->files + pos + 1,
+			(d->nr_files - pos) * sizeof(*d->files));
+		if (!d->nr_subdirs && !d->nr_files)
+			free_dir(d, topdown);
+	}
+}
+
+static struct dir *add_dir(struct dir *d,
+			   const char *path, const char *basename)
+{
+	struct dir *new;
+	int pos =3D get_dir_pos(d, basename);
+	if (pos >=3D 0)
+		return d->subdirs[pos];
+	pos =3D -pos-1;
+
+	new =3D create_dir(d, path, basename);
+	if (!new)
+		return NULL;
+
+	d->nr_subdirs++;
+	d->subdirs =3D xrealloc(d->subdirs, sizeof(*d->subdirs) * d->nr_subdi=
rs);
+	if (d->nr_subdirs > pos + 1)
+		memmove(d->subdirs + pos + 1, d->subdirs + pos,
+			(d->nr_subdirs - pos - 1) * sizeof(*d->subdirs));
+	d->subdirs[pos] =3D new;
+	return new;
+}
+
+static struct file *add_file(struct dir *d, const char *name)
+{
+	struct file *new;
+	int pos =3D get_file_pos(d, name);
+	if (pos >=3D 0)
+		return d->files[pos];
+	pos =3D -pos-1;
+
+	new =3D xmalloc(sizeof(*new));
+	memset(new, 0, sizeof(*new));
+	new->parent =3D d;
+	new->name =3D xstrdup(name);
+
+	d->nr_files++;
+	d->files =3D xrealloc(d->files, sizeof(*d->files) * d->nr_files);
+	if (d->nr_files > pos + 1)
+		memmove(d->files + pos + 1, d->files + pos,
+			(d->nr_files - pos - 1) * sizeof(*d->files));
+	d->files[pos] =3D new;
+	return new;
+}
=20
 static int watch_path(struct repository *repo, char *path)
 {
-	return -1;
+	struct dir *d =3D repo->root;
+	char *p =3D path;
+
+	if (!d) {
+		d =3D create_dir(NULL, ".", "");
+		if (!d)
+			return -1;
+		repo->root =3D d;
+		d->repo =3D repo;
+	}
+
+	for (;;) {
+		char *next, *sep;
+		sep =3D strchr(p, '/');
+		if (!sep) {
+			struct file *file;
+			file =3D add_file(d, p);
+			if (!file->repo)
+				file->repo =3D repo;
+			break;
+		}
+
+		next =3D sep + 1;
+		*sep =3D '\0';
+		d =3D add_dir(d, path, p);
+		if (!d)
+			/* we could free oldest watches and try again */
+			return -1;
+		*sep =3D '/';
+		p =3D next;
+	}
+	return 0;
 }
=20
 static void get_changed_list(int conn_id)
@@ -195,8 +407,15 @@ static struct repository *get_repo(const char *wor=
k_tree)
 	return repo;
 }
=20
+static void reset_watches(struct repository *repo)
+{
+	if (repo->root)
+		free_dir(repo->root, 1);
+}
+
 static void reset_repo(struct repository *repo, ino_t inode)
 {
+	reset_watches(repo);
 	string_list_clear(&repo->updated, 0);
 	memcpy(repo->index_signature, invalid_signature, 40);
 	repo->inode =3D inode;
@@ -497,6 +716,11 @@ int main(int argc, const char **argv)
=20
 	git_extract_argv0_path(argv[0]);
 	git_setup_gettext();
+
+	inotify_fd =3D inotify_init();
+	if (inotify_fd < 0)
+		die_errno("unable to initialize inotify");
+
 	argc =3D parse_options(argc, argv, NULL, options,
 			     file_watcher_usage, 0);
 	if (argc < 1)
--=20
1.8.5.2.240.g8478abd
