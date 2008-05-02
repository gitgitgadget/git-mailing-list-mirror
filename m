From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 4/7] pack-objects: clean up write_object() a bit
Date: Fri, 02 May 2008 15:11:48 -0400
Message-ID: <1209755511-7840-5-git-send-email-nico@cam.org>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
 <1209755511-7840-2-git-send-email-nico@cam.org>
 <1209755511-7840-3-git-send-email-nico@cam.org>
 <1209755511-7840-4-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0hY-00058j-NQ
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936502AbYEBTMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936449AbYEBTMH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:12:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936125AbYEBTMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:12:01 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:54 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
In-reply-to: <1209755511-7840-4-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81028>

... for improved readability.  No functional changes.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   64 ++++++++++++++++++++++++-----------------------
 1 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b4a63d2..257002a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -226,41 +226,43 @@ static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry,
 				  off_t write_offset)
 {
-	unsigned long size;
+	unsigned long size, limit;
 	void *buf;
-	unsigned char header[10];
-	unsigned char dheader[10];
+	unsigned char header[10], dheader[10];
 	unsigned hdrlen;
 	off_t datalen;
-	enum object_type obj_type;
-	int to_reuse = 0;
-	/* write limit if limited packsize and not first object */
-	unsigned long limit = pack_size_limit && nr_written ?
-				pack_size_limit - write_offset : 0;
-				/* no if no delta */
-	int usable_delta =	!entry->delta ? 0 :
-				/* yes if unlimited packfile */
-				!pack_size_limit ? 1 :
-				/* no if base written to previous pack */
-				entry->delta->idx.offset == (off_t)-1 ? 0 :
-				/* otherwise double-check written to this
-				 * pack,  like we do below
-				 */
-				entry->delta->idx.offset ? 1 : 0;
+	enum object_type type;
+	int usable_delta, to_reuse;
 
 	if (!pack_to_stdout)
 		crc32_begin(f);
 
-	obj_type = entry->type;
+	type = entry->type;
+
+	/* write limit if limited packsize and not first object */
+	limit = pack_size_limit && nr_written ?
+			pack_size_limit - write_offset : 0;
+
+	if (!entry->delta) 
+		usable_delta = 0;	/* no delta */
+	else if (!pack_size_limit)
+	       usable_delta = 1;	/* unlimited packfile */
+	else if (entry->delta->idx.offset == (off_t)-1)
+		usable_delta = 0;	/* base was written to another pack */
+	else if(entry->delta->idx.offset)
+		usable_delta = 1;	/* base already exists in this pack */
+	else
+		usable_delta = 0;	/* base could end up in another pack */
+
 	if (!reuse_object)
 		to_reuse = 0;	/* explicit */
 	else if (!entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
-	else if (obj_type == OBJ_REF_DELTA || obj_type == OBJ_OFS_DELTA)
+	else if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA)
 				/* check_object() decided it for us ... */
 		to_reuse = usable_delta;
 				/* ... but pack split may override that */
-	else if (obj_type != entry->in_pack_type)
+	else if (type != entry->in_pack_type)
 		to_reuse = 0;	/* pack has delta which is unusable */
 	else if (entry->delta)
 		to_reuse = 0;	/* we want to pack afresh */
@@ -274,19 +276,19 @@ static unsigned long write_object(struct sha1file *f,
 		unsigned long maxsize;
 		void *out;
 		if (!usable_delta) {
-			buf = read_sha1_file(entry->idx.sha1, &obj_type, &size);
+			buf = read_sha1_file(entry->idx.sha1, &type, &size);
 			if (!buf)
 				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
 		} else if (entry->delta_data) {
 			size = entry->delta_size;
 			buf = entry->delta_data;
 			entry->delta_data = NULL;
-			obj_type = (allow_ofs_delta && entry->delta->idx.offset) ?
+			type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		} else {
 			buf = get_delta(entry);
 			size = entry->delta_size;
-			obj_type = (allow_ofs_delta && entry->delta->idx.offset) ?
+			type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 		}
 		/* compress the data to store and put compressed length in datalen */
@@ -308,9 +310,9 @@ static unsigned long write_object(struct sha1file *f,
 		 * The object header is a byte of 'type' followed by zero or
 		 * more bytes of length.
 		 */
-		hdrlen = encode_header(obj_type, size, header);
+		hdrlen = encode_header(type, size, header);
 
-		if (obj_type == OBJ_OFS_DELTA) {
+		if (type == OBJ_OFS_DELTA) {
 			/*
 			 * Deltas with relative base contain an additional
 			 * encoding of the relative offset for the delta
@@ -329,7 +331,7 @@ static unsigned long write_object(struct sha1file *f,
 			sha1write(f, header, hdrlen);
 			sha1write(f, dheader + pos, sizeof(dheader) - pos);
 			hdrlen += sizeof(dheader) - pos;
-		} else if (obj_type == OBJ_REF_DELTA) {
+		} else if (type == OBJ_REF_DELTA) {
 			/*
 			 * Deltas with a base reference contain
 			 * an additional 20 bytes for the base sha1.
@@ -361,11 +363,11 @@ static unsigned long write_object(struct sha1file *f,
 		off_t offset;
 
 		if (entry->delta) {
-			obj_type = (allow_ofs_delta && entry->delta->idx.offset) ?
+			type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
 			reused_delta++;
 		}
-		hdrlen = encode_header(obj_type, entry->size, header);
+		hdrlen = encode_header(type, entry->size, header);
 		offset = entry->in_pack_offset;
 		revidx = find_pack_revindex(p, offset);
 		datalen = revidx[1].offset - offset;
@@ -374,7 +376,7 @@ static unsigned long write_object(struct sha1file *f,
 			die("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
 		offset += entry->in_pack_header_size;
 		datalen -= entry->in_pack_header_size;
-		if (obj_type == OBJ_OFS_DELTA) {
+		if (type == OBJ_OFS_DELTA) {
 			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
 			unsigned pos = sizeof(dheader) - 1;
 			dheader[pos] = ofs & 127;
@@ -385,7 +387,7 @@ static unsigned long write_object(struct sha1file *f,
 			sha1write(f, header, hdrlen);
 			sha1write(f, dheader + pos, sizeof(dheader) - pos);
 			hdrlen += sizeof(dheader) - pos;
-		} else if (obj_type == OBJ_REF_DELTA) {
+		} else if (type == OBJ_REF_DELTA) {
 			if (limit && hdrlen + 20 + datalen + 20 >= limit)
 				return 0;
 			sha1write(f, header, hdrlen);
-- 
1.5.5.1.226.g6f6e8
