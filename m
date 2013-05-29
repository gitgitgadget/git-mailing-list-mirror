From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Wed, 29 May 2013 03:22:25 -0400
Message-ID: <20130529072225.GB11955@sigill.intra.peff.net>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
 <20130529062007.GA11955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 29 09:22:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhaiR-0004Im-IU
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 09:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789Ab3E2HWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 03:22:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:36600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935097Ab3E2HW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 03:22:29 -0400
Received: (qmail 16702 invoked by uid 102); 29 May 2013 07:23:08 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 02:23:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 03:22:25 -0400
Content-Disposition: inline
In-Reply-To: <20130529062007.GA11955@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225766>

On Wed, May 29, 2013 at 02:20:07AM -0400, Jeff King wrote:

> In the best case, we compute no patch-ids at all. And even for the
> average case, I'd expect our lazy calculation to only have to compute a
> handful of ids.

Here is a not-well-tested version of the idea. I tried to contain the
changes to patch-ids.c, though we may also be able to simplify the
--cherry code, too.

Here are my timings compared to stock git and to yours
(all are best-of-five, "git log --cherry $revs"):

  revs=origin/master...origin/jk/submodule-subdirectory-ok
        stock    |    you   |    me
        -------------------------------
  real  0m0.501s | 0m0.078s | 0m0.098s
  user  0m0.480s | 0m0.056s | 0m0.084s
  sys   0m0.016s | 0m0.020s | 0m0.012s

  revs=origin/next...origin/pu
        stock    |    you   |    me
        -------------------------------
  real  0m0.857s | 0m0.847s | 0m0.519s
  user  0m0.828s | 0m0.812s | 0m0.488s
  sys   0m0.024s | 0m0.028s | 0m0.024s

So it performs slightly less well on the small case, and a bit better on
the large case. I think part of the problem is that when we do have a
"loose" hit, we end up re-doing the tree diff to find the strict, which
involves re-inflating the trees. It's unavoidable for the lazy entries
unless we want to cache the whole diff_queued_diff, but for the non-lazy
entries we should be able to do the strict patch-id incrementally. We
just need to improve the function interfaces.

---
 diff.c      |  15 ++++-
 diff.h      |   2 +-
 patch-ids.c | 117 +++++++++++++++++++----------------
 patch-ids.h |  11 ++--
 4 files changed, 82 insertions(+), 63 deletions(-)

diff --git a/diff.c b/diff.c
index f0b3e7c..3b55788 100644
--- a/diff.c
+++ b/diff.c
@@ -4233,7 +4233,8 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 }
 
 /* returns 0 upon success, and writes result into sha1 */
-static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
+static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
+			     int loose)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -4266,6 +4267,12 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		if (DIFF_PAIR_UNMERGED(p))
 			continue;
 
+		if (loose) {
+			git_SHA1_Update(&ctx, p->one->path, strlen(p->one->path));
+			git_SHA1_Update(&ctx, p->two->path, strlen(p->two->path));
+			continue;
+		}
+
 		diff_fill_sha1_info(p->one);
 		diff_fill_sha1_info(p->two);
 		if (fill_mmfile(&mf1, p->one) < 0 ||
@@ -4323,11 +4330,13 @@ int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
+int diff_flush_patch_id(struct diff_options *options,
+			unsigned char *sha1,
+			int loose)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, sha1);
+	int result = diff_get_patch_id(options, sha1, loose);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
diff --git a/diff.h b/diff.h
index 78b4091..b018aaf 100644
--- a/diff.h
+++ b/diff.h
@@ -320,7 +320,7 @@ extern int do_diff_cache(const unsigned char *, struct diff_options *);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
 extern int do_diff_cache(const unsigned char *, struct diff_options *);
-extern int diff_flush_patch_id(struct diff_options *, unsigned char *);
+extern int diff_flush_patch_id(struct diff_options *, unsigned char *, int loose);
 
 extern int diff_result_code(struct diff_options *, int);
 
diff --git a/patch-ids.c b/patch-ids.c
index bc8a28f..3a83ee6 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -5,7 +5,7 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
 #include "patch-ids.h"
 
 static int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    unsigned char *sha1)
+			   unsigned char *sha1, int loose)
 {
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.sha1,
@@ -13,27 +13,9 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_sha1(commit->object.sha1, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1);
+	return diff_flush_patch_id(options, sha1, loose);
 }
 
-static const unsigned char *patch_id_access(size_t index, void *table)
-{
-	struct patch_id **id_table = table;
-	return id_table[index]->patch_id;
-}
-
-static int patch_pos(struct patch_id **table, int nr, const unsigned char *id)
-{
-	return sha1_pos(id, table, nr, patch_id_access);
-}
-
-#define BUCKET_SIZE 190 /* 190 * 21 = 3990, with slop close enough to 4K */
-struct patch_id_bucket {
-	struct patch_id_bucket *next;
-	int nr;
-	struct patch_id bucket[BUCKET_SIZE];
-};
-
 int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
@@ -43,56 +25,83 @@ static struct patch_id *add_commit(struct commit *commit,
 	return 0;
 }
 
+static int free_each_patch_id(void *patch_id, void *data)
+{
+	free(patch_id);
+	return 0;
+}
+
 int free_patch_ids(struct patch_ids *ids)
 {
-	struct patch_id_bucket *next, *patches;
-
-	free(ids->table);
-	for (patches = ids->patches; patches; patches = next) {
-		next = patches->next;
-		free(patches);
-	}
+	for_each_hash(&ids->table, free_each_patch_id, NULL);
+	free_hash(&ids->table);
 	return 0;
 }
 
+static inline unsigned long hash_sha1(const unsigned char *sha1)
+{
+	unsigned int hash;
+	memcpy(&hash, sha1, sizeof(hash));
+	return hash;
+}
+
 static struct patch_id *add_commit(struct commit *commit,
 				   struct patch_ids *ids,
 				   int no_add)
 {
-	struct patch_id_bucket *bucket;
-	struct patch_id *ent;
-	unsigned char sha1[20];
-	int pos;
+	struct patch_id *p;
+	unsigned char loose[20], strict[20];
+	unsigned long hash;
+	void **pos;
 
-	if (commit_patch_id(commit, &ids->diffopts, sha1))
+	if (commit_patch_id(commit, &ids->diffopts, loose, 1))
 		return NULL;
-	pos = patch_pos(ids->table, ids->nr, sha1);
-	if (0 <= pos)
-		return ids->table[pos];
+	hash = hash_sha1(loose);
+
+	p = lookup_hash(hash, &ids->table);
+	for (; p; p = p->next) {
+		/* Skip collisions from our reduced hash. */
+		if (hashcmp(loose, p->loose))
+		    continue;
+
+		/*
+		 * We have a real loose match; lazily load and cache the strict
+		 * id to compare.
+		 */
+		if (is_null_sha1(p->strict)) {
+			if (commit_patch_id(p->commit, &ids->diffopts,
+					    p->strict, 0))
+				return NULL;
+		}
+		if (commit_patch_id(commit, &ids->diffopts, strict, 0))
+			return NULL;
+
+		/*
+		 * If the strict ones match, we do not need to look farther;
+		 * the patch-id is here.
+		 */
+		if (!hashcmp(strict, p->strict))
+			return p;
+	}
+
+	/*
+	 * Otherwise, we may have a loose but not strict match, or even no
+	 * loose match at all. Now we can add the new entry (or return failure
+	 * to look it up).
+	 */
 	if (no_add)
 		return NULL;
 
-	pos = -1 - pos;
+	p = xcalloc(1, sizeof(*p));
+	p->commit = commit;
+	hashcpy(p->loose, loose);
 
-	bucket = ids->patches;
-	if (!bucket || (BUCKET_SIZE <= bucket->nr)) {
-		bucket = xcalloc(1, sizeof(*bucket));
-		bucket->next = ids->patches;
-		ids->patches = bucket;
+	pos = insert_hash(hash, p, &ids->table);
+	if (pos) {
+		p->next = *pos;
+		*pos = p;
 	}
-	ent = &bucket->bucket[bucket->nr++];
-	hashcpy(ent->patch_id, sha1);
-
-	if (ids->alloc <= ids->nr) {
-		ids->alloc = alloc_nr(ids->nr);
-		ids->table = xrealloc(ids->table, sizeof(ent) * ids->alloc);
-	}
-	if (pos < ids->nr)
-		memmove(ids->table + pos + 1, ids->table + pos,
-			sizeof(ent) * (ids->nr - pos));
-	ids->nr++;
-	ids->table[pos] = ent;
-	return ids->table[pos];
+	return p;
 }
 
 struct patch_id *has_commit_patch_id(struct commit *commit,
diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..c40ff39 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -2,15 +2,16 @@ struct patch_ids {
 #define PATCH_IDS_H
 
 struct patch_id {
-	unsigned char patch_id[20];
-	char seen;
+	struct commit *commit;
+	unsigned char loose[20];
+	unsigned char strict[20];
+	unsigned seen:1;
+	struct patch_id *next;
 };
 
 struct patch_ids {
 	struct diff_options diffopts;
-	int nr, alloc;
-	struct patch_id **table;
-	struct patch_id_bucket *patches;
+	struct hash_table table;
 };
 
 int init_patch_ids(struct patch_ids *);
