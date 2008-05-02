From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/7] pack-objects: remove some double negative logic
Date: Fri, 02 May 2008 15:11:46 -0400
Message-ID: <1209755511-7840-3-git-send-email-nico@cam.org>
References: <1209755511-7840-1-git-send-email-nico@cam.org>
 <1209755511-7840-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:14:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js0hX-00058j-CJ
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 21:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbYEBTMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 15:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936503AbYEBTMB
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 15:12:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28091 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936493AbYEBTL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 15:11:56 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K090074V9BRMJ70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 May 2008 15:11:53 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.226.g6f6e8
In-reply-to: <1209755511-7840-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81024>

Parsing !no_reuse_delta everywhere makes my brain spend extra
cycles wondering each time.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8691c99..afbf3dd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -65,7 +65,8 @@ static struct pack_idx_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
-static int no_reuse_delta, no_reuse_object, keep_unreachable, include_tag;
+static int reuse_delta = 1, reuse_object = 1;
+static int keep_unreachable, include_tag;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
@@ -251,7 +252,7 @@ static unsigned long write_object(struct sha1file *f,
 		crc32_begin(f);
 
 	obj_type = entry->type;
-	if (no_reuse_object)
+	if (!reuse_object)
 		to_reuse = 0;	/* explicit */
 	else if (!entry->in_pack)
 		to_reuse = 0;	/* can't reuse what we don't have */
@@ -1021,7 +1022,7 @@ static void check_object(struct object_entry *entry)
 			unuse_pack(&w_curs);
 			return;
 		case OBJ_REF_DELTA:
-			if (!no_reuse_delta && !entry->preferred_base)
+			if (reuse_delta && !entry->preferred_base)
 				base_ref = use_pack(p, &w_curs,
 						entry->in_pack_offset + used, NULL);
 			entry->in_pack_header_size = used + 20;
@@ -1044,7 +1045,7 @@ static void check_object(struct object_entry *entry)
 				die("delta base offset out of bound for %s",
 				    sha1_to_hex(entry->idx.sha1));
 			ofs = entry->in_pack_offset - ofs;
-			if (!no_reuse_delta && !entry->preferred_base) {
+			if (reuse_delta && !entry->preferred_base) {
 				struct revindex_entry *revidx;
 				revidx = find_pack_revindex(p, ofs);
 				base_ref = nth_packed_object_sha1(p, revidx->nr);
@@ -1232,7 +1233,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	 * We do not bother to try a delta that we discarded
 	 * on an earlier try, but only when reusing delta data.
 	 */
-	if (!no_reuse_delta && trg_entry->in_pack &&
+	if (reuse_delta && trg_entry->in_pack &&
 	    trg_entry->in_pack == src_entry->in_pack &&
 	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
 	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
@@ -1687,7 +1688,7 @@ static void prepare_pack(int window, int depth)
 
 		if (entry->delta)
 			/* This happens if we decided to reuse existing
-			 * delta from a pack.  "!no_reuse_delta &&" is implied.
+			 * delta from a pack.  "reuse_delta &&" is implied.
 			 */
 			continue;
 
@@ -2049,11 +2050,11 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("--no-reuse-delta", arg)) {
-			no_reuse_delta = 1;
+			reuse_delta = 0;
 			continue;
 		}
 		if (!strcmp("--no-reuse-object", arg)) {
-			no_reuse_object = no_reuse_delta = 1;
+			reuse_object = reuse_delta = 0;
 			continue;
 		}
 		if (!strcmp("--delta-base-offset", arg)) {
-- 
1.5.5.1.226.g6f6e8
