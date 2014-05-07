From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/20] untracked cache: initial untracked cache validation
Date: Wed,  7 May 2014 21:51:46 +0700
Message-ID: <1399474320-6840-7-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3D7-0005k2-5j
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbaEGOwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:36 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60880 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaEGOwf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:35 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so1157226pdi.37
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vsONgx3jsg49tZF2ILCr/uWupt51LSle5AoLMfWOruA=;
        b=MHn/+ZZDiNSstGHauF4WoNufncUUtvFgA3LyymZ4mxwmEkcj/pPsl9Edtjypzmsd27
         4gX28fr715EhJ+5muvDmMmKtTNEzW71hAaP5tgS0pCiOfuTvlzx4fA9OtY7yhixV3I9U
         khOnEA4uqhQd1IXOgepAP94/HiGHOn+GsEJQE8ZahE68Gi5qs/WloYvd7ELIvoPQcA3N
         nZFF+cRaja31hGsc1LzBdd+EAjzm3cNBzEy3iV3xwu1aK+XAEG4HVt+/1gLmFnPUrN41
         wudbe/cRtwivo+VGLK4pMLh36UPf/BwRtXsyp6Vw5clhGq/yt4B6ztaKmTiqrNl61cc2
         nt4Q==
X-Received: by 10.66.180.168 with SMTP id dp8mr13179668pac.100.1399474354291;
        Wed, 07 May 2014 07:52:34 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id io8sm3628324pbc.96.2014.05.07.07.52.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:34 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248312>

---
 dir.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 dir.h |   3 ++
 2 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 34a10b2..a198aa8 100644
--- a/dir.c
+++ b/dir.c
@@ -568,6 +568,22 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 	return d;
 }
 
+static void do_invalidate_gitignore(struct untracked_cache_dir *dir)
+{
+	int i;
+	dir->valid = 0;
+	dir->untracked_nr = 0;
+	for (i = 0; i < dir->dirs_nr; i++)
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
 static int add_excludes(const char *fname,
 			const char *base,
 			int baselen,
@@ -685,6 +701,13 @@ void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 			      const unsigned char *ref_sha1)
 {
 	struct exclude_list *el;
+	/*
+	 * catch setup_standard_excludes() that's called before
+	 * dir->untracked is assigned. That function behaves
+	 * differently when dir->untracked is non-NULL.
+	 */
+	if (!dir->untracked)
+		dir->unmanaged_exclude_files++;
 	el = add_exclude_list(dir, EXC_FILE, fname);
 	if (add_excludes(fname, "", 0, el, 0, sha1, ref_stat, ref_sha1) < 0)
 		die("cannot use %s as an exclude file", fname);
@@ -692,6 +715,7 @@ void add_excludes_from_file_1(struct dir_struct *dir, const char *fname,
 
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
+	dir->unmanaged_exclude_files++; /* see validate_untracked_cache() */
 	add_excludes_from_file_1(dir, fname, NULL, NULL, NULL);
 }
 
@@ -1570,9 +1594,89 @@ static int treat_leading_path(struct dir_struct *dir,
 	return rc;
 }
 
+static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
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
+	if (dir->flags != dir->untracked->dir_flags ||
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
+	if (dir->exclude_per_dir != dir->untracked->exclude_per_dir &&
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
+		const int len = sizeof(*dir->untracked->root);
+		dir->untracked->root = xmalloc(len);
+		memset(dir->untracked->root, 0, len);
+	}
+
+	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
+	root = dir->untracked->root;
+	if (hashcmp(dir->info_exclude_sha1,
+		    dir->untracked->info_exclude_sha1)) {
+		invalidate_gitignore(dir->untracked, root);
+		hashcpy(dir->untracked->info_exclude_sha1,
+			dir->info_exclude_sha1);
+	}
+	if (hashcmp(dir->excludes_file_sha1,
+		    dir->untracked->excludes_file_sha1)) {
+		invalidate_gitignore(dir->untracked, root);
+		hashcpy(dir->untracked->excludes_file_sha1,
+			dir->excludes_file_sha1);
+	}
+	return root;
+}
+
 int read_directory(struct dir_struct *dir, const char *path, int len, const struct pathspec *pathspec)
 {
 	struct path_simplify *simplify;
+	struct untracked_cache_dir *untracked;
 
 	/*
 	 * Check out create_simplify()
@@ -1596,10 +1700,15 @@ int read_directory(struct dir_struct *dir, const char *path, int len, const stru
 	 * create_simplify().
 	 */
 	simplify = create_simplify(pathspec ? pathspec->_raw : NULL);
+	untracked = validate_untracked_cache(dir, len, pathspec);
+	if (!untracked)
+		/*
+		 * make sure untracked cache code path is disabled,
+		 * e.g. prep_exclude()
+		 */
+		dir->untracked = NULL;
 	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len,
-					 dir->untracked ? dir->untracked->root : NULL,
-					 0, simplify);
+		read_directory_recursive(dir, path, len, untracked, 0, simplify);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_name);
diff --git a/dir.h b/dir.h
index bce7055..ded251e 100644
--- a/dir.h
+++ b/dir.h
@@ -109,6 +109,7 @@ struct untracked_cache_dir {
 	unsigned char exclude_sha1[20];
 	struct stat_data stat_data;
 	unsigned int check_only : 1;
+	unsigned int valid : 1;
 	unsigned int untracked_nr : 29;
 	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
 	char name[1];
@@ -128,6 +129,7 @@ struct untracked_cache {
 	struct untracked_cache_dir *root;
 	/* Statistics */
 	int dir_created;
+	int gitignore_invalidated;
 };
 
 struct dir_struct {
@@ -180,6 +182,7 @@ struct dir_struct {
 
 	/* Enable untracked file cache if set */
 	struct untracked_cache *untracked;
+	unsigned unmanaged_exclude_files;
 	struct stat_data info_exclude_stat;
 	struct stat_data excludes_file_stat;
 	unsigned char info_exclude_sha1[20];
-- 
1.9.1.346.ga2b5940
