Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C3D1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 23:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJJGcu (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 02:32:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:34870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725750AbeJJGcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 02:32:50 -0400
Received: (qmail 14404 invoked by uid 109); 9 Oct 2018 23:13:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 23:13:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11300 invoked by uid 111); 9 Oct 2018 23:12:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 19:12:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 19:13:32 -0400
Date:   Tue, 9 Oct 2018 19:13:32 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PoC -- do not apply 1/3] initial tree-bitmap proof of concept
Message-ID: <20181009231331.GA23730@sigill.intra.peff.net>
References: <20181009231250.GA19342@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009231250.GA19342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile                    |   1 +
 t/helper/test-tree-bitmap.c | 167 ++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 t/helper/test-tree-bitmap.c

diff --git a/Makefile b/Makefile
index 13e1c52478..f6e823f2d6 100644
--- a/Makefile
+++ b/Makefile
@@ -751,6 +751,7 @@ TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-pkt-line
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
+TEST_PROGRAMS_NEED_X += test-tree-bitmap
 
 TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/t/helper/test-tree-bitmap.c b/t/helper/test-tree-bitmap.c
new file mode 100644
index 0000000000..bc5cf0e514
--- /dev/null
+++ b/t/helper/test-tree-bitmap.c
@@ -0,0 +1,167 @@
+#include "cache.h"
+#include "revision.h"
+#include "diffcore.h"
+#include "argv-array.h"
+#include "ewah/ewok.h"
+
+/* map of pathnames to bit positions */
+struct pathmap_entry {
+	struct hashmap_entry ent;
+	unsigned pos;
+	char path[FLEX_ARRAY];
+};
+
+static int pathmap_entry_hashcmp(const void *unused_cmp_data,
+				 const void *entry,
+				 const void *entry_or_key,
+				 const void *keydata)
+{
+	const struct pathmap_entry *a = entry;
+	const struct pathmap_entry *b = entry_or_key;
+	const char *key = keydata;
+
+	return strcmp(a->path, key ? key : b->path);
+}
+
+static int pathmap_entry_strcmp(const void *va, const void *vb)
+{
+	struct pathmap_entry *a = *(struct pathmap_entry **)va;
+	struct pathmap_entry *b = *(struct pathmap_entry **)vb;
+	return strcmp(a->path, b->path);
+}
+
+struct walk_paths_data {
+	struct hashmap *paths;
+	struct commit *commit;
+};
+
+static void walk_paths(diff_format_fn_t fn, struct hashmap *paths)
+{
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	struct rev_info revs;
+	struct walk_paths_data data;
+	struct commit *commit;
+
+	argv_array_pushl(&argv, "rev-list",
+			 "--all", "-t", "--no-renames",
+			 NULL);
+	init_revisions(&revs, NULL);
+	setup_revisions(argv.argc, argv.argv, &revs, NULL);
+	revs.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	revs.diffopt.format_callback = fn;
+	revs.diffopt.format_callback_data = &data;
+
+	data.paths = paths;
+
+	prepare_revision_walk(&revs);
+	while ((commit = get_revision(&revs))) {
+		data.commit = commit;
+		diff_tree_combined_merge(commit, 0, &revs);
+	}
+
+	reset_revision_walk();
+	argv_array_clear(&argv);
+}
+
+static void collect_commit_paths(struct diff_queue_struct *q,
+				 struct diff_options *opts,
+				 void *vdata)
+{
+	struct walk_paths_data *data = vdata;
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		struct pathmap_entry *entry;
+		struct hashmap_entry lookup;
+
+		hashmap_entry_init(&lookup, strhash(path));
+		entry = hashmap_get(data->paths, &lookup, path);
+		if (entry)
+			continue; /* already present */
+
+		FLEX_ALLOC_STR(entry, path, path);
+		entry->ent = lookup;
+		hashmap_put(data->paths, entry);
+	}
+}
+
+/* assign a bit position to all possible paths */
+static void collect_paths(struct hashmap *paths)
+{
+	struct pathmap_entry **sorted;
+	size_t i, n;
+	struct hashmap_iter iter;
+	struct pathmap_entry *entry;
+
+	/* grab all unique paths */
+	hashmap_init(paths, pathmap_entry_hashcmp, NULL, 0);
+	walk_paths(collect_commit_paths, paths);
+
+	/* and assign them bits in sorted order */
+	n = hashmap_get_size(paths);
+	ALLOC_ARRAY(sorted, n);
+	i = 0;
+	for (entry = hashmap_iter_first(paths, &iter);
+	     entry;
+	     entry = hashmap_iter_next(&iter)) {
+		assert(i < n);
+		sorted[i++] = entry;
+	}
+	QSORT(sorted, i, pathmap_entry_strcmp);
+	for (i = 0; i < n; i++)
+		sorted[i]->pos = i;
+	free(sorted);
+}
+
+/* generate the bitmap for a single commit */
+static void generate_bitmap(struct diff_queue_struct *q,
+			    struct diff_options *opts,
+			    void *vdata)
+{
+	struct walk_paths_data *data = vdata;
+	struct bitmap *bitmap = bitmap_new();
+	struct ewah_bitmap *ewah;
+	struct strbuf out = STRBUF_INIT;
+	size_t i;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		struct pathmap_entry *entry;
+		struct hashmap_entry lookup;
+
+		hashmap_entry_init(&lookup, strhash(path));
+		entry = hashmap_get(data->paths, &lookup, path);
+		if (!entry)
+			BUG("mysterious path appeared: %s", path);
+
+		bitmap_set(bitmap, entry->pos);
+	}
+
+	ewah = bitmap_to_ewah(bitmap);
+	ewah_serialize_strbuf(ewah, &out);
+	fwrite(out.buf, 1, out.len, stdout);
+
+	trace_printf("bitmap %s %u %u",
+		     oid_to_hex(&data->commit->object.oid),
+		     (unsigned)q->nr,
+		     (unsigned)out.len);
+
+	strbuf_release(&out);
+	ewah_free(ewah);
+	bitmap_free(bitmap);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	struct hashmap paths;
+
+	setup_git_directory();
+	collect_paths(&paths);
+
+	walk_paths(generate_bitmap, &paths);
+
+	return 0;
+}
-- 
2.19.1.550.g7610f1eecb

