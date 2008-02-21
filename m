From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] CE_REMOVE conversion
Date: Thu, 21 Feb 2008 12:06:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802211157100.19896@woody.linux-foundation.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802210746410.7833@woody.linux-foundation.org> <7vodaauunn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802210922100.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSHim-0007dw-GQ
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbYBUUIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbYBUUIG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:08:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45285 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756930AbYBUUIE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 15:08:04 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LK6LGx019935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Feb 2008 12:06:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LK6KrK006294;
	Thu, 21 Feb 2008 12:06:21 -0800
In-Reply-To: <alpine.LFD.1.00.0802210922100.7833@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.637 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_63,J_CHICKENPOX_65,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74648>



On Thu, 21 Feb 2008, Linus Torvalds wrote:
> 
> I say "early" just because I haven't really gone through it more than 
> once, and testing that it passes all the tests.

Ok, here's an improved version. This is a bit larger, but having now 
thought the problems through, I think this is *much* better.

The thing is, we used to not be able to handle the case of removing a 
index entry and then re-inserting it, and we even had a rather ugly 
special case for that reason, where replace_index_entry() basically turned 
itself into a no-op if the new and the old entries were the same.

But the merging code really wants to remove a set of entries and then 
replace them with a new one, and that whole logic needed the hash lists to 
be handled *properly*.

So what this patch does is to not just have the UNHASHED bit, but a HASHED 
bit too, and when you insert an entry into the name hash, that involves:

 - clear the UNHASHED bit, because now it's valid again for lookup (which 
   is really all that UNHASHED meant)
 - if we're being lazy, we're done here (but we still want to clear the 
   UNHASHED bit regardless of lazy mode, since we can become unlazy later, 
   and so we need the UNHASHED bit to always be set correctly, even if we 
   never actually insert the entry into the hash list)
 - if it was already hashed, we just leave it on the list
 - otherwise mark it HASHED and insert it into the list

this all means that unhashing and rehashing a name all just works 
automatically. Obviously, you cannot change the name of an entry (that 
would be a serious bug), but nothing can validly do that anyway (you'd 
have to allocate a new struct cache_entry anyway since the name length 
could change), so that's not a new limitation.

The code actually gets simpler in many ways, although the lazy hashing 
does mean that there are a few odd cases (ie something can be marked 
unhashed even though it was never on the hash in the first place, and 
isn't actually marked hashed!).

I haven't actually added any code to verify that the name hash state 
matches the index state, but I feel pretty good about this patch anyway: 
it passes my "it makes sense" filters in ways that the previous one 
didn't.

		Linus

---
 builtin-read-tree.c |    3 ++-
 cache.h             |   35 ++++++++++++++++++++++++++++++++++-
 read-cache.c        |   30 ++++++++++--------------------
 unpack-trees.c      |    2 +-
 4 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 5785401..7bdc312 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -41,11 +41,12 @@ static int read_cache_unmerged(void)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce)) {
+			remove_index_entry(ce);
 			if (last && !strcmp(ce->name, last->name))
 				continue;
 			cache_tree_invalidate_path(active_cache_tree, ce->name);
 			last = ce;
-			ce->ce_flags |= CE_REMOVE;
+			continue;
 		}
 		*dst++ = ce;
 	}
diff --git a/cache.h b/cache.h
index e1000bc..0ae33f4 100644
--- a/cache.h
+++ b/cache.h
@@ -133,7 +133,40 @@ struct cache_entry {
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
 #define CE_UPTODATE  (0x40000)
-#define CE_UNHASHED  (0x80000)
+
+#define CE_HASHED    (0x100000)
+#define CE_UNHASHED  (0x200000)
+
+/*
+ * Copy the sha1 and stat state of a cache entry from one to
+ * another. But we never change the name, or the hash state!
+ */
+#define CE_STATE_MASK (CE_HASHED | CE_UNHASHED)
+static inline void copy_cache_entry(struct cache_entry *dst, struct cache_entry *src)
+{
+	struct cache_entry *next = dst->next;
+	unsigned int state = dst->ce_flags & CE_STATE_MASK;
+
+	memcpy(dst, src, offsetof(struct cache_entry, name));
+
+	/* Restore the hash state */
+	dst->next = next;
+	dst->ce_flags = (dst->ce_flags & ~CE_STATE_MASK) | state;
+}
+
+/*
+ * We don't actually *remove* it, we can just mark it invalid so that
+ * we won't find it in lookups.
+ *
+ * Not only would we have to search the lists (simple enough), but
+ * we'd also have to rehash other hash buckets in case this makes the
+ * hash bucket empty (common). So it's much better to just mark
+ * it.
+ */
+static inline void remove_index_entry(struct cache_entry *ce)
+{
+	ce->ce_flags |= CE_UNHASHED;
+}
 
 static inline unsigned create_ce_flags(size_t len, unsigned stage)
 {
diff --git a/read-cache.c b/read-cache.c
index e45f4b3..fee0c80 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -37,8 +37,13 @@ static unsigned int hash_name(const char *name, int namelen)
 static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 {
 	void **pos;
-	unsigned int hash = hash_name(ce->name, ce_namelen(ce));
+	unsigned int hash;
 
+	if (ce->ce_flags & CE_HASHED)
+		return;
+	ce->ce_flags |= CE_HASHED;
+	ce->next = NULL;
+	hash = hash_name(ce->name, ce_namelen(ce));
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
 		ce->next = *pos;
@@ -59,33 +64,18 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
+	ce->ce_flags &= ~CE_UNHASHED;
 	istate->cache[nr] = ce;
 	if (istate->name_hash_initialized)
 		hash_index_entry(istate, ce);
 }
 
-/*
- * We don't actually *remove* it, we can just mark it invalid so that
- * we won't find it in lookups.
- *
- * Not only would we have to search the lists (simple enough), but
- * we'd also have to rehash other hash buckets in case this makes the
- * hash bucket empty (common). So it's much better to just mark
- * it.
- */
-static void remove_hash_entry(struct index_state *istate, struct cache_entry *ce)
-{
-	ce->ce_flags |= CE_UNHASHED;
-}
-
 static void replace_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
 	struct cache_entry *old = istate->cache[nr];
 
-	if (ce != old) {
-		remove_hash_entry(istate, old);
-		set_index_entry(istate, nr, ce);
-	}
+	remove_index_entry(old);
+	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
 }
 
@@ -413,7 +403,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
-	remove_hash_entry(istate, ce);
+	remove_index_entry(ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
diff --git a/unpack-trees.c b/unpack-trees.c
index ec558f9..07c4c28 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -590,7 +590,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		 * a match.
 		 */
 		if (same(old, merge)) {
-			memcpy(merge, old, offsetof(struct cache_entry, name));
+			copy_cache_entry(merge, old);
 		} else {
 			verify_uptodate(old, o);
 			invalidate_ce_path(old);
