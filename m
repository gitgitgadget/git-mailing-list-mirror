From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] two and half potential fixlets to the in-core index
 handling
Date: Sat, 23 Aug 2008 11:13:14 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808231104500.3363@nehalem.linux-foundation.org>
References: <20080823060839.GB23800@genesis.frugalware.org> <1219479293-29111-1-git-send-email-vmiklos@frugalware.org> <48AFD62F.2090500@gnu.org> <7vej4g12dv.fsf@gitster.siamese.dyndns.org> <7v7ia8126z.fsf@gitster.siamese.dyndns.org>
 <7vbpzkypwz.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 20:18:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWxgZ-0004VX-6M
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 20:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbYHWSO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 14:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbYHWSO5
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 14:14:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53325 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751567AbYHWSO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 14:14:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NIDGVS011404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 23 Aug 2008 11:13:17 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7NIDEaf027191;
	Sat, 23 Aug 2008 11:13:15 -0700
In-Reply-To: <7vbpzkypwz.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.928 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93469>



On Sat, 23 Aug 2008, Junio C Hamano wrote:
> 
> A hacky solution I have in the attached patch is to waste an xmalloc(1)
> and store it there when o->result is created, and also make
> read_from_index() pay attention to the cache_nr and the cache_changed
> bit. I think it is the safest and minimum fix.

Hmm. Wouldn't it be nicer to just add another bit to istate? We have the 
space already, since we already have a bitfield there, with just one bit 
used?

Something like this..

Untested. Of course.

			Linus

---
 cache.h        |    3 ++-
 read-cache.c   |    4 +++-
 unpack-trees.c |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 68ce6e6..6e41ec4 100644
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
