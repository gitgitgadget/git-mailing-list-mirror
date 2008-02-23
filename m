From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Fix name re-hashing semantics
Date: Fri, 22 Feb 2008 20:37:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802222033570.21332@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802222029180.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 05:38:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSmA2-0000Ez-3H
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 05:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbYBWEiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 23:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbYBWEiO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 23:38:14 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:49719 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752029AbYBWEiL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 23:38:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4beCW017406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Feb 2008 20:37:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1N4beun012591;
	Fri, 22 Feb 2008 20:37:40 -0800
In-Reply-To: <alpine.LFD.1.00.0802222029180.21332@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.062 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74796>


From: Linus Torvalds <torvalds@linux-foundation.org>

We handled the case of removing and re-inserting cache entries badly,
which is something that merging commonly needs to do (removing the
different stages, and then re-inserting one of them as the merged
state).

We even had a rather ugly special case for this failure case, where
replace_index_entry() basically turned itself into a no-op if the new
and the old entries were the same, exactly because the hash routines
didn't handle it on their own.

So what this patch does is to not just have the UNHASHED bit, but a
HASHED bit too, and when you insert an entry into the name hash, that
involves:

 - clear the UNHASHED bit, because now it's valid again for lookup
   (which is really all that UNHASHED meant)

 - if we're being lazy, we're done here (but we still want to clear the
   UNHASHED bit regardless of lazy mode, since we can become unlazy
   later, and so we need the UNHASHED bit to always be set correctly,
   even if we never actually insert the entry into the hash list)

 - if it was already hashed, we just leave it on the list

 - otherwise mark it HASHED and insert it into the list

this all means that unhashing and rehashing a name all just works
automatically.  Obviously, you cannot change the name of an entry (that
would be a serious bug), but nothing can validly do that anyway (you'd
have to allocate a new struct cache_entry anyway since the name length
could change), so that's not a new limitation.

The code actually gets simpler in many ways, although the lazy hashing
does mean that there are a few odd cases (ie something can be marked
unhashed even though it was never on the hash in the first place, and
isn't actually marked hashed!).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This does fix a bug, in the sense that a two- or three-way merge would 
mark an index entry as being CE_UNHASHED, but then when it got re-inserted 
it would stay marked as such, so "index_name_exists()" wouldn't find it 
even though it now exists in the index again.

But nobody used it that way, so I guess it didn't matter. Still, this is 
clearer and works more sanely.

 cache.h      |    4 +++-
 read-cache.c |   14 +++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index e1000bc..0b69c92 100644
--- a/cache.h
+++ b/cache.h
@@ -133,7 +133,9 @@ struct cache_entry {
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
 #define CE_UPTODATE  (0x40000)
-#define CE_UNHASHED  (0x80000)
+
+#define CE_HASHED    (0x100000)
+#define CE_UNHASHED  (0x200000)
 
 static inline unsigned create_ce_flags(size_t len, unsigned stage)
 {
diff --git a/read-cache.c b/read-cache.c
index e45f4b3..eb58b03 100644
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
@@ -59,6 +64,7 @@ static void lazy_init_name_hash(struct index_state *istate)
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
 {
+	ce->ce_flags &= ~CE_UNHASHED;
 	istate->cache[nr] = ce;
 	if (istate->name_hash_initialized)
 		hash_index_entry(istate, ce);
@@ -82,10 +88,8 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 {
 	struct cache_entry *old = istate->cache[nr];
 
-	if (ce != old) {
-		remove_hash_entry(istate, old);
-		set_index_entry(istate, nr, ce);
-	}
+	remove_hash_entry(istate, old);
+	set_index_entry(istate, nr, ce);
 	istate->cache_changed = 1;
 }
 
