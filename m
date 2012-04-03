From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/9] read-cache.c: allow unaligned mapping of the index file
Date: Tue,  3 Apr 2012 15:53:10 -0700
Message-ID: <1333493596-14202-4-git-send-email-gitster@pobox.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 00:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFCbU-0006o1-Mb
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 00:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab2DCWx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 18:53:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab2DCWxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 18:53:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E14E07F6B
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hPLA
	D5vEgccYacJ4I3QMjIjAlRk=; b=plkCUtLDvzFuMOeMcvE+gu2fJlvP68IQ9bVn
	YaZwjj5YXRON9nipYpyC+GiteWFXcLfzilAWnGTL9b3x4wlNEeQGDlRPkrr364bb
	QfpFGWfQPNvnB4T/iuN8G04dyCTEtAP6uMkl7Jy94VQhmGt1EN0aqxq57ws71jrR
	vVM+LCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hCpfhM
	dFJ73f7yRJLY7+ewoJDJe/F80L8j8ki41fDs7s2GhIMdGG1gRkD+Ymm8m81YHzz/
	1kDy08cQREtkfXMbEDXulWPRNd5v0HHWdfvsdIn0VBW5XAaOergn2tLJbezJ3Ml8
	sBY9rTruclYUhIUR0X9GWwBk+wpp/CNjvLwtA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7EF37F6A
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DF967F69 for
 <git@vger.kernel.org>; Tue,  3 Apr 2012 18:53:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc4.54.g1d5dd3
In-Reply-To: <1333493596-14202-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D0D5169E-7DDF-11E1-BE9E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194662>

Both the on-disk format v2 and v3 pads the "name" field to the multiple of
eight to make sure that various quantities in network long/short type can
be accessed with ntohl/ntohs without having to worry about alignment, but
this forces us to waste disk I/O bandwidth.

Introduce ntoh_s()/ntoh_l() macros that the callers can use as if they were
the regular ntohs()/ntohl() on a field that may not be aligned correctly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |   44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index fa8aa73..d8865f5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1285,6 +1285,26 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file());
 }
 
+#ifndef NEEDS_ALIGNED_ACCESS
+#define ntoh_s(var) ntohs(var)
+#define ntoh_l(var) ntohl(var)
+#else
+static inline uint16_t ntoh_s_force_align(void *p)
+{
+	uint16_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohs(x);
+}
+static inline uint32_t ntoh_l_force_align(void *p)
+{
+	uint32_t x;
+	memcpy(&x, p, sizeof(x));
+	return ntohl(x);
+}
+#define ntoh_s(var) ntoh_s_force_align(&(var))
+#define ntoh_l(var) ntoh_l_force_align(&(var))
+#endif
+
 static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk)
 {
 	struct cache_entry *ce;
@@ -1293,14 +1313,14 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk)
 	unsigned int flags;
 
 	/* On-disk flags are just 16 bits */
-	flags = ntohs(ondisk->flags);
+	flags = ntoh_s(ondisk->flags);
 	len = flags & CE_NAMEMASK;
 
 	if (flags & CE_EXTENDED) {
 		struct ondisk_cache_entry_extended *ondisk2;
 		int extended_flags;
 		ondisk2 = (struct ondisk_cache_entry_extended *)ondisk;
-		extended_flags = ntohs(ondisk2->flags2) << 16;
+		extended_flags = ntoh_s(ondisk2->flags2) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
 			die("Unknown index entry format %08x", extended_flags);
@@ -1315,16 +1335,16 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk)
 
 	ce = xmalloc(cache_entry_size(len));
 
-	ce->ce_ctime.sec = ntohl(ondisk->ctime.sec);
-	ce->ce_mtime.sec = ntohl(ondisk->mtime.sec);
-	ce->ce_ctime.nsec = ntohl(ondisk->ctime.nsec);
-	ce->ce_mtime.nsec = ntohl(ondisk->mtime.nsec);
-	ce->ce_dev   = ntohl(ondisk->dev);
-	ce->ce_ino   = ntohl(ondisk->ino);
-	ce->ce_mode  = ntohl(ondisk->mode);
-	ce->ce_uid   = ntohl(ondisk->uid);
-	ce->ce_gid   = ntohl(ondisk->gid);
-	ce->ce_size  = ntohl(ondisk->size);
+	ce->ce_ctime.sec = ntoh_l(ondisk->ctime.sec);
+	ce->ce_mtime.sec = ntoh_l(ondisk->mtime.sec);
+	ce->ce_ctime.nsec = ntoh_l(ondisk->ctime.nsec);
+	ce->ce_mtime.nsec = ntoh_l(ondisk->mtime.nsec);
+	ce->ce_dev   = ntoh_l(ondisk->dev);
+	ce->ce_ino   = ntoh_l(ondisk->ino);
+	ce->ce_mode  = ntoh_l(ondisk->mode);
+	ce->ce_uid   = ntoh_l(ondisk->uid);
+	ce->ce_gid   = ntoh_l(ondisk->gid);
+	ce->ce_size  = ntoh_l(ondisk->size);
 	ce->ce_flags = flags;
 
 	hashcpy(ce->sha1, ondisk->sha1);
-- 
1.7.10.rc4.54.g1d5dd3
