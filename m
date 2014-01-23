From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] compat: move unaligned helpers to bswap.h
Date: Thu, 23 Jan 2014 13:35:23 -0500
Message-ID: <20140123183522.GA26447@sigill.intra.peff.net>
References: <20140123183320.GA22995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 19:35:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6P7h-0003zk-Ej
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 19:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbaAWSfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 13:35:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:37649 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751184AbaAWSfY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 13:35:24 -0500
Received: (qmail 22710 invoked by uid 102); 23 Jan 2014 18:35:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 12:35:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 13:35:23 -0500
Content-Disposition: inline
In-Reply-To: <20140123183320.GA22995@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240925>

From: Vicent Marti <tanoku@gmail.com>

Commit d60c49c (read-cache.c: allow unaligned mapping of the
index file, 2012-04-03) introduced helpers to access
unaligned data. Let's factor them out to make them more
widely available.

While we're at it, we'll give the helpers more readable
names, add a helper for the "ntohll" form, and add the
appropriate Makefile knob.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile       |  7 +++++++
 compat/bswap.h | 28 ++++++++++++++++++++++++++++
 read-cache.c   | 44 ++++++++++++--------------------------------
 3 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/Makefile b/Makefile
index 4136c4f..5711c0e 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,9 @@ all::
 # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
 # (defaults to "man") if you want to have a different default when
 # "git help" is called without a parameter specifying the format.
+#
+# Define NEEDS_ALIGNED_ACCESS if your platform cannot handle unaligned
+# access to integers in mmap'd files.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1505,6 +1508,10 @@ ifneq (,$(XDL_FAST_HASH))
 	BASIC_CFLAGS += -DXDL_FAST_HASH
 endif
 
+ifdef NEEDS_ALIGNED_ACCESS
+	BASIC_CFLAGS += -DNEEDS_ALIGNED_ACCESS
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/compat/bswap.h b/compat/bswap.h
index c18a78e..80abc54 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -122,3 +122,31 @@ static inline uint64_t git_bswap64(uint64_t x)
 #endif
 
 #endif
+
+#ifndef NEEDS_ALIGNED_ACCESS
+#define align_ntohs(var) ntohs(var)
+#define align_ntohl(var) ntohl(var)
+#define align_ntohll(var) ntohll(var)
+#else
+static inline uint16_t ntohs_force_align(void *p)
+{
+	uint16_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohs(x);
+}
+static inline uint32_t ntohl_force_align(void *p)
+{
+	uint32_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohl(x);
+}
+static inline uint64_t ntohll_force_align(void *p)
+{
+	uint64_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohll(x);
+}
+#define align_ntohs(var) ntohs_force_align(&(var))
+#define align_ntohl(var) ntohl_force_align(&(var))
+#define align_ntohll(var) ntohll_force_align(&(var))
+#endif
diff --git a/read-cache.c b/read-cache.c
index 33dd676..fa53504 100644
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
+	ce->ce_stat_data.sd_ctime.sec = align_ntohl(ondisk->ctime.sec);
+	ce->ce_stat_data.sd_mtime.sec = align_ntohl(ondisk->mtime.sec);
+	ce->ce_stat_data.sd_ctime.nsec = align_ntohl(ondisk->ctime.nsec);
+	ce->ce_stat_data.sd_mtime.nsec = align_ntohl(ondisk->mtime.nsec);
+	ce->ce_stat_data.sd_dev   = align_ntohl(ondisk->dev);
+	ce->ce_stat_data.sd_ino   = align_ntohl(ondisk->ino);
+	ce->ce_mode  = align_ntohl(ondisk->mode);
+	ce->ce_stat_data.sd_uid   = align_ntohl(ondisk->uid);
+	ce->ce_stat_data.sd_gid   = align_ntohl(ondisk->gid);
+	ce->ce_stat_data.sd_size  = align_ntohl(ondisk->size);
 	ce->ce_flags = flags & ~CE_NAMEMASK;
 	ce->ce_namelen = len;
 	hashcpy(ce->sha1, ondisk->sha1);
@@ -1389,14 +1369,14 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	unsigned int flags;
 
 	/* On-disk flags are just 16 bits */
-	flags = ntoh_s(ondisk->flags);
+	flags = align_ntohs(ondisk->flags);
 	len = flags & CE_NAMEMASK;
 
 	if (flags & CE_EXTENDED) {
 		struct ondisk_cache_entry_extended *ondisk2;
 		int extended_flags;
 		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		extended_flags = ntoh_s(ondisk2->flags2) << 16;
+		extended_flags = align_ntohs(ondisk2->flags2) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
 			die("Unknown index entry format %08x", extended_flags);
-- 
1.8.5.2.500.g8060133
