From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 2/2] use REALLOC_ARRAY for changing the allocation size of
 arrays
Date: Tue, 16 Sep 2014 20:56:57 +0200
Message-ID: <541887F9.3000100@web.de>
References: <5415C89C.4090509@web.de> <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com> <541886D5.8060202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxwH-0008JN-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbaIPS5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:57:17 -0400
Received: from mout.web.de ([212.227.17.11]:54325 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006AbaIPS5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:57:16 -0400
Received: from [192.168.178.27] ([79.253.189.35]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MZDTE-1XkXNR0yDs-00Kzdc; Tue, 16 Sep 2014 20:57:01
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <541886D5.8060202@web.de>
X-Provags-ID: V03:K0:94MsjIhzzzLxc3rFQuTnPPN+SxEBhhJ01iwJ4q5jb9qM3ZL3QFs
 Y27Vibi1+vRqzuPnVukt9PjIt7qSoamAH9SJgSj9qQJkaRXugjN5JF9VGbUzir5wIgS1oFH
 05hQZEJcw1Bm1Pg04Qb96IG1KoIGGAx6emvbJAb+XamtAqUgbVHaxDbz/6oHDC631HSa/uW
 hQJJrkgpOyM1srOhYQ+Gw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257144>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 attr.c                 |  3 +--
 builtin/apply.c        |  2 +-
 builtin/for-each-ref.c |  9 +++------
 builtin/index-pack.c   |  4 +---
 builtin/log.c          |  2 +-
 builtin/merge.c        |  2 +-
 builtin/mv.c           |  8 ++++----
 builtin/pack-objects.c |  3 +--
 builtin/show-branch.c  |  2 +-
 cache.h                |  2 +-
 column.c               |  6 ++----
 commit-slab.h          |  3 +--
 fast-import.c          |  2 +-
 git.c                  |  3 +--
 graph.c                | 14 ++++----------
 khash.h                | 12 ++++--------
 line-log.c             |  2 +-
 object.c               |  2 +-
 pack-bitmap-write.c    |  3 +--
 pack-bitmap.c          |  6 ++----
 pack-objects.c         |  3 +--
 revision.c             |  2 +-
 sh-i18n--envsubst.c    |  5 +----
 shallow.c              |  3 +--
 string-list.c          |  3 +--
 walker.c               |  4 ++--
 26 files changed, 40 insertions(+), 70 deletions(-)

diff --git a/attr.c b/attr.c
index 734222d..cd54697 100644
--- a/attr.c
+++ b/attr.c
@@ -97,8 +97,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 	a->attr_nr = attr_nr++;
 	git_attr_hash[pos] = a;
 
-	check_all_attr = xrealloc(check_all_attr,
-				  sizeof(*check_all_attr) * attr_nr);
+	REALLOC_ARRAY(check_all_attr, attr_nr);
 	check_all_attr[a->attr_nr].attr = a;
 	check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
 	return a;
diff --git a/builtin/apply.c b/builtin/apply.c
index f204cca..8714a88 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2626,7 +2626,7 @@ static void update_image(struct image *img,
 		 * NOTE: this knows that we never call remove_first_line()
 		 * on anything other than pre/post image.
 		 */
-		img->line = xrealloc(img->line, nr * sizeof(*img->line));
+		REALLOC_ARRAY(img->line, nr);
 		img->line_allocated = img->line;
 	}
 	if (preimage_limit != postimage->nr)
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 47bd624..7f55e68 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -138,10 +138,8 @@ static int parse_atom(const char *atom, const char *ep)
 	/* Add it in, including the deref prefix */
 	at = used_atom_cnt;
 	used_atom_cnt++;
-	used_atom = xrealloc(used_atom,
-			     (sizeof *used_atom) * used_atom_cnt);
-	used_atom_type = xrealloc(used_atom_type,
-				  (sizeof(*used_atom_type) * used_atom_cnt));
+	REALLOC_ARRAY(used_atom, used_atom_cnt);
+	REALLOC_ARRAY(used_atom_type, used_atom_cnt);
 	used_atom[at] = xmemdupz(atom, ep - atom);
 	used_atom_type[at] = valid_atom[i].cmp_type;
 	if (*atom == '*')
@@ -870,8 +868,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	ref->flag = flag;
 
 	cnt = cb->grab_cnt;
-	cb->grab_array = xrealloc(cb->grab_array,
-				  sizeof(*cb->grab_array) * (cnt + 1));
+	REALLOC_ARRAY(cb->grab_array, cnt + 1);
 	cb->grab_array[cnt++] = ref;
 	cb->grab_cnt = cnt;
 	return 0;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5568a5b..783623d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1140,9 +1140,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		int nr_objects_initial = nr_objects;
 		if (nr_unresolved <= 0)
 			die(_("confusion beyond insanity"));
-		objects = xrealloc(objects,
-				   (nr_objects + nr_unresolved + 1)
-				   * sizeof(*objects));
+		REALLOC_ARRAY(objects, nr_objects + nr_unresolved + 1);
 		memset(objects + nr_objects + 1, 0,
 		       nr_unresolved * sizeof(*objects));
 		f = sha1fd(output_fd, curr_pack);
diff --git a/builtin/log.c b/builtin/log.c
index e4d8122..7643396 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1440,7 +1440,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			continue;
 
 		nr++;
-		list = xrealloc(list, nr * sizeof(list[0]));
+		REALLOC_ARRAY(list, nr);
 		list[nr - 1] = commit;
 	}
 	if (nr == 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 9da9e30..cb9af1e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -556,7 +556,7 @@ static void parse_branch_merge_options(char *bmo)
 	if (argc < 0)
 		die(_("Bad branch.%s.mergeoptions string: %s"), branch,
 		    split_cmdline_strerror(argc));
-	argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
+	REALLOC_ARRAY(argv, argc + 2);
 	memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 	argc++;
 	argv[0] = "branch.*.mergeoptions";
diff --git a/builtin/mv.c b/builtin/mv.c
index bf784cb..8883baa 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -184,10 +184,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 				modes[i] = WORKING_DIRECTORY;
 				n = argc + last - first;
-				source = xrealloc(source, n * sizeof(char *));
-				destination = xrealloc(destination, n * sizeof(char *));
-				modes = xrealloc(modes, n * sizeof(enum update_mode));
-				submodule_gitfile = xrealloc(submodule_gitfile, n * sizeof(char *));
+				REALLOC_ARRAY(source, n);
+				REALLOC_ARRAY(destination, n);
+				REALLOC_ARRAY(modes, n);
+				REALLOC_ARRAY(submodule_gitfile, n);
 
 				dst = add_slash(dst);
 				dst_len = strlen(dst);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b59f5d8..d391934 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -89,8 +89,7 @@ static void index_commit_for_bitmap(struct commit *commit)
 {
 	if (indexed_commits_nr >= indexed_commits_alloc) {
 		indexed_commits_alloc = (indexed_commits_alloc + 32) * 2;
-		indexed_commits = xrealloc(indexed_commits,
-			indexed_commits_alloc * sizeof(struct commit *));
+		REALLOC_ARRAY(indexed_commits, indexed_commits_alloc);
 	}
 
 	indexed_commits[indexed_commits_nr++] = commit;
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 298c95e..a127523 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -563,7 +563,7 @@ static int git_show_branch_config(const char *var, const char *value, void *cb)
 			default_arg[default_num++] = "show-branch";
 		} else if (default_alloc <= default_num + 1) {
 			default_alloc = default_alloc * 3 / 2 + 20;
-			default_arg = xrealloc(default_arg, sizeof *default_arg * default_alloc);
+			REALLOC_ARRAY(default_arg, default_alloc);
 		}
 		default_arg[default_num++] = xstrdup(value);
 		default_arg[default_num] = NULL;
diff --git a/cache.h b/cache.h
index dfa1a56..6cbef2c 100644
--- a/cache.h
+++ b/cache.h
@@ -482,7 +482,7 @@ extern int daemonize(void);
 				alloc = (nr); \
 			else \
 				alloc = alloc_nr(alloc); \
-			x = xrealloc((x), alloc * sizeof(*(x))); \
+			REALLOC_ARRAY(x, alloc); \
 		} \
 	} while (0)
 
diff --git a/column.c b/column.c
index 76b615d..8082a94 100644
--- a/column.c
+++ b/column.c
@@ -81,8 +81,7 @@ static void compute_column_width(struct column_data *data)
  */
 static void shrink_columns(struct column_data *data)
 {
-	data->width = xrealloc(data->width,
-			       sizeof(*data->width) * data->cols);
+	REALLOC_ARRAY(data->width, data->cols);
 	while (data->rows > 1) {
 		int x, total_width, cols, rows;
 		rows = data->rows;
@@ -91,8 +90,7 @@ static void shrink_columns(struct column_data *data)
 		data->rows--;
 		data->cols = DIV_ROUND_UP(data->list->nr, data->rows);
 		if (data->cols != cols)
-			data->width = xrealloc(data->width,
-					       sizeof(*data->width) * data->cols);
+			REALLOC_ARRAY(data->width, data->cols);
 		compute_column_width(data);
 
 		total_width = strlen(data->opts.indent);
diff --git a/commit-slab.h b/commit-slab.h
index 375c9c7..f37ec38 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -90,8 +90,7 @@ static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
 									\
 	if (s->slab_count <= nth_slab) {				\
 		int i;							\
-		s->slab = xrealloc(s->slab,				\
-				   (nth_slab + 1) * sizeof(*s->slab));	\
+		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
 		stat_ ##slabname## realloc++;				\
 		for (i = s->slab_count; i <= nth_slab; i++)		\
 			s->slab[i] = NULL;				\
diff --git a/fast-import.c b/fast-import.c
index c071253..07f65ec 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -878,7 +878,7 @@ static void start_packfile(void)
 	pack_size = sizeof(hdr);
 	object_count = 0;
 
-	all_packs = xrealloc(all_packs, sizeof(*all_packs) * (pack_id + 1));
+	REALLOC_ARRAY(all_packs, pack_id + 1);
 	all_packs[pack_id] = p;
 }
 
diff --git a/git.c b/git.c
index 210f1ae..d5bb674 100644
--- a/git.c
+++ b/git.c
@@ -282,8 +282,7 @@ static int handle_alias(int *argcp, const char ***argv)
 				  "trace: alias expansion: %s =>",
 				  alias_command);
 
-		new_argv = xrealloc(new_argv, sizeof(char *) *
-				    (count + *argcp));
+		REALLOC_ARRAY(new_argv, count + *argcp);
 		/* insert after command name */
 		memcpy(new_argv + count, *argv + 1, sizeof(char *) * *argcp);
 
diff --git a/graph.c b/graph.c
index 6404331..288b9a6 100644
--- a/graph.c
+++ b/graph.c
@@ -267,16 +267,10 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
 		graph->column_capacity *= 2;
 	} while (graph->column_capacity < num_columns);
 
-	graph->columns = xrealloc(graph->columns,
-				  sizeof(struct column) *
-				  graph->column_capacity);
-	graph->new_columns = xrealloc(graph->new_columns,
-				      sizeof(struct column) *
-				      graph->column_capacity);
-	graph->mapping = xrealloc(graph->mapping,
-				  sizeof(int) * 2 * graph->column_capacity);
-	graph->new_mapping = xrealloc(graph->new_mapping,
-				      sizeof(int) * 2 * graph->column_capacity);
+	REALLOC_ARRAY(graph->columns, graph->column_capacity);
+	REALLOC_ARRAY(graph->new_columns, graph->column_capacity);
+	REALLOC_ARRAY(graph->mapping, graph->column_capacity * 2);
+	REALLOC_ARRAY(graph->new_mapping, graph->column_capacity * 2);
 }
 
 /*
diff --git a/khash.h b/khash.h
index 06c7906..376475a 100644
--- a/khash.h
+++ b/khash.h
@@ -121,13 +121,9 @@ static const double __ac_HASH_UPPER = 0.77;
 				if (!new_flags) return -1;								\
 				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)); \
 				if (h->n_buckets < new_n_buckets) {	/* expand */		\
-					khkey_t *new_keys = (khkey_t*)xrealloc((void *)h->keys, new_n_buckets * sizeof(khkey_t)); \
-					if (!new_keys) return -1;							\
-					h->keys = new_keys;									\
+					REALLOC_ARRAY(h->keys, new_n_buckets); \
 					if (kh_is_map) {									\
-						khval_t *new_vals = (khval_t*)xrealloc((void *)h->vals, new_n_buckets * sizeof(khval_t)); \
-						if (!new_vals) return -1;						\
-						h->vals = new_vals;								\
+						REALLOC_ARRAY(h->vals, new_n_buckets); \
 					}													\
 				} /* otherwise shrink */								\
 			}															\
@@ -160,8 +156,8 @@ static const double __ac_HASH_UPPER = 0.77;
 				}														\
 			}															\
 			if (h->n_buckets > new_n_buckets) { /* shrink the hash table */ \
-				h->keys = (khkey_t*)xrealloc((void *)h->keys, new_n_buckets * sizeof(khkey_t)); \
-				if (kh_is_map) h->vals = (khval_t*)xrealloc((void *)h->vals, new_n_buckets * sizeof(khval_t)); \
+				REALLOC_ARRAY(h->keys, new_n_buckets); \
+				if (kh_is_map) REALLOC_ARRAY(h->vals, new_n_buckets); \
 			}															\
 			free(h->flags); /* free the working space */				\
 			h->flags = new_flags;										\
diff --git a/line-log.c b/line-log.c
index 1008e72..038c58a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -533,7 +533,7 @@ static void fill_line_ends(struct diff_filespec *spec, long *lines,
 	}
 
 	/* shrink the array to fit the elements */
-	ends = xrealloc(ends, cur * sizeof(*ends));
+	REALLOC_ARRAY(ends, cur);
 	*lines = cur-1;
 	*line_ends = ends;
 }
diff --git a/object.c b/object.c
index a16b9f9..4e36669 100644
--- a/object.c
+++ b/object.c
@@ -312,7 +312,7 @@ static void add_object_array_with_mode_context(struct object *obj, const char *n
 
 	if (nr >= alloc) {
 		alloc = (alloc + 32) * 2;
-		objects = xrealloc(objects, alloc * sizeof(*objects));
+		REALLOC_ARRAY(objects, alloc);
 		array->alloc = alloc;
 		array->objects = objects;
 	}
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 5f1791a..8029ae3 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -111,8 +111,7 @@ static inline void push_bitmapped_commit(struct commit *commit, struct ewah_bitm
 {
 	if (writer.selected_nr >= writer.selected_alloc) {
 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
-		writer.selected = xrealloc(writer.selected,
-					   writer.selected_alloc * sizeof(struct bitmapped_commit));
+		REALLOC_ARRAY(writer.selected, writer.selected_alloc);
 	}
 
 	writer.selected[writer.selected_nr].commit = commit;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 91e4101..a1f3c0d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -400,10 +400,8 @@ static int ext_index_add_object(struct object *object, const char *name)
 	if (hash_ret > 0) {
 		if (eindex->count >= eindex->alloc) {
 			eindex->alloc = (eindex->alloc + 16) * 3 / 2;
-			eindex->objects = xrealloc(eindex->objects,
-				eindex->alloc * sizeof(struct object *));
-			eindex->hashes = xrealloc(eindex->hashes,
-				eindex->alloc * sizeof(uint32_t));
+			REALLOC_ARRAY(eindex->objects, eindex->alloc);
+			REALLOC_ARRAY(eindex->hashes, eindex->alloc);
 		}
 
 		bitmap_pos = eindex->count;
diff --git a/pack-objects.c b/pack-objects.c
index 9992f3e..6398a8a 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -92,8 +92,7 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 	if (pdata->nr_objects >= pdata->nr_alloc) {
 		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
-		pdata->objects = xrealloc(pdata->objects,
-					  pdata->nr_alloc * sizeof(*new_entry));
+		REALLOC_ARRAY(pdata->objects, pdata->nr_alloc);
 	}
 
 	new_entry = pdata->objects + pdata->nr_objects++;
diff --git a/revision.c b/revision.c
index 0d3e417..e498b7c 100644
--- a/revision.c
+++ b/revision.c
@@ -1397,7 +1397,7 @@ static void prepare_show_merge(struct rev_info *revs)
 			continue;
 		if (ce_path_match(ce, &revs->prune_data, NULL)) {
 			prune_num++;
-			prune = xrealloc(prune, sizeof(*prune) * prune_num);
+			REALLOC_ARRAY(prune, prune_num);
 			prune[prune_num-2] = ce->name;
 			prune[prune_num-1] = NULL;
 		}
diff --git a/sh-i18n--envsubst.c b/sh-i18n--envsubst.c
index 6dd03a9..2842a22 100644
--- a/sh-i18n--envsubst.c
+++ b/sh-i18n--envsubst.c
@@ -208,11 +208,8 @@ string_list_append (string_list_ty *slp, const char *s)
   /* Grow the list.  */
   if (slp->nitems >= slp->nitems_max)
     {
-      size_t nbytes;
-
       slp->nitems_max = slp->nitems_max * 2 + 4;
-      nbytes = slp->nitems_max * sizeof (slp->item[0]);
-      slp->item = (const char **) xrealloc (slp->item, nbytes);
+      REALLOC_ARRAY(slp->item, slp->nitems_max);
     }
 
   /* Add the string to the end of the list.  */
diff --git a/shallow.c b/shallow.c
index de07709..57f4afa 100644
--- a/shallow.c
+++ b/shallow.c
@@ -392,8 +392,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	void *p;
 	if (!info->slab_count || info->free + size > info->end) {
 		info->slab_count++;
-		info->slab = xrealloc(info->slab,
-				      info->slab_count * sizeof(*info->slab));
+		REALLOC_ARRAY(info->slab, info->slab_count);
 		info->free = xmalloc(COMMIT_SLAB_SIZE);
 		info->slab[info->slab_count - 1] = info->free;
 		info->end = info->free + COMMIT_SLAB_SIZE;
diff --git a/string-list.c b/string-list.c
index db38b62..c5aa076 100644
--- a/string-list.c
+++ b/string-list.c
@@ -43,8 +43,7 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 	if (list->nr + 1 >= list->alloc) {
 		list->alloc += 32;
-		list->items = xrealloc(list->items, list->alloc
-				* sizeof(struct string_list_item));
+		REALLOC_ARRAY(list->items, list->alloc);
 	}
 	if (index < list->nr)
 		memmove(list->items + index + 1, list->items + index,
diff --git a/walker.c b/walker.c
index f8d3709..18a67d3 100644
--- a/walker.c
+++ b/walker.c
@@ -228,8 +228,8 @@ int walker_targets_stdin(char ***target, const char ***write_ref)
 
 		if (targets >= targets_alloc) {
 			targets_alloc = targets_alloc ? targets_alloc * 2 : 64;
-			*target = xrealloc(*target, targets_alloc * sizeof(**target));
-			*write_ref = xrealloc(*write_ref, targets_alloc * sizeof(**write_ref));
+			REALLOC_ARRAY(*target, targets_alloc);
+			REALLOC_ARRAY(*write_ref, targets_alloc);
 		}
 		(*target)[targets] = xstrdup(tg_one);
 		(*write_ref)[targets] = rf_one ? xstrdup(rf_one) : NULL;
-- 
2.1.0
