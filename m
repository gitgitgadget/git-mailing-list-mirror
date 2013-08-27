From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 07/23] pack v4: move to struct pack_idx_entry and get rid of
 our own struct idx_entry
Date: Tue, 27 Aug 2013 00:25:51 -0400
Message-ID: <1377577567-27655-8-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsN-0007jK-3m
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab3H0E10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:27:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab3H0E0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:31 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600F6D9O5GV90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 3022A2DA056B	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233067>

Let's create a struct pack_idx_entry list with sorted sha1 which will
be useful later.  The offset sorted list is now a separate indirect
list.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 72 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 20d97a4..012129b 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "object.h"
 #include "tree-walk.h"
+#include "pack.h"
 
 struct data_entry {
 	unsigned offset;
@@ -244,46 +245,53 @@ static void dict_dump(void)
 	dump_dict_table(tree_path_table);
 }
 
-struct idx_entry
+static struct pack_idx_entry *get_packed_object_list(struct packed_git *p)
 {
-	off_t                offset;
-	const unsigned char *sha1;
-};
+	unsigned i, nr_objects = p->num_objects;
+	struct pack_idx_entry *objects;
+
+	objects = xmalloc((nr_objects + 1) * sizeof(*objects));
+	objects[nr_objects].offset = p->pack_size - 20;
+	for (i = 0; i < nr_objects; i++) {
+		hashcpy(objects[i].sha1, nth_packed_object_sha1(p, i));
+		objects[i].offset = nth_packed_object_offset(p, i);
+	}
+
+	return objects;
+}
 
 static int sort_by_offset(const void *e1, const void *e2)
 {
-	const struct idx_entry *entry1 = e1;
-	const struct idx_entry *entry2 = e2;
-	if (entry1->offset < entry2->offset)
+	const struct pack_idx_entry * const *entry1 = e1;
+	const struct pack_idx_entry * const *entry2 = e2;
+	if ((*entry1)->offset < (*entry2)->offset)
 		return -1;
-	if (entry1->offset > entry2->offset)
+	if ((*entry1)->offset > (*entry2)->offset)
 		return 1;
 	return 0;
 }
 
-static struct idx_entry *get_packed_object_list(struct packed_git *p)
+static struct pack_idx_entry **sort_objs_by_offset(struct pack_idx_entry *list,
+						    unsigned nr_objects)
 {
-	uint32_t nr_objects, i;
-	struct idx_entry *objects;
+	unsigned i;
+	struct pack_idx_entry **sorted;
 
-	nr_objects = p->num_objects;
-	objects = xmalloc((nr_objects + 1) * sizeof(*objects));
-	objects[nr_objects].offset = p->index_size - 40;
-	for (i = 0; i < nr_objects; i++) {
-		objects[i].sha1 = nth_packed_object_sha1(p, i);
-		objects[i].offset = nth_packed_object_offset(p, i);
-	}
-	qsort(objects, nr_objects, sizeof(*objects), sort_by_offset);
+	sorted = xmalloc((nr_objects + 1) * sizeof(*sorted));
+	for (i = 0; i < nr_objects + 1; i++)
+		sorted[i] = &list[i];
+	qsort(sorted, nr_objects + 1, sizeof(*sorted), sort_by_offset);
 
-	return objects;
+	return sorted;
 }
 
 static int create_pack_dictionaries(struct packed_git *p,
-				    struct idx_entry *objects)
+				    struct pack_idx_entry **obj_list)
 {
 	unsigned int i;
 
 	for (i = 0; i < p->num_objects; i++) {
+		struct pack_idx_entry *obj = obj_list[i];
 		void *data;
 		enum object_type type;
 		unsigned long size;
@@ -292,9 +300,9 @@ static int create_pack_dictionaries(struct packed_git *p,
 
 		oi.typep = &type;
 		oi.sizep = &size;
-		if (packed_object_info(p, objects[i].offset, &oi) < 0)
+		if (packed_object_info(p, obj->offset, &oi) < 0)
 			die("cannot get type of %s from %s",
-			    sha1_to_hex(objects[i].sha1), p->pack_name);
+			    sha1_to_hex(obj->sha1), p->pack_name);
 
 		switch (type) {
 		case OBJ_COMMIT:
@@ -306,16 +314,16 @@ static int create_pack_dictionaries(struct packed_git *p,
 		default:
 			continue;
 		}
-		data = unpack_entry(p, objects[i].offset, &type, &size);
+		data = unpack_entry(p, obj->offset, &type, &size);
 		if (!data)
 			die("cannot unpack %s from %s",
-			    sha1_to_hex(objects[i].sha1), p->pack_name);
-		if (check_sha1_signature(objects[i].sha1, data, size, typename(type)))
+			    sha1_to_hex(obj->sha1), p->pack_name);
+		if (check_sha1_signature(obj->sha1, data, size, typename(type)))
 			die("packed %s from %s is corrupt",
-			    sha1_to_hex(objects[i].sha1), p->pack_name);
+			    sha1_to_hex(obj->sha1), p->pack_name);
 		if (add_dict_entries(data, size) < 0)
 			die("can't process %s object %s",
-				typename(type), sha1_to_hex(objects[i].sha1));
+				typename(type), sha1_to_hex(obj->sha1));
 		free(data);
 	}
 
@@ -378,14 +386,18 @@ static struct packed_git *open_pack(const char *path)
 static void process_one_pack(char *src_pack)
 {
 	struct packed_git *p;
-	struct idx_entry *objs;
+	struct pack_idx_entry *objs, **p_objs;
+	unsigned nr_objects;
 
 	p = open_pack(src_pack);
 	if (!p)
 		die("unable to open source pack");
 
+	nr_objects = p->num_objects;
 	objs = get_packed_object_list(p);
-	create_pack_dictionaries(p, objs);
+	p_objs = sort_objs_by_offset(objs, nr_objects);
+
+	create_pack_dictionaries(p, p_objs);
 }
 
 int main(int argc, char *argv[])
-- 
1.8.4.22.g54757b7
