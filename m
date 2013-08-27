From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 01/23] pack v4: initial pack dictionary structure and code
Date: Tue, 27 Aug 2013 00:25:45 -0400
Message-ID: <1377577567-27655-2-git-send-email-nico@fluxnic.net>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 06:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAsg-00080x-9y
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 06:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3H0E1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 00:27:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab3H0E03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 00:26:29 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS600F699O4GV90@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 00:26:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id BC7FD2DA056B	for <git@vger.kernel.org>; Tue,
 27 Aug 2013 00:26:28 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.22.g54757b7
In-reply-to: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233071>

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 packv4-create.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 packv4-create.c

diff --git a/packv4-create.c b/packv4-create.c
new file mode 100644
index 0000000..2de6d41
--- /dev/null
+++ b/packv4-create.c
@@ -0,0 +1,137 @@
+/*
+ * packv4-create.c: management of dictionary tables used in pack v4
+ *
+ * (C) Nicolas Pitre <nico@fluxnic.net>
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "cache.h"
+
+struct data_entry {
+	unsigned offset;
+	unsigned hits;
+};
+
+struct dict_table {
+	char *data;
+	unsigned ptr;
+	unsigned size;
+	struct data_entry *entry;
+	unsigned nb_entries;
+	unsigned max_entries;
+	unsigned *hash;
+	unsigned hash_size;
+};
+
+struct dict_table *create_dict_table(void)
+{
+	return xcalloc(sizeof(struct dict_table), 1);
+}
+
+void destroy_dict_table(struct dict_table *t)
+{
+	free(t->data);
+	free(t->entry);
+	free(t->hash);
+	free(t);
+}
+
+static int locate_entry(struct dict_table *t, const char *str)
+{
+	int i = 0;
+	const unsigned char *s = (const unsigned char *) str;
+
+	while (*s)
+		i = i * 111 + *s++;
+	i = (unsigned)i % t->hash_size;
+
+	while (t->hash[i]) {
+		unsigned n = t->hash[i] - 1;
+		if (!strcmp(str, t->data + t->entry[n].offset))
+			return n;
+		if (++i >= t->hash_size)
+			i = 0;
+	}
+	return -1 - i;
+}
+
+static void rehash_entries(struct dict_table *t)
+{
+	unsigned n;
+
+	t->hash_size *= 2;
+	if (t->hash_size < 1024)
+		t->hash_size = 1024;
+	t->hash = xrealloc(t->hash, t->hash_size * sizeof(*t->hash));
+	memset(t->hash, 0, t->hash_size * sizeof(*t->hash));
+
+	for (n = 0; n < t->nb_entries; n++) {
+		int i = locate_entry(t, t->data + t->entry[n].offset);
+		if (i < 0)
+			t->hash[-1 - i] = n + 1;
+	}
+}
+
+int dict_add_entry(struct dict_table *t, const char *str)
+{
+	int i, len = strlen(str) + 1;
+
+	if (t->ptr + len >= t->size) {
+		t->size = (t->size + len + 1024) * 3 / 2;
+		t->data = xrealloc(t->data, t->size);
+	}
+	memcpy(t->data + t->ptr, str, len);
+
+	i = (t->nb_entries) ? locate_entry(t, t->data + t->ptr) : -1;
+	if (i >= 0) {
+		t->entry[i].hits++;
+		return i;
+	}
+
+	if (t->nb_entries >= t->max_entries) {
+		t->max_entries = (t->max_entries + 1024) * 3 / 2;
+		t->entry = xrealloc(t->entry, t->max_entries * sizeof(*t->entry));
+	}
+	t->entry[t->nb_entries].offset = t->ptr;
+	t->entry[t->nb_entries].hits = 1;
+	t->ptr += len + 1;
+	t->nb_entries++;
+
+	if (t->hash_size * 3 <= t->nb_entries * 4)
+		rehash_entries(t);
+	else
+		t->hash[-1 - i] = t->nb_entries;
+
+	return t->nb_entries - 1;
+}
+
+static int cmp_dict_entries(const void *a_, const void *b_)
+{
+	const struct data_entry *a = a_;
+	const struct data_entry *b = b_;
+	int diff = b->hits - a->hits;
+	if (!diff)
+		diff = a->offset - b->offset;
+	return diff;
+}
+
+static void sort_dict_entries_by_hits(struct dict_table *t)
+{
+	qsort(t->entry, t->nb_entries, sizeof(*t->entry), cmp_dict_entries);
+	t->hash_size = (t->nb_entries * 4 / 3) / 2;
+	rehash_entries(t);
+}
+
+void dict_dump(struct dict_table *t)
+{
+	int i;
+
+	sort_dict_entries_by_hits(t);
+	for (i = 0; i < t->nb_entries; i++)
+		printf("%d\t%s\n",
+			t->entry[i].hits,
+			t->data + t->entry[i].offset);
+}
-- 
1.8.4.22.g54757b7
