From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 3/6] string_list: Fix argument order for string_list_insert
Date: Tue, 06 Apr 2010 02:11:35 +0100
Message-ID: <20100406011139.71279.30985.julian@quantumfyre.co.uk>
References: <20100406011106.71279.92681.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 03:29:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyxbW-0001M8-VY
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 03:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094Ab0DFB2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 21:28:55 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:45405 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756661Ab0DFB2r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 21:28:47 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 90BBA819C3A8;
	Tue,  6 Apr 2010 02:28:40 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 0780420C8E7;
	Tue,  6 Apr 2010 02:28:45 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ja-pxi5nix77; Tue,  6 Apr 2010 02:28:44 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 5C49520C8EB;
	Tue,  6 Apr 2010 02:28:44 +0100 (BST)
X-git-sha1: 88550d14ecabc95d171acc8a930051471f5a25c2 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100406011106.71279.92681.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144079>

Update the definition and callers of string_list_insert to use
the string_list as the first argument.  This helps make the string_list
API easier to use by being more consistent.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 builtin/apply.c     |    6 +++---
 builtin/commit.c    |    2 +-
 builtin/fetch.c     |    4 ++--
 builtin/mailsplit.c |    2 +-
 builtin/mv.c        |    2 +-
 builtin/remote.c    |    6 +++---
 builtin/shortlog.c  |    2 +-
 builtin/show-ref.c  |    2 +-
 diff-no-index.c     |    2 +-
 http-backend.c      |    2 +-
 mailmap.c           |    2 +-
 merge-recursive.c   |   16 ++++++++--------
 reflog-walk.c       |    2 +-
 remote.c            |    2 +-
 rerere.c            |   10 +++++-----
 resolve-undo.c      |    4 ++--
 string-list.c       |    2 +-
 string-list.h       |    2 +-
 wt-status.c         |    8 ++++----
 19 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index af4695f..aea852c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2664,7 +2664,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * file creations and copies
 	 */
 	if (patch->new_name != NULL) {
-		item = string_list_insert(patch->new_name, &fn_table);
+		item = string_list_insert(&fn_table, patch->new_name);
 		item->util = patch;
 	}
 
@@ -2673,7 +2673,7 @@ static void add_to_fn_table(struct patch *patch)
 	 * later chunks shouldn't patch old names
 	 */
 	if ((patch->new_name == NULL) || (patch->is_rename)) {
-		item = string_list_insert(patch->old_name, &fn_table);
+		item = string_list_insert(&fn_table, patch->old_name);
 		item->util = PATH_WAS_DELETED;
 	}
 }
@@ -2686,7 +2686,7 @@ static void prepare_fn_table(struct patch *patch)
 	while (patch) {
 		if ((patch->new_name == NULL) || (patch->is_rename)) {
 			struct string_list_item *item;
-			item = string_list_insert(patch->old_name, &fn_table);
+			item = string_list_insert(&fn_table, patch->old_name);
 			item->util = PATH_TO_BE_DELETED;
 		}
 		patch = patch->next;
diff --git a/builtin/commit.c b/builtin/commit.c
index 8f1ddc3..750bf39 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -205,7 +205,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 			continue;
 		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
 			continue;
-		item = string_list_insert(ce->name, list);
+		item = string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
 			item->util = item; /* better a valid pointer than a fake one */
 	}
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 31cec51..cebfe1a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -528,7 +528,7 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 			int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
-	struct string_list_item *item = string_list_insert(refname, list);
+	struct string_list_item *item = string_list_insert(list, refname);
 	item->util = (void *)sha1;
 	return 0;
 }
@@ -616,7 +616,7 @@ static void find_non_local_tags(struct transport *transport,
 		    string_list_has_string(&existing_refs, ref->name))
 			continue;
 
-		item = string_list_insert(ref->name, &remote_refs);
+		item = string_list_insert(&remote_refs, ref->name);
 		item->util = (void *)ref->old_sha1;
 	}
 	string_list_clear(&existing_refs, 0);
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index cdfc1b7..e4560da 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -121,7 +121,7 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 			if (dent->d_name[0] == '.')
 				continue;
 			snprintf(name, sizeof(name), "%s/%s", *sub, dent->d_name);
-			string_list_insert(name, list);
+			string_list_insert(list, name);
 		}
 
 		closedir(dir);
diff --git a/builtin/mv.c b/builtin/mv.c
index c07f53b..38574b8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -180,7 +180,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		} else if (string_list_has_string(&src_for_dst, dst))
 			bad = "multiple sources for the same target";
 		else
-			string_list_insert(dst, &src_for_dst);
+			string_list_insert(&src_for_dst, dst);
 
 		if (bad) {
 			if (ignore_errors) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 015ae71..87edc37 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -232,7 +232,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else
 			return 0;
 
-		item = string_list_insert(name, &branch_list);
+		item = string_list_insert(&branch_list, name);
 
 		if (!item->util)
 			item->util = xcalloc(sizeof(struct branch_info), 1);
@@ -851,7 +851,7 @@ static int add_remote_to_show_info(struct string_list_item *item, void *cb_data)
 	int n = strlen(item->string);
 	if (n > info->width)
 		info->width = n;
-	string_list_insert(item->string, info->list);
+	string_list_insert(info->list, item->string);
 	return 0;
 }
 
@@ -898,7 +898,7 @@ static int add_local_to_show_info(struct string_list_item *branch_item, void *cb
 	if (branch_info->rebase)
 		show_info->any_rebase = 1;
 
-	item = string_list_insert(branch_item->string, show_info->list);
+	item = string_list_insert(show_info->list, branch_item->string);
 	item->util = branch_info;
 
 	return 0;
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index bdf3402..3620cc0 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -84,7 +84,7 @@ static void insert_one_record(struct shortlog *log,
 		snprintf(namebuf + len, room, " <%.*s>", maillen, emailbuf);
 	}
 
-	item = string_list_insert(namebuf, &log->list);
+	item = string_list_insert(&log->list, namebuf);
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct string_list));
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 59f90df..703727f 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -105,7 +105,7 @@ match:
 static int add_existing(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
-	string_list_insert(refname, list);
+	string_list_insert(list, refname);
 	return 0;
 }
 
diff --git a/diff-no-index.c b/diff-no-index.c
index aae8e7a..3ffb028 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -26,7 +26,7 @@ static int read_directory(const char *path, struct string_list *list)
 
 	while ((e = readdir(dir)))
 		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
-			string_list_insert(e->d_name, list);
+			string_list_insert(list, e->d_name);
 
 	closedir(dir);
 	return 0;
diff --git a/http-backend.c b/http-backend.c
index af6a756..fa5e0f5 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -92,7 +92,7 @@ static struct string_list *get_parameters(void)
 
 			i = string_list_lookup(name, query_params);
 			if (!i)
-				i = string_list_insert(name, query_params);
+				i = string_list_insert(query_params, name);
 			else
 				free(i->util);
 			i->util = value;
diff --git a/mailmap.c b/mailmap.c
index b68c1fe..badf6a4 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -92,7 +92,7 @@ static void add_mapping(struct string_list *map,
 			mi->name = xstrdup(new_name);
 		if (new_email)
 			mi->email = xstrdup(new_email);
-		string_list_insert(old_name, &me->namemap)->util = mi;
+		string_list_insert(&me->namemap, old_name)->util = mi;
 	}
 
 	debug_mm("mailmap:  '%s' <%s> -> '%s' <%s>\n",
diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..5e60f4b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -238,9 +238,9 @@ static int save_files_dirs(const unsigned char *sha1,
 	newpath[baselen + len] = '\0';
 
 	if (S_ISDIR(mode))
-		string_list_insert(newpath, &o->current_directory_set);
+		string_list_insert(&o->current_directory_set, newpath);
 	else
-		string_list_insert(newpath, &o->current_file_set);
+		string_list_insert(&o->current_file_set, newpath);
 	free(newpath);
 
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
@@ -271,7 +271,7 @@ static struct stage_data *insert_stage_data(const char *path,
 			e->stages[2].sha, &e->stages[2].mode);
 	get_tree_entry(b->object.sha1, path,
 			e->stages[3].sha, &e->stages[3].mode);
-	item = string_list_insert(path, entries);
+	item = string_list_insert(entries, path);
 	item->util = e;
 	return e;
 }
@@ -296,7 +296,7 @@ static struct string_list *get_unmerged(void)
 
 		item = string_list_lookup(ce->name, unmerged);
 		if (!item) {
-			item = string_list_insert(ce->name, unmerged);
+			item = string_list_insert(unmerged, ce->name);
 			item->util = xcalloc(1, sizeof(struct stage_data));
 		}
 		e = item->util;
@@ -369,7 +369,7 @@ static struct string_list *get_renames(struct merge_options *o,
 					o_tree, a_tree, b_tree, entries);
 		else
 			re->dst_entry = item->util;
-		item = string_list_insert(pair->one->path, renames);
+		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
 	}
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -432,7 +432,7 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
 	       lstat(newpath, &st) == 0)
 		sprintf(p, "_%d", suffix++);
 
-	string_list_insert(newpath, &o->current_file_set);
+	string_list_insert(&o->current_file_set, newpath);
 	return newpath;
 }
 
@@ -811,12 +811,12 @@ static int process_renames(struct merge_options *o,
 
 	for (i = 0; i < a_renames->nr; i++) {
 		sre = a_renames->items[i].util;
-		string_list_insert(sre->pair->two->path, &a_by_dst)->util
+		string_list_insert(&a_by_dst, sre->pair->two->path)->util
 			= sre->dst_entry;
 	}
 	for (i = 0; i < b_renames->nr; i++) {
 		sre = b_renames->items[i].util;
-		string_list_insert(sre->pair->two->path, &b_by_dst)->util
+		string_list_insert(&b_by_dst, sre->pair->two->path)->util
 			= sre->dst_entry;
 	}
 
diff --git a/reflog-walk.c b/reflog-walk.c
index caba4f7..f125f37 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -190,7 +190,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		}
 		if (!reflogs || reflogs->nr == 0)
 			return -1;
-		string_list_insert(branch, &info->complete_reflogs)->util
+		string_list_insert(&info->complete_reflogs, branch)->util
 			= reflogs;
 	}
 
diff --git a/remote.c b/remote.c
index c70181c..4014c5b 100644
--- a/remote.c
+++ b/remote.c
@@ -776,7 +776,7 @@ void ref_remove_duplicates(struct ref *ref_map)
 			continue;
 		}
 
-		item = string_list_insert(ref_map->peer_ref->name, &refs);
+		item = string_list_insert(&refs, ref_map->peer_ref->name);
 		item->util = ref_map;
 	}
 	string_list_clear(&refs, 0);
diff --git a/rerere.c b/rerere.c
index f221bed..910cfd9 100644
--- a/rerere.c
+++ b/rerere.c
@@ -46,7 +46,7 @@ static void read_rr(struct string_list *rr)
 			; /* do nothing */
 		if (i == sizeof(buf))
 			die("filename too long");
-		string_list_insert(buf, rr)->util = name;
+		string_list_insert(rr, buf)->util = name;
 	}
 	fclose(in);
 }
@@ -354,7 +354,7 @@ static int find_conflict(struct string_list *conflict)
 		    ce_same_name(e2, e3) &&
 		    S_ISREG(e2->ce_mode) &&
 		    S_ISREG(e3->ce_mode)) {
-			string_list_insert((const char *)e2->name, conflict);
+			string_list_insert(conflict, (const char *)e2->name);
 			i++; /* skip over both #2 and #3 */
 		}
 	}
@@ -449,7 +449,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 			if (ret < 1)
 				continue;
 			hex = xstrdup(sha1_to_hex(sha1));
-			string_list_insert(path, rr)->util = hex;
+			string_list_insert(rr, path)->util = hex;
 			if (mkdir(git_path("rr-cache/%s", hex), 0755))
 				continue;
 			handle_file(path, NULL, rerere_path(hex, "preimage"));
@@ -471,7 +471,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		if (has_rerere_resolution(name)) {
 			if (!merge(name, path)) {
 				if (rerere_autoupdate)
-					string_list_insert(path, &update);
+					string_list_insert(&update, path);
 				fprintf(stderr,
 					"%s '%s' using previous resolution.\n",
 					rerere_autoupdate
@@ -577,7 +577,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	fprintf(stderr, "Updated preimage for '%s'\n", path);
 
 
-	string_list_insert(path, rr)->util = hex;
+	string_list_insert(rr, path)->util = hex;
 	fprintf(stderr, "Forgot resolution for %s\n", path);
 	return 0;
 }
diff --git a/resolve-undo.c b/resolve-undo.c
index e93b3d1..8b93559 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -20,7 +20,7 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 		istate->resolve_undo = resolve_undo;
 	}
 	resolve_undo = istate->resolve_undo;
-	lost = string_list_insert(ce->name, resolve_undo);
+	lost = string_list_insert(resolve_undo, ce->name);
 	if (!lost->util)
 		lost->util = xcalloc(1, sizeof(*ui));
 	ui = lost->util;
@@ -70,7 +70,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 		len = strlen(data) + 1;
 		if (size <= len)
 			goto error;
-		lost = string_list_insert(data, resolve_undo);
+		lost = string_list_insert(resolve_undo, data);
 		if (!lost->util)
 			lost->util = xcalloc(1, sizeof(*ui));
 		ui = lost->util;
diff --git a/string-list.c b/string-list.c
index 09798a2..de89efd 100644
--- a/string-list.c
+++ b/string-list.c
@@ -51,7 +51,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 	return index;
 }
 
-struct string_list_item *string_list_insert(const char *string, struct string_list *list)
+struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
 	return string_list_insert_at_index(-1, string, list);
 }
diff --git a/string-list.h b/string-list.h
index 1e2dfc3..3d5a8de 100644
--- a/string-list.h
+++ b/string-list.h
@@ -29,7 +29,7 @@ int for_each_string_list(struct string_list *list,
 int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
 				  int negative_existing_index);
-struct string_list_item *string_list_insert(const char *string, struct string_list *list);
+struct string_list_item *string_list_insert(struct string_list *list, const char *string);
 struct string_list_item *string_list_insert_at_index(int insert_at,
 						     const char *string, struct string_list *list);
 struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
diff --git a/wt-status.c b/wt-status.c
index 8ca59a2..8ba8f0c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -229,7 +229,7 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
 		struct wt_status_change_data *d;
 
 		p = q->queue[i];
-		it = string_list_insert(p->one->path, &s->change);
+		it = string_list_insert(&s->change, p->one->path);
 		d = it->util;
 		if (!d) {
 			d = xcalloc(1, sizeof(*d));
@@ -276,7 +276,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 		struct wt_status_change_data *d;
 
 		p = q->queue[i];
-		it = string_list_insert(p->two->path, &s->change);
+		it = string_list_insert(&s->change, p->two->path);
 		d = it->util;
 		if (!d) {
 			d = xcalloc(1, sizeof(*d));
@@ -343,7 +343,7 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 
 		if (!ce_path_match(ce, s->pathspec))
 			continue;
-		it = string_list_insert(ce->name, &s->change);
+		it = string_list_insert(&s->change, ce->name);
 		d = it->util;
 		if (!d) {
 			d = xcalloc(1, sizeof(*d));
@@ -379,7 +379,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		if (!match_pathspec(s->pathspec, ent->name, ent->len, 0, NULL))
 			continue;
 		s->workdir_untracked = 1;
-		string_list_insert(ent->name, &s->untracked);
+		string_list_insert(&s->untracked, ent->name);
 	}
 }
 
-- 
1.7.0.2
