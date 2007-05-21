From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] rename dirlink to gitlink.
Date: Mon, 21 May 2007 22:08:28 +0200
Message-ID: <20070521200828.GC5412@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Weqbz6OltVu8XOAh"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 22:08:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqEBT-0003bD-Fg
	for gcvg-git@gmane.org; Mon, 21 May 2007 22:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759220AbXEUUIc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 16:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759560AbXEUUIc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 16:08:32 -0400
Received: from mail.admingilde.org ([213.95.32.147]:33797 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759220AbXEUUIa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 16:08:30 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HqEBA-0008AL-Jc; Mon, 21 May 2007 22:08:28 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48048>


--Weqbz6OltVu8XOAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Unify naming of plumbing dirlink/gitlink concept:

perl -pi -e 's/dirlink/gitlink/g' -e 's/DIRLNK/GITLINK/g'
---
 archive-tar.c          |    4 ++--
 archive-zip.c          |    2 +-
 builtin-fsck.c         |    4 ++--
 builtin-ls-tree.c      |    2 +-
 builtin-update-index.c |    4 ++--
 cache-tree.c           |    2 +-
 cache.h                |   10 +++++-----
 diff.c                 |    2 +-
 dir.c                  |    6 +++---
 dir.h                  |    2 +-
 entry.c                |    4 ++--
 list-objects.c         |    2 +-
 read-cache.c           |    6 +++---
 tree.c                 |    4 ++--
 14 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 33e7657..66fe3e3 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -167,7 +167,7 @@ static void write_entry(const unsigned char *sha1, stru=
ct strbuf *path,
 	} else {
 		if (verbose)
 			fprintf(stderr, "%.*s\n", path->len, path->buf);
-		if (S_ISDIR(mode) || S_ISDIRLNK(mode)) {
+		if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 			*header.typeflag =3D TYPEFLAG_DIR;
 			mode =3D (mode | 0777) & ~tar_umask;
 		} else if (S_ISLNK(mode)) {
@@ -280,7 +280,7 @@ static int write_tar_entry(const unsigned char *sha1,
 	memcpy(path.buf + baselen, filename, filenamelen);
 	path.len =3D baselen + filenamelen;
 	path.buf[path.len] =3D '\0';
-	if (S_ISDIR(mode) || S_ISDIRLNK(mode)) {
+	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		strbuf_append_string(&path, "/");
 		buffer =3D NULL;
 		size =3D 0;
diff --git a/archive-zip.c b/archive-zip.c
index 3cbf6bb..444e162 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -182,7 +182,7 @@ static int write_zip_entry(const unsigned char *sha1,
 		goto out;
 	}
=20
-	if (S_ISDIR(mode) || S_ISDIRLNK(mode)) {
+	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		method =3D 0;
 		attr2 =3D 16;
 		result =3D (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 44ce629..cbbcaf0 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -256,7 +256,7 @@ static int fsck_tree(struct tree *item)
 		case S_IFREG | 0644:
 		case S_IFLNK:
 		case S_IFDIR:
-		case S_IFDIRLNK:
+		case S_IFGITLINK:
 			break;
 		/*
 		 * This is nonstandard, but we had a few of these
@@ -715,7 +715,7 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			struct object *obj;
=20
 			mode =3D ntohl(active_cache[i]->ce_mode);
-			if (S_ISDIRLNK(mode))
+			if (S_ISGITLINK(mode))
 				continue;
 			blob =3D lookup_blob(active_cache[i]->sha1);
 			if (!blob)
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 1cb4dca..9a5977f 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -60,7 +60,7 @@ static int show_tree(const unsigned char *sha1, const cha=
r *base, int baselen,
 	int retval =3D 0;
 	const char *type =3D blob_type;
=20
-	if (S_ISDIRLNK(mode)) {
+	if (S_ISGITLINK(mode)) {
 		/*
 		 * Maybe we want to have some recursive version here?
 		 *
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 8f98991..509369e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -134,7 +134,7 @@ static int process_directory(const char *path, int len,=
 struct stat *st)
 	/* Exact match: file or existing gitlink */
 	if (pos >=3D 0) {
 		struct cache_entry *ce =3D active_cache[pos];
-		if (S_ISDIRLNK(ntohl(ce->ce_mode))) {
+		if (S_ISGITLINK(ntohl(ce->ce_mode))) {
=20
 			/* Do nothing to the index if there is no HEAD! */
 			if (resolve_gitlink_ref(path, "HEAD", sha1) < 0)
@@ -178,7 +178,7 @@ static int process_file(const char *path, int len, stru=
ct stat *st)
 	int pos =3D cache_name_pos(path, len);
 	struct cache_entry *ce =3D pos < 0 ? NULL : active_cache[pos];
=20
-	if (ce && S_ISDIRLNK(ntohl(ce->ce_mode)))
+	if (ce && S_ISGITLINK(ntohl(ce->ce_mode)))
 		return error("%s is already a gitlink, not replacing", path);
=20
 	return add_one_path(ce, path, len, st);
diff --git a/cache-tree.c b/cache-tree.c
index 6369cc7..350a79b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -326,7 +326,7 @@ static int update_one(struct cache_tree *it,
 			mode =3D ntohl(ce->ce_mode);
 			entlen =3D pathlen - baselen;
 		}
-		if (mode !=3D S_IFDIRLNK && !missing_ok && !has_sha1_file(sha1))
+		if (mode !=3D S_IFGITLINK && !missing_ok && !has_sha1_file(sha1))
 			return error("invalid object %s", sha1_to_hex(sha1));
=20
 		if (!ce->ce_mode)
diff --git a/cache.h b/cache.h
index 4204bc1..2497c21 100644
--- a/cache.h
+++ b/cache.h
@@ -40,8 +40,8 @@
  * happens that everybody shares the same bit representation
  * in the UNIX world (and apparently wider too..)
  */
-#define S_IFDIRLNK	0160000
-#define S_ISDIRLNK(m)	(((m) & S_IFMT) =3D=3D S_IFDIRLNK)
+#define S_IFGITLINK	0160000
+#define S_ISGITLINK(m)	(((m) & S_IFMT) =3D=3D S_IFGITLINK)
=20
 /*
  * Intensive research over the course of many years has shown that
@@ -123,8 +123,8 @@ static inline unsigned int create_ce_mode(unsigned int =
mode)
 {
 	if (S_ISLNK(mode))
 		return htonl(S_IFLNK);
-	if (S_ISDIR(mode) || S_ISDIRLNK(mode))
-		return htonl(S_IFDIRLNK);
+	if (S_ISDIR(mode) || S_ISGITLINK(mode))
+		return htonl(S_IFGITLINK);
 	return htonl(S_IFREG | ce_permissions(mode));
 }
 static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsig=
ned int mode)
@@ -142,7 +142,7 @@ static inline unsigned int ce_mode_from_stat(struct cac=
he_entry *ce, unsigned in
 }
 #define canon_mode(mode) \
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
-	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFDIRLNK)
+	S_ISLNK(mode) ? S_IFLNK : S_ISDIR(mode) ? S_IFDIR : S_IFGITLINK)
=20
 #define cache_entry_size(len) ((offsetof(struct cache_entry,name) + (len) =
+ 8) & ~7)
=20
diff --git a/diff.c b/diff.c
index 33297aa..9a5e980 100644
--- a/diff.c
+++ b/diff.c
@@ -1467,7 +1467,7 @@ int diff_populate_filespec(struct diff_filespec *s, i=
nt size_only)
 	if (size_only && 0 < s->size)
 		return 0;
=20
-	if (S_ISDIRLNK(s->mode))
+	if (S_ISGITLINK(s->mode))
 		return diff_populate_gitlink(s, size_only);
=20
 	if (!s->sha1_valid ||
diff --git a/dir.c b/dir.c
index 11fab7f..f543f50 100644
--- a/dir.c
+++ b/dir.c
@@ -321,7 +321,7 @@ static enum exist_status directory_exists_in_index(cons=
t char *dirname, int len)
 			break;
 		if (endchar =3D=3D '/')
 			return index_directory;
-		if (!endchar && S_ISDIRLNK(ntohl(ce->ce_mode)))
+		if (!endchar && S_ISGITLINK(ntohl(ce->ce_mode)))
 			return index_gitdir;
 	}
 	return index_nonexistent;
@@ -356,7 +356,7 @@ static enum exist_status directory_exists_in_index(cons=
t char *dirname, int len)
  *      also true and the directory is empty, in which case
  *      we just ignore it entirely.
  *  (b) if it looks like a git directory, and we don't have
- *      'no_dirlinks' set we treat it as a gitlink, and show it
+ *      'no_gitlinks' set we treat it as a gitlink, and show it
  *      as a directory.
  *  (c) otherwise, we recurse into it.
  */
@@ -383,7 +383,7 @@ static enum directory_treatment treat_directory(struct =
dir_struct *dir,
 	case index_nonexistent:
 		if (dir->show_other_directories)
 			break;
-		if (!dir->no_dirlinks) {
+		if (!dir->no_gitlinks) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) =3D=3D 0)
 				return show_directory;
diff --git a/dir.h b/dir.h
index 817c674..172147f 100644
--- a/dir.h
+++ b/dir.h
@@ -34,7 +34,7 @@ struct dir_struct {
 	unsigned int show_ignored:1,
 		     show_other_directories:1,
 		     hide_empty_directories:1,
-		     no_dirlinks:1;
+		     no_gitlinks:1;
 	struct dir_entry **entries;
=20
 	/* Exclude info */
diff --git a/entry.c b/entry.c
index 82bf725..ae64764 100644
--- a/entry.c
+++ b/entry.c
@@ -145,7 +145,7 @@ static int write_entry(struct cache_entry *ce, char *pa=
th, const struct checkout
 						 "symlink %s (%s)", path, strerror(errno));
 		}
 		break;
-	case S_IFDIRLNK:
+	case S_IFGITLINK:
 		if (to_tempfile)
 			return error("git-checkout-index: cannot create temporary subproject %s=
", path);
 		if (mkdir(path, 0777) < 0)
@@ -194,7 +194,7 @@ int checkout_entry(struct cache_entry *ce, const struct=
 checkout *state, char *t
 		unlink(path);
 		if (S_ISDIR(st.st_mode)) {
 			/* If it is a gitlink, leave it alone! */
-			if (S_ISDIRLNK(ntohl(ce->ce_mode)))
+			if (S_ISGITLINK(ntohl(ce->ce_mode)))
 				return 0;
 			if (!state->force)
 				return error("%s is a directory", path);
diff --git a/list-objects.c b/list-objects.c
index 310f8d3..e5c88c2 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -87,7 +87,7 @@ static void process_tree(struct rev_info *revs,
 			process_tree(revs,
 				     lookup_tree(entry.sha1),
 				     p, &me, entry.path);
-		else if (S_ISDIRLNK(entry.mode))
+		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(revs, entry.sha1,
 					p, &me, entry.path);
 		else
diff --git a/read-cache.c b/read-cache.c
index d9f46da..ad4e187 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -92,7 +92,7 @@ static int ce_compare_gitlink(struct cache_entry *ce)
=20
 	/*
 	 * We don't actually require that the .git directory
-	 * under DIRLNK directory be a valid git directory. It
+	 * under GITLINK directory be a valid git directory. It
 	 * might even be missing (in case nobody populated that
 	 * sub-project).
 	 *
@@ -115,7 +115,7 @@ static int ce_modified_check_fs(struct cache_entry *ce,=
 struct stat *st)
 			return DATA_CHANGED;
 		break;
 	case S_IFDIR:
-		if (S_ISDIRLNK(ntohl(ce->ce_mode)))
+		if (S_ISGITLINK(ntohl(ce->ce_mode)))
 			return 0;
 	default:
 		return TYPE_CHANGED;
@@ -142,7 +142,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, =
struct stat *st)
 		    (has_symlinks || !S_ISREG(st->st_mode)))
 			changed |=3D TYPE_CHANGED;
 		break;
-	case S_IFDIRLNK:
+	case S_IFGITLINK:
 		if (!S_ISDIR(st->st_mode))
 			changed |=3D TYPE_CHANGED;
 		else if (ce_compare_gitlink(ce))
diff --git a/tree.c b/tree.c
index e4a39aa..a372827 100644
--- a/tree.c
+++ b/tree.c
@@ -157,7 +157,7 @@ static void track_tree_refs(struct tree *item)
 	/* Count how many entries there are.. */
 	init_tree_desc(&desc, item->buffer, item->size);
 	while (tree_entry(&desc, &entry)) {
-		if (S_ISDIRLNK(entry.mode))
+		if (S_ISGITLINK(entry.mode))
 			continue;
 		n_refs++;
 	}
@@ -169,7 +169,7 @@ static void track_tree_refs(struct tree *item)
 	while (tree_entry(&desc, &entry)) {
 		struct object *obj;
=20
-		if (S_ISDIRLNK(entry.mode))
+		if (S_ISGITLINK(entry.mode))
 			continue;
 		if (S_ISDIR(entry.mode))
 			obj =3D &lookup_tree(entry.sha1)->object;
--=20
1.5.2.2.g081e

--=20
Martin Waitz

--Weqbz6OltVu8XOAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUfw8j/Eaxd/oD7IRAoekAJ4/t43cwXlqie7uWfhaIYk1/5cfSgCdFa2N
Fmg4OpRODHZZ7MBk38oJl+0=
=rUg8
-----END PGP SIGNATURE-----

--Weqbz6OltVu8XOAh--
