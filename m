From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] read-cache: use get_be32 instead of hand-rolled ntoh_l
Date: Thu, 23 Jan 2014 16:26:42 -0500
Message-ID: <20140123212642.GB21705@sigill.intra.peff.net>
References: <20140123212036.GA21299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 22:26:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6RnT-0003kt-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 22:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbaAWV0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 16:26:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:37796 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753172AbaAWV0n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 16:26:43 -0500
Received: (qmail 1328 invoked by uid 102); 23 Jan 2014 21:26:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 15:26:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 16:26:42 -0500
Content-Disposition: inline
In-Reply-To: <20140123212036.GA21299@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240960>

Commit d60c49c (read-cache.c: allow unaligned mapping of the
index file, 2012-04-03) introduced helpers to access
unaligned data. However, we already have get_be32, which has
a few advantages:

  1. It's already written, so we avoid duplication.

  2. It's probably faster, since it does the endian
     conversion and the alignment fix at the same time.

  3. The get_be32 code is well-tested, having been in
     block-sha1 for a long time. By contrast, our custom
     helpers were probably almost never used, since the user
     needed to manually define a macro to enable them.

We have to add a get_be16 implementation to the existing
get_be32, but that is very simple to do.

Signed-off-by: Jeff King <peff@peff.net>
---
This _might_ still suffer from the issue fixed in 5f6a112 (block-sha1:
avoid pointer conversion that violates alignment constraints,
2012-07-22), as we are taking the pointer of a uint32 in a struct. But
if that is the case, then the original did, as well. It's not clear to
me if the casting get_be32 does is sufficient, or if a sufficiently
clever compiler might make assumptions based on the original pointer
type.

I'm inclined to leave it for now, as we haven't made anything worse, and
nobody has reported a problem.

 compat/bswap.h |  4 ++++
 read-cache.c   | 44 ++++++++++++--------------------------------
 2 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 7d17953..120c6c1 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -136,11 +136,15 @@ static inline uint64_t git_bswap64(uint64_t x)
     defined(__powerpc__) || defined(__powerpc64__) || \
     defined(__s390__) || defined(__s390x__)
 
+#define get_be16(p)	ntohs(*(unsigned short *)(p))
 #define get_be32(p)	ntohl(*(unsigned int *)(p))
 #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
 
 #else
 
+#define get_be16(p)	( \
+	(*((unsigned char *)(p) + 0) << 8) | \
+	(*((unsigned char *)(p) + 1) << 0) )
 #define get_be32(p)	( \
 	(*((unsigned char *)(p) + 0) << 24) | \
 	(*((unsigned char *)(p) + 1) << 16) | \
diff --git a/read-cache.c b/read-cache.c
index 33dd676..4221872 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1313,26 +1313,6 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
-#ifndef NEEDS_ALIGNED_ACCESS
-#define ntoh_s(var) ntohs(var)
-#define ntoh_l(var) ntohl(var)
-#else
-static inline uint16_t ntoh_s_force_align(void *p)
-{
-	uint16_t x;
-	memcpy(&x, p, sizeof(x));
-	return ntohs(x);
-}
-static inline uint32_t ntoh_l_force_align(void *p)
-{
-	uint32_t x;
-	memcpy(&x, p, sizeof(x));
-	return ntohl(x);
-}
-#define ntoh_s(var) ntoh_s_force_align(&(var))
-#define ntoh_l(var) ntoh_l_force_align(&(var))
-#endif
-
 static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
 						   unsigned int flags,
 						   const char *name,
@@ -1340,16 +1320,16 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
 {
 	struct cache_entry *ce = xmalloc(cache_entry_size(len));
 
-	ce->ce_stat_data.sd_ctime.sec = ntoh_l(ondisk->ctime.sec);
-	ce->ce_stat_data.sd_mtime.sec = ntoh_l(ondisk->mtime.sec);
-	ce->ce_stat_data.sd_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
-	ce->ce_stat_data.sd_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
-	ce->ce_stat_data.sd_dev   = ntoh_l(ondisk->dev);
-	ce->ce_stat_data.sd_ino   = ntoh_l(ondisk->ino);
-	ce->ce_mode  = ntoh_l(ondisk->mode);
-	ce->ce_stat_data.sd_uid   = ntoh_l(ondisk->uid);
-	ce->ce_stat_data.sd_gid   = ntoh_l(ondisk->gid);
-	ce->ce_stat_data.sd_size  = ntoh_l(ondisk->size);
+	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
+	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
+	ce->ce_stat_data.sd_ctime.nsec = get_be32(&ondisk->ctime.nsec);
+	ce->ce_stat_data.sd_mtime.nsec = get_be32(&ondisk->mtime.nsec);
+	ce->ce_stat_data.sd_dev   = get_be32(&ondisk->dev);
+	ce->ce_stat_data.sd_ino   = get_be32(&ondisk->ino);
+	ce->ce_mode  = get_be32(&ondisk->mode);
+	ce->ce_stat_data.sd_uid   = get_be32(&ondisk->uid);
+	ce->ce_stat_data.sd_gid   = get_be32(&ondisk->gid);
+	ce->ce_stat_data.sd_size  = get_be32(&ondisk->size);
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	hashcpy(ce->sha1, ondisk->sha1);
@@ -1389,14 +1369,14 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	unsigned int flags;
 
 	/* On-disk flags are just 16 bits */
-	flags = ntoh_s(ondisk->flags);
+	flags = get_be16(&ondisk->flags);
 	len = flags & CE_NAMEMASK;
 
 	if (flags & CE_EXTENDED) {
 		struct ondisk_cache_entry_extended *ondisk2;
 		int extended_flags;
 		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		extended_flags = ntoh_s(ondisk2->flags2) << 16;
+		extended_flags = get_be16(&ondisk2->flags2) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
 			die("Unknown index entry format %08x", extended_flags);
-- 
1.8.5.2.500.g8060133
