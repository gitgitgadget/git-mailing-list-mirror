From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/9] better validation on delta base object offsets
Date: Wed, 29 Oct 2008 19:02:45 -0400
Message-ID: <1225321372-6570-3-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:05:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6s-0004tU-8B
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493AbYJ2XDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757415AbYJ2XDS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756228AbYJ2XDK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:10 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99424>

In one case, it was possible to have a bad offset equal to 0 effectively
pointing a delta onto itself and crashing git after too many recursions.
In the other cases, a negative offset could result due to off_t being
signed.  Catch those.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c   |    4 ++--
 builtin-unpack-objects.c |    2 ++
 index-pack.c             |    2 +-
 sha1_file.c              |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 0366277..d4c721b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1038,10 +1038,10 @@ static void check_object(struct object_entry *entry)
 				c = buf[used_0++];
 				ofs = (ofs << 7) + (c & 127);
 			}
-			if (ofs >= entry->in_pack_offset)
+			ofs = entry->in_pack_offset - ofs;
+			if (ofs <= 0 || ofs >= entry->in_pack_offset)
 				die("delta base offset out of bound for %s",
 				    sha1_to_hex(entry->idx.sha1));
-			ofs = entry->in_pack_offset - ofs;
 			if (reuse_delta && !entry->preferred_base) {
 				struct revindex_entry *revidx;
 				revidx = find_pack_revindex(p, ofs);
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9f4bdd3..47ed610 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -370,6 +370,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			base_offset = (base_offset << 7) + (c & 127);
 		}
 		base_offset = obj_list[nr].offset - base_offset;
+		if (base_offset <= 0 || base_offset >= obj_list[nr].offset)
+			die("offset value out of bound for delta base object");
 
 		delta_data = get_data(delta_size);
 		if (dry_run || !delta_data) {
diff --git a/index-pack.c b/index-pack.c
index fe75332..60ed41a 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -338,7 +338,7 @@ static void *unpack_raw_entry(struct object_entry *obj, union delta_base *delta_
 			base_offset = (base_offset << 7) + (c & 127);
 		}
 		delta_base->offset = obj->idx.offset - base_offset;
-		if (delta_base->offset >= obj->idx.offset)
+		if (delta_base->offset <= 0 || delta_base->offset >= obj->idx.offset)
 			bad_object(obj->idx.offset, "delta base offset is out of bound");
 		break;
 	case OBJ_COMMIT:
diff --git a/sha1_file.c b/sha1_file.c
index 88d9cf3..e57949b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1355,7 +1355,7 @@ static off_t get_delta_base(struct packed_git *p,
 			base_offset = (base_offset << 7) + (c & 127);
 		}
 		base_offset = delta_obj_offset - base_offset;
-		if (base_offset >= delta_obj_offset)
+		if (base_offset <= 0 || base_offset >= delta_obj_offset)
 			return 0;  /* out of bound */
 		*curpos += used;
 	} else if (type == OBJ_REF_DELTA) {
-- 
1.6.0.3.757.g01be.dirty
