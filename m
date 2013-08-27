From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 22/23] pack v4: add progress display
Date: Tue, 27 Aug 2013 00:26:06 -0400
Message-ID: <1377577567-27655-23-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:26:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEArq-0007MP-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152Ab3H0E0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:50 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab3H0E0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:35 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600DCD9O4IO90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 4390F2DA052D	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:30 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233056>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/packv4-create.c b/packv4-create.c
index 6801e21..22e14da 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -13,6 +13,7 @@
 #include "tree-walk.h"
 #include "pack.h"
 #include "pack-revindex.h"
+#include "progress.h"
 
 
 static int pack_compression_seen;
@@ -609,8 +610,10 @@ static struct pack_idx_entry **sort_objs_by_offset(struct pack_idx_entry *list,
 static int create_pack_dictionaries(struct packed_git *p,
 				    struct pack_idx_entry **obj_list)
 {
+	struct progress *progress_state;
 	unsigned int i;
 
+	progress_state = start_progress("Scanning objects", p->num_objects);
 	for (i = 0; i < p->num_objects; i++) {
 		struct pack_idx_entry *obj = obj_list[i];
 		void *data;
@@ -619,6 +622,8 @@ static int create_pack_dictionaries(struct packed_git *p,
 		struct object_info oi = {};
 		int (*add_dict_entries)(void *, unsigned long);
 
+		display_progress(progress_state, i+1);
+
 		oi.typep = &type;
 		oi.sizep = &size;
 		if (packed_object_info(p, obj->offset, &oi) < 0)
@@ -648,6 +653,7 @@ static int create_pack_dictionaries(struct packed_git *p,
 		free(data);
 	}
 
+	stop_progress(&progress_state);
 	return 0;
 }
 
@@ -1002,6 +1008,7 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	off_t written = 0;
 	char *packname;
 	unsigned char pack_sha1[20];
+	struct progress *progress_state;
 
 	p = open_pack(src_pack);
 	if (!p)
@@ -1023,6 +1030,7 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 	written += packv4_write_tables(f, nr_objects, objs);
 
 	/* Let's write objects out, updating the object index list in place */
+	progress_state = start_progress("Writing objects", nr_objects);
 	all_objs = objs;
 	all_objs_nr = nr_objects;
 	for (i = 0; i < nr_objects; i++) {
@@ -1032,7 +1040,9 @@ static void process_one_pack(char *src_pack, char *dst_pack)
 		written += packv4_write_object(f, p, obj);
 		obj->offset = obj_pos;
 		obj->crc32 = crc32_end(f);
+		display_progress(progress_state, i+1);
 	}
+	stop_progress(&progress_state);
 
 	sha1close(f, pack_sha1, CSUM_CLOSE | CSUM_FSYNC);
 
-- 
1.8.4.22.g54757b7
