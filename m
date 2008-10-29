From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/9] make check_object() resilient to pack corruptions
Date: Wed, 29 Oct 2008 19:02:48 -0400
Message-ID: <1225321372-6570-6-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
 <1225321372-6570-3-git-send-email-nico@cam.org>
 <1225321372-6570-4-git-send-email-nico@cam.org>
 <1225321372-6570-5-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:06:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6w-0004tU-3l
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758201AbYJ2XDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbYJ2XDh
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757381AbYJ2XDe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:34 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:54 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-5-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99427>

The check_object() function tries to get away with the least amount of
pack access possible when it already has partial information on given
object rather than calling the more costly packed_object_info().

When things don't look right, it should just give up and fall back to
packed_object_info() directly instead of die()'ing.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 9e249c9..b595d04 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1005,6 +1005,8 @@ static void check_object(struct object_entry *entry)
 		used = unpack_object_header_buffer(buf, avail,
 						   &entry->in_pack_type,
 						   &entry->size);
+		if (used == 0)
+			goto give_up;
 
 		/*
 		 * Determine if this is a delta and if so whether we can
@@ -1016,6 +1018,8 @@ static void check_object(struct object_entry *entry)
 			/* Not a delta hence we've already got all we need. */
 			entry->type = entry->in_pack_type;
 			entry->in_pack_header_size = used;
+			if (entry->type < OBJ_COMMIT || entry->type > OBJ_BLOB)
+				goto give_up;
 			unuse_pack(&w_curs);
 			return;
 		case OBJ_REF_DELTA:
@@ -1032,16 +1036,20 @@ static void check_object(struct object_entry *entry)
 			ofs = c & 127;
 			while (c & 128) {
 				ofs += 1;
-				if (!ofs || MSB(ofs, 7))
-					die("delta base offset overflow in pack for %s",
-					    sha1_to_hex(entry->idx.sha1));
+				if (!ofs || MSB(ofs, 7)) {
+					error("delta base offset overflow in pack for %s",
+					      sha1_to_hex(entry->idx.sha1));
+					goto give_up;
+				}
 				c = buf[used_0++];
 				ofs = (ofs << 7) + (c & 127);
 			}
 			ofs = entry->in_pack_offset - ofs;
-			if (ofs <= 0 || ofs >= entry->in_pack_offset)
-				die("delta base offset out of bound for %s",
-				    sha1_to_hex(entry->idx.sha1));
+			if (ofs <= 0 || ofs >= entry->in_pack_offset) {
+				error("delta base offset out of bound for %s",
+				      sha1_to_hex(entry->idx.sha1));
+				goto give_up;
+			}
 			if (reuse_delta && !entry->preferred_base) {
 				struct revindex_entry *revidx;
 				revidx = find_pack_revindex(p, ofs);
@@ -1078,6 +1086,8 @@ static void check_object(struct object_entry *entry)
 			 */
 			entry->size = get_size_from_delta(p, &w_curs,
 					entry->in_pack_offset + entry->in_pack_header_size);
+			if (entry->size == 0)
+				goto give_up;
 			unuse_pack(&w_curs);
 			return;
 		}
@@ -1087,6 +1097,7 @@ static void check_object(struct object_entry *entry)
 		 * with sha1_object_info() to find about the object type
 		 * at this point...
 		 */
+		give_up:
 		unuse_pack(&w_curs);
 	}
 
-- 
1.6.0.3.757.g01be.dirty
