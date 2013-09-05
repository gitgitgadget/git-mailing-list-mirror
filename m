From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 24/38] packv4-create: add progress display
Date: Thu, 05 Sep 2013 02:19:47 -0400
Message-ID: <1378362001-1738-25-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:21:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSwX-0008I0-86
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab3IEGVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979Ab3IEGUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:20 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G3W2XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:15 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id B4E132DA05B8	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:15 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233915>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index c23c791..fd16222 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -13,6 +13,7 @@
 #include "tree-walk.h"
 #include "pack.h"
 #include "pack-revindex.h"
+#include "progress.h"
 #include "varint.h"
 
 
@@ -627,8 +628,10 @@ static struct pack_idx_entry **sort_objs_by_offset(struct pack_idx_entry *list,
 static int create_pack_dictionaries(struct packed_git *p,
 				    struct pack_idx_entry **obj_list)
 {
+	struct progress *progress_state;
 	unsigned int i;
 
+	progress_state = start_progress("Scanning objects", p->num_objects);
 	for (i = 0; i < p->num_objects; i++) {
 		struct pack_idx_entry *obj = obj_list[i];
 		void *data;
@@ -637,6 +640,8 @@ static int create_pack_dictionaries(struct packed_git *p,
 		struct object_info oi = {};
 		int (*add_dict_entries)(void *, unsigned long);
 
+		display_progress(progress_state, i+1);
+
 		oi.typep = &type;
 		oi.sizep = &size;
 		if (packed_object_info(p, obj->offset, &oi) < 0)
@@ -666,6 +671,7 @@ static int create_pack_dictionaries(struct packed_git *p,
 		free(data);
 	}
 
+	stop_progress(&progress_state);
 	return 0;
 }
 
@@ -1009,6 +1015,7 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	off_t written = 0;
 	char *packname;
 	unsigned char pack_sha1[20];
+	struct progress *progress_state;
 
 	p = open_pack(src_pack);
 	if (!p)
@@ -1030,6 +1037,7 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	written += packv4_write_tables(f, nr_objects, objs);
 
 	/* Let's write objects out, updating the object index list in place */
+	progress_state = start_progress("Writing objects", nr_objects);
 	all_objs = objs;
 	all_objs_nr = nr_objects;
 	for (i = 0; i < nr_objects; i++) {
@@ -1039,7 +1047,9 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 		written += packv4_write_object(f, p, obj);
 		obj->offset = obj_pos;
 		obj->crc32 = crc32_end(f);
+		display_progress(progress_state, i+1);
 	}
+	stop_progress(&progress_state);
 
 	sha1close(f, pack_sha1, CSUM_CLOSE | CSUM_FSYNC);
 
-- 
1.8.4.38.g317e65b
