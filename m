From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] packed_object_info: make type lookup optional
Date: Fri, 12 Jul 2013 02:32:25 -0400
Message-ID: <20130712063225.GE15572@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:32:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWu7-0000A4-Dz
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab3GLGc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:32:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:36587 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994Ab3GLGc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:32:27 -0400
Received: (qmail 17135 invoked by uid 102); 12 Jul 2013 06:33:45 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:33:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:32:25 -0400
Content-Disposition: inline
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230177>

Currently, packed_object_info can save some work by not
calculating the size or disk_size of the object if the
caller is not interested. However, it always calculates the
true object type, whether the caller cares or not, and only
optionally returns the easy-to-get "representation type".

Let's swap these types. The function will now return the
representation type (or OBJ_BAD on failure), and will only
optionally fill in the true type.

There should be no behavior change yet, as the only caller,
sha1_object_info_extended, will always feed it a type
pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6f4aff3..2a1e230 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1783,7 +1783,7 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 }
 
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      unsigned long *sizep, int *rtype,
+			      enum object_type *typep, unsigned long *sizep,
 			      unsigned long *disk_sizep)
 {
 	struct pack_window *w_curs = NULL;
@@ -1791,11 +1791,12 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 	off_t curpos = obj_offset;
 	enum object_type type;
 
+	/*
+	 * We always get the representation type, but only convert it to
+	 * a "real" type later if the caller is interested.
+	 */
 	type = unpack_object_header(p, &w_curs, &curpos, &size);
 
-	if (rtype)
-		*rtype = type; /* representation type */
-
 	if (sizep) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			off_t tmp_pos = curpos;
@@ -1820,7 +1821,13 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 		*disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	type = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
+	if (typep) {
+		*typep = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
+		if (*typep < 0) {
+			type = OBJ_BAD;
+			goto out;
+		}
+	}
 
 out:
 	unuse_pack(&w_curs);
@@ -2471,11 +2478,11 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 			return -1;
 	}
 
-	type = packed_object_info(e.p, e.offset, oi->sizep, &rtype,
-				  oi->disk_sizep);
-	if (type < 0) {
+	rtype = packed_object_info(e.p, e.offset, &type, oi->sizep,
+				   oi->disk_sizep);
+	if (rtype < 0) {
 		mark_bad_packed_object(e.p, sha1);
-		type = sha1_object_info_extended(sha1, oi);
+		return sha1_object_info_extended(sha1, oi);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
 	} else {
-- 
1.8.3.rc3.24.gec82cb9
