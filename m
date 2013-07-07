From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 11/22] ls-files.c: use the index api
Date: Sun,  7 Jul 2013 10:11:49 +0200
Message-ID: <1373184720-29767-12-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5w-0006Dl-E5
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab3GGINP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:15 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33071 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3GGINJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:13:09 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so2137941eek.19
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Inn+uyDHngtsPC+sW7mAUY6hU3wPFK7QX17z/ohhuxo=;
        b=gdhKag733ax2CvEjtUOy4ZlV8peOZrpNV0b0FdF+MdOyWu5dvLrjof6jTCvYVW22Q4
         o5jHuTXgsNtXVUqMZ4vy7Jhc3VYheItmwQyZ1N3a7UFzVxR2oQDOC5FwnVxM67F3W7cP
         vbskVxOU4BSeMLc41ViJTJ50Wbw8R1vcy1ERaci42dYJbolnytB3J0/xT8Q4asfaNzHm
         0eW0g6HeQrsu2dGcUf5is+dCDHqlfqCBUaKqpOGN2BpEqvPyKPb/5vFfjGxq/n98ULAI
         D1Qja30PTJLwennnkBXkiex0dTeM3869ZLN40e8vJNRVxyazj3O1Kh2p258pm9WAiU5R
         KABQ==
X-Received: by 10.15.91.69 with SMTP id r45mr19623696eez.79.1373184787537;
        Sun, 07 Jul 2013 01:13:07 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id cg12sm30745713eeb.7.2013.07.07.01.13.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:13:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229741>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/ls-files.c | 213 +++++++++++++++++++++++++----------------------------
 1 file changed, 100 insertions(+), 113 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 08d9786..82857d4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -88,36 +88,35 @@ static void show_killed_files(struct dir_struct *dir)
 	for (i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
 		char *cp, *sp;
-		int pos, len, killed = 0;
+		int len, killed = 0;
 
 		for (cp = ent->name; cp - ent->name < ent->len; cp = sp + 1) {
+			struct cache_entry *ce;
+
 			sp = strchr(cp, '/');
 			if (!sp) {
 				/* If ent->name is prefix of an entry in the
 				 * cache, it will be killed.
 				 */
-				pos = cache_name_pos(ent->name, ent->len);
-				if (0 <= pos)
+				if (get_cache_entry_by_name(ent->name, ent->len, &ce))
 					die("bug in show-killed-files");
-				pos = -pos - 1;
-				while (pos < active_nr &&
-				       ce_stage(active_cache[pos]))
-					pos++; /* skip unmerged */
-				if (active_nr <= pos)
+				while (ce && ce_stage(ce))
+					ce = next_cache_entry(ce);
+				if (!ce)
 					break;
 				/* pos points at a name immediately after
 				 * ent->name in the cache.  Does it expect
 				 * ent->name to be a directory?
 				 */
-				len = ce_namelen(active_cache[pos]);
+				len = ce_namelen(ce);
 				if ((ent->len < len) &&
-				    !strncmp(active_cache[pos]->name,
+				    !strncmp(ce->name,
 					     ent->name, ent->len) &&
-				    active_cache[pos]->name[ent->len] == '/')
+				    ce->name[ent->len] == '/')
 					killed = 1;
 				break;
 			}
-			if (0 <= cache_name_pos(ent->name, sp - ent->name)) {
+			if (get_cache_entry_by_name(ent->name, sp - ent->name, &ce)) {
 				/* If any of the leading directories in
 				 * ent->name is registered in the cache,
 				 * ent->name will be killed.
@@ -213,10 +212,43 @@ static int ce_excluded(struct dir_struct *dir, struct cache_entry *ce)
 	return is_excluded(dir, ce->name, &dtype);
 }
 
-static void show_files(struct dir_struct *dir)
+static int show_cached_stage(struct cache_entry *ce, void *cb_data)
 {
-	int i;
+	struct dir_struct *dir = cb_data;
+
+	if ((dir->flags & DIR_SHOW_IGNORED) && !ce_excluded(dir, ce))
+		return 0;
+	if (show_unmerged && !ce_stage(ce))
+		return 0;
+	if (ce->ce_flags & CE_UPDATE)
+		return 0;
+	show_ce_entry(ce_stage(ce) ? tag_unmerged :
+		(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
+	return 0;
+}
 
+static int show_deleted_modified(struct cache_entry *ce, void *cb_data)
+{
+	struct stat st;
+	int err;
+	struct dir_struct *dir = cb_data;
+
+	if ((dir->flags & DIR_SHOW_IGNORED) && !ce_excluded(dir, ce))
+		return 0;
+	if (ce->ce_flags & CE_UPDATE)
+		return 0;
+	if (ce_skip_worktree(ce))
+		return 0;
+	err = lstat(ce->name, &st);
+	if (show_deleted && err)
+		show_ce_entry(tag_removed, ce);
+	if (show_modified && ce_modified(ce, &st, 0))
+		show_ce_entry(tag_modified, ce);
+	return 0;
+}
+
+static void show_files(struct dir_struct *dir)
+{
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
 		fill_directory(dir, pathspec);
@@ -225,66 +257,18 @@ static void show_files(struct dir_struct *dir)
 		if (show_killed)
 			show_killed_files(dir);
 	}
-	if (show_cached || show_stage) {
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
-				continue;
-			if (show_unmerged && !ce_stage(ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			show_ce_entry(ce_stage(ce) ? tag_unmerged :
-				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
-		}
-	}
-	if (show_deleted || show_modified) {
-		for (i = 0; i < active_nr; i++) {
-			struct cache_entry *ce = active_cache[i];
-			struct stat st;
-			int err;
-			if ((dir->flags & DIR_SHOW_IGNORED) &&
-			    !ce_excluded(dir, ce))
-				continue;
-			if (ce->ce_flags & CE_UPDATE)
-				continue;
-			if (ce_skip_worktree(ce))
-				continue;
-			err = lstat(ce->name, &st);
-			if (show_deleted && err)
-				show_ce_entry(tag_removed, ce);
-			if (show_modified && ce_modified(ce, &st, 0))
-				show_ce_entry(tag_modified, ce);
-		}
-	}
+	if (show_cached | show_stage)
+		for_each_cache_entry(show_cached_stage, dir);
+	if (show_deleted | show_modified)
+		for_each_cache_entry(show_deleted_modified, dir);
 }
 
-/*
- * Prune the index to only contain stuff starting with "prefix"
- */
-static void prune_cache(const char *prefix)
+static int hoist_unmerged(struct cache_entry *ce, void *cb_data)
 {
-	int pos = cache_name_pos(prefix, max_prefix_len);
-	unsigned int first, last;
-
-	if (pos < 0)
-		pos = -pos-1;
-	memmove(active_cache, active_cache + pos,
-		(active_nr - pos) * sizeof(struct cache_entry *));
-	active_nr -= pos;
-	first = 0;
-	last = active_nr;
-	while (last > first) {
-		int next = (last + first) >> 1;
-		struct cache_entry *ce = active_cache[next];
-		if (!strncmp(ce->name, prefix, max_prefix_len)) {
-			first = next+1;
-			continue;
-		}
-		last = next;
-	}
-	active_nr = last;
+	if (!ce_stage(ce))
+		return 0;
+	ce->ce_flags |= CE_STAGEMASK;
+	return 0;
 }
 
 static void strip_trailing_slash_from_submodules(void)
@@ -292,16 +276,38 @@ static void strip_trailing_slash_from_submodules(void)
 	const char **p;
 
 	for (p = pathspec; *p != NULL; p++) {
-		int len = strlen(*p), pos;
+		int len = strlen(*p);
+		struct cache_entry *ce;
 
 		if (len < 1 || (*p)[len - 1] != '/')
 			continue;
-		pos = cache_name_pos(*p, len - 1);
-		if (pos >= 0 && S_ISGITLINK(active_cache[pos]->ce_mode))
+		if (get_cache_entry_by_name(*p, len - 1, &ce) && S_ISGITLINK(ce->ce_mode))
 			*p = xstrndup(*p, len - 1);
 	}
 }
 
+int mark_entry_to_show(struct cache_entry *ce, void *cb_data)
+{
+	struct cache_entry *last_stage0 = cb_data;
+	switch (ce_stage(ce)) {
+	case 0:
+		last_stage0 = ce;
+		/* fallthru */
+	default:
+		return 0;
+	case 1:
+		/*
+		 * If there is stage #0 entry for this, we do not
+		 * need to show it.  We use CE_UPDATE bit to mark
+		 * such an entry.
+		 */
+		if (last_stage0 &&
+			!strcmp(last_stage0->name, ce->name))
+			ce->ce_flags |= CE_UPDATE;
+	}
+	return 0;
+}
+
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -316,7 +322,6 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	unsigned char sha1[20];
 	struct pathspec pathspec;
 	struct cache_entry *last_stage0 = NULL;
-	int i;
 
 	if (get_sha1(tree_name, sha1))
 		die("tree-ish %s not found.", tree_name);
@@ -325,12 +330,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 		die("bad tree-ish %s", tree_name);
 
 	/* Hoist the unmerged entries up to stage #3 to make room */
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
-		ce->ce_flags |= CE_STAGEMASK;
-	}
+	for_each_cache_entry(hoist_unmerged, NULL);
 
 	if (prefix) {
 		static const char *(matchbuf[2]);
@@ -343,25 +343,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 	if (read_tree(tree, 1, &pathspec))
 		die("unable to read tree entries %s", tree_name);
 
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		switch (ce_stage(ce)) {
-		case 0:
-			last_stage0 = ce;
-			/* fallthru */
-		default:
-			continue;
-		case 1:
-			/*
-			 * If there is stage #0 entry for this, we do not
-			 * need to show it.  We use CE_UPDATE bit to mark
-			 * such an entry.
-			 */
-			if (last_stage0 &&
-			    !strcmp(last_stage0->name, ce->name))
-				ce->ce_flags |= CE_UPDATE;
-		}
-	}
+	for_each_cache_entry(mark_entry_to_show, last_stage0);
 }
 
 int report_path_error(const char *ps_matched, const char **pathspec, const char *prefix)
@@ -457,6 +439,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct dir_struct dir;
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct filter_opts *opts = xmalloc(sizeof(*opts));
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			N_("paths are separated with NUL character"),
@@ -522,9 +505,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		prefix_len = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
@@ -557,14 +537,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	pathspec = get_pathspec(prefix, argv);
 
-	/* be nice with submodule paths ending in a slash */
-	if (pathspec)
-		strip_trailing_slash_from_submodules();
-
-	/* Find common prefix for all pathspec's */
-	max_prefix = common_prefix(pathspec);
-	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
-
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec && error_unmatch) {
 		int num;
@@ -573,6 +545,23 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		ps_matched = xcalloc(1, num);
 	}
 
+	memset(opts, 0, sizeof(*opts));
+	opts->pathspec = pathspec;
+	opts->read_staged = 1;
+	if (show_resolve_undo)
+		opts->read_resolve_undo = 1;
+	read_cache_filtered(opts);
+
+	if (pathspec) {
+		strip_trailing_slash_from_submodules();
+		opts->pathspec = pathspec;
+		cache_change_filter_opts(opts);
+	}
+
+	/* Find common prefix for all pathspec's */
+	max_prefix = opts->max_prefix;
+	max_prefix_len = opts->max_prefix_len;
+
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
 
@@ -581,8 +570,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	      show_killed || show_modified || show_resolve_undo))
 		show_cached = 1;
 
-	if (max_prefix)
-		prune_cache(max_prefix);
 	if (with_tree) {
 		/*
 		 * Basic sanity check; show-stages and show-unmerged
-- 
1.8.3.453.g1dfc63d
