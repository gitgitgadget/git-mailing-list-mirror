Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B0F1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 01:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503777AbfIXBEN (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:04:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59532 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391798AbfIXBEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:04:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 6779D1FAD4;
        Tue, 24 Sep 2019 01:03:28 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 17/19] hashmap: introduce hashmap_free_entries
Date:   Tue, 24 Sep 2019 01:03:22 +0000
Message-Id: <20190924010324.22619-18-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`hashmap_free_entries' behaves like `container_of' and passes
the offset of the hashmap_entry struct to the internal
`hashmap_free_' function, allowing the function to free any
struct pointer regardless of where the hashmap_entry field
is located.

`hashmap_free' no longer takes any arguments aside from
the hashmap itself.

Signed-off-by: Eric Wong <e@80x24.org>
---
 blame.c                 |  2 +-
 builtin/fetch.c         |  6 +++---
 config.c                |  2 +-
 diff.c                  |  6 ++++--
 diffcore-rename.c       |  2 +-
 hashmap.c               | 11 ++++++++---
 hashmap.h               | 19 +++++++++++++------
 merge-recursive.c       |  7 ++++---
 name-hash.c             |  4 ++--
 oidmap.c                |  4 +++-
 patch-ids.c             |  2 +-
 range-diff.c            |  2 +-
 ref-filter.c            |  3 ++-
 revision.c              |  2 +-
 sequencer.c             |  4 ++--
 submodule-config.c      |  4 ++--
 t/helper/test-hashmap.c |  6 +++---
 17 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/blame.c b/blame.c
index 3d8accf902..f33af0da9f 100644
--- a/blame.c
+++ b/blame.c
@@ -433,7 +433,7 @@ static void get_fingerprint(struct fingerprint *result,
 
 static void free_fingerprint(struct fingerprint *f)
 {
-	hashmap_free(&f->map, 0);
+	hashmap_free(&f->map);
 	free(f->entries);
 }
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 476c2416e3..09f7170616 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -366,7 +366,7 @@ static void find_non_local_tags(const struct ref *refs,
 		item = refname_hash_add(&remote_refs, ref->name, &ref->old_oid);
 		string_list_insert(&remote_refs_list, ref->name);
 	}
-	hashmap_free(&existing_refs, 1);
+	hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
 
 	/*
 	 * We may have a final lightweight tag that needs to be
@@ -401,7 +401,7 @@ static void find_non_local_tags(const struct ref *refs,
 		**tail = rm;
 		*tail = &rm->next;
 	}
-	hashmap_free(&remote_refs, 1);
+	hashmap_free_entries(&remote_refs, struct refname_hash_entry, ent);
 	string_list_clear(&remote_refs_list, 0);
 }
 
@@ -530,7 +530,7 @@ static struct ref *get_ref_map(struct remote *remote,
 			}
 		}
 	}
-	hashmap_free(&existing_refs, 1);
+	hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
 
 	return ref_map;
 }
diff --git a/config.c b/config.c
index 8433f74371..4d05dbc15a 100644
--- a/config.c
+++ b/config.c
@@ -1948,7 +1948,7 @@ void git_configset_clear(struct config_set *cs)
 		free(entry->key);
 		string_list_clear(&entry->value_list, 1);
 	}
-	hashmap_free(&cs->config_hash, 1);
+	hashmap_free_entries(&cs->config_hash, struct config_set_element, ent);
 	cs->hash_initialized = 0;
 	free(cs->list.items);
 	cs->list.nr = 0;
diff --git a/diff.c b/diff.c
index 5eaf689fcc..f94d9f96af 100644
--- a/diff.c
+++ b/diff.c
@@ -6236,8 +6236,10 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
 				dim_moved_lines(o);
 
-			hashmap_free(&add_lines, 1);
-			hashmap_free(&del_lines, 1);
+			hashmap_free_entries(&add_lines, struct moved_entry,
+						ent);
+			hashmap_free_entries(&del_lines, struct moved_entry,
+						ent);
 		}
 
 		for (i = 0; i < esm.nr; i++)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 611b08f463..994609ed58 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -358,7 +358,7 @@ static int find_exact_renames(struct diff_options *options)
 		renames += find_identical_files(&file_table, i, options);
 
 	/* Free the hash data structure and entries */
-	hashmap_free(&file_table, 1);
+	hashmap_free_entries(&file_table, struct file_similarity, entry);
 
 	return renames;
 }
diff --git a/hashmap.c b/hashmap.c
index 75ad053de1..1efd5e431b 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -171,16 +171,21 @@ void hashmap_init(struct hashmap *map, hashmap_cmp_fn equals_function,
 	map->do_count_items = 1;
 }
 
-void hashmap_free(struct hashmap *map, int free_entries)
+void hashmap_free_(struct hashmap *map, ssize_t entry_offset)
 {
 	if (!map || !map->table)
 		return;
-	if (free_entries) {
+	if (entry_offset >= 0) { /* called by hashmap_free_entries */
 		struct hashmap_iter iter;
 		struct hashmap_entry *e;
+
 		hashmap_iter_init(map, &iter);
 		while ((e = hashmap_iter_next(&iter)))
-			free(e);
+			/*
+			 * like container_of, but using caller-calculated
+			 * offset (caller being hashmap_free_entries)
+			 */
+			free((char *)e - entry_offset);
 	}
 	free(map->table);
 	memset(map, 0, sizeof(*map));
diff --git a/hashmap.h b/hashmap.h
index e4078135dd..7c7a54d15e 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -96,7 +96,7 @@
  *         }
  *
  *         if (!strcmp("end", action)) {
- *             hashmap_free(&map, 1);
+ *             hashmap_free_entries(&map, struct long2string, ent);
  *             break;
  *         }
  *     }
@@ -232,13 +232,20 @@ void hashmap_init(struct hashmap *map,
 			 const void *equals_function_data,
 			 size_t initial_size);
 
+/* internal function for freeing hashmap */
+void hashmap_free_(struct hashmap *map, ssize_t offset);
+
 /*
- * Frees a hashmap structure and allocated memory.
- *
- * If `free_entries` is true, each hashmap_entry in the map is freed as well
- * using stdlibs free().
+ * Frees a hashmap structure and allocated memory, leaves entries undisturbed
+ */
+#define hashmap_free(map) hashmap_free_(map, -1)
+
+/*
+ * Frees @map and all entries.  @type is the struct type of the entry
+ * where @member is the hashmap_entry struct used to associate with @map
  */
-void hashmap_free(struct hashmap *map, int free_entries);
+#define hashmap_free_entries(map, type, member) \
+	hashmap_free_(map, offsetof(type, member));
 
 /* hashmap_entry functions */
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 73c7750448..34b3d54154 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2633,7 +2633,7 @@ static struct string_list *get_renames(struct merge_options *opt,
 		free(e->target_file);
 		string_list_clear(&e->source_files, 0);
 	}
-	hashmap_free(&collisions, 1);
+	hashmap_free_entries(&collisions, struct collision_entry, ent);
 	return renames;
 }
 
@@ -2853,7 +2853,7 @@ static void initial_cleanup_rename(struct diff_queue_struct *pairs,
 		strbuf_release(&e->new_dir);
 		/* possible_new_dirs already cleared in get_directory_renames */
 	}
-	hashmap_free(dir_renames, 1);
+	hashmap_free_entries(dir_renames, struct dir_rename_entry, ent);
 	free(dir_renames);
 
 	free(pairs->queue);
@@ -3482,7 +3482,8 @@ int merge_trees(struct merge_options *opt,
 		string_list_clear(entries, 1);
 		free(entries);
 
-		hashmap_free(&opt->current_file_dir_set, 1);
+		hashmap_free_entries(&opt->current_file_dir_set,
+					struct path_hashmap_entry, e);
 
 		if (clean < 0) {
 			unpack_trees_finish(opt);
diff --git a/name-hash.c b/name-hash.c
index 85a1ce982c..c86fe0f1df 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -728,6 +728,6 @@ void free_name_hash(struct index_state *istate)
 		return;
 	istate->name_hash_initialized = 0;
 
-	hashmap_free(&istate->name_hash, 0);
-	hashmap_free(&istate->dir_hash, 1);
+	hashmap_free(&istate->name_hash);
+	hashmap_free_entries(&istate->dir_hash, struct dir_entry, ent);
 }
diff --git a/oidmap.c b/oidmap.c
index 4942599391..423aa014a3 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -25,7 +25,9 @@ void oidmap_free(struct oidmap *map, int free_entries)
 {
 	if (!map)
 		return;
-	hashmap_free(&map->map, free_entries);
+
+	/* TODO: make oidmap itself not depend on struct layouts */
+	hashmap_free_(&map->map, free_entries ? 0 : -1);
 }
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
diff --git a/patch-ids.c b/patch-ids.c
index 75f8c9f1a1..af17828e33 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -71,7 +71,7 @@ int init_patch_ids(struct repository *r, struct patch_ids *ids)
 
 int free_patch_ids(struct patch_ids *ids)
 {
-	hashmap_free(&ids->patches, 1);
+	hashmap_free_entries(&ids->patches, struct patch_id, ent);
 	return 0;
 }
 
diff --git a/range-diff.c b/range-diff.c
index e5e7820bfe..9df53569bb 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -241,7 +241,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		}
 	}
 
-	hashmap_free(&map, 0);
+	hashmap_free(&map);
 }
 
 static void diffsize_consume(void *data, char *line, unsigned long len)
diff --git a/ref-filter.c b/ref-filter.c
index 4613df8826..0950b789e3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2172,7 +2172,8 @@ void ref_array_clear(struct ref_array *array)
 	used_atom_cnt = 0;
 
 	if (ref_to_worktree_map.worktrees) {
-		hashmap_free(&(ref_to_worktree_map.map), 1);
+		hashmap_free_entries(&(ref_to_worktree_map.map),
+					struct ref_to_worktree_entry, ent);
 		free_worktrees(ref_to_worktree_map.worktrees);
 		ref_to_worktree_map.worktrees = NULL;
 	}
diff --git a/revision.c b/revision.c
index f28cbe5de8..8a5f866ae6 100644
--- a/revision.c
+++ b/revision.c
@@ -136,7 +136,7 @@ static void paths_and_oids_clear(struct hashmap *map)
 		free(entry->path);
 	}
 
-	hashmap_free(map, 1);
+	hashmap_free_entries(map, struct path_and_oids_entry, ent);
 }
 
 static void paths_and_oids_insert(struct hashmap *map,
diff --git a/sequencer.c b/sequencer.c
index b3e7319b55..694b463518 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4772,7 +4772,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 
 	oidmap_free(&commit2todo, 1);
 	oidmap_free(&state.commit2label, 1);
-	hashmap_free(&state.labels, 1);
+	hashmap_free_entries(&state.labels, struct labels_entry, entry);
 	strbuf_release(&state.buf);
 
 	return 0;
@@ -5301,7 +5301,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 	for (i = 0; i < todo_list->nr; i++)
 		free(subjects[i]);
 	free(subjects);
-	hashmap_free(&subject2item, 1);
+	hashmap_free_entries(&subject2item, struct subject2item_entry, entry);
 
 	clear_commit_todo_item(&commit_todo);
 
diff --git a/submodule-config.c b/submodule-config.c
index a289d195f6..5462acc8ec 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -103,8 +103,8 @@ static void submodule_cache_clear(struct submodule_cache *cache)
 				struct submodule_entry, ent /* member name */)
 		free_one_config(entry);
 
-	hashmap_free(&cache->for_path, 1);
-	hashmap_free(&cache->for_name, 1);
+	hashmap_free_entries(&cache->for_path, struct submodule_entry, ent);
+	hashmap_free_entries(&cache->for_name, struct submodule_entry, ent);
 	cache->initialized = 0;
 	cache->gitmodules_read = 0;
 }
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 07a93a2aec..6f2530dcc8 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -109,7 +109,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 				hashmap_add(&map, &entries[i]->ent);
 			}
 
-			hashmap_free(&map, 0);
+			hashmap_free(&map);
 		}
 	} else {
 		/* test map lookups */
@@ -129,7 +129,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 			}
 		}
 
-		hashmap_free(&map, 0);
+		hashmap_free(&map);
 	}
 }
 
@@ -266,6 +266,6 @@ int cmd__hashmap(int argc, const char **argv)
 	}
 
 	strbuf_release(&line);
-	hashmap_free(&map, 1);
+	hashmap_free_entries(&map, struct test_entry, ent);
 	return 0;
 }
