From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/19] untracked cache: initial untracked cache validation
Date: Mon, 27 Oct 2014 19:10:30 +0700
Message-ID: <1414411846-4450-4-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8d-0002br-UC
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbaJ0MLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:03 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59333 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbaJ0MLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:01 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so5544467pde.18
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HBntc9nhgrRE/R6VxvkKqisbNtyVUMKawCAQxBYlJe0=;
        b=oF1i6g+/+v4zlMNRWgdeZNw6DWfebyqqT3IXvNCppi04AHn9mrcUvAcUYZWE6gMRZD
         jC3hk/LDVCqcfFUdwiH+v3iG8ooYx5IGQZRDGdT+LrNYDyijRENnP9FKIu6hkez/dGfZ
         5juwCfo9cRg6BPjhJN8skyoGU/kBcDZVyUCO898e/WIhr1CxmxZXknVAtd/Z6DgDjCcl
         4bqrGIsR6MhxcXWsFG3i9J40ye3DazszBvokgdOrKmllePhp+ui+zIDOO7o5R5hUUrC4
         qrNkRKq/s6fyvW5tV04c7+ed6cQ7aeivadNZs7eUUobZSRj4VkmeM4ES0bh4lc35WgnX
         3SlA==
X-Received: by 10.66.141.142 with SMTP id ro14mr23503833pab.111.1414411860997;
        Mon, 27 Oct 2014 05:11:00 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id uh2sm10732097pbc.86.2014.10.27.05.10.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:04 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure the starting conditions and all global exclude files are
good to go. If not, either disable untracked cache completely, or wipe
out the cache and start fresh.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 dir.h |   4 +++
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 25d8c5d..5161f74 100644
--- a/dir.c
+++ b/dir.c
@@ -581,6 +581,22 @@ static struct untracked_cache_dir *lookup_untracke=
d(struct untracked_cache *uc,
 	return d;
 }
=20
+static void do_invalidate_gitignore(struct untracked_cache_dir *dir)
+{
+	int i;
+	dir->valid =3D 0;
+	dir->untracked_nr =3D 0;
+	for (i =3D 0; i < dir->dirs_nr; i++)
+		do_invalidate_gitignore(dir->dirs[i]);
+}
+
+static void invalidate_gitignore(struct untracked_cache *uc,
+				 struct untracked_cache_dir *dir)
+{
+	uc->gitignore_invalidated++;
+	do_invalidate_gitignore(dir);
+}
+
 /*
  * Given a file with name "fname", read it (either from disk, or from
  * the index if "check_index" is non-zero), parse it and store the
@@ -693,6 +709,13 @@ static void add_excludes_from_file_1(struct dir_st=
ruct *dir, const char *fname,
 				     struct sha1_stat *ss, int ss_valid)
 {
 	struct exclude_list *el;
+	/*
+	 * catch setup_standard_excludes() that's called before
+	 * dir->untracked is assigned. That function behaves
+	 * differently when dir->untracked is non-NULL.
+	 */
+	if (!dir->untracked)
+		dir->unmanaged_exclude_files++;
 	el =3D add_exclude_list(dir, EXC_FILE, fname);
 	if (add_excludes(fname, "", 0, el, 0, ss, ss_valid) < 0)
 		die("cannot use %s as an exclude file", fname);
@@ -700,6 +723,7 @@ static void add_excludes_from_file_1(struct dir_str=
uct *dir, const char *fname,
=20
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
+	dir->unmanaged_exclude_files++; /* see validate_untracked_cache() */
 	add_excludes_from_file_1(dir, fname, NULL, 0);
 }
=20
@@ -1567,9 +1591,87 @@ static int treat_leading_path(struct dir_struct =
*dir,
 	return rc;
 }
=20
+static struct untracked_cache_dir *validate_untracked_cache(struct dir=
_struct *dir,
+						      int base_len,
+						      const struct pathspec *pathspec)
+{
+	struct untracked_cache_dir *root;
+
+	if (!dir->untracked)
+		return NULL;
+
+	/*
+	 * We only support $GIT_DIR/info/exclude and core.excludesfile
+	 * as the global ignore rule files. Any other additions
+	 * (e.g. from command line) invalidate the cache. This
+	 * condition also catches running setup_standard_excludes()
+	 * before setting dir->untracked!
+	 */
+	if (dir->unmanaged_exclude_files)
+		return NULL;
+
+	/*
+	 * Optimize for the main use case only: whole-tree git
+	 * status. More work involved in treat_leading_path() if we
+	 * use cache on just a subset of the worktree. pathspec
+	 * support could make the matter even worse.
+	 */
+	if (base_len || (pathspec && pathspec->nr))
+		return NULL;
+
+	/* Different set of flags may produce different results */
+	if (dir->flags !=3D dir->untracked->dir_flags ||
+	    /*
+	     * See treat_directory(), case index_nonexistent. Without
+	     * this flag, we may need to also cache .git file content
+	     * for the resolve_gitlink_ref() call, which we don't.
+	     */
+	    !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||
+	    /* We don't support collecting ignore files */
+	    (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
+			   DIR_COLLECT_IGNORED)))
+		return NULL;
+
+	/*
+	 * If we use .gitignore in the cache and now you change it to
+	 * .gitexclude, everything will go wrong.
+	 */
+	if (dir->exclude_per_dir !=3D dir->untracked->exclude_per_dir &&
+	    strcmp(dir->exclude_per_dir, dir->untracked->exclude_per_dir))
+		return NULL;
+
+	/*
+	 * EXC_CMDL is not considered in the cache. If people set it,
+	 * skip the cache.
+	 */
+	if (dir->exclude_list_group[EXC_CMDL].nr)
+		return NULL;
+
+	if (!dir->untracked->root) {
+		const int len =3D sizeof(*dir->untracked->root);
+		dir->untracked->root =3D xmalloc(len);
+		memset(dir->untracked->root, 0, len);
+	}
+
+	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
+	root =3D dir->untracked->root;
+	if (hashcmp(dir->ss_info_exclude.sha1,
+		    dir->untracked->ss_info_exclude.sha1)) {
+		invalidate_gitignore(dir->untracked, root);
+		dir->untracked->ss_info_exclude =3D dir->ss_info_exclude;
+	}
+	if (hashcmp(dir->ss_excludes_file.sha1,
+		    dir->untracked->ss_excludes_file.sha1)) {
+		invalidate_gitignore(dir->untracked, root);
+		dir->untracked->ss_excludes_file =3D dir->ss_excludes_file;
+	}
+	return root;
+}
+
 int read_directory(struct dir_struct *dir, const char *path, int len, =
const struct pathspec *pathspec)
 {
 	struct path_simplify *simplify;
+	struct untracked_cache_dir *untracked;
=20
 	/*
 	 * Check out create_simplify()
@@ -1593,10 +1695,15 @@ int read_directory(struct dir_struct *dir, cons=
t char *path, int len, const stru
 	 * create_simplify().
 	 */
 	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
+	untracked =3D validate_untracked_cache(dir, len, pathspec);
+	if (!untracked)
+		/*
+		 * make sure untracked cache code path is disabled,
+		 * e.g. prep_exclude()
+		 */
+		dir->untracked =3D NULL;
 	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len,
-					 dir->untracked ? dir->untracked->root : NULL,
-					 0, simplify);
+		read_directory_recursive(dir, path, len, untracked, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
diff --git a/dir.h b/dir.h
index f282501..35701b2 100644
--- a/dir.h
+++ b/dir.h
@@ -114,6 +114,8 @@ struct untracked_cache_dir {
 	unsigned char exclude_sha1[20];
 	struct stat_data stat_data;
 	unsigned int check_only : 1;
+	/* all data in this struct are good */
+	unsigned int valid : 1;
 	unsigned int untracked_nr : 29;
 	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
 	char name[1];
@@ -131,6 +133,7 @@ struct untracked_cache {
 	struct untracked_cache_dir *root;
 	/* Statistics */
 	int dir_created;
+	int gitignore_invalidated;
 };
=20
 struct dir_struct {
@@ -185,6 +188,7 @@ struct dir_struct {
 	struct untracked_cache *untracked;
 	struct sha1_stat ss_info_exclude;
 	struct sha1_stat ss_excludes_file;
+	unsigned unmanaged_exclude_files;
 };
=20
 /*
--=20
2.1.0.rc0.78.gc0d8480
