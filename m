From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 6/9] make find_pack_revindex() aware of the nasty world
Date: Wed, 29 Oct 2008 19:02:49 -0400
Message-ID: <1225321372-6570-7-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
 <1225321372-6570-3-git-send-email-nico@cam.org>
 <1225321372-6570-4-git-send-email-nico@cam.org>
 <1225321372-6570-5-git-send-email-nico@cam.org>
 <1225321372-6570-6-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:06:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6w-0004tU-SY
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991AbYJ2XDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbYJ2XDn
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756961AbYJ2XDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:40 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:54 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-6-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99428>

It currently calls die() whenever given offset is not found thinking
that such thing should never happen.  But this offset may come from a
corrupted pack whych _could_ happen and not be found.  Callers should
deal with this possibility gracefully instead.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    2 ++
 pack-revindex.c        |    3 ++-
 sha1_file.c            |   18 ++++++++++++------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b595d04..963b432 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1053,6 +1053,8 @@ static void check_object(struct object_entry *entry)
 			if (reuse_delta && !entry->preferred_base) {
 				struct revindex_entry *revidx;
 				revidx = find_pack_revindex(p, ofs);
+				if (!revidx)
+					goto give_up;
 				base_ref = nth_packed_object_sha1(p, revidx->nr);
 			}
 			entry->in_pack_header_size = used + used_0;
diff --git a/pack-revindex.c b/pack-revindex.c
index 6096b62..1de53c8 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -140,7 +140,8 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 		else
 			lo = mi + 1;
 	} while (lo < hi);
-	die("internal error: pack revindex corrupt");
+	error("bad offset for revindex");
+	return NULL;
 }
 
 void discard_revindex(void)
diff --git a/sha1_file.c b/sha1_file.c
index 384a430..9ce1df0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1388,9 +1388,12 @@ static int packed_delta_info(struct packed_git *p,
 		return OBJ_BAD;
 	type = packed_object_info(p, base_offset, NULL);
 	if (type <= OBJ_NONE) {
-		struct revindex_entry *revidx = find_pack_revindex(p, base_offset);
-		const unsigned char *base_sha1 =
-					nth_packed_object_sha1(p, revidx->nr);
+		struct revindex_entry *revidx;
+		const unsigned char *base_sha1;
+		revidx = find_pack_revindex(p, base_offset);
+		if (!revidx)
+			return OBJ_BAD;
+		base_sha1 = nth_packed_object_sha1(p, revidx->nr);
 		mark_bad_packed_object(p, base_sha1);
 		type = sha1_object_info(base_sha1, NULL);
 		if (type <= OBJ_NONE)
@@ -1682,9 +1685,12 @@ static void *unpack_delta_entry(struct packed_git *p,
 		 * This is costly but should happen only in the presence
 		 * of a corrupted pack, and is better than failing outright.
 		 */
-		struct revindex_entry *revidx = find_pack_revindex(p, base_offset);
-		const unsigned char *base_sha1 =
-					nth_packed_object_sha1(p, revidx->nr);
+		struct revindex_entry *revidx;
+		const unsigned char *base_sha1;
+		revidx = find_pack_revindex(p, base_offset);
+		if (!revidx)
+			return NULL;
+		base_sha1 = nth_packed_object_sha1(p, revidx->nr);
 		error("failed to read delta base object %s"
 		      " at offset %"PRIuMAX" from %s",
 		      sha1_to_hex(base_sha1), (uintmax_t)base_offset,
-- 
1.6.0.3.757.g01be.dirty
