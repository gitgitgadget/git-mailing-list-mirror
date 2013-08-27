From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 04/23] pack v4: add tree entry mode support to dictionary
 entries
Date: Tue, 27 Aug 2013 00:25:48 -0400
Message-ID: <1377577567-27655-5-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsH-0007jK-9J
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab3H0E0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:26:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab3H0E0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:31 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600G0I9O51090@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 054002DA0669	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:29 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233060>

Augment dict entries with a 16-bit prefix in order to store the file
mode value of tree entries.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 56 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 00762a5..eccd9fc 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -14,11 +14,12 @@
 
 struct data_entry {
 	unsigned offset;
+	unsigned size;
 	unsigned hits;
 };
 
 struct dict_table {
-	char *data;
+	unsigned char *data;
 	unsigned ptr;
 	unsigned size;
 	struct data_entry *entry;
@@ -41,18 +42,19 @@ void destroy_dict_table(struct dict_table *t)
 	free(t);
 }
 
-static int locate_entry(struct dict_table *t, const char *str)
+static int locate_entry(struct dict_table *t, const void *data, int size)
 {
-	int i = 0;
-	const unsigned char *s = (const unsigned char *) str;
+	int i = 0, len = size;
+	const unsigned char *p = data;
 
-	while (*s)
-		i = i * 111 + *s++;
+	while (len--)
+		i = i * 111 + *p++;
 	i = (unsigned)i % t->hash_size;
 
 	while (t->hash[i]) {
 		unsigned n = t->hash[i] - 1;
-		if (!strcmp(str, t->data + t->entry[n].offset))
+		if (t->entry[n].size == size &&
+		    memcmp(t->data + t->entry[n].offset, data, size) == 0)
 			return n;
 		if (++i >= t->hash_size)
 			i = 0;
@@ -71,23 +73,28 @@ static void rehash_entries(struct dict_table *t)
 	memset(t->hash, 0, t->hash_size * sizeof(*t->hash));
 
 	for (n = 0; n < t->nb_entries; n++) {
-		int i = locate_entry(t, t->data + t->entry[n].offset);
+		int i = locate_entry(t, t->data + t->entry[n].offset,
+					t->entry[n].size);
 		if (i < 0)
 			t->hash[-1 - i] = n + 1;
 	}
 }
 
-int dict_add_entry(struct dict_table *t, const char *str)
+int dict_add_entry(struct dict_table *t, int val, const char *str)
 {
-	int i, len = strlen(str) + 1;
+	int i, val_len = 2, str_len = strlen(str) + 1;
 
-	if (t->ptr + len >= t->size) {
-		t->size = (t->size + len + 1024) * 3 / 2;
+	if (t->ptr + val_len + str_len > t->size) {
+		t->size = (t->size + val_len + str_len + 1024) * 3 / 2;
 		t->data = xrealloc(t->data, t->size);
 	}
-	memcpy(t->data + t->ptr, str, len);
 
-	i = (t->nb_entries) ? locate_entry(t, t->data + t->ptr) : -1;
+	t->data[t->ptr] = val >> 8;
+	t->data[t->ptr + 1] = val;
+	memcpy(t->data + t->ptr + val_len, str, str_len);
+
+	i = (t->nb_entries) ?
+		locate_entry(t, t->data + t->ptr, val_len + str_len) : -1;
 	if (i >= 0) {
 		t->entry[i].hits++;
 		return i;
@@ -98,8 +105,9 @@ int dict_add_entry(struct dict_table *t, const char *str)
 		t->entry = xrealloc(t->entry, t->max_entries * sizeof(*t->entry));
 	}
 	t->entry[t->nb_entries].offset = t->ptr;
+	t->entry[t->nb_entries].size = val_len + str_len;
 	t->entry[t->nb_entries].hits = 1;
-	t->ptr += len + 1;
+	t->ptr += val_len + str_len;
 	t->nb_entries++;
 
 	if (t->hash_size * 3 <= t->nb_entries * 4)
@@ -139,7 +147,8 @@ static int add_tree_dict_entries(void *buf, unsigned long size)
 
 	init_tree_desc(&desc, buf, size);
 	while (tree_entry(&desc, &name_entry))
-		dict_add_entry(tree_path_table, name_entry.path);
+		dict_add_entry(tree_path_table, name_entry.mode,
+			       name_entry.path);
 	return 0;
 }
 
@@ -148,10 +157,16 @@ void dict_dump(struct dict_table *t)
 	int i;
 
 	sort_dict_entries_by_hits(t);
-	for (i = 0; i < t->nb_entries; i++)
-		printf("%d\t%s\n",
-			t->entry[i].hits,
-			t->data + t->entry[i].offset);
+	for (i = 0; i < t->nb_entries; i++) {
+		int16_t val;
+		uint16_t uval;
+		val = t->data[t->entry[i].offset] << 8;
+		val |= t->data[t->entry[i].offset + 1];
+		uval = val;
+		printf("%d\t%d\t%o\t%s\n",
+			t->entry[i].hits, val, uval,
+			t->data + t->entry[i].offset + 2);
+	}
 }
 
 struct idx_entry
@@ -170,6 +185,7 @@ static int sort_by_offset(const void *e1, const void *e2)
 		return 1;
 	return 0;
 }
+
 static int create_pack_dictionaries(struct packed_git *p)
 {
 	uint32_t nr_objects, i;
-- 
1.8.4.22.g54757b7
