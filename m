From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] CE_REMOVE conversion
Date: Thu, 21 Feb 2008 09:31:05 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802210922100.7833@woody.linux-foundation.org>
References: <7v7igywvnj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802210746410.7833@woody.linux-foundation.org> <7vodaauunn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 18:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSFHo-0006U3-GH
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 18:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535AbYBURcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 12:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbYBURcG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 12:32:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59821 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741AbYBURcB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 12:32:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LHV6Iq014032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Feb 2008 09:31:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1LHV5FS000540;
	Thu, 21 Feb 2008 09:31:05 -0800
In-Reply-To: <7vodaauunn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.638 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_63,J_CHICKENPOX_65,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74639>



On Thu, 21 Feb 2008, Junio C Hamano wrote:
> 
> And we probably should unhash the entry instead of just removing
> it?  Come to think of it, I am starting to wonder if the
> entries unpack-trees add to and drop from the index are hashed
> and unhashed correctly...

Heh. This was exactly what I was working on, and here's an early patch.

I say "early" just because I haven't really gone through it more than 
once, and testing that it passes all the tests.

It includes your "continue" fix, since that was actually related to the 
"remove_index_entry()" addition this needs. It also contains the hash next 
pointer initialization.

The bulk of the patch is moving (and renaming) the "remove_index_entry()" 
function (used to be remove_hash_entry, but it's very specific to the 
index, not to general hashes), and the comment that goes with it.

I also made that "copy a cache entry" thing use a function of its own, and 
made sure it saves/restores the hash pointer rather than using a naked 
"memcpy()" with offsetof etc. At least it's abstracted away, even if the 
function itself is ugly as sin.

Everything else is really just one-liners.

But I'm still looking at this. In particular, I want to add some 
assertions to make sure the index state matches the name hash state, but 
your lazy patch makes that less convenient.

		Linus

---
 builtin-read-tree.c |    3 ++-
 cache.h             |   21 +++++++++++++++++++++
 read-cache.c        |   19 +++----------------
 unpack-trees.c      |    2 +-
 4 files changed, 27 insertions(+), 18 deletions(-)

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
index e1000bc..32fa6da 100644
--- a/cache.h
+++ b/cache.h
@@ -135,6 +135,27 @@ struct cache_entry {
 #define CE_UPTODATE  (0x40000)
 #define CE_UNHASHED  (0x80000)
 
+static inline void copy_cache_entry(struct cache_entry *dst, struct cache_entry *src)
+{
+	struct cache_entry *next = dst->next;
+	memcpy(dst, src, offsetof(struct cache_entry, name));
+	dst->next = next;
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
+
 static inline unsigned create_ce_flags(size_t len, unsigned stage)
 {
 	if (len >= CE_NAMEMASK)
diff --git a/read-cache.c b/read-cache.c
index e45f4b3..e8e2be8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -39,6 +39,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 	void **pos;
 	unsigned int hash = hash_name(ce->name, ce_namelen(ce));
 
+	ce->next = NULL;
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
 		ce->next = *pos;
@@ -64,26 +65,12 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
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
 
 	if (ce != old) {
-		remove_hash_entry(istate, old);
+		remove_index_entry(old);
 		set_index_entry(istate, nr, ce);
 	}
 	istate->cache_changed = 1;
@@ -413,7 +400,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
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
