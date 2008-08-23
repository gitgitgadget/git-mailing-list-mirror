From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] unpack_trees(): protect the handcrafted in-core index
 from read_cache()
Date: Sat, 23 Aug 2008 12:57:30 -0700
Message-ID: <7vbpzjy05x.fsf_-_@gitster.siamese.dyndns.org>
References: <7v3akw2jgo.fsf@gitster.siamese.dyndns.org>
 <1219489071-5679-1-git-send-email-vmiklos@frugalware.org>
 <7vk5e7y0a0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 21:59:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWzGB-0007cO-DM
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbYHWT5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758620AbYHWT5j
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:57:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758616AbYHWT5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:57:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F2FEC6AA8E;
	Sat, 23 Aug 2008 15:57:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 070136AA8D; Sat, 23 Aug 2008 15:57:31 -0400 (EDT)
In-Reply-To: <7vk5e7y0a0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 23 Aug 2008 12:55:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBE5FBEC-714D-11DD-A498-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93484>

unpack_trees() rebuilds the in-core index from scratch by allocating a new
structure and finishing it off by copying the built one to the final
index.

The resulting in-core index is Ok for most use, but read_cache() does not
recognize it as such.  The function is meant to be no-op if you already
have loaded the index, until you call discard_cache().

This change the way read_cache() detects an already initialized in-core
index, by introducing an extra bit, and marks the handcrafted in-core
index as initialized, to avoid this problem.

A better fix in the longer term would be to change the read_cache() API so
that it will always discard and re-read from the on-disk index to avoid
confusion.  But there are higher level API that have relied on the current
semantics, and they and their users all need to get converted, which is
outside the scope of 'maint' track.

An example of such a higher level API is write_cache_as_tree(), which is
used by git-write-tree as well as later Porcelains like git-merge, revert
and cherry-pick.  In the longer term, we should remove read_cache() from
there and add one to cmd_write_tree(); other callers expect that the
in-core index they prepared is what gets written as a tree so no other
change is necessary for this particular codepath.

The original version of this patch marked the index by pointing an
otherwise wasted malloc'ed memory with o->result.alloc, but this version
uses Linus's idea to use a new "initialized" bit, which is conceptually
much cleaner.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                  |    3 ++-
 read-cache.c             |    4 +++-
 t/t7605-merge-resolve.sh |    2 +-
 unpack-trees.c           |    1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2475de9..884fae8 100644
--- a/cache.h
+++ b/cache.h
@@ -222,7 +222,8 @@ struct index_state {
 	struct cache_tree *cache_tree;
 	time_t timestamp;
 	void *alloc;
-	unsigned name_hash_initialized : 1;
+	unsigned name_hash_initialized : 1,
+		 initialized : 1;
 	struct hash_table name_hash;
 };
 
diff --git a/read-cache.c b/read-cache.c
index 2c03ec3..35fec46 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1155,7 +1155,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	size_t mmap_size;
 
 	errno = EBUSY;
-	if (istate->alloc)
+	if (istate->initialized)
 		return istate->cache_nr;
 
 	errno = ENOENT;
@@ -1195,6 +1195,7 @@ int read_index_from(struct index_state *istate, const char *path)
 	 * index size
 	 */
 	istate->alloc = xmalloc(estimate_cache_size(mmap_size, istate->cache_nr));
+	istate->initialized = 1;
 
 	src_offset = sizeof(*hdr);
 	dst_offset = 0;
@@ -1247,6 +1248,7 @@ int discard_index(struct index_state *istate)
 	cache_tree_free(&(istate->cache_tree));
 	free(istate->alloc);
 	istate->alloc = NULL;
+	istate->initialized = 0;
 
 	/* no need to throw away allocated active_cache */
 	return 0;
diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 5c53608..f1f86dd 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
-test_expect_failure 'merge c1 to c2' '
+test_expect_success 'merge c1 to c2' '
 	git reset --hard c1 &&
 	git merge -s resolve c2 &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
diff --git a/unpack-trees.c b/unpack-trees.c
index cba0aca..ef21c62 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -376,6 +376,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	state.refresh_cache = 1;
 
 	memset(&o->result, 0, sizeof(o->result));
+	o->result.initialized = 1;
 	if (o->src_index)
 		o->result.timestamp = o->src_index->timestamp;
 	o->merge_size = len;
-- 
1.6.0.51.g078ae
