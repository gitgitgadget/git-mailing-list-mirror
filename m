From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Mon, 24 Oct 2011 23:59:14 +0200
Message-ID: <4EA5DFB2.3050406@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx> <20111023162944.GB28156@sigill.intra.peff.net> <4EA453D3.7080002@lsrfire.ath.cx> <4EA4B8E7.5070106@lsrfire.ath.cx> <7vipne50lz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 23:59:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RISYM-0000QD-6M
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 23:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab1JXV7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 17:59:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:60200 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab1JXV7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 17:59:24 -0400
Received: from [192.168.2.104] (p4FFD8D85.dip.t-dialin.net [79.253.141.133])
	by india601.server4you.de (Postfix) with ESMTPSA id 8EBFB2F8038;
	Mon, 24 Oct 2011 23:59:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vipne50lz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184187>

Am 24.10.2011 09:07, schrieb Junio C Hamano:
> Thanks.
> 
> This approach may be the most appropriate for the maintenance track, but
> for the purpose of going forward, I wonder if we really want to keep the
> "estimate and allocate a large pool, and carve out individual pieces".
> 
> This bulk-allocate dates back to the days when we didn't have ondisk vs
> incore representation differences, IIRC, and as the result we deliberately
> leak cache entries whenever an entry in the index is replaced with a new
> one. Does the overhead to allocate individually really kill us that much
> for say a tree with 30k files in it?

Something like this (applies to master)?  Very basic testing didn't show
any slowdown of git status in the Linux repo.

-- >8 --
Subject: read-cache.c: allocate index entries individually

The code to estimate the in-memory size of the index based on its on-disk
representation is subtly wrong for certain architecture-dependent struct
layouts.  Instead of fixing it, replace the code to keep the index entries
in a single large block of memory and allocate each entry separately
instead.  This is both simpler and more flexible, as individual entries
can now be freed.  Actually using that added flexibility is left for a
later patch.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Note: This patch was brought to you by the option --histogram, which
produced nicer output than the default diff method.

 cache.h      |    1 -
 read-cache.c |   86 +++++++++++++++++++++++----------------------------------
 2 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/cache.h b/cache.h
index be07ec7..ec0e571 100644
--- a/cache.h
+++ b/cache.h
@@ -316,7 +316,6 @@ struct index_state {
 	struct string_list *resolve_undo;
 	struct cache_tree *cache_tree;
 	struct cache_time timestamp;
-	void *alloc;
 	unsigned name_hash_initialized : 1,
 		 initialized : 1;
 	struct hash_table name_hash;
diff --git a/read-cache.c b/read-cache.c
index 01a0e25..7f75bfa 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1202,10 +1202,35 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
-static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_entry *ce)
+static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk)
 {
+	struct cache_entry *ce;
 	size_t len;
 	const char *name;
+	unsigned int flags;
+
+	/* On-disk flags are just 16 bits */
+	flags = ntohs(ondisk->flags);
+	len = flags & CE_NAMEMASK;
+
+	if (flags & CE_EXTENDED) {
+		struct ondisk_cache_entry_extended *ondisk2;
+		int extended_flags;
+		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
+		extended_flags = ntohs(ondisk2->flags2) << 16;
+		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
+		if (extended_flags & ~CE_EXTENDED_FLAGS)
+			die("Unknown index entry format %08x", extended_flags);
+		flags |= extended_flags;
+		name = ondisk2->name;
+	}
+	else
+		name = ondisk->name;
+
+	if (len == CE_NAMEMASK)
+		len = strlen(name);
+
+	ce = xmalloc(cache_entry_size(len));
 
 	ce->ce_ctime.sec = ntohl(ondisk->ctime.sec);
 	ce->ce_mtime.sec = ntohl(ondisk->mtime.sec);
@@ -1217,48 +1242,16 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 	ce->ce_uid   = ntohl(ondisk->uid);
 	ce->ce_gid   = ntohl(ondisk->gid);
 	ce->ce_size  = ntohl(ondisk->size);
-	/* On-disk flags are just 16 bits */
-	ce->ce_flags = ntohs(ondisk->flags);
+	ce->ce_flags = flags;
 
 	hashcpy(ce->sha1, ondisk->sha1);
 
-	len = ce->ce_flags & CE_NAMEMASK;
-
-	if (ce->ce_flags & CE_EXTENDED) {
-		struct ondisk_cache_entry_extended *ondisk2;
-		int extended_flags;
-		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		extended_flags = ntohs(ondisk2->flags2) << 16;
-		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
-		if (extended_flags & ~CE_EXTENDED_FLAGS)
-			die("Unknown index entry format %08x", extended_flags);
-		ce->ce_flags |= extended_flags;
-		name = ondisk2->name;
-	}
-	else
-		name = ondisk->name;
-
-	if (len == CE_NAMEMASK)
-		len = strlen(name);
 	/*
 	 * NEEDSWORK: If the original index is crafted, this copy could
 	 * go unchecked.
 	 */
 	memcpy(ce->name, name, len + 1);
-}
-
-static inline size_t estimate_cache_size(size_t ondisk_size, unsigned int entries)
-{
-	long per_entry;
-
-	per_entry = sizeof(struct cache_entry) - sizeof(struct ondisk_cache_entry);
-
-	/*
-	 * Alignment can cause differences. This should be "alignof", but
-	 * since that's a gcc'ism, just use the size of a pointer.
-	 */
-	per_entry += sizeof(void *);
-	return ondisk_size + entries*per_entry;
+	return ce;
 }
 
 /* remember to discard_cache() before reading a different cache! */
@@ -1266,7 +1259,7 @@ int read_index_from(struct index_state *istate, const char *path)
 {
 	int fd, i;
 	struct stat st;
-	unsigned long src_offset, dst_offset;
+	unsigned long src_offset;
 	struct cache_header *hdr;
 	void *mmap;
 	size_t mmap_size;
@@ -1305,29 +1298,18 @@ int read_index_from(struct index_state *istate, const char *path)
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(struct cache_entry *));
-
-	/*
-	 * The disk format is actually larger than the in-memory format,
-	 * due to space for nsec etc, so even though the in-memory one
-	 * has room for a few  more flags, we can allocate using the same
-	 * index size
-	 */
-	istate->alloc = xmalloc(estimate_cache_size(mmap_size, istate->cache_nr));
 	istate->initialized = 1;
 
 	src_offset = sizeof(*hdr);
-	dst_offset = 0;
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct ondisk_cache_entry *disk_ce;
 		struct cache_entry *ce;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = (struct cache_entry *)((char *)istate->alloc + dst_offset);
-		convert_from_disk(disk_ce, ce);
+		ce = create_from_disk(disk_ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += ondisk_ce_size(ce);
-		dst_offset += ce_size(ce);
 	}
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
@@ -1361,11 +1343,15 @@ unmap:
 
 int is_index_unborn(struct index_state *istate)
 {
-	return (!istate->cache_nr && !istate->alloc && !istate->timestamp.sec);
+	return (!istate->cache_nr && !istate->timestamp.sec);
 }
 
 int discard_index(struct index_state *istate)
 {
+	int i;
+
+	for (i = 0; i < istate->cache_nr; i++)
+		free(istate->cache[i]);
 	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
@@ -1374,8 +1360,6 @@ int discard_index(struct index_state *istate)
 	istate->name_hash_initialized = 0;
 	free_hash(&istate->name_hash);
 	cache_tree_free(&(istate->cache_tree));
-	free(istate->alloc);
-	istate->alloc = NULL;
 	istate->initialized = 0;
 
 	/* no need to throw away allocated active_cache */
-- 
1.7.7
