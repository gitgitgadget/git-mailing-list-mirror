From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] adding support for md5
Date: Wed, 23 Aug 2006 02:49:00 -0400
Message-ID: <20060823064900.GA26340@spearce.org>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com> <Pine.LNX.4.64.0608191339010.11811@g5.osdl.org> <20060821204430.GA2700@tuatara.stupidest.org> <7vr6z9s376.fsf@assigned-by-dhcp.cox.net> <20060823041453.GA25796@spearce.org> <7v3bbojbzj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 08:49:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFmY7-0008Dw-2e
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 08:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWHWGtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 02:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWHWGtJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 02:49:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22188 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751414AbWHWGtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 02:49:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GFmXt-000214-Pn; Wed, 23 Aug 2006 02:49:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A2EE920FB7D; Wed, 23 Aug 2006 02:49:00 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bbojbzj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25899>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> I personally am not interested in making this configurable at
> >> all.  The hashcmp() change on the other hand to abstract out 20
> >> was a good preparation, if we ever want to switch to longer
> >> hashes we would know where to look.
> >
> > What about all of those memcpy(a, b, 20)'s?  :-)
> 
> Surely.  If you are inclined to, go wild.

Like this?  :-)

-->--
Convert memcpy(a,b,20) to hashcpy(a,b).

This abstracts away the size of the hash values when copying them
from memory location to memory location, much as the introduction
of hashcmp abstracted away hash value comparsion.

A few call sites were using char* rather than unsigned char* so
I added the cast rather than open hashcpy to be void*.  This is a
reasonable tradeoff as most call sites already use unsigned char*
and the existing hashcmp is also declared to be unsigned char*.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 blame.c                  |    4 ++--
 builtin-diff.c           |    4 ++--
 builtin-pack-objects.c   |    6 +++---
 builtin-read-tree.c      |    2 +-
 builtin-unpack-objects.c |    4 ++--
 builtin-update-index.c   |    4 ++--
 builtin-write-tree.c     |    4 ++--
 cache-tree.c             |    6 +++---
 cache.h                  |    4 ++++
 combine-diff.c           |    6 +++---
 connect.c                |    6 +++---
 convert-objects.c        |    6 +++---
 csum-file.c              |    2 +-
 diff.c                   |    4 ++--
 fetch-pack.c             |    2 +-
 fetch.c                  |    2 +-
 fsck-objects.c           |    2 +-
 http-fetch.c             |    2 +-
 http-push.c              |    6 +++---
 index-pack.c             |    4 ++--
 merge-recursive.c        |   20 ++++++++++----------
 mktree.c                 |    4 ++--
 object.c                 |    2 +-
 patch-id.c               |    2 +-
 receive-pack.c           |    4 ++--
 revision.c               |    2 +-
 send-pack.c              |    4 ++--
 sha1_file.c              |   18 +++++++++---------
 sha1_name.c              |   22 +++++++++++-----------
 tree-walk.c              |    4 ++--
 tree.c                   |    2 +-
 unpack-trees.c           |    2 +-
 32 files changed, 85 insertions(+), 81 deletions(-)

diff --git a/blame.c b/blame.c
index c253b9c..5a8af72 100644
--- a/blame.c
+++ b/blame.c
@@ -176,7 +176,7 @@ static int get_blob_sha1(struct tree *t,
 	if (i == 20)
 		return -1;
 
-	memcpy(sha1, blob_sha1, 20);
+	hashcpy(sha1, blob_sha1);
 	return 0;
 }
 
@@ -191,7 +191,7 @@ static int get_blob_sha1_internal(const 
 	    strcmp(blame_file + baselen, pathname))
 		return -1;
 
-	memcpy(blob_sha1, sha1, 20);
+	hashcpy(blob_sha1, sha1);
 	return -1;
 }
 
diff --git a/builtin-diff.c b/builtin-diff.c
index 874f773..a659020 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -192,7 +192,7 @@ static int builtin_diff_combined(struct 
 	parent = xmalloc(ents * sizeof(*parent));
 	/* Again, the revs are all reverse */
 	for (i = 0; i < ents; i++)
-		memcpy(parent + i, ent[ents - 1 - i].item->sha1, 20);
+		hashcpy((unsigned char*)parent + i, ent[ents - 1 - i].item->sha1);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
 			   revs->dense_combined_merges, revs);
 	return 0;
@@ -290,7 +290,7 @@ int cmd_diff(int argc, const char **argv
 		if (obj->type == OBJ_BLOB) {
 			if (2 <= blobs)
 				die("more than two blobs given: '%s'", name);
-			memcpy(blob[blobs].sha1, obj->sha1, 20);
+			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name = name;
 			blobs++;
 			continue;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index f19f0d6..46f524d 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -534,7 +534,7 @@ static int add_object_entry(const unsign
 	entry = objects + idx;
 	nr_objects = idx + 1;
 	memset(entry, 0, sizeof(*entry));
-	memcpy(entry->sha1, sha1, 20);
+	hashcpy(entry->sha1, sha1);
 	entry->hash = hash;
 
 	if (object_ix_hashsz * 3 <= nr_objects * 4)
@@ -649,7 +649,7 @@ static struct pbase_tree_cache *pbase_tr
 		free(ent->tree_data);
 		nent = ent;
 	}
-	memcpy(nent->sha1, sha1, 20);
+	hashcpy(nent->sha1, sha1);
 	nent->tree_data = data;
 	nent->tree_size = size;
 	nent->ref = 1;
@@ -799,7 +799,7 @@ static void add_preferred_base(unsigned 
 	it->next = pbase_tree;
 	pbase_tree = it;
 
-	memcpy(it->pcache.sha1, tree_sha1, 20);
+	hashcpy(it->pcache.sha1, tree_sha1);
 	it->pcache.tree_data = data;
 	it->pcache.tree_size = size;
 }
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 53087fa..c1867d2 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -53,7 +53,7 @@ static void prime_cache_tree_rec(struct 
 	struct name_entry entry;
 	int cnt;
 
-	memcpy(it->sha1, tree->object.sha1, 20);
+	hashcpy(it->sha1, tree->object.sha1);
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 	cnt = 0;
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index f0ae5c9..ca0ebc2 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -95,7 +95,7 @@ static void add_delta_to_list(unsigned c
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
 
-	memcpy(info->base_sha1, base_sha1, 20);
+	hashcpy(info->base_sha1, base_sha1);
 	info->size = size;
 	info->delta = delta;
 	info->next = delta_list;
@@ -173,7 +173,7 @@ static int unpack_delta_entry(unsigned l
 	unsigned char base_sha1[20];
 	int result;
 
-	memcpy(base_sha1, fill(20), 20);
+	hashcpy(base_sha1, fill(20));
 	use(20);
 
 	delta_data = get_data(delta_size);
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 5dd91af..8675126 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -142,7 +142,7 @@ static int add_cacheinfo(unsigned int mo
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 
-	memcpy(ce->sha1, sha1, 20);
+	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(len, stage);
 	ce->ce_mode = create_ce_mode(mode);
@@ -333,7 +333,7 @@ static struct cache_entry *read_one_ent(
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 
-	memcpy(ce->sha1, sha1, 20);
+	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = create_ce_flags(namelen, stage);
 	ce->ce_mode = create_ce_mode(mode);
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index ca06149..50670dc 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -50,10 +50,10 @@ int write_tree(unsigned char *sha1, int 
 	if (prefix) {
 		struct cache_tree *subtree =
 			cache_tree_find(active_cache_tree, prefix);
-		memcpy(sha1, subtree->sha1, 20);
+		hashcpy(sha1, subtree->sha1);
 	}
 	else
-		memcpy(sha1, active_cache_tree->sha1, 20);
+		hashcpy(sha1, active_cache_tree->sha1);
 
 	rollback_lock_file(lock_file);
 
diff --git a/cache-tree.c b/cache-tree.c
index d9f7e1e..323c68a 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -335,7 +335,7 @@ static int update_one(struct cache_tree 
 		offset += sprintf(buffer + offset,
 				  "%o %.*s", mode, entlen, path + baselen);
 		buffer[offset++] = 0;
-		memcpy(buffer + offset, sha1, 20);
+		hashcpy((unsigned char*)buffer + offset, sha1);
 		offset += 20;
 
 #if DEBUG
@@ -412,7 +412,7 @@ #if DEBUG
 #endif
 
 	if (0 <= it->entry_count) {
-		memcpy(buffer + *offset, it->sha1, 20);
+		hashcpy((unsigned char*)buffer + *offset, it->sha1);
 		*offset += 20;
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
@@ -478,7 +478,7 @@ static struct cache_tree *read_one(const
 	if (0 <= it->entry_count) {
 		if (size < 20)
 			goto free_return;
-		memcpy(it->sha1, buf, 20);
+		hashcpy(it->sha1, (unsigned char*)buf);
 		buf += 20;
 		size -= 20;
 	}
diff --git a/cache.h b/cache.h
index cd2ad90..df642a1 100644
--- a/cache.h
+++ b/cache.h
@@ -222,6 +222,10 @@ static inline int hashcmp(const unsigned
 {
 	return memcmp(sha1, sha2, 20);
 }
+static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
+{
+	memcpy(sha_dst, sha_src, 20);
+}
 
 int git_mkstemp(char *path, size_t n, const char *template);
 
diff --git a/combine-diff.c b/combine-diff.c
index 0682acd..466899d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -31,9 +31,9 @@ static struct combine_diff_path *interse
 			memset(p->parent, 0,
 			       sizeof(p->parent[0]) * num_parent);
 
-			memcpy(p->sha1, q->queue[i]->two->sha1, 20);
+			hashcpy(p->sha1, q->queue[i]->two->sha1);
 			p->mode = q->queue[i]->two->mode;
-			memcpy(p->parent[n].sha1, q->queue[i]->one->sha1, 20);
+			hashcpy(p->parent[n].sha1, q->queue[i]->one->sha1);
 			p->parent[n].mode = q->queue[i]->one->mode;
 			p->parent[n].status = q->queue[i]->status;
 			*tail = p;
@@ -927,6 +927,6 @@ void diff_tree_combined_merge(const unsi
 	for (parents = commit->parents, num_parent = 0;
 	     parents;
 	     parents = parents->next, num_parent++)
-		memcpy(parent + num_parent, parents->item->object.sha1, 20);
+		hashcpy((unsigned char*)parent + num_parent, parents->item->object.sha1);
 	diff_tree_combined(sha1, parent, num_parent, dense, rev);
 }
diff --git a/connect.c b/connect.c
index 7a6a73f..e501ccc 100644
--- a/connect.c
+++ b/connect.c
@@ -77,7 +77,7 @@ struct ref **get_remote_heads(int in, st
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
 		ref = xcalloc(1, sizeof(*ref) + len - 40);
-		memcpy(ref->old_sha1, old_sha1, 20);
+		hashcpy(ref->old_sha1, old_sha1);
 		memcpy(ref->name, buffer + 41, len - 40);
 		*list = ref;
 		list = &ref->next;
@@ -208,7 +208,7 @@ static struct ref *try_explicit_object_n
 	len = strlen(name) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
 	memcpy(ref->name, name, len);
-	memcpy(ref->new_sha1, sha1, 20);
+	hashcpy(ref->new_sha1, sha1);
 	return ref;
 }
 
@@ -318,7 +318,7 @@ int match_refs(struct ref *src, struct r
 			int len = strlen(src->name) + 1;
 			dst_peer = xcalloc(1, sizeof(*dst_peer) + len);
 			memcpy(dst_peer->name, src->name, len);
-			memcpy(dst_peer->new_sha1, src->new_sha1, 20);
+			hashcpy(dst_peer->new_sha1, src->new_sha1);
 			link_dst_tail(dst_peer, dst_tail);
 		}
 		dst_peer->peer_ref = src;
diff --git a/convert-objects.c b/convert-objects.c
index 4e7ff75..631678b 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -23,7 +23,7 @@ static struct entry * convert_entry(unsi
 static struct entry *insert_new(unsigned char *sha1, int pos)
 {
 	struct entry *new = xcalloc(1, sizeof(struct entry));
-	memcpy(new->old_sha1, sha1, 20);
+	hashcpy(new->old_sha1, sha1);
 	memmove(convert + pos + 1, convert + pos, (nr_convert - pos) * sizeof(struct entry *));
 	convert[pos] = new;
 	nr_convert++;
@@ -54,7 +54,7 @@ static struct entry *lookup_entry(unsign
 static void convert_binary_sha1(void *buffer)
 {
 	struct entry *entry = convert_entry(buffer);
-	memcpy(buffer, entry->new_sha1, 20);
+	hashcpy(buffer, entry->new_sha1);
 }
 
 static void convert_ascii_sha1(void *buffer)
@@ -104,7 +104,7 @@ static int write_subdirectory(void *buff
 		if (!slash) {
 			newlen += sprintf(new + newlen, "%o %s", mode, path);
 			new[newlen++] = '\0';
-			memcpy(new + newlen, (char *) buffer + len - 20, 20);
+			hashcpy((unsigned char*)new + newlen, (unsigned char *) buffer + len - 20);
 			newlen += 20;
 
 			used += len;
diff --git a/csum-file.c b/csum-file.c
index e227889..b7174c6 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -38,7 +38,7 @@ int sha1close(struct sha1file *f, unsign
 	}
 	SHA1_Final(f->buffer, &f->ctx);
 	if (result)
-		memcpy(result, f->buffer, 20);
+		hashcpy(result, f->buffer);
 	if (update)
 		sha1flush(f, 20);
 	if (close(f->fd))
diff --git a/diff.c b/diff.c
index ddf2dea..852c175 100644
--- a/diff.c
+++ b/diff.c
@@ -1107,7 +1107,7 @@ void fill_filespec(struct diff_filespec 
 {
 	if (mode) {
 		spec->mode = canon_mode(mode);
-		memcpy(spec->sha1, sha1, 20);
+		hashcpy(spec->sha1, sha1);
 		spec->sha1_valid = !is_null_sha1(sha1);
 	}
 }
@@ -1200,7 +1200,7 @@ static struct sha1_size_cache *locate_si
 			sizeof(*sha1_size_cache));
 	e = xmalloc(sizeof(struct sha1_size_cache));
 	sha1_size_cache[first] = e;
-	memcpy(e->sha1, sha1, 20);
+	hashcpy(e->sha1, sha1);
 	e->size = size;
 	return e;
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index e18c148..377fede 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -404,7 +404,7 @@ static int everything_local(struct ref *
 			continue;
 		}
 
-		memcpy(ref->new_sha1, local, 20);
+		hashcpy(ref->new_sha1, local);
 		if (!verbose)
 			continue;
 		fprintf(stderr,
diff --git a/fetch.c b/fetch.c
index aeb6bf2..ef60b04 100644
--- a/fetch.c
+++ b/fetch.c
@@ -84,7 +84,7 @@ static int process_commit(struct commit 
 	if (commit->object.flags & COMPLETE)
 		return 0;
 
-	memcpy(current_commit_sha1, commit->object.sha1, 20);
+	hashcpy(current_commit_sha1, commit->object.sha1);
 
 	pull_say("walk %s\n", sha1_to_hex(commit->object.sha1));
 
diff --git a/fsck-objects.c b/fsck-objects.c
index 31e00d8..ae0ec8d 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -356,7 +356,7 @@ static void add_sha1_list(unsigned char 
 	int nr;
 
 	entry->ino = ino;
-	memcpy(entry->sha1, sha1, 20);
+	hashcpy(entry->sha1, sha1);
 	nr = sha1_list.nr;
 	if (nr == MAX_SHA1_ENTRIES) {
 		fsck_sha1_list();
diff --git a/http-fetch.c b/http-fetch.c
index d1f74b4..7619b33 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -393,7 +393,7 @@ void prefetch(unsigned char *sha1)
 	char *filename = sha1_file_name(sha1);
 
 	newreq = xmalloc(sizeof(*newreq));
-	memcpy(newreq->sha1, sha1, 20);
+	hashcpy(newreq->sha1, sha1);
 	newreq->repo = alt;
 	newreq->url = NULL;
 	newreq->local = -1;
diff --git a/http-push.c b/http-push.c
index 4849779..ebfcc73 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1874,7 +1874,7 @@ static int one_local_ref(const char *ref
 	struct ref *ref;
 	int len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
-	memcpy(ref->new_sha1, sha1, 20);
+	hashcpy(ref->new_sha1, sha1);
 	memcpy(ref->name, refname, len);
 	*local_tail = ref;
 	local_tail = &ref->next;
@@ -1909,7 +1909,7 @@ static void one_remote_ref(char *refname
 	}
 
 	ref = xcalloc(1, sizeof(*ref) + len);
-	memcpy(ref->old_sha1, remote_sha1, 20);
+	hashcpy(ref->old_sha1, remote_sha1);
 	memcpy(ref->name, refname, len);
 	*remote_tail = ref;
 	remote_tail = &ref->next;
@@ -2445,7 +2445,7 @@ int main(int argc, char **argv)
 				continue;
 			}
 		}
-		memcpy(ref->new_sha1, ref->peer_ref->new_sha1, 20);
+		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 		if (is_zero_sha1(ref->new_sha1)) {
 			error("cannot happen anymore");
 			rc = -3;
diff --git a/index-pack.c b/index-pack.c
index 96ea687..80bc6cb 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -161,7 +161,7 @@ static void *unpack_raw_entry(unsigned l
 	case OBJ_DELTA:
 		if (pos + 20 >= pack_limit)
 			bad_object(offset, "object extends past end of pack");
-		memcpy(delta_base, pack_base + pos, 20);
+		hashcpy(delta_base, pack_base + pos);
 		pos += 20;
 		/* fallthru */
 	case OBJ_COMMIT:
@@ -304,7 +304,7 @@ static void parse_pack_objects(void)
 		if (obj->type == OBJ_DELTA) {
 			struct delta_entry *delta = &deltas[nr_deltas++];
 			delta->obj = obj;
-			memcpy(delta->base_sha1, base_sha1, 20);
+			hashcpy(delta->base_sha1, base_sha1);
 		} else
 			sha1_object(data, data_size, obj->type, obj->sha1);
 		free(data);
diff --git a/merge-recursive.c b/merge-recursive.c
index 048cca1..8a2f697 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -158,7 +158,7 @@ static struct cache_entry *make_cache_en
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 
-	memcpy(ce->sha1, sha1, 20);
+	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(len, stage);
 	ce->ce_mode = create_ce_mode(mode);
@@ -355,7 +355,7 @@ static struct path_list *get_unmerged(vo
 		}
 		e = item->util;
 		e->stages[ce_stage(ce)].mode = ntohl(ce->ce_mode);
-		memcpy(e->stages[ce_stage(ce)].sha, ce->sha1, 20);
+		hashcpy(e->stages[ce_stage(ce)].sha, ce->sha1);
 	}
 
 	return unmerged;
@@ -636,10 +636,10 @@ static struct merge_file_info merge_file
 		result.clean = 0;
 		if (S_ISREG(a->mode)) {
 			result.mode = a->mode;
-			memcpy(result.sha, a->sha1, 20);
+			hashcpy(result.sha, a->sha1);
 		} else {
 			result.mode = b->mode;
-			memcpy(result.sha, b->sha1, 20);
+			hashcpy(result.sha, b->sha1);
 		}
 	} else {
 		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
@@ -648,9 +648,9 @@ static struct merge_file_info merge_file
 		result.mode = a->mode == o->mode ? b->mode: a->mode;
 
 		if (sha_eq(a->sha1, o->sha1))
-			memcpy(result.sha, b->sha1, 20);
+			hashcpy(result.sha, b->sha1);
 		else if (sha_eq(b->sha1, o->sha1))
-			memcpy(result.sha, a->sha1, 20);
+			hashcpy(result.sha, a->sha1);
 		else if (S_ISREG(a->mode)) {
 			int code = 1, fd;
 			struct stat st;
@@ -699,7 +699,7 @@ static struct merge_file_info merge_file
 			if (!(S_ISLNK(a->mode) || S_ISLNK(b->mode)))
 				die("cannot merge modes?");
 
-			memcpy(result.sha, a->sha1, 20);
+			hashcpy(result.sha, a->sha1);
 
 			if (!sha_eq(a->sha1, b->sha1))
 				result.clean = 0;
@@ -1096,11 +1096,11 @@ static int process_entry(const char *pat
 
 		output("Auto-merging %s", path);
 		o.path = a.path = b.path = (char *)path;
-		memcpy(o.sha1, o_sha, 20);
+		hashcpy(o.sha1, o_sha);
 		o.mode = o_mode;
-		memcpy(a.sha1, a_sha, 20);
+		hashcpy(a.sha1, a_sha);
 		a.mode = a_mode;
-		memcpy(b.sha1, b_sha, 20);
+		hashcpy(b.sha1, b_sha);
 		b.mode = b_mode;
 
 		mfi = merge_file(&o, &a, &b,
diff --git a/mktree.c b/mktree.c
index 9324138..56205d1 100644
--- a/mktree.c
+++ b/mktree.c
@@ -30,7 +30,7 @@ static void append_to_tree(unsigned mode
 	ent = entries[used++] = xmalloc(sizeof(**entries) + len + 1);
 	ent->mode = mode;
 	ent->len = len;
-	memcpy(ent->sha1, sha1, 20);
+	hashcpy(ent->sha1, sha1);
 	memcpy(ent->name, path, len+1);
 }
 
@@ -64,7 +64,7 @@ static void write_tree(unsigned char *sh
 		offset += sprintf(buffer + offset, "%o ", ent->mode);
 		offset += sprintf(buffer + offset, "%s", ent->name);
 		buffer[offset++] = 0;
-		memcpy(buffer + offset, ent->sha1, 20);
+		hashcpy((unsigned char*)buffer + offset, ent->sha1);
 		offset += 20;
 	}
 	write_sha1_file(buffer, offset, tree_type, sha1);
diff --git a/object.c b/object.c
index fdcfff7..60bf16b 100644
--- a/object.c
+++ b/object.c
@@ -91,7 +91,7 @@ void created_object(const unsigned char 
 	obj->used = 0;
 	obj->type = OBJ_NONE;
 	obj->flags = 0;
-	memcpy(obj->sha1, sha1, 20);
+	hashcpy(obj->sha1, sha1);
 
 	if (obj_hash_size - 1 <= nr_objs * 2)
 		grow_object_hash();
diff --git a/patch-id.c b/patch-id.c
index 3b4c80f..086d2d9 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -47,7 +47,7 @@ static void generate_id_list(void)
 
 		if (!get_sha1_hex(p, n)) {
 			flush_current_id(patchlen, sha1, &ctx);
-			memcpy(sha1, n, 20);
+			hashcpy(sha1, n);
 			patchlen = 0;
 			continue;
 		}
diff --git a/receive-pack.c b/receive-pack.c
index 81e9190..2015316 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -247,8 +247,8 @@ static void read_head_info(void)
 				report_status = 1;
 		}
 		cmd = xmalloc(sizeof(struct command) + len - 80);
-		memcpy(cmd->old_sha1, old_sha1, 20);
-		memcpy(cmd->new_sha1, new_sha1, 20);
+		hashcpy(cmd->old_sha1, old_sha1);
+		hashcpy(cmd->new_sha1, new_sha1);
 		memcpy(cmd->ref_name, line + 82, len - 81);
 		cmd->error_string = "n/a (unpacker error)";
 		cmd->next = NULL;
diff --git a/revision.c b/revision.c
index 5a91d06..1d89d72 100644
--- a/revision.c
+++ b/revision.c
@@ -496,7 +496,7 @@ static int add_parents_only(struct rev_i
 		it = get_reference(revs, arg, sha1, 0);
 		if (it->type != OBJ_TAG)
 			break;
-		memcpy(sha1, ((struct tag*)it)->tagged->sha1, 20);
+		hashcpy(sha1, ((struct tag*)it)->tagged->sha1);
 	}
 	if (it->type != OBJ_COMMIT)
 		return 0;
diff --git a/send-pack.c b/send-pack.c
index f7c0cfc..fd79a61 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -185,7 +185,7 @@ static int one_local_ref(const char *ref
 	struct ref *ref;
 	int len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
-	memcpy(ref->new_sha1, sha1, 20);
+	hashcpy(ref->new_sha1, sha1);
 	memcpy(ref->name, refname, len);
 	*local_tail = ref;
 	local_tail = &ref->next;
@@ -310,7 +310,7 @@ static int send_pack(int in, int out, in
 				continue;
 			}
 		}
-		memcpy(ref->new_sha1, ref->peer_ref->new_sha1, 20);
+		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 		if (is_zero_sha1(ref->new_sha1)) {
 			error("cannot happen anymore");
 			ret = -3;
diff --git a/sha1_file.c b/sha1_file.c
index 4b1be72..789deb7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -558,7 +558,7 @@ struct packed_git *add_packed_git(char *
 	p->pack_use_cnt = 0;
 	p->pack_local = local;
 	if ((path_len > 44) && !get_sha1_hex(path + path_len - 44, sha1))
-		memcpy(p->sha1, sha1, 20);
+		hashcpy(p->sha1, sha1);
 	return p;
 }
 
@@ -589,7 +589,7 @@ struct packed_git *parse_pack_index_file
 	p->pack_base = NULL;
 	p->pack_last_used = 0;
 	p->pack_use_cnt = 0;
-	memcpy(p->sha1, sha1, 20);
+	hashcpy(p->sha1, sha1);
 	return p;
 }
 
@@ -971,7 +971,7 @@ int check_reuse_pack_delta(struct packed
 	ptr = unpack_object_header(p, ptr, kindp, sizep);
 	if (*kindp != OBJ_DELTA)
 		goto done;
-	memcpy(base, (unsigned char *) p->pack_base + ptr, 20);
+	hashcpy(base, (unsigned char *) p->pack_base + ptr);
 	status = 0;
  done:
 	unuse_packed_git(p);
@@ -999,7 +999,7 @@ void packed_object_info_detail(struct pa
 		if (p->pack_size <= offset + 20)
 			die("pack file %s records an incomplete delta base",
 			    p->pack_name);
-		memcpy(base_sha1, pack, 20);
+		hashcpy(base_sha1, pack);
 		do {
 			struct pack_entry base_ent;
 			unsigned long junk;
@@ -1219,7 +1219,7 @@ int nth_packed_object_sha1(const struct 
 	void *index = p->index_base + 256;
 	if (n < 0 || num_packed_objects(p) <= n)
 		return -1;
-	memcpy(sha1, (char *) index + (24 * n) + 4, 20);
+	hashcpy(sha1, (unsigned char *) index + (24 * n) + 4);
 	return 0;
 }
 
@@ -1236,7 +1236,7 @@ int find_pack_entry_one(const unsigned c
 		int cmp = hashcmp((unsigned char *)index + (24 * mi) + 4, sha1);
 		if (!cmp) {
 			e->offset = ntohl(*((unsigned int *) ((char *) index + (24 * mi))));
-			memcpy(e->sha1, sha1, 20);
+			hashcpy(e->sha1, sha1);
 			e->p = p;
 			return 1;
 		}
@@ -1349,7 +1349,7 @@ void *read_object_with_reference(const u
 	unsigned long isize;
 	unsigned char actual_sha1[20];
 
-	memcpy(actual_sha1, sha1, 20);
+	hashcpy(actual_sha1, sha1);
 	while (1) {
 		int ref_length = -1;
 		const char *ref_type = NULL;
@@ -1360,7 +1360,7 @@ void *read_object_with_reference(const u
 		if (!strcmp(type, required_type)) {
 			*size = isize;
 			if (actual_sha1_return)
-				memcpy(actual_sha1_return, actual_sha1, 20);
+				hashcpy(actual_sha1_return, actual_sha1);
 			return buffer;
 		}
 		/* Handle references */
@@ -1555,7 +1555,7 @@ int write_sha1_file(void *buf, unsigned 
 	 */
 	filename = write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
 	if (returnsha1)
-		memcpy(returnsha1, sha1, 20);
+		hashcpy(returnsha1, sha1);
 	if (has_sha1_file(sha1))
 		return 0;
 	fd = open(filename, O_RDONLY);
diff --git a/sha1_name.c b/sha1_name.c
index b6c198f..8a5809e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -109,7 +109,7 @@ static int find_short_packed_object(int 
 				    !match_sha(len, match, next)) {
 					/* unique within this pack */
 					if (!found) {
-						memcpy(found_sha1, now, 20);
+						hashcpy(found_sha1, now);
 						found++;
 					}
 					else if (hashcmp(found_sha1, now)) {
@@ -126,7 +126,7 @@ static int find_short_packed_object(int 
 		}
 	}
 	if (found == 1)
-		memcpy(sha1, found_sha1, 20);
+		hashcpy(sha1, found_sha1);
 	return found;
 }
 
@@ -146,13 +146,13 @@ static int find_unique_short_object(int 
 	if (1 < has_unpacked || 1 < has_packed)
 		return SHORT_NAME_AMBIGUOUS;
 	if (has_unpacked != has_packed) {
-		memcpy(sha1, (has_packed ? packed_sha1 : unpacked_sha1), 20);
+		hashcpy(sha1, (has_packed ? packed_sha1 : unpacked_sha1));
 		return 0;
 	}
 	/* Both have unique ones -- do they match? */
 	if (hashcmp(packed_sha1, unpacked_sha1))
 		return SHORT_NAME_AMBIGUOUS;
-	memcpy(sha1, packed_sha1, 20);
+	hashcpy(sha1, packed_sha1);
 	return 0;
 }
 
@@ -326,13 +326,13 @@ static int get_parent(const char *name, 
 	if (parse_commit(commit))
 		return -1;
 	if (!idx) {
-		memcpy(result, commit->object.sha1, 20);
+		hashcpy(result, commit->object.sha1);
 		return 0;
 	}
 	p = commit->parents;
 	while (p) {
 		if (!--idx) {
-			memcpy(result, p->item->object.sha1, 20);
+			hashcpy(result, p->item->object.sha1);
 			return 0;
 		}
 		p = p->next;
@@ -353,9 +353,9 @@ static int get_nth_ancestor(const char *
 
 		if (!commit || parse_commit(commit) || !commit->parents)
 			return -1;
-		memcpy(sha1, commit->parents->item->object.sha1, 20);
+		hashcpy(sha1, commit->parents->item->object.sha1);
 	}
-	memcpy(result, sha1, 20);
+	hashcpy(result, sha1);
 	return 0;
 }
 
@@ -407,7 +407,7 @@ static int peel_onion(const char *name, 
 		o = deref_tag(o, name, sp - name - 2);
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return -1;
-		memcpy(sha1, o->sha1, 20);
+		hashcpy(sha1, o->sha1);
 	}
 	else {
 		/* At this point, the syntax look correct, so
@@ -419,7 +419,7 @@ static int peel_onion(const char *name, 
 			if (!o || (!o->parsed && !parse_object(o->sha1)))
 				return -1;
 			if (o->type == expected_type) {
-				memcpy(sha1, o->sha1, 20);
+				hashcpy(sha1, o->sha1);
 				return 0;
 			}
 			if (o->type == OBJ_TAG)
@@ -526,7 +526,7 @@ int get_sha1(const char *name, unsigned 
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
-				memcpy(sha1, ce->sha1, 20);
+				hashcpy(sha1, ce->sha1);
 				return 0;
 			}
 			pos++;
diff --git a/tree-walk.c b/tree-walk.c
index 3f83e98..14cc5ae 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -179,7 +179,7 @@ static int find_tree_entry(struct tree_d
 		if (cmp < 0)
 			break;
 		if (entrylen == namelen) {
-			memcpy(result, sha1, 20);
+			hashcpy(result, sha1);
 			return 0;
 		}
 		if (name[entrylen] != '/')
@@ -187,7 +187,7 @@ static int find_tree_entry(struct tree_d
 		if (!S_ISDIR(*mode))
 			break;
 		if (++entrylen == namelen) {
-			memcpy(result, sha1, 20);
+			hashcpy(result, sha1);
 			return 0;
 		}
 		return get_tree_entry(sha1, name + entrylen, result, mode);
diff --git a/tree.c b/tree.c
index ef456be..ea386e5 100644
--- a/tree.c
+++ b/tree.c
@@ -25,7 +25,7 @@ static int read_one_entry(const unsigned
 	ce->ce_flags = create_ce_flags(baselen + len, stage);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len+1);
-	memcpy(ce->sha1, sha1, 20);
+	hashcpy(ce->sha1, sha1);
 	return add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 467d994..3ac0289 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -200,7 +200,7 @@ #endif
 
 			any_files = 1;
 
-			memcpy(ce->sha1, posns[i]->sha1, 20);
+			hashcpy(ce->sha1, posns[i]->sha1);
 			src[i + o->merge] = ce;
 			subposns[i] = df_conflict_list;
 			posns[i] = posns[i]->next;
-- 
1.4.2.gfec68
