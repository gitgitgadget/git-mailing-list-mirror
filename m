From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Tue,  9 Apr 2013 14:51:37 +0530
Message-ID: <1365499297-8667-3-git-send-email-artagnon@gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 11:20:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPUjO-0003jf-PL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 11:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194Ab3DIJU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 05:20:26 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:65159 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965174Ab3DIJUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 05:20:22 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx1so3777999pab.28
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 02:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=RH8BazztnmBoNojjv+Nyd8Slz6QmoXyFylNW1DNCvf0=;
        b=dHz++xvfu7QILcxSM+F127XCJ9srum7ppxRDgrptk2Gj02J5mgwU6GzRGeF0MWpHuK
         pwvrN709whhXY+QO94jMfnb4+DW45wLqE4Vavg+l86LQD21tFSofBkYxnh9PT543cBhi
         EQjBJZBRz7j4T0hhFFlizoe/TTrhh1lNBYlXFPzTxgRGsXva1bbrdg4rLjHAcKbrDeJM
         mjzIEBIzZYMjkDmLPeKbhxbWwUBnztRhANgMCPpqFLSlaqIAsFFOqxZ+hPZOxffX+QyT
         3sqaQI6eStz78rueFwezmuccRUrksSOErF2Dg5YUENVAi9H5zl4OvjoNclc+twOZ5uDH
         f1uA==
X-Received: by 10.66.25.206 with SMTP id e14mr9392381pag.13.1365499221569;
        Tue, 09 Apr 2013 02:20:21 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id mm9sm1484714pbc.43.2013.04.09.02.20.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 02:20:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.347.gdd82260.dirty
In-Reply-To: <1365499297-8667-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220558>

Currently, git add has the logic for refusing to add gitlinks using
treat_path(), which in turn calls check_path_for_gitlink().  However,
this only checks for an in-index submodule (or gitlink cache_entry).
A path inside a git repository in the worktree still adds fine, and
this is a bug.  The logic for denying it is very similar to denying
adding paths beyond symbolic links: die_if_path_beyond_symlink().
Follow its example and write a die_if_path_beyond_gitrepo() to fix
this bug.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/add.c  |  5 +++--
 cache.h        |  2 ++
 pathspec.c     | 12 ++++++++++++
 pathspec.h     |  1 +
 symlinks.c     | 43 +++++++++++++++++++++++++++++++++++++------
 t/t3700-add.sh |  2 +-
 6 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ab1c9e8..1538129 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -155,8 +155,8 @@ static void refresh(int verbose, const char **pathspec)
 
 /*
  * Normalizes argv relative to prefix, via get_pathspec(), and then
- * runs die_if_path_beyond_symlink() on each path in the normalized
- * list.
+ * runs die_if_path_beyond_symlink() and die_if_path_beyond_repository()
+ * on each path in the normalized list.
  */
 static const char **validate_pathspec(const char **argv, const char *prefix)
 {
@@ -166,6 +166,7 @@ static const char **validate_pathspec(const char **argv, const char *prefix)
 		const char **p;
 		for (p = pathspec; *p; p++) {
 			die_if_path_beyond_symlink(*p, prefix);
+			die_if_path_beyond_gitrepo(*p, prefix);
 		}
 	}
 
diff --git a/cache.h b/cache.h
index e1e8ce8..987d7f3 100644
--- a/cache.h
+++ b/cache.h
@@ -962,6 +962,8 @@ struct cache_def {
 
 extern int has_symlink_leading_path(const char *name, int len);
 extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
+extern int has_gitrepo_leading_path(const char *name, int len);
+extern int threaded_has_gitrepo_leading_path(struct cache_def *, const char *, int);
 extern int check_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
diff --git a/pathspec.c b/pathspec.c
index 284f397..142631d 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -99,3 +99,15 @@ void die_if_path_beyond_symlink(const char *path, const char *prefix)
 		die(_("'%s' is beyond a symbolic link"), path + len);
 	}
 }
+
+/*
+ * Dies if the given path refers to a file inside a directory with a
+ * git repository in it.
+ */
+void die_if_path_beyond_gitrepo(const char *path, const char *prefix)
+{
+	if (has_gitrepo_leading_path(path, strlen(path))) {
+		int len = prefix ? strlen(prefix) : 0;
+		die(_("'%s' is beyond a git repository"), path + len);
+	}
+}
diff --git a/pathspec.h b/pathspec.h
index db0184a..c201c7b 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -5,5 +5,6 @@ extern char *find_pathspecs_matching_against_index(const char **pathspec);
 extern void add_pathspec_matches_against_index(const char **pathspec, char *seen, int specs);
 extern const char *check_path_for_gitlink(const char *path);
 extern void die_if_path_beyond_symlink(const char *path, const char *prefix);
+extern void die_if_path_beyond_gitrepo(const char *path, const char *prefix);
 
 #endif /* PATHSPEC_H */
diff --git a/symlinks.c b/symlinks.c
index c2b41a8..e551dae 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -54,6 +54,7 @@ static inline void reset_lstat_cache(struct cache_def *cache)
 #define FL_LSTATERR (1 << 3)
 #define FL_ERR      (1 << 4)
 #define FL_FULLPATH (1 << 5)
+#define FL_GITREPO  (1 << 6)
 
 /*
  * Check if name 'name' of length 'len' has a symlink leading
@@ -142,8 +143,22 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 			if (errno == ENOENT)
 				*ret_flags |= FL_NOENT;
 		} else if (S_ISDIR(st.st_mode)) {
-			last_slash_dir = last_slash;
-			continue;
+			/* Check to see if the directory contains a
+			   git repository */
+			struct stat st;
+			struct strbuf dotgitentry = STRBUF_INIT;
+			strbuf_addf(&dotgitentry, "%s/.git", cache->path);
+			if (lstat(dotgitentry.buf, &st) < 0) {
+				if (errno == ENOENT) {
+					strbuf_release(&dotgitentry);
+					last_slash_dir = last_slash;
+					continue;
+				}
+				*ret_flags = FL_LSTATERR;
+			}
+			else
+				*ret_flags = FL_GITREPO;
+			strbuf_release(&dotgitentry);
 		} else if (S_ISLNK(st.st_mode)) {
 			*ret_flags = FL_SYMLINK;
 		} else {
@@ -153,11 +168,11 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 	}
 
 	/*
-	 * At the end update the cache.  Note that max 3 different
-	 * path types, FL_NOENT, FL_SYMLINK and FL_DIR, can be cached
-	 * for the moment!
+	 * At the end update the cache.  Note that max 4 different
+	 * path types: FL_NOENT, FL_SYMLINK, FL_GITREPO, and
+	 * FL_DIR.
 	 */
-	save_flags = *ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
+	save_flags = *ret_flags & track_flags & (FL_NOENT|FL_SYMLINK|FL_GITREPO);
 	if (save_flags && last_slash > 0 && last_slash <= PATH_MAX) {
 		cache->path[last_slash] = '\0';
 		cache->len = last_slash;
@@ -204,6 +219,14 @@ int threaded_has_symlink_leading_path(struct cache_def *cache, const char *name,
 }
 
 /*
+ * Return non-zero if path 'name' has a leading gitrepo component
+ */
+int threaded_has_gitrepo_leading_path(struct cache_def *cache, const char *name, int len)
+{
+	return lstat_cache(cache, name, len, FL_GITREPO|FL_DIR, USE_ONLY_LSTAT) & FL_GITREPO;
+}
+
+/*
  * Return non-zero if path 'name' has a leading symlink component
  */
 int has_symlink_leading_path(const char *name, int len)
@@ -212,6 +235,14 @@ int has_symlink_leading_path(const char *name, int len)
 }
 
 /*
+ * Return non-zero if path 'name' has a leading gitrepo component
+ */
+int has_gitrepo_leading_path(const char *name, int len)
+{
+	return threaded_has_gitrepo_leading_path(&default_cache, name, len);
+}
+
+/*
  * Return zero if path 'name' has a leading symlink component or
  * if some leading path component does not exists.
  *
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 1ad2331..4714734 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -327,7 +327,7 @@ test_expect_success 'git add should not go past gitlink boundaries' '
 	test_must_fail git add submodule_dir/foo
 '
 
-test_expect_failure 'git add should not go past git repository boundaries' '
+test_expect_success 'git add should not go past git repository boundaries' '
 	rm -rf submodule_dir &&
 	mkdir submodule_dir &&
 	(
-- 
1.8.2.1.347.gdd82260.dirty
