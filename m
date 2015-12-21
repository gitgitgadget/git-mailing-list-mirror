From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pack-revindex: drop hash table
Date: Mon, 21 Dec 2015 01:19:49 -0500
Message-ID: <20151221061948.GA25763@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 07:20:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAtpY-0000wS-1y
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 07:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbbLUGTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 01:19:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:44788 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750794AbbLUGTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 01:19:52 -0500
Received: (qmail 29321 invoked by uid 102); 21 Dec 2015 06:19:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 00:19:52 -0600
Received: (qmail 18313 invoked by uid 107); 21 Dec 2015 06:20:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Dec 2015 01:20:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Dec 2015 01:19:49 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282783>

The main entry point to the pack-revindex code is
find_pack_revindex(). This calls revindex_for_pack(), which
lazily computes and caches the revindex for the pack.

We store the cache in a very simple hash table. It's created
by init_pack_revindex(), which inserts an entry for every
packfile we know about, and we never grow or shrink the
hash. If we ever need the revindex for a pack that isn't in
the hash, we die() with an internal error.

This can lead to a race, because we may load more packs
after having called init_pack_revindex(). For example,
imagine we have one process which needs to look at the
revindex for a variety of objects (e.g., cat-file's
"%(objectsize:disk)" format).  Simultaneously, git-gc is
running, which is doing a `git repack -ad` is running. We
might hit a sequence like:

  1. We need the revidx for some packed object. We call
     find_pack_revindex() and end up in init_pack_revindex()
     to create the hash table for all packs we know about.

  2. We look up another object and can't find it, because
     the repack has removed the pack it's in. We re-scan the
     pack directory and find a new pack containing the
     object. It gets added to our packed_git list.

  3. We call find_pack_revindex() for the new object, which
     hits revindex_for_pack() for our new pack. It can't
     find the packed_git in the revindex hash, and dies.

You could also replace the `repack` above with a push or
fetch to create a new pack, though these are less likely
(you would have to somehow learn about the new objects to
look them up).

Prior to 1a6d8b9 (do not discard revindex when re-preparing
packfiles, 2014-01-15), this was safe, as we threw away the
revindex whenever we re-scanned the pack directory (and thus
re-created the revindex hash on the fly). However, we don't
want to simply revert that commit, as it was solving a
different race.

So we have a few options:

  - We can fix the race in 1a6d8b9 differently, by having
    the bitmap code look in the revindex hash instead of
    caching the pointer. But this would introduce a lot of
    extra hash lookups for common bitmap operations.

  - We could teach the revindex to dynamically add new packs
    to the hash table. This would perform the same, but
    would mean adding extra code to the revindex hash (which
    currently cannot be resized at all).

  - We can get rid of the hash table entirely. There is
    exactly one revindex per pack, so we can just store it
    in the packed_git struct. Since it's initialized lazily,
    it does not add to the startup cost.

    This is the best of both worlds: less code and fewer
    hash table lookups.  The original code likely avoided
    this in the name of encapsulation. But the packed_git
    and reverse_index code are fairly intimate already, so
    it's not much of a loss.

This patch implements the final option. It's a minimal
conversion that retains the pack_revindex struct. No callers
need to change, and we can do further cleanup in a follow-on
patch.

Signed-off-by: Jeff King <peff@peff.net>
---
The race was added in v2.0.0. I doubt it comes up much in practice,
because not much code uses the revidx. We started seeing it at GitHub
when we added a frequent automated job that uses "git cat-file" as
above. So probably something for 'maint', but not urgent.

 cache.h         |  2 ++
 pack-revindex.c | 60 ++++++---------------------------------------------------
 2 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/cache.h b/cache.h
index 5ab6cb5..de4ef88 100644
--- a/cache.h
+++ b/cache.h
@@ -9,6 +9,7 @@
 #include "convert.h"
 #include "trace.h"
 #include "string-list.h"
+#include "pack-revindex.h"
 
 #include SHA1_HEADER
 #ifndef platform_SHA_CTX
@@ -1298,6 +1299,7 @@ extern struct packed_git {
 		 freshened:1,
 		 do_not_close:1;
 	unsigned char sha1[20];
+	struct pack_revindex reverse_index;
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
diff --git a/pack-revindex.c b/pack-revindex.c
index e542ea7..8e63dbc 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -8,52 +8,13 @@
  * size is easily available by examining the pack entry header).  It is
  * also rather expensive to find the sha1 for an object given its offset.
  *
- * We build a hashtable of existing packs (pack_revindex), and keep reverse
- * index here -- pack index file is sorted by object name mapping to offset;
- * this pack_revindex[].revindex array is a list of offset/index_nr pairs
+ * The pack index file is sorted by object name mapping to offset;
+ * this revindex array is a list of offset/index_nr pairs
  * ordered by offset, so if you know the offset of an object, next offset
  * is where its packed representation ends and the index_nr can be used to
  * get the object sha1 from the main index.
  */
 
-static struct pack_revindex *pack_revindex;
-static int pack_revindex_hashsz;
-
-static int pack_revindex_ix(struct packed_git *p)
-{
-	unsigned long ui = (unsigned long)(intptr_t)p;
-	int i;
-
-	ui = ui ^ (ui >> 16); /* defeat structure alignment */
-	i = (int)(ui % pack_revindex_hashsz);
-	while (pack_revindex[i].p) {
-		if (pack_revindex[i].p == p)
-			return i;
-		if (++i == pack_revindex_hashsz)
-			i = 0;
-	}
-	return -1 - i;
-}
-
-static void init_pack_revindex(void)
-{
-	int num;
-	struct packed_git *p;
-
-	for (num = 0, p = packed_git; p; p = p->next)
-		num++;
-	if (!num)
-		return;
-	pack_revindex_hashsz = num * 11;
-	pack_revindex = xcalloc(pack_revindex_hashsz, sizeof(*pack_revindex));
-	for (p = packed_git; p; p = p->next) {
-		num = pack_revindex_ix(p);
-		num = - 1 - num;
-		pack_revindex[num].p = p;
-	}
-	/* revindex elements are lazily initialized */
-}
-
 /*
  * This is a least-significant-digit radix sort.
  *
@@ -198,20 +159,11 @@ static void create_pack_revindex(struct pack_revindex *rix)
 
 struct pack_revindex *revindex_for_pack(struct packed_git *p)
 {
-	int num;
-	struct pack_revindex *rix;
-
-	if (!pack_revindex_hashsz)
-		init_pack_revindex();
-
-	num = pack_revindex_ix(p);
-	if (num < 0)
-		die("internal error: pack revindex fubar");
-
-	rix = &pack_revindex[num];
-	if (!rix->revindex)
+	struct pack_revindex *rix = &p->reverse_index;
+	if (!rix->revindex) {
+		rix->p = p;
 		create_pack_revindex(rix);
-
+	}
 	return rix;
 }
 
-- 
2.7.0.rc1.350.g9acc0f4
