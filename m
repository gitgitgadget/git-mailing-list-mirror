From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 03/23] pack v4: scan tree objects
Date: Tue, 27 Aug 2013 00:25:47 -0400
Message-ID: <1377577567-27655-4-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsM-0007jK-J9
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab3H0E0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30513 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab3H0E0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:30 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0G9O51090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id EA7652DA052D	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:28 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233063>

From: Nicolas Pitre <nico@lenovo.(none)>

Let's read a pack to feed our dictionary with all the path strings
contained in all the tree objects.

Dump the resulting dictionary sorted by frequency to stdout.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 Makefile        |   1 +
 packv4-create.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/Makefile b/Makefile
index 3588ca1..4716113 100644
--- a/Makefile
+++ b/Makefile
@@ -550,6 +550,7 @@ PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
 PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += remote-testsvn.o
+PROGRAM_OBJS += packv4-create.o
 
 # Binary suffix, set to .exe for Windows builds
 X =
diff --git a/packv4-create.c b/packv4-create.c
index 2de6d41..00762a5 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -9,6 +9,8 @@
  */
 
 #include "cache.h"
+#include "object.h"
+#include "tree-walk.h"
 
 struct data_entry {
 	unsigned offset;
@@ -125,6 +127,22 @@ static void sort_dict_entries_by_hits(struct dict_table *t)
 	rehash_entries(t);
 }
 
+static struct dict_table *tree_path_table;
+
+static int add_tree_dict_entries(void *buf, unsigned long size)
+{
+	struct tree_desc desc;
+	struct name_entry name_entry;
+
+	if (!tree_path_table)
+		tree_path_table = create_dict_table();
+
+	init_tree_desc(&desc, buf, size);
+	while (tree_entry(&desc, &name_entry))
+		dict_add_entry(tree_path_table, name_entry.path);
+	return 0;
+}
+
 void dict_dump(struct dict_table *t)
 {
 	int i;
@@ -135,3 +153,122 @@ void dict_dump(struct dict_table *t)
 			t->entry[i].hits,
 			t->data + t->entry[i].offset);
 }
+
+struct idx_entry
+{
+	off_t                offset;
+	const unsigned char *sha1;
+};
+
+static int sort_by_offset(const void *e1, const void *e2)
+{
+	const struct idx_entry *entry1 = e1;
+	const struct idx_entry *entry2 = e2;
+	if (entry1->offset < entry2->offset)
+		return -1;
+	if (entry1->offset > entry2->offset)
+		return 1;
+	return 0;
+}
+static int create_pack_dictionaries(struct packed_git *p)
+{
+	uint32_t nr_objects, i;
+	struct idx_entry *objects;
+
+	nr_objects = p->num_objects;
+	objects = xmalloc((nr_objects + 1) * sizeof(*objects));
+	objects[nr_objects].offset = p->index_size - 40;
+	for (i = 0; i < nr_objects; i++) {
+		objects[i].sha1 = nth_packed_object_sha1(p, i);
+		objects[i].offset = nth_packed_object_offset(p, i);
+	}
+	qsort(objects, nr_objects, sizeof(*objects), sort_by_offset);
+
+	for (i = 0; i < nr_objects; i++) {
+		void *data;
+		enum object_type type;
+		unsigned long size;
+		struct object_info oi = {};
+
+		oi.typep = &type;
+		oi.sizep = &size;
+		if (packed_object_info(p, objects[i].offset, &oi) < 0)
+			die("cannot get type of %s from %s",
+			    sha1_to_hex(objects[i].sha1), p->pack_name);
+
+		switch (type) {
+		case OBJ_TREE:
+			break;
+		default:
+			continue;
+		}
+		data = unpack_entry(p, objects[i].offset, &type, &size);
+		if (!data)
+			die("cannot unpack %s from %s",
+			    sha1_to_hex(objects[i].sha1), p->pack_name);
+		if (check_sha1_signature(objects[i].sha1, data, size, typename(type)))
+			die("packed %s from %s is corrupt",
+			    sha1_to_hex(objects[i].sha1), p->pack_name);
+		if (add_tree_dict_entries(data, size) < 0)
+			die("can't process %s object %s",
+				typename(type), sha1_to_hex(objects[i].sha1));
+		free(data);
+	}
+	free(objects);
+
+	return 0;
+}
+
+static int process_one_pack(const char *path)
+{
+	char arg[PATH_MAX];
+	int len;
+	struct packed_git *p;
+
+	len = strlcpy(arg, path, PATH_MAX);
+	if (len >= PATH_MAX)
+		return error("name too long: %s", path);
+
+	/*
+	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
+	 * normalize these forms to "foo.idx" for add_packed_git().
+	 */
+	if (has_extension(arg, ".pack")) {
+		strcpy(arg + len - 5, ".idx");
+		len--;
+	} else if (!has_extension(arg, ".idx")) {
+		if (len + 4 >= PATH_MAX)
+			return error("name too long: %s.idx", arg);
+		strcpy(arg + len, ".idx");
+		len += 4;
+	}
+
+	/*
+	 * add_packed_git() uses our buffer (containing "foo.idx") to
+	 * build the pack filename ("foo.pack").  Make sure it fits.
+	 */
+	if (len + 1 >= PATH_MAX) {
+		arg[len - 4] = '\0';
+		return error("name too long: %s.pack", arg);
+	}
+
+	p = add_packed_git(arg, len, 1);
+	if (!p)
+		return error("packfile %s not found.", arg);
+
+	install_packed_git(p);
+	if (open_pack_index(p))
+		return error("packfile %s index not opened", p->pack_name);
+	return create_pack_dictionaries(p);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <packfile>\n", argv[0]);
+		exit(1);
+	}
+	process_one_pack(argv[1]);
+	dict_dump(tree_path_table);
+	return 0;
+}
-- 
1.8.4.22.g54757b7
