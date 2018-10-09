Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64551F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 23:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJJGdX (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 02:33:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:34882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725750AbeJJGdX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 02:33:23 -0400
Received: (qmail 14469 invoked by uid 109); 9 Oct 2018 23:14:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 23:14:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11327 invoked by uid 111); 9 Oct 2018 23:13:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 19:13:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 19:14:05 -0400
Date:   Tue, 9 Oct 2018 19:14:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PoC -- do not apply 2/3] test-tree-bitmap: add "dump" mode
Message-ID: <20181009231405.GB23730@sigill.intra.peff.net>
References: <20181009231250.GA19342@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009231250.GA19342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches "gen" mode (formerly the only mode) to include
the list of paths, and to prefix each bitmap with its
matching oid.

The "dump" mode can then read that back in and generate the
list of changed paths. This should be almost identical to:

  git rev-list --all |
  git diff-tree --stdin --name-only -t

The one difference is the sort order: git's diff output is
in tree-sort order, so a subtree "foo" sorts like "foo/",
which is after "foo.bar". Whereas the bitmap path list has a
true byte sort, which puts "foo.bar" after "foo".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-tree-bitmap.c | 104 +++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-tree-bitmap.c b/t/helper/test-tree-bitmap.c
index bc5cf0e514..6f8833344a 100644
--- a/t/helper/test-tree-bitmap.c
+++ b/t/helper/test-tree-bitmap.c
@@ -112,6 +112,14 @@ static void collect_paths(struct hashmap *paths)
 	QSORT(sorted, i, pathmap_entry_strcmp);
 	for (i = 0; i < n; i++)
 		sorted[i]->pos = i;
+
+	/* dump it while we have the sorted order in memory */
+	for (i = 0; i < n; i++) {
+		printf("%s", sorted[i]->path);
+		putchar('\0');
+	}
+	putchar('\0');
+
 	free(sorted);
 }
 
@@ -142,6 +150,8 @@ static void generate_bitmap(struct diff_queue_struct *q,
 
 	ewah = bitmap_to_ewah(bitmap);
 	ewah_serialize_strbuf(ewah, &out);
+
+	fwrite(data->commit->object.oid.hash, 1, GIT_SHA1_RAWSZ, stdout);
 	fwrite(out.buf, 1, out.len, stdout);
 
 	trace_printf("bitmap %s %u %u",
@@ -154,14 +164,104 @@ static void generate_bitmap(struct diff_queue_struct *q,
 	bitmap_free(bitmap);
 }
 
-int cmd_main(int argc, const char **argv)
+static void do_gen(void)
 {
 	struct hashmap paths;
-
 	setup_git_directory();
 	collect_paths(&paths);
 
 	walk_paths(generate_bitmap, &paths);
+}
+
+static void show_path(size_t pos, void *data)
+{
+	const char **paths = data;
+
+	/* assert(pos < nr_paths), but we didn't pass the latter in */
+	printf("%s\n", paths[pos]);
+}
+
+static void do_dump(void)
+{
+	struct strbuf in = STRBUF_INIT;
+	const char *cur;
+	size_t remain;
+
+	const char **paths = NULL;
+	size_t alloc_paths = 0, nr_paths = 0;
+
+	/* slurp stdin; in the real world we'd mmap all this */
+	strbuf_read(&in, 0, 0);
+	cur = in.buf;
+	remain = in.len;
+
+	/* read path for each bit; in the real world this would be separate */
+	while (remain) {
+		const char *end = memchr(cur, '\0', remain);
+		if (!end) {
+			error("truncated input while reading path");
+			goto out;
+		}
+		if (end == cur) {
+			/* empty field signals end of paths */
+			cur++;
+			remain--;
+			break;
+		}
+
+		ALLOC_GROW(paths, nr_paths + 1, alloc_paths);
+		paths[nr_paths++] = cur;
+
+		remain -= end - cur + 1;
+		cur = end + 1;
+	}
+
+	/* read the bitmap for each commit */
+	while (remain) {
+		struct object_id oid;
+		struct ewah_bitmap *ewah;
+		ssize_t len;
+
+		if (remain < GIT_SHA1_RAWSZ) {
+			error("truncated input reading oid");
+			goto out;
+		}
+		hashcpy(oid.hash, (const unsigned char *)cur);
+		cur += GIT_SHA1_RAWSZ;
+		remain -= GIT_SHA1_RAWSZ;
+
+		ewah = ewah_new();
+		len = ewah_read_mmap(ewah, cur, remain);
+		if (len < 0) {
+			ewah_free(ewah);
+			goto out;
+		}
+
+		printf("%s\n", oid_to_hex(&oid));
+		ewah_each_bit(ewah, show_path, paths);
+
+		ewah_free(ewah);
+		cur += len;
+		remain -= len;
+	}
+
+out:
+	free(paths);
+	strbuf_release(&in);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	const char *usage_msg = "test-tree-bitmap <gen|dump>";
+
+	if (!argv[1])
+		usage(usage_msg);
+	else if (!strcmp(argv[1], "gen"))
+		do_gen();
+	else if (!strcmp(argv[1], "dump"))
+		do_dump();
+	else
+		usage(usage_msg);
 
 	return 0;
 }
-- 
2.19.1.550.g7610f1eecb

