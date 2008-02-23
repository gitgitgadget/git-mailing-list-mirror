From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] Name hash fixups: export (and rename)
 remove_hash_entry
Date: Fri, 22 Feb 2008 20:39:21 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802222037560.21332@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802222029180.21332@woody.linux-foundation.org> <alpine.LFD.1.00.0802222033570.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 05:41:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSmC3-0000cV-Fe
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 05:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYBWEkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 23:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752298AbYBWEkX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 23:40:23 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:46340 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973AbYBWEkW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 23:40:22 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4dMdX017519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Feb 2008 20:39:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4dLP5012631;
	Fri, 22 Feb 2008 20:39:21 -0800
In-Reply-To: <alpine.LFD.1.00.0802222033570.21332@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.562 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74797>


From: Linus Torvalds <torvalds@linux-foundation.org>

This makes the name hash removal function (which really just sets the
bit that disables lookups of it) available to external routines, and
makes read_cache_unmerged() use it when it drops an unmerged entry from
the index.

It's renamed to remove_index_entry(), and we drop the (unused) 'istate'
argument.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Oops, I forgot to number the previous patch. That was 1/3.

The changelog above matches what the patch obviously does.

 builtin-read-tree.c |    1 +
 cache.h             |   14 ++++++++++++++
 read-cache.c        |   18 ++----------------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 726fb0b..7bdc312 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -41,6 +41,7 @@ static int read_cache_unmerged(void)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		if (ce_stage(ce)) {
+			remove_index_entry(ce);
 			if (last && !strcmp(ce->name, last->name))
 				continue;
 			cache_tree_invalidate_path(active_cache_tree, ce->name);
diff --git a/cache.h b/cache.h
index 0b69c92..88d3b92 100644
--- a/cache.h
+++ b/cache.h
@@ -137,6 +137,20 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
 
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
index eb58b03..fee0c80 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -70,25 +70,11 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
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
 
-	remove_hash_entry(istate, old);
+	remove_index_entry(old);
 	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
 }
@@ -417,7 +403,7 @@ int remove_index_entry_at(struct index_state *istate, int pos)
 {
 	struct cache_entry *ce = istate->cache[pos];
 
-	remove_hash_entry(istate, ce);
+	remove_index_entry(ce);
 	istate->cache_changed = 1;
 	istate->cache_nr--;
 	if (pos >= istate->cache_nr)
