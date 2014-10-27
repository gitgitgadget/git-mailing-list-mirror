From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/19] untracked cache: record/validate dir mtime and reuse cached output
Date: Mon, 27 Oct 2014 19:10:33 +0700
Message-ID: <1414411846-4450-7-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8x-0002pZ-3O
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbaJ0MLT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55743 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbaJ0MLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:16 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx10so5292340pab.26
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GksEDahpz+HvvTen3cq5wMNFLtMg5gcEcHm+CJRkZXE=;
        b=I4/5CieNBP5TWwnjjeBmFeROlMfAPrb8qAX0iNLIc/oA6CZ4Fu7k5SO/RbP/1EYy7Y
         fFDumgK/nP5b+WPk1EB1Wh/3oQgiYy4V2/Sr1do/pF3VldsPB47YyQyjgUt+3X4sSLT3
         qtyGbALdx6m+GlRqSGgQyf3iNs2KjzFPkp4YZm5TSZ04uxdruRFCKyEqW63O8DVevD1C
         kvX/scEU1kFbU2YYpL3yLeIVzJcqXNoXFYJK0Hx8AwzeKckMEhz+ny8MD/dss1FnQXSe
         PjIeqAeE3qsxsYYj28SnzK189TEFefWSn97PRbQRbEGfnoPOdCL0lHGqGa+PfOsrWD3r
         m4vA==
X-Received: by 10.68.212.196 with SMTP id nm4mr12316282pbc.8.1414411876313;
        Mon, 27 Oct 2014 05:11:16 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id f2sm10799182pdo.29.2014.10.27.05.11.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:19 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main readdir loop in read_directory_recursive() is replaced with a
new one that checks if cached results of a directory is still valid.

If a file is added or removed from the index, the containing directory
is invalidated (but not its subdirs). If directory's mtime is changed,
the same happens. If a .gitignore is updated, the containing directory
and all subdirs are invalidated recursively. If dir_struct#flags or
other conditions change, the cache is ignored.

If a directory is invalidated, we opendir/readdir/closedir and run the
exclude machinery on that directory listing as usual. If untracked
cache is also enabled, we'll update the cache along the way. If a
directory is validated, we simply pull the untracked listing out from
the cache. The cache also records the list of direct subdirs that we
have to recurse in. Fully excluded directories are seen as "untracked
files".

In the best case when no dirs are invalidated, read_directory()
becomes a series of

  stat(dir), open(.gitignore), fstat(), read(), close() and optionally
  hash_sha1_file()

=46or comparison, standard read_directory() is a sequence of

  opendir(), readdir(), open(.gitignore), fstat(), read(), close(), the
  expensive last_exclude_matching() and closedir().

We already try not to open(.gitignore) if we know it does not exist,
so open/fstat/read/close sequence does not apply to every
directory. The sequence could be reduced further, as noted in
prep_exclude() in another patch. So in theory, the entire best-case
read_directory sequence could be reduced to a series of stat() and
nothing else.

This is not a silver bullet approach. When you compile a C file, for
example, the old .o file is removed and a new one with the same name
created, effectively invalidating the containing directory's cache
(but not its subdirectories). If your build process touches every
directory, this cache adds extra overhead for nothing, so it's a good
idea to separate generated files from tracked files.. Editors may use
the same strategy for saving files. And of course you're out of luck
running your repo on an unsupported filesytem and/or operating system.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 dir.h |   2 ++
 2 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 2793e57..55780a7 100644
--- a/dir.c
+++ b/dir.c
@@ -37,7 +37,12 @@ enum path_treatment {
 struct cached_dir {
 	DIR *fdir;
 	struct untracked_cache_dir *untracked;
+	int nr_files;
+	int nr_dirs;
+
 	struct dirent *de;
+	const char *file;
+	struct untracked_cache_dir *ucd;
 };
=20
 static enum path_treatment read_directory_recursive(struct dir_struct =
*dir,
@@ -606,6 +611,14 @@ static void invalidate_gitignore(struct untracked_=
cache *uc,
 	do_invalidate_gitignore(dir);
 }
=20
+static void invalidate_directory(struct untracked_cache *uc,
+				 struct untracked_cache_dir *dir)
+{
+	uc->dir_invalidated++;
+	dir->valid =3D 0;
+	dir->untracked_nr =3D 0;
+}
+
 /*
  * Given a file with name "fname", read it (either from disk, or from
  * the index if "check_index" is non-zero), parse it and store the
@@ -1418,6 +1431,41 @@ static enum path_treatment treat_one_path(struct=
 dir_struct *dir,
 	}
 }
=20
+static enum path_treatment treat_path_fast(struct dir_struct *dir,
+					   struct untracked_cache_dir *untracked,
+					   struct cached_dir *cdir,
+					   struct strbuf *path,
+					   int baselen,
+					   const struct path_simplify *simplify)
+{
+	if (!cdir->ucd) {
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, cdir->file);
+		return path_untracked;
+	}
+	strbuf_setlen(path, baselen);
+	strbuf_addstr(path, cdir->ucd->name);
+	/* treat_one_path() does this before it calls treat_directory() */
+	if (path->buf[path->len - 1] !=3D '/')
+		strbuf_addch(path, '/');
+	if (cdir->ucd->check_only)
+		/*
+		 * check_only is set as a result of treat_directory() getting
+		 * to its bottom. Verify again the same set of directories
+		 * with check_only set.
+		 */
+		return read_directory_recursive(dir, path->buf, path->len,
+
+						cdir->ucd, 1, simplify);
+	/*
+	 * We get path_recurse in the first run when
+	 * directory_exists_in_index() returns index_nonexistent. We
+	 * are sure that new changes in the index does not impact the
+	 * outcome. Return now.
+	 */
+	return path_recurse;
+}
+
 static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct untracked_cache_dir *untracked,
 				      struct cached_dir *cdir,
@@ -1428,6 +1476,9 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
 	int dtype;
 	struct dirent *de =3D cdir->de;
=20
+	if (!de)
+		return treat_path_fast(dir, untracked, cdir, path,
+				       baselen, simplify);
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
@@ -1448,6 +1499,52 @@ static void add_untracked(struct untracked_cache=
_dir *dir, const char *name)
 	dir->untracked[dir->untracked_nr++] =3D xstrdup(name);
 }
=20
+static int valid_cached_dir(struct dir_struct *dir,
+			    struct untracked_cache_dir *untracked,
+			    struct strbuf *path,
+			    int check_only)
+{
+	struct stat st;
+
+	if (!untracked)
+		return 0;
+
+	if (stat(path->len ? path->buf : ".", &st)) {
+		invalidate_directory(dir->untracked, untracked);
+		memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
+		return 0;
+	}
+	if (!untracked->valid ||
+	    match_stat_data(&untracked->stat_data, &st)) {
+		if (untracked->valid)
+			invalidate_directory(dir->untracked, untracked);
+		fill_stat_data(&untracked->stat_data, &st);
+		return 0;
+	}
+
+	if (untracked->check_only !=3D !!check_only) {
+		invalidate_directory(dir->untracked, untracked);
+		return 0;
+	}
+
+	/*
+	 * prep_exclude will be called eventually on this directory,
+	 * but it's called much later in last_exclude_matching(). We
+	 * need it now to determine the validity of the cache for this
+	 * path. The next calls will be nearly no-op, the way
+	 * prep_exclude() is designed.
+	 */
+	if (path->len && path->buf[path->len - 1] !=3D '/') {
+		strbuf_addch(path, '/');
+		prep_exclude(dir, path->buf, path->len);
+		strbuf_setlen(path, path->len - 1);
+	} else
+		prep_exclude(dir, path->buf, path->len);
+
+	/* hopefully prep_exclude() haven't invalidated this entry... */
+	return untracked->valid;
+}
+
 static int open_cached_dir(struct cached_dir *cdir,
 			   struct dir_struct *dir,
 			   struct untracked_cache_dir *untracked,
@@ -1456,7 +1553,11 @@ static int open_cached_dir(struct cached_dir *cd=
ir,
 {
 	memset(cdir, 0, sizeof(*cdir));
 	cdir->untracked =3D untracked;
+	if (valid_cached_dir(dir, untracked, path, check_only))
+		return 0;
 	cdir->fdir =3D opendir(path->len ? path->buf : ".");
+	if (dir->untracked)
+		dir->untracked->dir_opened++;
 	if (!cdir->fdir)
 		return -1;
 	return 0;
@@ -1470,6 +1571,18 @@ int read_cached_dir(struct cached_dir *cdir)
 			return -1;
 		return 0;
 	}
+	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
+		struct untracked_cache_dir *d =3D cdir->untracked->dirs[cdir->nr_dir=
s];
+		cdir->ucd =3D d;
+		cdir->nr_dirs++;
+		return 0;
+	}
+	cdir->ucd =3D NULL;
+	if (cdir->nr_files < cdir->untracked->untracked_nr) {
+		struct untracked_cache_dir *d =3D cdir->untracked;
+		cdir->file =3D d->untracked[cdir->nr_files++];
+		return 0;
+	}
 	return -1;
 }
=20
@@ -1477,6 +1590,12 @@ static void close_cached_dir(struct cached_dir *=
cdir)
 {
 	if (cdir->fdir)
 		closedir(cdir->fdir);
+	/*
+	 * We have gone through this directory and found no untracked
+	 * entries. Mark it valid.
+	 */
+	if (cdir->untracked && !cdir->untracked->valid)
+		cdir->untracked->valid =3D 1;
 }
=20
 /*
@@ -1530,7 +1649,7 @@ static enum path_treatment read_directory_recursi=
ve(struct dir_struct *dir,
 		if (check_only) {
 			/* abort early if maximum state has been reached */
 			if (dir_state =3D=3D path_untracked) {
-				if (untracked)
+				if (cdir.fdir)
 					add_untracked(untracked, path.buf + baselen);
 				break;
 			}
@@ -1554,7 +1673,7 @@ static enum path_treatment read_directory_recursi=
ve(struct dir_struct *dir,
 			if (dir->flags & DIR_SHOW_IGNORED)
 				break;
 			dir_add_name(dir, path.buf, path.len);
-			if (untracked)
+			if (cdir.fdir)
 				add_untracked(untracked, path.buf + baselen);
 			break;
=20
diff --git a/dir.h b/dir.h
index 35701b2..1fefd4e 100644
--- a/dir.h
+++ b/dir.h
@@ -134,6 +134,8 @@ struct untracked_cache {
 	/* Statistics */
 	int dir_created;
 	int gitignore_invalidated;
+	int dir_invalidated;
+	int dir_opened;
 };
=20
 struct dir_struct {
--=20
2.1.0.rc0.78.gc0d8480
