Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876B51F466
	for <e@80x24.org>; Tue, 24 Sep 2019 01:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503748AbfIXBDk (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 21:03:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59226 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392394AbfIXBDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 21:03:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id DB3E91F4B9;
        Tue, 24 Sep 2019 01:03:25 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH v2 06/19] hashmap_add takes "struct hashmap_entry *"
Date:   Tue, 24 Sep 2019 01:03:11 +0000
Message-Id: <20190924010324.22619-7-e@80x24.org>
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
References: <20190924010324.22619-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is less error-prone than "void *" as the compiler now
detects invalid types being passed.

Signed-off-by: Eric Wong <e@80x24.org>
---
 attr.c                  | 2 +-
 blame.c                 | 2 +-
 builtin/describe.c      | 2 +-
 builtin/difftool.c      | 6 +++---
 builtin/fetch.c         | 2 +-
 config.c                | 2 +-
 diff.c                  | 2 +-
 diffcore-rename.c       | 2 +-
 hashmap.c               | 6 +++---
 hashmap.h               | 4 ++--
 merge-recursive.c       | 4 ++--
 name-hash.c             | 8 ++++----
 packfile.c              | 2 +-
 patch-ids.c             | 2 +-
 range-diff.c            | 2 +-
 ref-filter.c            | 2 +-
 sequencer.c             | 2 +-
 sub-process.c           | 2 +-
 submodule-config.c      | 2 +-
 t/helper/test-hashmap.c | 6 +++---
 20 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/attr.c b/attr.c
index a8be7a7b4f..fa26a3e3cb 100644
--- a/attr.c
+++ b/attr.c
@@ -122,7 +122,7 @@ static void attr_hashmap_add(struct attr_hashmap *map,
 	e->keylen = keylen;
 	e->value = value;
 
-	hashmap_add(&map->map, e);
+	hashmap_add(&map->map, &e->ent);
 }
 
 struct all_attrs_item {
diff --git a/blame.c b/blame.c
index 46059410cd..4d20aee435 100644
--- a/blame.c
+++ b/blame.c
@@ -424,7 +424,7 @@ static void get_fingerprint(struct fingerprint *result,
 			found_entry->count += 1;
 		} else {
 			entry->count = 1;
-			hashmap_add(&result->map, entry);
+			hashmap_add(&result->map, &entry->entry);
 			++entry;
 		}
 	}
diff --git a/builtin/describe.c b/builtin/describe.c
index 596ddf89a5..f5e0a7e033 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -124,7 +124,7 @@ static void add_to_known_names(const char *path,
 			e = xmalloc(sizeof(struct commit_name));
 			oidcpy(&e->peeled, peeled);
 			hashmap_entry_init(&e->entry, oidhash(peeled));
-			hashmap_add(&names, e);
+			hashmap_add(&names, &e->entry);
 			e->path = NULL;
 		}
 		e->tag = tag;
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 98ffc04c61..82c146718d 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -168,7 +168,7 @@ static void add_left_or_right(struct hashmap *map, const char *path,
 		e = existing;
 	} else {
 		e->left[0] = e->right[0] = '\0';
-		hashmap_add(map, e);
+		hashmap_add(map, &e->entry);
 	}
 	strlcpy(is_right ? e->right : e->left, content, PATH_MAX);
 }
@@ -235,7 +235,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 		struct path_entry *entry;
 		FLEX_ALLOC_STR(entry, path, buf.buf);
 		hashmap_entry_init(&entry->entry, strhash(buf.buf));
-		hashmap_add(result, entry);
+		hashmap_add(result, &entry->entry);
 	}
 	fclose(fp);
 	if (finish_command(&diff_files))
@@ -466,7 +466,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 				free(entry);
 				continue;
 			}
-			hashmap_add(&working_tree_dups, entry);
+			hashmap_add(&working_tree_dups, &entry->entry);
 
 			if (!use_wt_file(workdir, dst_path, &roid)) {
 				if (checkout_path(rmode, &roid, dst_path,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b7d70eee70..909dbde909 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -278,7 +278,7 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	FLEX_ALLOC_MEM(ent, refname, refname, len);
 	hashmap_entry_init(&ent->ent, strhash(refname));
 	oidcpy(&ent->oid, oid);
-	hashmap_add(map, ent);
+	hashmap_add(map, &ent->ent);
 	return ent;
 }
 
diff --git a/config.c b/config.c
index 08d866e7de..2243d7c3d6 100644
--- a/config.c
+++ b/config.c
@@ -1885,7 +1885,7 @@ static int configset_add_value(struct config_set *cs, const char *key, const cha
 		hashmap_entry_init(&e->ent, strhash(key));
 		e->key = xstrdup(key);
 		string_list_init(&e->value_list, 1);
-		hashmap_add(&cs->config_hash, e);
+		hashmap_add(&cs->config_hash, &e->ent);
 	}
 	si = string_list_append_nodup(&e->value_list, xstrdup_or_null(value));
 
diff --git a/diff.c b/diff.c
index 1168f0cbb9..cc7f06d10d 100644
--- a/diff.c
+++ b/diff.c
@@ -1003,7 +1003,7 @@ static void add_lines_to_move_detection(struct diff_options *o,
 		if (prev_line && prev_line->es->s == o->emitted_symbols->buf[n].s)
 			prev_line->next_line = key;
 
-		hashmap_add(hm, key);
+		hashmap_add(hm, &key->ent);
 		prev_line = key;
 	}
 }
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 2a1449013b..4670a40179 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -330,7 +330,7 @@ static void insert_file_table(struct repository *r,
 	entry->filespec = filespec;
 
 	hashmap_entry_init(&entry->entry, hash_filespec(r, filespec));
-	hashmap_add(table, entry);
+	hashmap_add(table, &entry->entry);
 }
 
 /*
diff --git a/hashmap.c b/hashmap.c
index c1de40eea0..9c2db3e0c8 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -201,12 +201,12 @@ void *hashmap_get_next(const struct hashmap *map,
 	return NULL;
 }
 
-void hashmap_add(struct hashmap *map, void *entry)
+void hashmap_add(struct hashmap *map, struct hashmap_entry *entry)
 {
 	unsigned int b = bucket(map, entry);
 
 	/* add entry */
-	((struct hashmap_entry *) entry)->next = map->table[b];
+	entry->next = map->table[b];
 	map->table[b] = entry;
 
 	/* fix size and rehash if appropriate */
@@ -302,7 +302,7 @@ const void *memintern(const void *data, size_t len)
 		FLEX_ALLOC_MEM(e, data, data, len);
 		hashmap_entry_init(&e->ent, key.ent.hash);
 		e->len = len;
-		hashmap_add(&map, e);
+		hashmap_add(&map, &e->ent);
 	}
 	return e->data;
 }
diff --git a/hashmap.h b/hashmap.h
index d607da525b..40bcc64289 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -50,7 +50,7 @@
  *             FLEX_ALLOC_STR(e, value, value);
  *             hashmap_entry_init(&e->ent, memhash(&key, sizeof(long)));
  *             e->key = key;
- *             hashmap_add(&map, e);
+ *             hashmap_add(&map, &e->ent);
  *         }
  *
  *         if (!strcmp("print_all_by_key", action)) {
@@ -328,7 +328,7 @@ void *hashmap_get_next(const struct hashmap *map,
  * `map` is the hashmap structure.
  * `entry` is the entry to add.
  */
-void hashmap_add(struct hashmap *map, void *entry);
+void hashmap_add(struct hashmap *map, struct hashmap_entry *entry);
 
 /*
  * Adds or replaces a hashmap entry. If the hashmap contains duplicate
diff --git a/merge-recursive.c b/merge-recursive.c
index 6bc4f14ff4..db9b247ece 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -455,7 +455,7 @@ static int save_files_dirs(const struct object_id *oid,
 
 	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
 	hashmap_entry_init(&entry->e, path_hash(entry->path));
-	hashmap_add(&opt->current_file_dir_set, entry);
+	hashmap_add(&opt->current_file_dir_set, &entry->e);
 
 	strbuf_setlen(base, baselen);
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
@@ -732,7 +732,7 @@ static char *unique_path(struct merge_options *opt, const char *path, const char
 
 	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
 	hashmap_entry_init(&entry->e, path_hash(entry->path));
-	hashmap_add(&opt->current_file_dir_set, entry);
+	hashmap_add(&opt->current_file_dir_set, &entry->e);
 	return strbuf_detach(&newpath, NULL);
 }
 
diff --git a/name-hash.c b/name-hash.c
index 4d84326c58..faec682bc7 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -70,7 +70,7 @@ static struct dir_entry *hash_dir_entry(struct index_state *istate,
 		FLEX_ALLOC_MEM(dir, name, ce->name, namelen);
 		hashmap_entry_init(&dir->ent, memihash(ce->name, namelen));
 		dir->namelen = namelen;
-		hashmap_add(&istate->dir_hash, dir);
+		hashmap_add(&istate->dir_hash, &dir->ent);
 
 		/* recursively add missing parent directories */
 		dir->parent = hash_dir_entry(istate, ce, namelen);
@@ -107,7 +107,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 		return;
 	ce->ce_flags |= CE_HASHED;
 	hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
-	hashmap_add(&istate->name_hash, ce);
+	hashmap_add(&istate->name_hash, &ce->ent);
 
 	if (ignore_case)
 		add_dir_entry(istate, ce);
@@ -283,7 +283,7 @@ static struct dir_entry *hash_dir_entry_with_parent_and_prefix(
 		hashmap_entry_init(&dir->ent, hash);
 		dir->namelen = prefix->len;
 		dir->parent = parent;
-		hashmap_add(&istate->dir_hash, dir);
+		hashmap_add(&istate->dir_hash, &dir->ent);
 
 		if (parent) {
 			unlock_dir_mutex(lock_nr);
@@ -473,7 +473,7 @@ static void *lazy_name_thread_proc(void *_data)
 		struct cache_entry *ce_k = d->istate->cache[k];
 		ce_k->ce_flags |= CE_HASHED;
 		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
-		hashmap_add(&d->istate->name_hash, ce_k);
+		hashmap_add(&d->istate->name_hash, &ce_k->ent);
 	}
 
 	return NULL;
diff --git a/packfile.c b/packfile.c
index 96535eb86b..f7402c470b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1488,7 +1488,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	if (!delta_base_cache.cmpfn)
 		hashmap_init(&delta_base_cache, delta_base_cache_hash_cmp, NULL, 0);
 	hashmap_entry_init(&ent->ent, pack_entry_hash(p, base_offset));
-	hashmap_add(&delta_base_cache, ent);
+	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
 int packed_object_info(struct repository *r, struct packed_git *p,
diff --git a/patch-ids.c b/patch-ids.c
index a2da711678..f87b62bf58 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -116,6 +116,6 @@ struct patch_id *add_commit_patch_id(struct commit *commit,
 		return NULL;
 	}
 
-	hashmap_add(&ids->patches, key);
+	hashmap_add(&ids->patches, &key->ent);
 	return key;
 }
diff --git a/range-diff.c b/range-diff.c
index 32b29f9594..96f955d84d 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -218,7 +218,7 @@ static void find_exact_matches(struct string_list *a, struct string_list *b)
 		util->patch = a->items[i].string;
 		util->diff = util->patch + util->diff_offset;
 		hashmap_entry_init(&util->e, strhash(util->diff));
-		hashmap_add(&map, util);
+		hashmap_add(&map, &util->e);
 	}
 
 	/* Now try to find exact matches in b */
diff --git a/ref-filter.c b/ref-filter.c
index 206014c93d..d939ebc6bb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1568,7 +1568,7 @@ static void populate_worktree_map(struct hashmap *map, struct worktree **worktre
 			hashmap_entry_init(&entry->ent,
 					strhash(worktrees[i]->head_ref));
 
-			hashmap_add(map, entry);
+			hashmap_add(map, &entry->ent);
 		}
 	}
 }
diff --git a/sequencer.c b/sequencer.c
index 1140cdf526..ee11cda7e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4539,7 +4539,7 @@ static const char *label_oid(struct object_id *oid, const char *label,
 
 	FLEX_ALLOC_STR(labels_entry, label, label);
 	hashmap_entry_init(&labels_entry->entry, strihash(label));
-	hashmap_add(&state->labels, labels_entry);
+	hashmap_add(&state->labels, &labels_entry->entry);
 
 	FLEX_ALLOC_STR(string_entry, string, label);
 	oidcpy(&string_entry->entry.oid, oid);
diff --git a/sub-process.c b/sub-process.c
index 9847dad6fc..d58e069855 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -105,7 +105,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 		return err;
 	}
 
-	hashmap_add(hashmap, entry);
+	hashmap_add(hashmap, &entry->ent);
 	return 0;
 }
 
diff --git a/submodule-config.c b/submodule-config.c
index 4aa02e280e..a3bbd9fd6f 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -149,7 +149,7 @@ static void cache_add(struct submodule_cache *cache,
 	struct submodule_entry *e = xmalloc(sizeof(*e));
 	hashmap_entry_init(&e->ent, hash);
 	e->config = submodule;
-	hashmap_add(&cache->for_name, e);
+	hashmap_add(&cache->for_name, &e->ent);
 }
 
 static const struct submodule *cache_lookup_path(struct submodule_cache *cache,
diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index bf063a2521..49e715f1cd 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -104,7 +104,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 			/* add entries */
 			for (i = 0; i < TEST_SIZE; i++) {
 				hashmap_entry_init(&entries[i]->ent, hashes[i]);
-				hashmap_add(&map, entries[i]);
+				hashmap_add(&map, &entries[i]->ent);
 			}
 
 			hashmap_free(&map, 0);
@@ -117,7 +117,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 		j = (method & TEST_SPARSE) ? TEST_SIZE / 10 : TEST_SIZE;
 		for (i = 0; i < j; i++) {
 			hashmap_entry_init(&entries[i]->ent, hashes[i]);
-			hashmap_add(&map, entries[i]);
+			hashmap_add(&map, &entries[i]->ent);
 		}
 
 		for (j = 0; j < rounds; j++) {
@@ -179,7 +179,7 @@ int cmd__hashmap(int argc, const char **argv)
 			entry = alloc_test_entry(hash, p1, p2);
 
 			/* add to hashmap */
-			hashmap_add(&map, entry);
+			hashmap_add(&map, &entry->ent);
 
 		} else if (!strcmp("put", cmd) && p1 && p2) {
 
