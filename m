Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6064DC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353228AbiETT3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353214AbiETT3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:29:17 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2E18C046
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y20so7603119qvx.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S08q/J6OW42mwSXRcD0DloCppAN8Urxp3qBTLhdJi3E=;
        b=Ch07UJd28zr0nKTRNpoYii2sH/Oy4j2yCJmi7OgVrwxOQ7Yj7vfknRdri9hYQCHiFR
         HsYqqE32mDImhGXGb5qDSgDkQpSQGvfKK+jgIcU/JXjwkdOb4OXKNon1PyTxrqfJ6NH4
         B3eXM38Wqeeq0BPSU76LcvV/d0T2HdEohk2HTqSqcslCO87iHpSzeErCobYSh1JXIlyp
         9YZ5VFjq/4z5gOmfhrRb7Jmq9u0JnoD2zRjOgqHg6mJ6zXchMhykqCA4EgGWH0XB4n8Z
         A+zTN0oMRstSjyw1ZR4botn/DZaKNMQ6VyAV37xNeFBuEKOhRWInwVeuounJfgRe/4WT
         8bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S08q/J6OW42mwSXRcD0DloCppAN8Urxp3qBTLhdJi3E=;
        b=NE4j3EuJubMZgaFoCrS8e9Nd5HlLqNHHpQVOAmOOokfNxcSBEuMNTEAANWs0J+rVcr
         aHtTUCHqnni1PechE/Zj1nfPr8+LH7K6GcXAAkMC9Jhg5jcWa+XAhyV7zdGq6w2yrH64
         mK9xiyAqE+Zys0IRlScF/AInGRHR4PwYmw0WYajTW2XFru4txbAT2SLf5bUcM7G6w2SS
         Agn+Ov6Lxcn7QfcM6vHtORD/abhXi3UJFGpu5mnBxf7IQvNXw4JsHlS3/pQowD3BaA82
         yBlRQc0/iCeP7ifUgPKWqhdZw2XAbIJt7g2KRz1xhqLm//LOJa9UJ6hRafjGfCQn1D1X
         5ReQ==
X-Gm-Message-State: AOAM533cCyl3PuhlXkkhsRZIU7epEg8r7pDG//5qrWffkXr6a2lLxN30
        JZsD7m8lLwRIsyj9Id7kzd2p+w++eDKCYA==
X-Google-Smtp-Source: ABdhPJxbZlpRZrMBlxUw0TrNGfT7rda5wWFGw3uVDP72fgaOS2Bd9G8vpwniiMRG0FpgEhgT8aPBsw==
X-Received: by 2002:a05:6214:2301:b0:435:38af:2f87 with SMTP id gc1-20020a056214230100b0043538af2f87mr9335245qvb.83.1653074955419;
        Fri, 20 May 2022 12:29:15 -0700 (PDT)
Received: from localhost.localdomain ([108.29.205.134])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b006a059f1d8b8sm142379qkf.124.2022.05.20.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:29:15 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 2/3] dir: cache git_dir's realpath
Date:   Fri, 20 May 2022 19:28:39 +0000
Message-Id: <20220520192840.8942-3-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520192840.8942-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220520192840.8942-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When traversing the directory tree, the realpath of the `git_dir` is
required each time a nested repository is encountered to determine how
the nested repository should be treated.  To prevent excessive resource
usage in pathological cases (e.g. many nested repositories, a long path,
symlinks, etc.), cache the realpath after the first usage until the
traversal is complete.
---
 dir.c | 63 ++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index e45e117875..45b89560fc 100644
--- a/dir.c
+++ b/dir.c
@@ -47,10 +47,22 @@ struct cached_dir {
 	struct untracked_cache_dir *ucd;
 };
 
+/*
+ * Support data structure for the recursing into the directory tree.
+ */
+struct traversal_cache {
+	/*
+	 * The realpath for the `git_dir` may be required in the recursion and is
+	 * cached for repeated use.
+	 */
+	char *real_gitdir;
+};
+
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *path, int len,
 	struct untracked_cache_dir *untracked,
-	int check_only, int stop_at_first_file, const struct pathspec *pathspec);
+	int check_only, int stop_at_first_file, const struct pathspec *pathspec,
+	struct traversal_cache *cache);
 static int resolve_dtype(int dtype, struct index_state *istate,
 			 const char *path, int len);
 struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp)
@@ -1852,7 +1864,8 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	struct index_state *istate,
 	struct untracked_cache_dir *untracked,
 	const char *dirname, int len, int baselen, int excluded,
-	const struct pathspec *pathspec)
+	const struct pathspec *pathspec,
+	struct traversal_cache *cache)
 {
 	/*
 	 * WARNING: From this function, you can return path_recurse or you
@@ -1906,13 +1919,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		nested_repo = is_nonbare_repository_dir(&sb);
 
 		if (nested_repo) {
-			char *real_dirname, *real_gitdir;
+			char *real_dirname;
 			strbuf_addstr(&sb, ".git");
 			real_dirname = real_pathdup(sb.buf, 1);
-			real_gitdir = real_pathdup(the_repository->gitdir, 1);
+			if (!cache->real_gitdir)
+				cache->real_gitdir = real_pathdup(the_repository->gitdir, 1);
 
-			nested_repo = !!strcmp(real_dirname, real_gitdir);
-			free(real_gitdir);
+			nested_repo = !!strcmp(real_dirname, cache->real_gitdir);
 			free(real_dirname);
 		}
 		strbuf_release(&sb);
@@ -1944,7 +1957,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 				return path_excluded;
 
 			if (read_directory_recursive(dir, istate, dirname, len,
-						     untracked, 1, 1, pathspec) == path_excluded)
+						     untracked, 1, 1, pathspec, cache) == path_excluded)
 				return path_excluded;
 
 			return path_none;
@@ -2045,7 +2058,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	untracked = lookup_untracked(dir->untracked, untracked,
 				     dirname + baselen, len - baselen);
 	state = read_directory_recursive(dir, istate, dirname, len, untracked,
-					 check_only, stop_early, pathspec);
+					 check_only, stop_early, pathspec, cache);
 
 	/* There are a variety of reasons we may need to fixup the state... */
 	if (state == path_excluded) {
@@ -2242,7 +2255,8 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 					   struct index_state *istate,
 					   struct strbuf *path,
 					   int baselen,
-					   const struct pathspec *pathspec)
+					   const struct pathspec *pathspec,
+					   struct traversal_cache *cache)
 {
 	/*
 	 * WARNING: From this function, you can return path_recurse or you
@@ -2264,7 +2278,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 		 * with check_only set.
 		 */
 		return read_directory_recursive(dir, istate, path->buf, path->len,
-						cdir->ucd, 1, 0, pathspec);
+						cdir->ucd, 1, 0, pathspec, cache);
 	/*
 	 * We get path_recurse in the first run when
 	 * directory_exists_in_index() returns index_nonexistent. We
@@ -2280,13 +2294,14 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct index_state *istate,
 				      struct strbuf *path,
 				      int baselen,
-				      const struct pathspec *pathspec)
+				      const struct pathspec *pathspec,
+				      struct traversal_cache *cache)
 {
 	int has_path_in_index, dtype, excluded;
 
 	if (!cdir->d_name)
 		return treat_path_fast(dir, cdir, istate, path,
-				       baselen, pathspec);
+				       baselen, pathspec, cache);
 	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
@@ -2348,7 +2363,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 		strbuf_addch(path, '/');
 		return treat_directory(dir, istate, untracked,
 				       path->buf, path->len,
-				       baselen, excluded, pathspec);
+				       baselen, excluded, pathspec, cache);
 	case DT_REG:
 	case DT_LNK:
 		if (pathspec &&
@@ -2549,7 +2564,8 @@ static void add_path_to_appropriate_result_list(struct dir_struct *dir,
 static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *base, int baselen,
 	struct untracked_cache_dir *untracked, int check_only,
-	int stop_at_first_file, const struct pathspec *pathspec)
+	int stop_at_first_file, const struct pathspec *pathspec,
+	struct traversal_cache *cache)
 {
 	/*
 	 * WARNING: Do NOT recurse unless path_recurse is returned from
@@ -2572,7 +2588,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
 		state = treat_path(dir, untracked, &cdir, istate, &path,
-				   baselen, pathspec);
+				   baselen, pathspec, cache);
 		dir->visited_paths++;
 
 		if (state > dir_state)
@@ -2587,7 +2603,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			subdir_state =
 				read_directory_recursive(dir, istate, path.buf,
 							 path.len, ud,
-							 check_only, stop_at_first_file, pathspec);
+							 check_only, stop_at_first_file, pathspec, cache);
 			if (subdir_state > dir_state)
 				dir_state = subdir_state;
 
@@ -2661,7 +2677,8 @@ int check_dir_entry_contains(const struct dir_entry *out, const struct dir_entry
 static int treat_leading_path(struct dir_struct *dir,
 			      struct index_state *istate,
 			      const char *path, int len,
-			      const struct pathspec *pathspec)
+			      const struct pathspec *pathspec,
+			      struct traversal_cache *cache)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf subdir = STRBUF_INIT;
@@ -2713,7 +2730,8 @@ static int treat_leading_path(struct dir_struct *dir,
 		strbuf_reset(&subdir);
 		strbuf_add(&subdir, path+prevlen, baselen-prevlen);
 		cdir.d_name = subdir.buf;
-		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen, pathspec);
+
+		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen, pathspec, cache);
 
 		if (state != path_recurse)
 			break; /* do not recurse into it */
@@ -2986,6 +3004,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
+	struct traversal_cache cache = {
+		.real_gitdir = NULL,
+	};
 
 	trace2_region_enter("dir", "read_directory", istate->repo);
 	dir->visited_paths = 0;
@@ -3003,8 +3024,10 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		 * e.g. prep_exclude()
 		 */
 		dir->untracked = NULL;
-	if (!len || treat_leading_path(dir, istate, path, len, pathspec))
-		read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec);
+	if (!len || treat_leading_path(dir, istate, path, len, pathspec, &cache)) {
+		read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec, &cache);
+	}
+	FREE_AND_NULL(cache.real_gitdir);
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
-- 
2.36.0

