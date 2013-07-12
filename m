From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] packed_object_info: hoist delta type resolution to helper
Date: Fri, 12 Jul 2013 02:31:57 -0400
Message-ID: <20130712063157.GD15572@sigill.intra.peff.net>
References: <20130712061533.GA11297@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWth-0008IU-5H
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab3GLGcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:32:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:36583 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554Ab3GLGb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:31:59 -0400
Received: (qmail 17072 invoked by uid 102); 12 Jul 2013 06:33:17 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 12 Jul 2013 01:33:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jul 2013 02:31:57 -0400
Content-Disposition: inline
In-Reply-To: <20130712061533.GA11297@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230176>

To calculate the type of a packed object, we must walk down
its delta chain until we hit a true base object with a real
type. Most of the code in packed_object_info is for handling
this case.

Let's hoist it out into a separate helper function, which
will make it easier to make the type-lookup optional in the
future (and keep our indentation level sane).

Signed-off-by: Jeff King <peff@peff.net>
---
Annoyingly, since the part we are moving comprises the bulk
of the function, the diff tends to show the opposite of what
actually happened: it looks like we renamed the function to its helper
name, and moved the other parts to a new function, which happens to have
the same name as the old one. So read the diff with care. :)

 sha1_file.c | 93 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 39e7313..6f4aff3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1713,52 +1713,21 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 	return type;
 }
 
-
 #define POI_STACK_PREALLOC 64
 
-static int packed_object_info(struct packed_git *p, off_t obj_offset,
-			      unsigned long *sizep, int *rtype,
-			      unsigned long *disk_sizep)
+static enum object_type packed_to_object_type(struct packed_git *p,
+					      off_t obj_offset,
+					      enum object_type type,
+					      struct pack_window **w_curs,
+					      off_t curpos)
 {
-	struct pack_window *w_curs = NULL;
-	unsigned long size;
-	off_t curpos = obj_offset;
-	enum object_type type;
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
 	int poi_stack_nr = 0, poi_stack_alloc = POI_STACK_PREALLOC;
 
-	type = unpack_object_header(p, &w_curs, &curpos, &size);
-
-	if (rtype)
-		*rtype = type; /* representation type */
-
-	if (sizep) {
-		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
-			off_t tmp_pos = curpos;
-			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
-							   type, obj_offset);
-			if (!base_offset) {
-				type = OBJ_BAD;
-				goto out;
-			}
-			*sizep = get_size_from_delta(p, &w_curs, tmp_pos);
-			if (*sizep == 0) {
-				type = OBJ_BAD;
-				goto out;
-			}
-		} else {
-			*sizep = size;
-		}
-	}
-
-	if (disk_sizep) {
-		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
-		*disk_sizep = revidx[1].offset - obj_offset;
-	}
-
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
+		unsigned long size;
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
@@ -1769,11 +1738,11 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 		}
 		poi_stack[poi_stack_nr++] = obj_offset;
 		/* If parsing the base offset fails, just unwind */
-		base_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
+		base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
 		if (!base_offset)
 			goto unwind;
 		curpos = obj_offset = base_offset;
-		type = unpack_object_header(p, &w_curs, &curpos, &size);
+		type = unpack_object_header(p, w_curs, &curpos, &size);
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
@@ -1800,7 +1769,6 @@ out:
 out:
 	if (poi_stack != small_poi_stack)
 		free(poi_stack);
-	unuse_pack(&w_curs);
 	return type;
 
 unwind:
@@ -1814,6 +1782,51 @@ unwind:
 	goto out;
 }
 
+static int packed_object_info(struct packed_git *p, off_t obj_offset,
+			      unsigned long *sizep, int *rtype,
+			      unsigned long *disk_sizep)
+{
+	struct pack_window *w_curs = NULL;
+	unsigned long size;
+	off_t curpos = obj_offset;
+	enum object_type type;
+
+	type = unpack_object_header(p, &w_curs, &curpos, &size);
+
+	if (rtype)
+		*rtype = type; /* representation type */
+
+	if (sizep) {
+		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+			off_t tmp_pos = curpos;
+			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
+							   type, obj_offset);
+			if (!base_offset) {
+				type = OBJ_BAD;
+				goto out;
+			}
+			*sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+			if (*sizep == 0) {
+				type = OBJ_BAD;
+				goto out;
+			}
+		} else {
+			*sizep = size;
+		}
+	}
+
+	if (disk_sizep) {
+		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
+		*disk_sizep = revidx[1].offset - obj_offset;
+	}
+
+	type = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
+
+out:
+	unuse_pack(&w_curs);
+	return type;
+}
+
 static void *unpack_compressed_entry(struct packed_git *p,
 				    struct pack_window **w_curs,
 				    off_t curpos,
-- 
1.8.3.rc3.24.gec82cb9
