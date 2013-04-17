From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2-pu 11/14] dir.c: replace is_path_excluded with now equivalent
 is_excluded API
Date: Wed, 17 Apr 2013 21:50:57 +0200
Message-ID: <516EFD21.2050306@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com> <7v1uabsin7.fsf@alter.siamese.dyndns.org> <7vwqs3r3m4.fsf@alter.siamese.dyndns.org> <516C5DBF.1010102@gmail.com> <7vli8jr17i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 21:51:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USYNj-0003OP-L1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 21:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758884Ab3DQTu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 15:50:58 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:41347 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935529Ab3DQTu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 15:50:57 -0400
Received: by mail-ee0-f53.google.com with SMTP id d17so242624eek.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=j+RGL+rxDB1s9jjpUUym8DCMOKh7SYuh1iuVYGaLGjk=;
        b=ru7chhnI8oZ2DXToxr9/L3/m+FWUoPixadykumoAoMdwbv8PIX+EpxQ5J55WhsPCtA
         HpA30PHV2Xv2vlnYd6I0zvfqD8dM7s10baQCnbd4llbCKf2mtYus+nITtoo5/8WX1IR0
         VusjsikM+B9ZaVJYvwLcsxIuyrCdeUhyWoFH6ZlhByxzKssTWlNejhLN0i4fQWchtNiy
         vww1MIVQWZ2sMKfk5c9DI6+Fj4iR/N2f36xl92qlApwZdgKBuYWM0Lp8EjUGg7pcnO7v
         K8Yr/t9hf+TMBCHTSkjPD0qJB790lZHlYs7dZKZ5rOcLd/uc/NRtEISbqzG6DiYXHZ3m
         4Zag==
X-Received: by 10.15.32.67 with SMTP id z43mr21797211eeu.24.1366228255927;
        Wed, 17 Apr 2013 12:50:55 -0700 (PDT)
Received: from [10.1.100.56] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id s47sm11121746eeg.8.2013.04.17.12.50.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 12:50:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vli8jr17i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221567>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/add.c          |  5 +---
 builtin/check-ignore.c | 16 ++++------
 builtin/ls-files.c     | 15 +++-------
 dir.c                  | 79 ++++----------------------------------------------
 dir.h                  | 16 ++--------
 unpack-trees.c         | 10 +------
 unpack-trees.h         |  1 -
 7 files changed, 21 insertions(+), 121 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ddd5e38..050330e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -419,9 +419,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (pathspec) {
 		int i;
-		struct path_exclude_check check;
 
-		path_exclude_check_init(&check, &dir);
 		if (!seen)
 			seen = find_pathspecs_matching_against_index(pathspec);
 		for (i = 0; pathspec[i]; i++) {
@@ -429,7 +427,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			    && !file_exists(pathspec[i])) {
 				if (ignore_missing) {
 					int dtype = DT_UNKNOWN;
-					if (is_path_excluded(&check, pathspec[i], -1, &dtype))
+					if (is_excluded(&dir, pathspec[i], &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
 					die(_("pathspec '%s' did not match any files"),
@@ -437,7 +435,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			}
 		}
 		free(seen);
-		path_exclude_check_clear(&check);
 	}
 
 	plug_bulk_checkin();
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index c00a7d6..a4357fb 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -63,7 +63,7 @@ static void output_exclude(const char *path, struct exclude *exclude)
 	}
 }
 
-static int check_ignore(struct path_exclude_check *check,
+static int check_ignore(struct dir_struct *dir,
 			const char *prefix, const char **pathspec)
 {
 	const char *path, *full_path;
@@ -91,8 +91,7 @@ static int check_ignore(struct path_exclude_check *check,
 		die_if_path_beyond_symlink(full_path, prefix);
 		exclude = NULL;
 		if (!seen[i]) {
-			exclude = last_exclude_matching_path(check, full_path,
-							     -1, &dtype);
+			exclude = last_exclude_matching(dir, full_path, &dtype);
 		}
 		if (!quiet && (exclude || show_non_matching))
 			output_exclude(path, exclude);
@@ -104,7 +103,7 @@ static int check_ignore(struct path_exclude_check *check,
 	return num_ignored;
 }
 
-static int check_ignore_stdin_paths(struct path_exclude_check *check, const char *prefix)
+static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 {
 	struct strbuf buf, nbuf;
 	char *pathspec[2] = { NULL, NULL };
@@ -121,7 +120,7 @@ static int check_ignore_stdin_paths(struct path_exclude_check *check, const char
 			strbuf_swap(&buf, &nbuf);
 		}
 		pathspec[0] = buf.buf;
-		num_ignored += check_ignore(check, prefix, (const char **)pathspec);
+		num_ignored += check_ignore(dir, prefix, (const char **)pathspec);
 		maybe_flush_or_die(stdout, "check-ignore to stdout");
 	}
 	strbuf_release(&buf);
@@ -133,7 +132,6 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 {
 	int num_ignored;
 	struct dir_struct dir;
-	struct path_exclude_check check;
 
 	git_config(git_default_config, NULL);
 
@@ -166,16 +164,14 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 	dir.flags |= DIR_COLLECT_IGNORED;
 	setup_standard_excludes(&dir);
 
-	path_exclude_check_init(&check, &dir);
 	if (stdin_paths) {
-		num_ignored = check_ignore_stdin_paths(&check, prefix);
+		num_ignored = check_ignore_stdin_paths(&dir, prefix);
 	} else {
-		num_ignored = check_ignore(&check, prefix, argv);
+		num_ignored = check_ignore(&dir, prefix, argv);
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
 
 	clear_directory(&dir);
-	path_exclude_check_clear(&check);
 
 	return !num_ignored;
 }
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 175e6e3..2202072 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -201,19 +201,15 @@ static void show_ru_info(void)
 	}
 }
 
-static int ce_excluded(struct path_exclude_check *check, struct cache_entry *ce)
+static int ce_excluded(struct dir_struct *dir, struct cache_entry *ce)
 {
 	int dtype = ce_to_dtype(ce);
-	return is_path_excluded(check, ce->name, ce_namelen(ce), &dtype);
+	return is_excluded(dir, ce->name, &dtype);
 }
 
 static void show_files(struct dir_struct *dir)
 {
 	int i;
-	struct path_exclude_check check;
-
-	if ((dir->flags & DIR_SHOW_IGNORED))
-		path_exclude_check_init(&check, dir);
 
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
@@ -227,7 +223,7 @@ static void show_files(struct dir_struct *dir)
 		for (i = 0; i < active_nr; i++) {
 			struct cache_entry *ce = active_cache[i];
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(&check, ce))
+			    !ce_excluded(dir, ce))
 				continue;
 			if (show_unmerged && !ce_stage(ce))
 				continue;
@@ -243,7 +239,7 @@ static void show_files(struct dir_struct *dir)
 			struct stat st;
 			int err;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(&check, ce))
+			    !ce_excluded(dir, ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
@@ -256,9 +252,6 @@ static void show_files(struct dir_struct *dir)
 				show_ce_entry(tag_modified, ce);
 		}
 	}
-
-	if ((dir->flags & DIR_SHOW_IGNORED))
-		path_exclude_check_clear(&check);
 }
 
 /*
diff --git a/dir.c b/dir.c
index 7e68a1c..16e1c07 100644
--- a/dir.c
+++ b/dir.c
@@ -843,7 +843,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
  * Returns the exclude_list element which matched, or NULL for
  * undecided.
  */
-static struct exclude *last_exclude_matching(struct dir_struct *dir,
+struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     const char *pathname,
 					     int *dtype_p)
 {
@@ -865,7 +865,7 @@ static struct exclude *last_exclude_matching(struct dir_struct *dir,
  * scans all exclude lists to determine whether pathname is excluded.
  * Returns 1 if true, otherwise 0.
  */
-static int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 {
 	struct exclude *exclude =
 		last_exclude_matching(dir, pathname, dtype_p);
@@ -874,47 +874,6 @@ static int is_excluded(struct dir_struct *dir, const char *pathname, int *dtype_
 	return 0;
 }
 
-void path_exclude_check_init(struct path_exclude_check *check,
-			     struct dir_struct *dir)
-{
-	check->dir = dir;
-}
-
-void path_exclude_check_clear(struct path_exclude_check *check)
-{
-}
-
-/*
- * For each subdirectory in name, starting with the top-most, checks
- * to see if that subdirectory is excluded, and if so, returns the
- * corresponding exclude structure.  Otherwise, checks whether name
- * itself (which is presumably a file) is excluded.
- *
- * A path to a directory known to be excluded is left in check->path to
- * optimize for repeated checks for files in the same excluded directory.
- */
-struct exclude *last_exclude_matching_path(struct path_exclude_check *check,
-					   const char *name, int namelen,
-					   int *dtype)
-{
-	return last_exclude_matching(check->dir, name, dtype);
-}
-
-/*
- * Is this name excluded?  This is for a caller like show_files() that
- * do not honor directory hierarchy and iterate through paths that are
- * possibly in an ignored directory.
- */
-int is_path_excluded(struct path_exclude_check *check,
-		  const char *name, int namelen, int *dtype)
-{
-	struct exclude *exclude =
-		last_exclude_matching_path(check, name, namelen, dtype);
-	if (exclude)
-		return exclude->flags & EXC_FLAG_NEGATIVE ? 0 : 1;
-	return 0;
-}
-
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
 {
 	struct dir_entry *ent;
@@ -1086,15 +1045,6 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 
 	/* This is the "show_other_directories" case */
 
-	/* might be a sub directory in an excluded directory */
-	if (!exclude) {
-		struct path_exclude_check check;
-		int dt = DT_DIR;
-		path_exclude_check_init(&check, dir);
-		exclude = is_path_excluded(&check, dirname, len, &dt);
-		path_exclude_check_clear(&check);
-	}
-
 	/*
 	 * We are looking for ignored files and our directory is not ignored,
 	 * check if it contains untracked files (i.e. is listed as untracked)
@@ -1129,27 +1079,13 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
  *
  * Return 1 for exclude, 0 for include.
  */
-static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude, int *dtype)
+static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude)
 {
-	struct path_exclude_check check;
-	int exclude_file = 0;
-
 	/* Always exclude indexed files */
 	if (index_name_exists(&the_index, path->buf, path->len, ignore_case))
 		return 1;
 
-	if (exclude)
-		exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
-	else if (dir->flags & DIR_SHOW_IGNORED) {
-		path_exclude_check_init(&check, dir);
-
-		if (!is_path_excluded(&check, path->buf, path->len, dtype))
-			exclude_file = 1;
-
-		path_exclude_check_clear(&check);
-	}
-
-	return exclude_file;
+	return exclude == !(dir->flags & DIR_SHOW_IGNORED);
 }
 
 /*
@@ -1306,12 +1242,9 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		break;
 	case DT_REG:
 	case DT_LNK:
-		switch (treat_file(dir, path, exclude, &dtype)) {
-		case 1:
+		if (treat_file(dir, path, exclude))
 			return path_ignored;
-		default:
-			break;
-		}
+		break;
 	}
 	return path_handled;
 }
diff --git a/dir.h b/dir.h
index cd166d0..bfe726e 100644
--- a/dir.h
+++ b/dir.h
@@ -151,20 +151,10 @@ extern int match_pathname(const char *, int,
 			  const char *, int,
 			  const char *, int, int, int);
 
-/*
- * The is_excluded() API is meant for callers that check each level of leading
- * directory hierarchies with is_excluded() to avoid recursing into excluded
- * directories.  Callers that do not do so should use this API instead.
- */
-struct path_exclude_check {
-	struct dir_struct *dir;
-};
-extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
-extern void path_exclude_check_clear(struct path_exclude_check *);
-extern struct exclude *last_exclude_matching_path(struct path_exclude_check *, const char *,
-						  int namelen, int *dtype);
-extern int is_path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
+extern struct exclude *last_exclude_matching(struct dir_struct *dir,
+					     const char *name, int *dtype);
 
+extern int is_excluded(struct dir_struct *dir, const char *name, int *dtype);
 
 extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
 					     int group_type, const char *src);
diff --git a/unpack-trees.c b/unpack-trees.c
index 09e53df..ede4299 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1026,10 +1026,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			o->el = &el;
 	}
 
-	if (o->dir) {
-		o->path_exclude_check = xmalloc(sizeof(struct path_exclude_check));
-		path_exclude_check_init(o->path_exclude_check, o->dir);
-	}
 	memset(&o->result, 0, sizeof(o->result));
 	o->result.initialized = 1;
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
@@ -1155,10 +1151,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 done:
 	clear_exclude_list(&el);
-	if (o->path_exclude_check) {
-		path_exclude_check_clear(o->path_exclude_check);
-		free(o->path_exclude_check);
-	}
 	return ret;
 
 return_failed:
@@ -1375,7 +1367,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_path_excluded(o->path_exclude_check, name, -1, &dtype))
+	    is_excluded(o->dir, name, &dtype))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
diff --git a/unpack-trees.h b/unpack-trees.h
index ec74a9f..5e432f5 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -52,7 +52,6 @@ struct unpack_trees_options {
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-	struct path_exclude_check *path_exclude_check;
 	struct pathspec *pathspec;
 	merge_fn_t fn;
 	const char *msgs[NB_UNPACK_TREES_ERROR_TYPES];
-- 
1.8.1.2.8038.ge6fb49b.dirty
