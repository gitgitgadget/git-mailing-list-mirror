From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I'm a total push-over..
Date: Tue, 22 Jan 2008 23:23:51 -0800
Message-ID: <7vprvtngxk.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	<7vabmxqnz8.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 08:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHZys-0008UY-GM
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 08:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbYAWHYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 02:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753249AbYAWHYK
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 02:24:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbYAWHYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 02:24:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A4A226A2C;
	Wed, 23 Jan 2008 02:24:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C44786A2B;
	Wed, 23 Jan 2008 02:23:58 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801221844570.1741@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 22 Jan 2008 18:58:53 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71516>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Basically, I dislike having two copies of the same data. If something can 
> be computed from something else, then only the original data should exist, 
> and the other thing should be recomputed.

Yes, I agree with that in principle. Storing computable values
makes sense only when it is expensive to recompute.  We did not
have cache-tree for quite a long time until you noticed that it
was rather expensive and wasteful to recompute tree objects from
unchanged parts of the index every time.

It's the same argument; when the hashing performance starts to
become noticeable, we can think about storing and reusing it,
not before.

> I did consider doing the indexing only on demand, and we can certainly 
> simply just "turn it off" when we know it's never going to get used (ie 
> "git ls-files"). So in that sense, it's easy to get rid of the overhead, 
> but it didn't really seem like the conceptual complexity (even if it's 
> just a couple of lines) is really worth it. It's not like git ls-files is 
> really performance-critical anyway.

Yes, ls-files is cheap.  So is lstat(2) on Linux.  It only
matters when you do it many many times.

In any case, the change does not look too bad.  The best time
(real) of running git-ls-files in the kernel repository on my
box is 0.010s vs 0.011s (10% improvement, heh!, which is the
same as the master version) and empty commit is both 0.082s (no
change).

-- >8 --
[PATCH] lazy index hashing

This delays the hashing of index names until it becomes necessary for
the first time.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h      |    1 +
 read-cache.c |   26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 409738c..e4aeff0 100644
--- a/cache.h
+++ b/cache.h
@@ -191,6 +191,7 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	time_t timestamp;
 	void *alloc;
+	unsigned name_hash_initialized : 1;
 	struct hash_table name_hash;
 };
 
diff --git a/read-cache.c b/read-cache.c
index 9477c0b..e45f4b3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -34,12 +34,11 @@ static unsigned int hash_name(const char *name, int namelen)
 	return hash;
 }
 
-static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
 {
 	void **pos;
 	unsigned int hash = hash_name(ce->name, ce_namelen(ce));
 
-	istate->cache[nr] = ce;
 	pos = insert_hash(hash, ce, &istate->name_hash);
 	if (pos) {
 		ce->next = *pos;
@@ -47,6 +46,24 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
 	}
 }
 
+static void lazy_init_name_hash(struct index_state *istate)
+{
+	int nr;
+
+	if (istate->name_hash_initialized)
+		return;
+	for (nr = 0; nr < istate->cache_nr; nr++)
+		hash_index_entry(istate, istate->cache[nr]);
+	istate->name_hash_initialized = 1;
+}
+
+static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+{
+	istate->cache[nr] = ce;
+	if (istate->name_hash_initialized)
+		hash_index_entry(istate, ce);
+}
+
 /*
  * We don't actually *remove* it, we can just mark it invalid so that
  * we won't find it in lookups.
@@ -75,7 +92,10 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
 int index_name_exists(struct index_state *istate, const char *name, int namelen)
 {
 	unsigned int hash = hash_name(name, namelen);
-	struct cache_entry *ce = lookup_hash(hash, &istate->name_hash);
+	struct cache_entry *ce;
+
+	lazy_init_name_hash(istate);
+	ce = lookup_hash(hash, &istate->name_hash);
 
 	while (ce) {
 		if (!(ce->ce_flags & CE_UNHASHED)) {
-- 
1.5.4.rc4.14.g6fc74
