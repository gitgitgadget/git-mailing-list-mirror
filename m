From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/24] untracked cache: record/validate dir mtime and reuse cached output
Date: Sun,  8 Feb 2015 15:55:30 +0700
Message-ID: <1423385748-19825-7-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:56:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNfM-0002cL-I0
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbbBHI42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:56:28 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:60842 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbbBHI40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:56:26 -0500
Received: by mail-pa0-f52.google.com with SMTP id ey11so2674815pad.11
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5DiucH8oExwpooXlPM2Jycn8o1XDkQDOKKDC3lZLNEc=;
        b=bcKiuISojS0xEkYWyWX3w0MbGIX5iYG3ncVx5WTMJeuQYjvtZAO92/tn79eHI2avGN
         R9F1cOJShsxAREAASHNu/UPZBgTWNengSznRxHDHJpHZ+KDD/Gcyb6DPucSjG43u5aSR
         /IGZpDhFf5N0nkARlWYs3jals+hqJqCVPkAtHZ1JNCD13wblLW8YTcwY95mK7+bAl84B
         HS74sGdO6dxmZ42u2pXKcmymgGrhzmPKM+UIlLAIZj/MhH61J6V46ZmaaXLzSYp3UMQD
         DGUVSceeWm4ukUduFOa8nByHgHto74zU/oooi3LxWX7Um6Td0efbrL0/HCwIoqwcf2B2
         uWsA==
X-Received: by 10.70.133.200 with SMTP id pe8mr19258981pdb.89.1423385786028;
        Sun, 08 Feb 2015 00:56:26 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id r7sm12921684pdn.87.2015.02.08.00.56.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:56:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:56:33 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263469>

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
running your repo on an unsupported filesystem and/or operating system.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 dir.h |   2 ++
 2 files changed, 121 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index fb6ed86..8c989e3 100644
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
@@ -607,6 +612,14 @@ static void invalidate_gitignore(struct untracked_=
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
@@ -1424,6 +1437,39 @@ static enum path_treatment treat_one_path(struct=
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
+	strbuf_setlen(path, baselen);
+	if (!cdir->ucd) {
+		strbuf_addstr(path, cdir->file);
+		return path_untracked;
+	}
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
@@ -1434,6 +1480,9 @@ static enum path_treatment treat_path(struct dir_=
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
@@ -1454,6 +1503,52 @@ static void add_untracked(struct untracked_cache=
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
@@ -1462,7 +1557,11 @@ static int open_cached_dir(struct cached_dir *cd=
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
@@ -1476,6 +1575,18 @@ static int read_cached_dir(struct cached_dir *cd=
ir)
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
@@ -1483,6 +1594,12 @@ static void close_cached_dir(struct cached_dir *=
cdir)
 {
 	if (cdir->fdir)
 		closedir(cdir->fdir);
+	/*
+	 * We have gone through this directory and found no untracked
+	 * entries. Mark it valid.
+	 */
+	if (cdir->untracked)
+		cdir->untracked->valid =3D 1;
 }
=20
 /*
@@ -1536,7 +1653,7 @@ static enum path_treatment read_directory_recursi=
ve(struct dir_struct *dir,
 		if (check_only) {
 			/* abort early if maximum state has been reached */
 			if (dir_state =3D=3D path_untracked) {
-				if (untracked)
+				if (cdir.fdir)
 					add_untracked(untracked, path.buf + baselen);
 				break;
 			}
@@ -1560,7 +1677,7 @@ static enum path_treatment read_directory_recursi=
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
index 1d7a958..ff3d99b 100644
--- a/dir.h
+++ b/dir.h
@@ -135,6 +135,8 @@ struct untracked_cache {
 	/* Statistics */
 	int dir_created;
 	int gitignore_invalidated;
+	int dir_invalidated;
+	int dir_opened;
 };
=20
 struct dir_struct {
--=20
2.3.0.rc1.137.g477eb31
