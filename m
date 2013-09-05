From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 05/38] pack v4: add commit object parsing
Date: Thu, 05 Sep 2013 02:19:28 -0400
Message-ID: <1378362001-1738-6-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:22:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSxB-00009K-Ix
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762730Ab3IEGV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:21:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221Ab3IEGUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:16 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G402XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:14 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id A727C2DA0613	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:14 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233928>

Let's create another dictionary table to hold the author and committer
entries.  We use the same table format used for tree entries where the
16 bit data prefix is conveniently used to store the timezone value.

In order to copy straight from a commit object buffer, dict_add_entry()
is modified to get the string length as the provided string pointer is
not always be null terminated.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 9 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index eccd9fc..5c08871 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -1,5 +1,5 @@
 /*
- * packv4-create.c: management of dictionary tables used in pack v4
+ * packv4-create.c: creation of dictionary tables and objects used in pack v4
  *
  * (C) Nicolas Pitre <nico@fluxnic.net>
  *
@@ -80,9 +80,9 @@ static void rehash_entries(struct dict_table *t)
 	}
 }
 
-int dict_add_entry(struct dict_table *t, int val, const char *str)
+int dict_add_entry(struct dict_table *t, int val, const char *str, int str_len)
 {
-	int i, val_len = 2, str_len = strlen(str) + 1;
+	int i, val_len = 2;
 
 	if (t->ptr + val_len + str_len > t->size) {
 		t->size = (t->size + val_len + str_len + 1024) * 3 / 2;
@@ -92,6 +92,7 @@ int dict_add_entry(struct dict_table *t, int val, const char *str)
 	t->data[t->ptr] = val >> 8;
 	t->data[t->ptr + 1] = val;
 	memcpy(t->data + t->ptr + val_len, str, str_len);
+	t->data[t->ptr + val_len + str_len] = 0;
 
 	i = (t->nb_entries) ?
 		locate_entry(t, t->data + t->ptr, val_len + str_len) : -1;
@@ -107,7 +108,7 @@ int dict_add_entry(struct dict_table *t, int val, const char *str)
 	t->entry[t->nb_entries].offset = t->ptr;
 	t->entry[t->nb_entries].size = val_len + str_len;
 	t->entry[t->nb_entries].hits = 1;
-	t->ptr += val_len + str_len;
+	t->ptr += val_len + str_len + 1;
 	t->nb_entries++;
 
 	if (t->hash_size * 3 <= t->nb_entries * 4)
@@ -135,8 +136,73 @@ static void sort_dict_entries_by_hits(struct dict_table *t)
 	rehash_entries(t);
 }
 
+static struct dict_table *commit_name_table;
 static struct dict_table *tree_path_table;
 
+/*
+ * Parse the author/committer line from a canonical commit object.
+ * The 'from' argument points right after the "author " or "committer "
+ * string.  The time zone is parsed and stored in *tz_val.  The returned
+ * pointer is right after the end of the email address which is also just
+ * before the time value, or NULL if a parsing error is encountered.
+ */
+static char *get_nameend_and_tz(char *from, int *tz_val)
+{
+	char *end, *tz;
+
+	tz = strchr(from, '\n');
+	/* let's assume the smallest possible string to be "x <x> 0 +0000\n" */
+	if (!tz || tz - from < 13)
+		return NULL;
+	tz -= 4;
+	end = tz - 4;
+	while (end - from > 5 && *end != ' ')
+		end--;
+	if (end[-1] != '>' || end[0] != ' ' || tz[-2] != ' ')
+		return NULL;
+	*tz_val = (tz[0] - '0') * 1000 +
+		  (tz[1] - '0') * 100 +
+		  (tz[2] - '0') * 10 +
+		  (tz[3] - '0');
+	switch (tz[-1]) {
+	default:	return NULL;
+	case '+':	break;
+	case '-':	*tz_val = -*tz_val;
+	}
+	return end;
+}
+
+static int add_commit_dict_entries(void *buf, unsigned long size)
+{
+	char *name, *end = NULL;
+	int tz_val;
+
+	if (!commit_name_table)
+		commit_name_table = create_dict_table();
+
+	/* parse and add author info */
+	name = strstr(buf, "\nauthor ");
+	if (name) {
+		name += 8;
+		end = get_nameend_and_tz(name, &tz_val);
+	}
+	if (!name || !end)
+		return -1;
+	dict_add_entry(commit_name_table, tz_val, name, end - name);
+
+	/* parse and add committer info */
+	name = strstr(end, "\ncommitter ");
+	if (name) {
+	       name += 11;
+	       end = get_nameend_and_tz(name, &tz_val);
+	}
+	if (!name || !end)
+		return -1;
+	dict_add_entry(commit_name_table, tz_val, name, end - name);
+
+	return 0;
+}
+
 static int add_tree_dict_entries(void *buf, unsigned long size)
 {
 	struct tree_desc desc;
@@ -146,13 +212,16 @@ static int add_tree_dict_entries(void *buf, unsigned long size)
 		tree_path_table = create_dict_table();
 
 	init_tree_desc(&desc, buf, size);
-	while (tree_entry(&desc, &name_entry))
+	while (tree_entry(&desc, &name_entry)) {
+		int pathlen = tree_entry_len(&name_entry);
 		dict_add_entry(tree_path_table, name_entry.mode,
-			       name_entry.path);
+				name_entry.path, pathlen);
+	}
+
 	return 0;
 }
 
-void dict_dump(struct dict_table *t)
+void dump_dict_table(struct dict_table *t)
 {
 	int i;
 
@@ -169,6 +238,12 @@ void dict_dump(struct dict_table *t)
 	}
 }
 
+static void dict_dump(void)
+{
+	dump_dict_table(commit_name_table);
+	dump_dict_table(tree_path_table);
+}
+
 struct idx_entry
 {
 	off_t                offset;
@@ -205,6 +280,7 @@ static int create_pack_dictionaries(struct packed_git *p)
 		enum object_type type;
 		unsigned long size;
 		struct object_info oi = {};
+		int (*add_dict_entries)(void *, unsigned long);
 
 		oi.typep = &type;
 		oi.sizep = &size;
@@ -213,7 +289,11 @@ static int create_pack_dictionaries(struct packed_git *p)
 			    sha1_to_hex(objects[i].sha1), p->pack_name);
 
 		switch (type) {
+		case OBJ_COMMIT:
+			add_dict_entries = add_commit_dict_entries;
+			break;
 		case OBJ_TREE:
+			add_dict_entries = add_tree_dict_entries;
 			break;
 		default:
 			continue;
@@ -225,7 +305,7 @@ static int create_pack_dictionaries(struct packed_git *p)
 		if (check_sha1_signature(objects[i].sha1, data, size, typename(type)))
 			die("packed %s from %s is corrupt",
 			    sha1_to_hex(objects[i].sha1), p->pack_name);
-		if (add_tree_dict_entries(data, size) < 0)
+		if (add_dict_entries(data, size) < 0)
 			die("can't process %s object %s",
 				typename(type), sha1_to_hex(objects[i].sha1));
 		free(data);
@@ -285,6 +365,6 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 	process_one_pack(argv[1]);
-	dict_dump(tree_path_table);
+	dict_dump();
 	return 0;
 }
-- 
1.8.4.38.g317e65b
