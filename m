From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/22] untracked cache: initial untracked cache validation
Date: Sat,  8 Nov 2014 16:39:36 +0700
Message-ID: <1415439595-469-4-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
 <1415439595-469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 10:40:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn2VB-0000Ri-Rz
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 10:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbaKHJkJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2014 04:40:09 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36339 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbaKHJkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 04:40:05 -0500
Received: by mail-pd0-f175.google.com with SMTP id y13so4777753pdi.6
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 01:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NijfmjrDlG65Xre2Kpm04MbcCmvi0u28QXwslO8+/ew=;
        b=va4nNuEoACjvowK/ncMfW0BgGbXpBRwu64nTRz7ib9QsUJlfL5hjm/IG3ulBsL5l8+
         UjYL9Ha2yoHKNEHPEKHj0oHoaBZALA4BIo5rV755WTKMElHsTQqvCADrurWV0+9eLIb9
         V6S6/jzMdjMrkgr8iLUaM25kz+katwNyumMvQJQHscVF27tz7KtTUat7dDr24Bj75vwd
         GB3LSkJKwHXZlB2q0FOMRT8oc1J1EJhj11BafROPz+uk3jxX6+Pkf8oOogth52w2++uJ
         rkB4KnKcdCIhd9xs6waXinhatbpl+SJnrunBLLUnDTv1rYtxv6ZY+rhX9SuVasx7BW51
         q0Zg==
X-Received: by 10.68.68.141 with SMTP id w13mr18305303pbt.82.1415439604879;
        Sat, 08 Nov 2014 01:40:04 -0800 (PST)
Received: from lanh ([115.73.197.54])
        by mx.google.com with ESMTPSA id ft12sm11018848pdb.43.2014.11.08.01.40.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Nov 2014 01:40:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Nov 2014 16:40:18 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1415439595-469-1-git-send-email-pclouds@gmail.com>
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
index 19f4b1e..4f4f302 100644
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
@@ -696,6 +712,13 @@ static void add_excludes_from_file_1(struct dir_st=
ruct *dir, const char *fname,
 				     struct sha1_stat *sha1_stat)
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
 	if (add_excludes(fname, "", 0, el, 0, sha1_stat) < 0)
 		die("cannot use %s as an exclude file", fname);
@@ -703,6 +726,7 @@ static void add_excludes_from_file_1(struct dir_str=
uct *dir, const char *fname,
=20
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
+	dir->unmanaged_exclude_files++; /* see validate_untracked_cache() */
 	add_excludes_from_file_1(dir, fname, NULL);
 }
=20
@@ -1571,9 +1595,87 @@ static int treat_leading_path(struct dir_struct =
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
@@ -1597,10 +1699,15 @@ int read_directory(struct dir_struct *dir, cons=
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
index 278c464..bd51948 100644
--- a/dir.h
+++ b/dir.h
@@ -115,6 +115,8 @@ struct untracked_cache_dir {
 	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
 	unsigned int untracked_nr;
 	unsigned int check_only : 1;
+	/* all data in this struct are good */
+	unsigned int valid : 1;
 	/* null SHA-1 means this directory does not have .gitignore */
 	unsigned char exclude_sha1[20];
 	char name[1];
@@ -132,6 +134,7 @@ struct untracked_cache {
 	struct untracked_cache_dir *root;
 	/* Statistics */
 	int dir_created;
+	int gitignore_invalidated;
 };
=20
 struct dir_struct {
@@ -186,6 +189,7 @@ struct dir_struct {
 	struct untracked_cache *untracked;
 	struct sha1_stat ss_info_exclude;
 	struct sha1_stat ss_excludes_file;
+	unsigned unmanaged_exclude_files;
 };
=20
 /*
--=20
2.1.0.rc0.78.gc0d8480
