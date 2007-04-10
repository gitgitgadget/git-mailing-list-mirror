From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 12/10] validate reused pack data with CRC when possible
Date: Tue, 10 Apr 2007 00:15:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704100004200.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 09:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb7lk-0006pg-MO
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 06:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbXDJEPp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 00:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbXDJEPp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 00:15:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17208 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965044AbXDJEPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 00:15:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG900JXAL6541Q0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Apr 2007 00:15:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44109>

This replaces the inflate validation with a CRC validation when reusing
data from a pack which uses index version 2.  That makes repacking much 
safer against corruptions, and it should be a bit faster too.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

This completes the development for this patch series.  I tested that 
this works as expected by manually corrupting a pack, etc.
I intend to write real tests for this stuff of course, but at least the
way should be completely clear for the pack spliting series now.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 099dea0..533dd99 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -233,12 +233,6 @@ static struct revindex_entry * find_packed_object(struct packed_git *p,
 	die("internal error: pack revindex corrupt");
 }
 
-static off_t find_packed_object_size(struct packed_git *p, off_t ofs)
-{
-	struct revindex_entry *entry = find_packed_object(p, ofs);
-	return entry[1].offset - ofs;
-}
-
 static const unsigned char *find_packed_object_name(struct packed_git *p,
 						    off_t ofs)
 {
@@ -321,6 +315,28 @@ static int check_pack_inflate(struct packed_git *p,
 		stream.total_in == len) ? 0 : -1;
 }
 
+static int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
+			  off_t offset, off_t len, unsigned int nr)
+{
+	const uint32_t *index_crc;
+	uint32_t data_crc = crc32(0, Z_NULL, 0);
+
+	do {
+		unsigned int avail;
+		void *data = use_pack(p, w_curs, offset, &avail);
+		if (avail > len)
+			avail = len;
+		data_crc = crc32(data_crc, data, avail);
+		offset += avail;
+		len -= avail;
+	} while (len);
+
+	index_crc = p->index_data;
+	index_crc += 2 + 256 + p->num_objects * (20/4) + nr;
+
+	return data_crc != ntohl(*index_crc);
+}
+
 static void copy_pack_data(struct sha1file *f,
 		struct packed_git *p,
 		struct pack_window **w_curs,
@@ -485,6 +501,7 @@ static unsigned long write_object(struct sha1file *f,
 	else {
 		struct packed_git *p = entry->in_pack;
 		struct pack_window *w_curs = NULL;
+		struct revindex_entry *revidx;
 		off_t offset;
 
 		if (entry->delta) {
@@ -507,12 +524,17 @@ static unsigned long write_object(struct sha1file *f,
 			hdrlen += 20;
 		}
 
-		offset = entry->in_pack_offset + entry->in_pack_header_size;
-		datalen = find_packed_object_size(p, entry->in_pack_offset)
-				- entry->in_pack_header_size;
-		if (!pack_to_stdout && check_pack_inflate(p, &w_curs,
-				offset, datalen, entry->size))
-			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
+		offset = entry->in_pack_offset;
+		revidx = find_packed_object(p, offset);
+		datalen = revidx[1].offset - offset;
+		if (!pack_to_stdout && p->index_version > 1 &&
+		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr))
+			die("bad packed object CRC for %s", sha1_to_hex(entry->sha1));
+		offset += entry->in_pack_header_size;
+		datalen -= entry->in_pack_header_size;
+		if (!pack_to_stdout && p->index_version == 1 &&
+		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size))
+			die("corrupt packed object for %s", sha1_to_hex(entry->sha1));
 		copy_pack_data(f, p, &w_curs, offset, datalen);
 		unuse_pack(&w_curs);
 		reused++;
