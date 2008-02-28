From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/4] fix unimplemented packed_object_info_detail() features
Date: Thu, 28 Feb 2008 00:25:19 -0500
Message-ID: <1204176320-31358-4-git-send-email-nico@cam.org>
References: <1204176320-31358-1-git-send-email-nico@cam.org>
 <1204176320-31358-2-git-send-email-nico@cam.org>
 <1204176320-31358-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 06:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUbHy-0004gi-3f
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 06:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbYB1FZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 00:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbYB1FZ3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 00:25:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbYB1FZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 00:25:26 -0500
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWX00B63OE9QT70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Feb 2008 00:25:22 -0500 (EST)
X-Mailer: git-send-email 1.5.4.2.200.g99e75
In-reply-to: <1204176320-31358-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75357>

Since commit eb32d236df0c16b936b04f0c5402addb61cdb311, there was a TODO
comment in packed_object_info_detail() about the SHA1 of base object to
OBJ_OFS_DELTA objects.  So here it is at last.

While at it, providing the actual storage size information as well is now
trivial.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 pack-check.c |    3 +++
 sha1_file.c  |   10 +++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index d7dd62b..ae25685 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pack.h"
+#include "pack-revindex.h"
 
 struct idx_entry
 {
@@ -101,8 +102,10 @@ static int verify_packfile(struct packed_git *p,
 static void show_pack_info(struct packed_git *p)
 {
 	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN+1];
+
 	nr_objects = p->num_objects;
 	memset(chain_histogram, 0, sizeof(chain_histogram));
+	init_pack_revindex();
 
 	for (i = 0; i < nr_objects; i++) {
 		const unsigned char *sha1;
diff --git a/sha1_file.c b/sha1_file.c
index 1ddb96b..445a871 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -14,6 +14,7 @@
 #include "tag.h"
 #include "tree.h"
 #include "refs.h"
+#include "pack-revindex.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -1367,11 +1368,15 @@ const char *packed_object_info_detail(struct packed_git *p,
 	unsigned long dummy;
 	unsigned char *next_sha1;
 	enum object_type type;
+	struct revindex_entry *revidx;
 
 	*delta_chain_length = 0;
 	curpos = obj_offset;
 	type = unpack_object_header(p, &w_curs, &curpos, size);
 
+	revidx = find_pack_revindex(p, obj_offset);
+	*store_size = revidx[1].offset - obj_offset;
+
 	for (;;) {
 		switch (type) {
 		default:
@@ -1381,14 +1386,13 @@ const char *packed_object_info_detail(struct packed_git *p,
 		case OBJ_TREE:
 		case OBJ_BLOB:
 		case OBJ_TAG:
-			*store_size = 0; /* notyet */
 			unuse_pack(&w_curs);
 			return typename(type);
 		case OBJ_OFS_DELTA:
 			obj_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
 			if (*delta_chain_length == 0) {
-				/* TODO: find base_sha1 as pointed by curpos */
-				hashclr(base_sha1);
+				revidx = find_pack_revindex(p, obj_offset);
+				hashcpy(base_sha1, nth_packed_object_sha1(p, revidx->nr));
 			}
 			break;
 		case OBJ_REF_DELTA:
-- 
1.5.4.2.200.g99e75
