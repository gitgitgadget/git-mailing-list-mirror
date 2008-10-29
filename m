From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 7/9] pack-objects: allow "fixing" a corrupted pack without a
 full repack
Date: Wed, 29 Oct 2008 19:02:50 -0400
Message-ID: <1225321372-6570-8-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
 <1225321372-6570-3-git-send-email-nico@cam.org>
 <1225321372-6570-4-git-send-email-nico@cam.org>
 <1225321372-6570-5-git-send-email-nico@cam.org>
 <1225321372-6570-6-git-send-email-nico@cam.org>
 <1225321372-6570-7-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:06:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6x-0004tU-L7
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359AbYJ2XDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbYJ2XDt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757705AbYJ2XDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:47 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-7-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99429>

When the pack data to be reused is found to be bad, let's fall back to
full object access through the generic path which has its own strategies
to find alternate object sources in that case.  This allows for "fixing"
a corrupted pack simply by copying either another pack containing the
object(s) found to be bad, or the loose object itself, into the object
store and launch a repack without the need for -f.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 963b432..826c762 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -277,6 +277,7 @@ static unsigned long write_object(struct sha1file *f,
 				 */
 
 	if (!to_reuse) {
+		no_reuse:
 		if (!usable_delta) {
 			buf = read_sha1_file(entry->idx.sha1, &type, &size);
 			if (!buf)
@@ -358,20 +359,30 @@ static unsigned long write_object(struct sha1file *f,
 		struct revindex_entry *revidx;
 		off_t offset;
 
-		if (entry->delta) {
+		if (entry->delta)
 			type = (allow_ofs_delta && entry->delta->idx.offset) ?
 				OBJ_OFS_DELTA : OBJ_REF_DELTA;
-			reused_delta++;
-		}
 		hdrlen = encode_header(type, entry->size, header);
+
 		offset = entry->in_pack_offset;
 		revidx = find_pack_revindex(p, offset);
 		datalen = revidx[1].offset - offset;
 		if (!pack_to_stdout && p->index_version > 1 &&
-		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr))
-			die("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
+		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
+			error("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
+			unuse_pack(&w_curs);
+			goto no_reuse;
+		}
+
 		offset += entry->in_pack_header_size;
 		datalen -= entry->in_pack_header_size;
+		if (!pack_to_stdout && p->index_version == 1 &&
+		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
+			error("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
+			unuse_pack(&w_curs);
+			goto no_reuse;
+		}
+
 		if (type == OBJ_OFS_DELTA) {
 			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
 			unsigned pos = sizeof(dheader) - 1;
@@ -383,21 +394,19 @@ static unsigned long write_object(struct sha1file *f,
 			sha1write(f, header, hdrlen);
 			sha1write(f, dheader + pos, sizeof(dheader) - pos);
 			hdrlen += sizeof(dheader) - pos;
+			reused_delta++;
 		} else if (type == OBJ_REF_DELTA) {
 			if (limit && hdrlen + 20 + datalen + 20 >= limit)
 				return 0;
 			sha1write(f, header, hdrlen);
 			sha1write(f, entry->delta->idx.sha1, 20);
 			hdrlen += 20;
+			reused_delta++;
 		} else {
 			if (limit && hdrlen + datalen + 20 >= limit)
 				return 0;
 			sha1write(f, header, hdrlen);
 		}
-
-		if (!pack_to_stdout && p->index_version == 1 &&
-		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size))
-			die("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
 		copy_pack_data(f, p, &w_curs, offset, datalen);
 		unuse_pack(&w_curs);
 		reused++;
@@ -1074,6 +1083,7 @@ static void check_object(struct object_entry *entry)
 			 */
 			entry->type = entry->in_pack_type;
 			entry->delta = base_entry;
+			entry->delta_size = entry->size;
 			entry->delta_sibling = base_entry->delta_child;
 			base_entry->delta_child = entry;
 			unuse_pack(&w_curs);
-- 
1.6.0.3.757.g01be.dirty
