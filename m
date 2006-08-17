From: David Rientjes <rientjes@google.com>
Subject: [PATCH] introduce inline is_same_sha1
Date: Wed, 16 Aug 2006 17:25:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608161721020.11465@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Aug 17 02:26:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDVhz-0001QW-Sv
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 02:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWHQAZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 20:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWHQAZ4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 20:25:56 -0400
Received: from smtp-out.google.com ([216.239.45.12]:12549 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932157AbWHQAZy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 20:25:54 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7H0PbNm030223
	for <git@vger.kernel.org>; Wed, 16 Aug 2006 17:25:37 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=DybBPrpg4M3goz2GG0/zUm7esheBAQYNj4zyQEMUX+zcJmsZiTcKgXPtDNr1028Ar
	iG/BYQqQLS2cfeCHhsTEg==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7H0PVKO019263
	for <git@vger.kernel.org>; Wed, 16 Aug 2006 17:25:31 -0700
Received: by localhost (Postfix, from userid 24081)
	id 3753A87D71; Wed, 16 Aug 2006 17:25:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id ED66387D70
	for <git@vger.kernel.org>; Wed, 16 Aug 2006 17:25:30 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25540>

Introduces global inline:
	is_same_sha1(const unsigned char *sha1,
		     const unsigned char *sha2);

Uses memcmp for comparison and returns the result.  All tests for comparisons 
for sha1 have been changed to use the new global inline, but existing uses of 
memcmp have been preserved where the return value other than 0 is needed, i.e.:

	int cmp = !memcmp(old_sha1, new_sha1, 20);

Conversions from char* to unsigned char* casts have been made where appropriate.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-commit-tree.c    |    2 +-
 builtin-diff-stages.c    |    2 +-
 builtin-diff.c           |    2 +-
 builtin-pack-objects.c   |    6 +++---
 builtin-show-branch.c    |    4 ++--
 builtin-unpack-objects.c |    4 ++--
 builtin-update-index.c   |    4 ++--
 cache.h                  |    4 ++++
 combine-diff.c           |    4 ++--
 diff-lib.c               |    2 +-
 diff.c                   |    8 ++++----
 diffcore-break.c         |    2 +-
 diffcore-rename.c        |    2 +-
 dump-cache-tree.c        |    2 +-
 http-fetch.c             |    6 +++---
 http-push.c              |    4 ++--
 index-pack.c             |   10 ++++++----
 merge-tree.c             |    2 +-
 object.c                 |    2 +-
 pack-check.c             |    6 +++---
 read-cache.c             |    2 +-
 refs.c                   |    8 ++++----
 send-pack.c              |    2 +-
 sha1_file.c              |   16 ++++++++--------
 sha1_name.c              |    4 ++--
 ssh-fetch.c              |    2 +-
 tree-diff.c              |    2 +-
 unpack-trees.c           |    2 +-
 28 files changed, 61 insertions(+), 55 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 9c98796..99fab3b 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -69,7 +69,7 @@ static int new_parent(int idx)
 	int i;
 	unsigned char *sha1 = parent_sha1[idx];
 	for (i = 0; i < idx; i++) {
-		if (!memcmp(parent_sha1[i], sha1, 20)) {
+		if (is_same_sha1(parent_sha1[i], sha1)) {
 			error("duplicate parent %s ignored", sha1_to_hex(sha1));
 			return 0;
 		}
diff --git a/builtin-diff-stages.c b/builtin-diff-stages.c
index 5960e08..4593fd2 100644
--- a/builtin-diff-stages.c
+++ b/builtin-diff-stages.c
@@ -46,7 +46,7 @@ static void diff_stages(int stage1, int 
 		else if (!two)
 			diff_addremove(&diff_options, '-', ntohl(one->ce_mode),
 				       one->sha1, name, NULL);
-		else if (memcmp(one->sha1, two->sha1, 20) ||
+		else if (!is_same_sha1(one->sha1, two->sha1) ||
 			 (one->ce_mode != two->ce_mode) ||
 			 diff_options.find_copies_harder)
 			diff_change(&diff_options,
diff --git a/builtin-diff.c b/builtin-diff.c
index 40e5c96..12ae9b1 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -69,7 +69,7 @@ static void stuff_change(struct diff_opt
 	struct diff_filespec *one, *two;
 
 	if (!is_null_sha1(old_sha1) && !is_null_sha1(new_sha1) &&
-	    !memcmp(old_sha1, new_sha1, 20))
+	    is_same_sha1(old_sha1, new_sha1))
 		return;
 
 	if (opt->reverse_diff) {
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 448461b..3c1d3c1 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -441,7 +441,7 @@ static int locate_object_entry_hash(cons
 	memcpy(&ui, sha1, sizeof(unsigned int));
 	i = ui % object_ix_hashsz;
 	while (0 < object_ix[i]) {
-		if (!memcmp(sha1, objects[object_ix[i]-1].sha1, 20))
+		if (is_same_sha1(sha1, objects[object_ix[i] - 1].sha1))
 			return i;
 		if (++i == object_ix_hashsz)
 			i = 0;
@@ -607,7 +607,7 @@ static struct pbase_tree_cache *pbase_tr
 	 */
 	for (neigh = 0; neigh < 8; neigh++) {
 		ent = pbase_tree_cache[my_ix];
-		if (ent && !memcmp(ent->sha1, sha1, 20)) {
+		if (ent && is_same_sha1(ent->sha1, sha1)) {
 			ent->ref++;
 			return ent;
 		}
@@ -789,7 +789,7 @@ static void add_preferred_base(unsigned 
 		return;
 
 	for (it = pbase_tree; it; it = it->next) {
-		if (!memcmp(it->pcache.sha1, tree_sha1, 20)) {
+		if (is_same_sha1(it->pcache.sha1, tree_sha1)) {
 			free(data);
 			return;
 		}
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 95fbf77..88c7c1c 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -378,7 +378,7 @@ static int append_head_ref(const char *r
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (get_sha1(refname + ofs, tmp) || memcmp(tmp, sha1, 20))
+	if (get_sha1(refname + ofs, tmp) || !is_same_sha1(tmp, sha1))
 		ofs = 5;
 	return append_ref(refname + ofs, sha1);
 }
@@ -442,7 +442,7 @@ static int rev_is_head(char *head_path, 
 {
 	int namelen;
 	if ((!head_path[0]) ||
-	    (head_sha1 && sha1 && memcmp(head_sha1, sha1, 20)))
+	    (head_sha1 && sha1 && !is_same_sha1(head_sha1, sha1)))
 		return 0;
 	namelen = strlen(name);
 	if ((headlen < namelen) ||
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 63f4b8e..4f42d21 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -136,7 +136,7 @@ static void added_object(unsigned char *
 	struct delta_info *info;
 
 	while ((info = *p) != NULL) {
-		if (!memcmp(info->base_sha1, sha1, 20)) {
+		if (is_same_sha1(info->base_sha1, sha1)) {
 			*p = info->next;
 			p = &delta_list;
 			resolve_delta(type, data, size, info->delta, info->size);
@@ -292,7 +292,7 @@ int cmd_unpack_objects(int argc, const c
 	unpack_all();
 	SHA1_Update(&ctx, buffer, offset);
 	SHA1_Final(sha1, &ctx);
-	if (memcmp(fill(20), sha1, 20))
+	if (!is_same_sha1(fill(20), sha1))
 		die("final sha1 did not match");
 	use(20);
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 9f0cf28..1f74edd 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -378,7 +378,7 @@ static int unresolve_one(const char *pat
 		ret = -1;
 		goto free_return;
 	}
-	if (!memcmp(ce_2->sha1, ce_3->sha1, 20) &&
+	if (is_same_sha1(ce_2->sha1, ce_3->sha1) &&
 	    ce_2->ce_mode == ce_3->ce_mode) {
 		fprintf(stderr, "%s: identical in both, skipping.\n",
 			path);
@@ -460,7 +460,7 @@ static int do_reupdate(int ac, const cha
 			old = read_one_ent(NULL, head_sha1,
 					   ce->name, ce_namelen(ce), 0);
 		if (old && ce->ce_mode == old->ce_mode &&
-		    !memcmp(ce->sha1, old->sha1, 20)) {
+		    is_same_sha1(ce->sha1, old->sha1)) {
 			free(old);
 			continue; /* unchanged */
 		}
diff --git a/cache.h b/cache.h
index c738299..5a78b03 100644
--- a/cache.h
+++ b/cache.h
@@ -214,6 +214,10 @@ static inline int is_null_sha1(const uns
 {
 	return !memcmp(sha1, null_sha1, 20);
 }
+static inline int is_same_sha1(const unsigned char *sha1, const unsigned char *sha2)
+{
+	return !memcmp(sha1, sha2, 20);
+}
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
diff --git a/combine-diff.c b/combine-diff.c
index ce063b4..c78a157 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -688,8 +688,8 @@ static void show_patch_diff(struct combi
 	for (i = 0; i < num_parent; i++) {
 		int j;
 		for (j = 0; j < i; j++) {
-			if (!memcmp(elem->parent[i].sha1,
-				    elem->parent[j].sha1, 20)) {
+			if (is_same_sha1(elem->parent[i].sha1,
+					 elem->parent[j].sha1)) {
 				reuse_combine_diff(sline, cnt, i, j);
 				break;
 			}
diff --git a/diff-lib.c b/diff-lib.c
index 116b5a9..4bcb350 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -215,7 +215,7 @@ static int show_modified(struct rev_info
 	}
 
 	oldmode = old->ce_mode;
-	if (mode == oldmode && !memcmp(sha1, old->sha1, 20) &&
+	if (mode == oldmode && is_same_sha1(sha1, old->sha1) &&
 	    !revs->diffopt.find_copies_harder)
 		return 0;
 
diff --git a/diff.c b/diff.c
index 7a238d0..b1e07a1 100644
--- a/diff.c
+++ b/diff.c
@@ -1140,7 +1140,7 @@ static int work_tree_matches(const char 
 	if ((lstat(name, &st) < 0) ||
 	    !S_ISREG(st.st_mode) || /* careful! */
 	    ce_match_stat(ce, &st, 0) ||
-	    memcmp(sha1, ce->sha1, 20))
+	    !is_same_sha1(sha1, ce->sha1))
 		return 0;
 	/* we return 1 only when we can stat, it is a regular file,
 	 * stat information matches, and sha1 recorded in the cache
@@ -1579,7 +1579,7 @@ static void run_diff(struct diff_filepai
 		;
 	}
 
-	if (memcmp(one->sha1, two->sha1, 20)) {
+	if (!is_same_sha1(one->sha1, two->sha1)) {
 		int abbrev = o->full_index ? 40 : DEFAULT_ABBREV;
 
 		len += snprintf(msg + len, sizeof(msg) - len,
@@ -2098,7 +2098,7 @@ int diff_unmodified_pair(struct diff_fil
 	 * dealing with a change.
 	 */
 	if (one->sha1_valid && two->sha1_valid &&
-	    !memcmp(one->sha1, two->sha1, sizeof(one->sha1)))
+	    is_same_sha1(one->sha1, two->sha1))
 		return 1; /* no change */
 	if (!one->sha1_valid && !two->sha1_valid)
 		return 1; /* both look at the same file on the filesystem. */
@@ -2237,7 +2237,7 @@ static void diff_resolve_rename_copy(voi
 			if (!p->status)
 				p->status = DIFF_STATUS_RENAMED;
 		}
-		else if (memcmp(p->one->sha1, p->two->sha1, 20) ||
+		else if (!is_same_sha1(p->one->sha1, p->two->sha1) ||
 			 p->one->mode != p->two->mode)
 			p->status = DIFF_STATUS_MODIFIED;
 		else {
diff --git a/diffcore-break.c b/diffcore-break.c
index ed0e14c..821ec57 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -56,7 +56,7 @@ static int should_break(struct diff_file
 		return 0; /* leave symlink rename alone */
 
 	if (src->sha1_valid && dst->sha1_valid &&
-	    !memcmp(src->sha1, dst->sha1, 20))
+	    is_same_sha1(src->sha1, dst->sha1))
 		return 0; /* they are the same */
 
 	if (diff_populate_filespec(src, 0) || diff_populate_filespec(dst, 0))
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0ec488a..32afcc3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -101,7 +101,7 @@ static int is_exact_match(struct diff_fi
 			  int contents_too)
 {
 	if (src->sha1_valid && dst->sha1_valid &&
-	    !memcmp(src->sha1, dst->sha1, 20))
+	    is_same_sha1(src->sha1, dst->sha1))
 		return 1;
 	if (!contents_too)
 		return 0;
diff --git a/dump-cache-tree.c b/dump-cache-tree.c
index 1ccaf51..51aadcc 100644
--- a/dump-cache-tree.c
+++ b/dump-cache-tree.c
@@ -33,7 +33,7 @@ static int dump_cache_tree(struct cache_
 	}
 	else {
 		dump_one(it, pfx, "");
-		if (memcmp(it->sha1, ref->sha1, 20) ||
+		if (!is_same_sha1(it->sha1, ref->sha1) ||
 		    ref->entry_count != it->entry_count ||
 		    ref->subtree_nr != it->subtree_nr) {
 			dump_one(ref, pfx, "#(ref) ");
diff --git a/http-fetch.c b/http-fetch.c
index 7f07d2a..dc4e30e 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -301,7 +301,7 @@ static void finish_object_request(struct
 		unlink(obj_req->tmpfile);
 		return;
 	}
-	if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
+	if (!is_same_sha1(obj_req->sha1, obj_req->real_sha1)) {
 		unlink(obj_req->tmpfile);
 		return;
 	}
@@ -1070,7 +1070,7 @@ static int fetch_object(struct alt_base 
 	int ret = 0;
 	struct object_request *obj_req = object_queue_head;
 
-	while (obj_req != NULL && memcmp(obj_req->sha1, sha1, 20))
+	while (obj_req != NULL && !is_same_sha1(obj_req->sha1, sha1))
 		obj_req = obj_req->next;
 	if (obj_req == NULL)
 		return error("Couldn't find request for %s in the queue", hex);
@@ -1109,7 +1109,7 @@ #endif
 	} else if (obj_req->zret != Z_STREAM_END) {
 		corrupt_object_found++;
 		ret = error("File %s (%s) corrupt", hex, obj_req->url);
-	} else if (memcmp(obj_req->sha1, obj_req->real_sha1, 20)) {
+	} else if (!is_same_sha1(obj_req->sha1, obj_req->real_sha1)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (obj_req->rename < 0) {
 		ret = error("unable to write sha1 filename %s",
diff --git a/http-push.c b/http-push.c
index 2bd9845..6a13c3e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -745,7 +745,7 @@ static void finish_request(struct transf
 			SHA1_Final(request->real_sha1, &request->c);
 			if (request->zret != Z_STREAM_END) {
 				unlink(request->tmpfile);
-			} else if (memcmp(request->obj->sha1, request->real_sha1, 20)) {
+			} else if (!is_same_sha1(request->obj->sha1, request->real_sha1)) {
 				unlink(request->tmpfile);
 			} else {
 				request->rename =
@@ -2416,7 +2416,7 @@ int main(int argc, char **argv)
 
 		if (!ref->peer_ref)
 			continue;
-		if (!memcmp(ref->old_sha1, ref->peer_ref->new_sha1, 20)) {
+		if (is_same_sha1(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (push_verbosely || 1)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			continue;
diff --git a/index-pack.c b/index-pack.c
index b20659c..be4c36b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -82,7 +82,7 @@ static void parse_pack_header(void)
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, pack_base, pack_size - 20);
 	SHA1_Final(sha1, &ctx);
-	if (memcmp(sha1, pack_base + pack_size - 20, 20))
+	if (!is_same_sha1(sha1, pack_base + pack_size - 20))
 		die("packfile '%s' SHA1 mismatch", pack_name);
 }
 
@@ -210,9 +210,11 @@ static int find_deltas_based_on_sha1(con
 
 	if (first < 0)
 		return -1;
-	while (first > 0 && !memcmp(deltas[first-1].base_sha1, base_sha1, 20))
+	while (first > 0 && is_same_sha1(deltas[first - 1].base_sha1,
+					 base_sha1))
 		--first;
-	while (last < end && !memcmp(deltas[last+1].base_sha1, base_sha1, 20))
+	while (last < end && is_same_sha1(deltas[last + 1].base_sha1,
+					  base_sha1))
 		++last;
 	*first_index = first;
 	*last_index = last;
diff --git a/merge-tree.c b/merge-tree.c
index 7cf00be..7f68cb9 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -152,7 +152,7 @@ static int same_entry(struct name_entry 
 {
 	return	a->sha1 &&
 		b->sha1 &&
-		!memcmp(a->sha1, b->sha1, 20) &&
+		is_same_sha1(a->sha1, b->sha1) &&
 		a->mode == b->mode;
 }
 
diff --git a/object.c b/object.c
index b5d8ed4..bcf3564 100644
--- a/object.c
+++ b/object.c
@@ -58,7 +58,7 @@ struct object *lookup_object(const unsig
 
 	i = hashtable_index(sha1);
 	while ((obj = obj_hash[i]) != NULL) {
-		if (!memcmp(sha1, obj->sha1, 20))
+		if (is_same_sha1(sha1, obj->sha1))
 			break;
 		i++;
 		if (i == obj_hash_size)
diff --git a/pack-check.c b/pack-check.c
index 3a62e1b..8434a8d 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -29,10 +29,10 @@ static int verify_packfile(struct packed
 	pack_base = p->pack_base;
 	SHA1_Update(&ctx, pack_base, pack_size - 20);
 	SHA1_Final(sha1, &ctx);
-	if (memcmp(sha1, (char *) pack_base + pack_size - 20, 20))
+	if (!is_same_sha1(sha1, (unsigned char *)pack_base + pack_size - 20))
 		return error("Packfile %s SHA1 mismatch with itself",
 			     p->pack_name);
-	if (memcmp(sha1, (char *) index_base + index_size - 40, 20))
+	if (!is_same_sha1(sha1, (unsigned char *)index_base + index_size - 40))
 		return error("Packfile %s SHA1 mismatch with idx",
 			     p->pack_name);
 
@@ -135,7 +135,7 @@ int verify_pack(struct packed_git *p, in
 	SHA1_Init(&ctx);
 	SHA1_Update(&ctx, index_base, index_size - 20);
 	SHA1_Final(sha1, &ctx);
-	if (memcmp(sha1, (char *) index_base + index_size - 20, 20))
+	if (!is_same_sha1(sha1, (unsigned char *)index_base + index_size - 20))
 		ret = error("Packfile index for %s SHA1 mismatch",
 			    p->pack_name);
 
diff --git a/read-cache.c b/read-cache.c
index 3228ffb..ae0156f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -739,7 +739,7 @@ static int verify_hdr(struct cache_heade
 	SHA1_Init(&c);
 	SHA1_Update(&c, hdr, size - 20);
 	SHA1_Final(sha1, &c);
-	if (memcmp(sha1, (char *) hdr + size - 20, 20))
+	if (!is_same_sha1(sha1, (unsigned char *)hdr + size - 20))
 		return error("bad index file sha1 signature");
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 86ef916..5f3f5d2 100644
--- a/refs.c
+++ b/refs.c
@@ -281,7 +281,7 @@ static struct ref_lock *verify_lock(stru
 		unlock_ref(lock);
 		return NULL;
 	}
-	if (memcmp(lock->old_sha1, old_sha1, 20)) {
+	if (!is_same_sha1(lock->old_sha1, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_file,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
@@ -411,7 +411,7 @@ int write_ref_sha1(struct ref_lock *lock
 
 	if (!lock)
 		return -1;
-	if (!lock->force_write && !memcmp(lock->old_sha1, sha1, 20)) {
+	if (!lock->force_write && is_same_sha1(lock->old_sha1, sha1)) {
 		unlock_ref(lock);
 		return 0;
 	}
@@ -475,7 +475,7 @@ int read_ref_at(const char *ref, unsigne
 					die("Log %s is corrupt.", logfile);
 				if (get_sha1_hex(rec + 41, sha1))
 					die("Log %s is corrupt.", logfile);
-				if (memcmp(logged_sha1, sha1, 20)) {
+				if (!is_same_sha1(logged_sha1, sha1)) {
 					tz = strtoul(tz_c, NULL, 10);
 					fprintf(stderr,
 						"warning: Log %s has gap after %s.\n",
@@ -489,7 +489,7 @@ int read_ref_at(const char *ref, unsigne
 			else {
 				if (get_sha1_hex(rec + 41, logged_sha1))
 					die("Log %s is corrupt.", logfile);
-				if (memcmp(logged_sha1, sha1, 20)) {
+				if (!is_same_sha1(logged_sha1, sha1)) {
 					tz = strtoul(tz_c, NULL, 10);
 					fprintf(stderr,
 						"warning: Log %s unexpectedly ended on %s.\n",
diff --git a/send-pack.c b/send-pack.c
index 43e10b0..d7f58cd 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -265,7 +265,7 @@ static int send_pack(int in, int out, in
 		char old_hex[60], *new_hex;
 		if (!ref->peer_ref)
 			continue;
-		if (!memcmp(ref->old_sha1, ref->peer_ref->new_sha1, 20)) {
+		if (is_same_sha1(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (verbose)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			continue;
diff --git a/sha1_file.c b/sha1_file.c
index 18dece4..04d54ef 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -485,10 +485,10 @@ int use_packed_git(struct packed_git *p)
 		/* Check if the pack file matches with the index file.
 		 * this is cheap.
 		 */
-		if (memcmp((char*)(p->index_base) + p->index_size - 40,
-			   (char *) p->pack_base + p->pack_size - 20,
-			   20)) {
-
+		if (!is_same_sha1((unsigned char *)(p->index_base) +
+				  p->index_size - 40,
+				  (unsigned char *)p->pack_base +
+				  p->pack_size - 20)) {
 			die("packfile %s does not match index.", p->pack_name);
 		}
 	}
@@ -643,7 +643,7 @@ int check_sha1_signature(const unsigned 
 	SHA1_Update(&c, header, 1+sprintf(header, "%s %lu", type, size));
 	SHA1_Update(&c, map, size);
 	SHA1_Final(real_sha1, &c);
-	return memcmp(sha1, real_sha1, 20) ? -1 : 0;
+	return !is_same_sha1(sha1, real_sha1) ? -1 : 0;
 }
 
 void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
@@ -941,7 +941,7 @@ int check_reuse_pack_delta(struct packed
 	ptr = unpack_object_header(p, ptr, kindp, sizep);
 	if (*kindp != OBJ_DELTA)
 		goto done;
-	memcpy(base, (char *) p->pack_base + ptr, 20);
+	memcpy(base, (unsigned char *) p->pack_base + ptr, 20);
 	status = 0;
  done:
 	unuse_packed_git(p);
@@ -1715,7 +1715,7 @@ int write_sha1_from_fd(const unsigned ch
 		unlink(tmpfile);
 		return error("File %s corrupted", sha1_to_hex(sha1));
 	}
-	if (memcmp(sha1, real_sha1, 20)) {
+	if (!is_same_sha1(sha1, real_sha1)) {
 		unlink(tmpfile);
 		return error("File %s has bad hash", sha1_to_hex(sha1));
 	}
diff --git a/sha1_name.c b/sha1_name.c
index f567454..2d4d26a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -106,7 +106,7 @@ static int find_short_packed_object(int 
 						memcpy(found_sha1, now, 20);
 						found++;
 					}
-					else if (memcmp(found_sha1, now, 20)) {
+					else if (!is_same_sha1(found_sha1, now)) {
 						found = 2;
 						break;
 					}
@@ -144,7 +144,7 @@ static int find_unique_short_object(int 
 		return 0;
 	}
 	/* Both have unique ones -- do they match? */
-	if (memcmp(packed_sha1, unpacked_sha1, 20))
+	if (!is_same_sha1(packed_sha1, unpacked_sha1))
 		return SHORT_NAME_AMBIGUOUS;
 	memcpy(sha1, packed_sha1, 20);
 	return 0;
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 0b89df6..603e244 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -67,7 +67,7 @@ int fetch(unsigned char *sha1)
 	signed char remote;
 	struct object_list *temp;
 
-	if (memcmp(sha1, in_transit->item->sha1, 20)) {
+	if (!is_same_sha1(sha1, in_transit->item->sha1)) {
 		/* we must have already fetched it to clean the queue */
 		return has_sha1_file(sha1) ? 0 : -1;
 	}
diff --git a/tree-diff.c b/tree-diff.c
index 916f489..51df262 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -40,7 +40,7 @@ static int compare_tree_entry(struct tre
 		return 1;
 	}
 	if (!opt->find_copies_harder &&
-	    !memcmp(sha1, sha2, 20) && mode1 == mode2)
+	    is_same_sha1(sha1, sha2) && mode1 == mode2)
 		return 0;
 
 	/*
diff --git a/unpack-trees.c b/unpack-trees.c
index 43ed124..153b321 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -417,7 +417,7 @@ static int same(struct cache_entry *a, s
 	if (!a && !b)
 		return 1;
 	return a->ce_mode == b->ce_mode &&
-		!memcmp(a->sha1, b->sha1, 20);
+		is_same_sha1(a->sha1, b->sha1);
 }
 
 
-- 
1.4.2.g1c2a-dirty
