From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH] two and half potential fixlets to the in-core index handling
Date: Sat, 23 Aug 2008 03:41:16 -0700
Message-ID: <7vbpzkypwz.fsf_-_@gitster.siamese.dyndns.org>
References: <20080823060839.GB23800@genesis.frugalware.org>
 <1219479293-29111-1-git-send-email-vmiklos@frugalware.org>
 <48AFD62F.2090500@gnu.org> <7vej4g12dv.fsf@gitster.siamese.dyndns.org>
 <7v7ia8126z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 12:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWqZk-0003wq-H6
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 12:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbYHWKl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 06:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbYHWKl1
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 06:41:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54869 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYHWKl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 06:41:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C0ED646C2;
	Sat, 23 Aug 2008 06:41:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8525E646C1; Sat, 23 Aug 2008 06:41:18 -0400 (EDT)
In-Reply-To: <7v7ia8126z.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 23 Aug 2008 03:00:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 08DD013C-7100-11DD-BE34-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93457>

While debugging merge-in-C with Miklos, I noticed that relatively recent
codepaths that deal with the in-core index are subtly broken when a single
process calls read_cache() more than once.

A historical invariant in the API is "if you have read the index or
populated it, then the next read_cache() is a no-op and you need to run
discard_cache() beforehand if you want to read a new on-disk index."  I
think this was broken by relatively recent unpack-trees rewrite, namely
34110cd (Make 'unpack_trees()' have a separate source and destination
index, 2008-03-06) and also 7a51ed6 (Make on-disk index representation
separate from in-core one, 2008-01-14).

With the current code, unpack_trees() builds its merge into a cleaned
o->result (an index_state structure), and it is copied to o->dst_index,
which often is the_index.  But the logic in read_from_index() that
implements the historical invariant checks if istate->alloc is NULL (in
which case the istate is empty -- just after startup, or just after
discard_index()).  The "result" index_state does not have alloc because it
is built from scratch and never allocated anything.

This wouldn't work very well.

A hacky solution I have in the attached patch is to waste an xmalloc(1)
and store it there when o->result is created, and also make
read_from_index() pay attention to the cache_nr and the cache_changed
bit. I think it is the safest and minimum fix.

Another independent issue is that istate has name_hash_initialized bit
that records the validity of the name_hash.  discard_index() frees the
name_hash, but it never resets the bit to zero.  I am not sure what the
ramifications of not doing so, but it certainly feels wrong.

Also, discard_index() did not free the array of pointers istate->cache[];
I think it should.

 read-cache.c   |   11 ++++-------
 unpack-trees.c |    2 ++
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git c/read-cache.c w/read-cache.c
index 2c03ec3..b29f263 100644
--- c/read-cache.c
+++ w/read-cache.c
@@ -1144,7 +1144,7 @@ static inline size_t estimate_cache_size(size_t ondisk_size, unsigned int entrie
 	return ondisk_size + entries*per_entry;
 }
 
-/* remember to discard_cache() before reading a different cache! */
+/* remember to discard_index() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
 	int fd, i;
@@ -1155,7 +1155,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	size_t mmap_size;
 
 	errno = EBUSY;
-	if (istate->alloc)
+	if (istate->alloc || istate->cache_nr || istate->cache_changed)
 		return istate->cache_nr;
 
 	errno = ENOENT;
@@ -1240,15 +1240,12 @@ unmap:
 
 int discard_index(struct index_state *istate)
 {
-	istate->cache_nr = 0;
-	istate->cache_changed = 0;
-	istate->timestamp = 0;
 	free_hash(&istate->name_hash);
 	cache_tree_free(&(istate->cache_tree));
 	free(istate->alloc);
-	istate->alloc = NULL;
+	free(istate->cache);
 
-	/* no need to throw away allocated active_cache */
+	memset(istate, 0, sizeof(*istate));
 	return 0;
 }
 
diff --git c/unpack-trees.c w/unpack-trees.c
index cba0aca..016fd46 100644
--- c/unpack-trees.c
+++ w/unpack-trees.c
@@ -378,6 +378,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	memset(&o->result, 0, sizeof(o->result));
 	if (o->src_index)
 		o->result.timestamp = o->src_index->timestamp;
+	if (o->dst_index)
+		o->result.alloc = xmalloc(1);
 	o->merge_size = len;
 
 	if (!dfc)
