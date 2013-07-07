From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] teach sha1_object_info_extended a "disk_size" query
Date: Sun, 7 Jul 2013 06:04:00 -0400
Message-ID: <20130707100400.GB19143@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 12:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvlpF-0003j6-Jb
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 12:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab3GGKEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 06:04:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:46788 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab3GGKEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 06:04:08 -0400
Received: (qmail 12691 invoked by uid 102); 7 Jul 2013 10:05:22 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Jul 2013 05:05:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jul 2013 06:04:00 -0400
Content-Disposition: inline
In-Reply-To: <20130707100133.GA18717@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229764>

Using sha1_object_info_extended, a caller can find out the
type of an object, its size, and information about where it
is stored. In addition to the object's "true" size, it can
also be useful to know the size that the object takes on
disk (e.g., to generate statistics about which refs consume
space).

This patch adds a "disk_sizep" field to "struct object_info",
and fills it in during sha1_object_info_extended if it is
non-NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  1 +
 sha1_file.c | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index dd0fb33..2d06169 100644
--- a/cache.h
+++ b/cache.h
@@ -1130,6 +1130,7 @@ struct object_info {
 struct object_info {
 	/* Request */
 	unsigned long *sizep;
+	unsigned long *disk_sizep;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index de06a97..4c2365f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1697,7 +1697,8 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 #define POI_STACK_PREALLOC 64
 
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      unsigned long *sizep, int *rtype)
+			      unsigned long *sizep, int *rtype,
+			      unsigned long *disk_sizep)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
@@ -1731,6 +1732,11 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 		}
 	}
 
+	if (disk_sizep) {
+		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
+		*disk_sizep = revidx[1].offset - obj_offset;
+	}
+
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
 		/* Push the object we're going to leave behind */
@@ -2357,7 +2363,8 @@ struct packed_git *find_sha1_pack(const unsigned char *sha1,
 
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *sizep)
+static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *sizep,
+				  unsigned long *disk_sizep)
 {
 	int status;
 	unsigned long mapsize, size;
@@ -2368,6 +2375,8 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return -1;
+	if (disk_sizep)
+		*disk_sizep = mapsize;
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
@@ -2391,13 +2400,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	if (co) {
 		if (oi->sizep)
 			*(oi->sizep) = co->size;
+		if (oi->disk_sizep)
+			*(oi->disk_sizep) = 0;
 		oi->whence = OI_CACHED;
 		return co->type;
 	}
 
 	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
-		status = sha1_loose_object_info(sha1, oi->sizep);
+		status = sha1_loose_object_info(sha1, oi->sizep, oi->disk_sizep);
 		if (status >= 0) {
 			oi->whence = OI_LOOSE;
 			return status;
@@ -2409,7 +2420,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 			return status;
 	}
 
-	status = packed_object_info(e.p, e.offset, oi->sizep, &rtype);
+	status = packed_object_info(e.p, e.offset, oi->sizep, &rtype,
+				    oi->disk_sizep);
 	if (status < 0) {
 		mark_bad_packed_object(e.p, sha1);
 		status = sha1_object_info_extended(sha1, oi);
-- 
1.8.3.rc3.24.gec82cb9
