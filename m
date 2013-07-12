From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] sha1_object_info_extended: pass object_info to helpers
Date: Fri, 12 Jul 2013 02:37:53 -0400
Message-ID: <20130712063752.GG15572@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWzP-0004OK-L6
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab3GLGhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:37:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:36627 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab3GLGhz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:37:55 -0400
Received: (qmail 17523 invoked by uid 102); 12 Jul 2013 06:39:13 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:39:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:37:53 -0400
Content-Disposition: inline
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230180>

We take in a "struct object_info" which contains pointers to
storage for items the caller cares about. But then rather
than pass the whole object to the low-level loose/packed
helper functions, we pass the individual pointers.

Let's pass the whole struct instead, which will make adding
more items later easier.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is an optional cleanup. The diff is quite noisy due to all of
the s/foo/oi->foo/, so it is arguable whether the result is nicer or
not. It would make later additions to object_info nicer, but I do not
plan to add any more.

It _would_ have been a nice cleanup to do at the beginning of the series
(and further diffs would not have to add extra parameters to the
function calls), but that would make the incremental "learn to do type
optionally" patches quite awkward.

So I am on the fence over this one, and do not mind too much if it gets
dropped.

 sha1_file.c | 49 ++++++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 52f7a1e..563f521 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1783,8 +1783,7 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 }
 
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      enum object_type *typep, unsigned long *sizep,
-			      unsigned long *disk_sizep)
+			      struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
@@ -1797,7 +1796,7 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 	 */
 	type = unpack_object_header(p, &w_curs, &curpos, &size);
 
-	if (sizep) {
+	if (oi->sizep) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			off_t tmp_pos = curpos;
 			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
@@ -1806,24 +1805,24 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 				type = OBJ_BAD;
 				goto out;
 			}
-			*sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*sizep == 0) {
+			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+			if (*oi->sizep == 0) {
 				type = OBJ_BAD;
 				goto out;
 			}
 		} else {
-			*sizep = size;
+			*oi->sizep = size;
 		}
 	}
 
-	if (disk_sizep) {
+	if (oi->disk_sizep) {
 		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-		*disk_sizep = revidx[1].offset - obj_offset;
+		*oi->disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	if (typep) {
-		*typep = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
-		if (*typep < 0) {
+	if (oi->typep) {
+		*oi->typep = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
+		if (*oi->typep < 0) {
 			type = OBJ_BAD;
 			goto out;
 		}
@@ -2404,9 +2403,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 }
 
 static int sha1_loose_object_info(const unsigned char *sha1,
-				  enum object_type *typep,
-				  unsigned long *sizep,
-				  unsigned long *disk_sizep)
+				  struct object_info *oi)
 {
 	int status;
 	unsigned long mapsize, size;
@@ -2418,12 +2415,12 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * If we don't care about type or size, then we don't
 	 * need to look inside the object at all.
 	 */
-	if (!typep && !sizep) {
-		if (disk_sizep) {
+	if (!oi->typep && !oi->sizep) {
+		if (oi->disk_sizep) {
 			struct stat st;
 			if (stat_sha1_file(sha1, &st) < 0)
 				return -1;
-			*disk_sizep = st.st_size;
+			*oi->disk_sizep = st.st_size;
 		}
 		return 0;
 	}
@@ -2431,19 +2428,19 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return -1;
-	if (disk_sizep)
-		*disk_sizep = mapsize;
+	if (oi->disk_sizep)
+		*oi->disk_sizep = mapsize;
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
 	else if ((status = parse_sha1_header(hdr, &size)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
-	else if (sizep)
-		*sizep = size;
+	else if (oi->sizep)
+		*oi->sizep = size;
 	git_inflate_end(&stream);
 	munmap(map, mapsize);
-	if (typep)
-		*typep = status;
+	if (oi->typep)
+		*oi->typep = status;
 	return 0;
 }
 
@@ -2468,8 +2465,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 
 	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(sha1, oi->typep,
-					    oi->sizep, oi->disk_sizep)) {
+		if (!sha1_loose_object_info(sha1, oi)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
@@ -2480,8 +2476,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 			return -1;
 	}
 
-	rtype = packed_object_info(e.p, e.offset, oi->typep, oi->sizep,
-				   oi->disk_sizep);
+	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, sha1);
 		return sha1_object_info_extended(sha1, oi);
-- 
1.8.3.rc3.24.gec82cb9
