Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221931F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 18:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJJCFK (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 22:05:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726855AbeJJCFK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 22:05:10 -0400
Received: (qmail 3523 invoked by uid 109); 9 Oct 2018 18:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 18:46:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8658 invoked by uid 111); 9 Oct 2018 18:45:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 14:45:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 14:46:47 -0400
Date:   Tue, 9 Oct 2018 14:46:47 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bloom Filters (was Re: We should add a "git gc --auto" after
 "git clone" due to commit graph)
Message-ID: <20181009184647.GA7014@sigill.intra.peff.net>
References: <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
 <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 09, 2018 at 09:48:20AM -0400, Derrick Stolee wrote:

> [I snipped all of the parts about bloom filters that seemed entirely
>  reasonable to me ;) ]

> > Imagine we have that list. Is a bloom filter still the best data
> > structure for each commit? At the point that we have the complete
> > universe of paths, we could give each commit a bitmap of changed paths.
> > That lets us ask "did this commit touch these paths" (collect the bits
> > from the list of paths, then check for 1's), as well as "what paths did
> > we touch" (collect the 1 bits, and then index the path list).  Those
> > bitmaps should compress very well via EWAH or similar (most of them
> > would be huge stretches of 0's punctuated by short runs of 1's).
> 
> I'm not convinced we would frequently have runs of 1's, and the bitmap would
> not compress much better than simply listing the positions. For example, a
> path "foo/bar" that resolves to a tree would only start a run if the next
> changes are the initial section of entries in that tree (sorted
> lexicographically) such as "foo/bar/a, foo/bar/b". If we deepen into a tree,
> then we will break the run of 1's unless we changed every path deeper than
> that tree.

Yeah, I doubt we'd really have runs of 1's (by short, I just mean 1 or
2). I agree that listing the positions could work, though I sort of
assumed that was more or less what a decent compressed bitmap would
turn into. E.g., if bit N is set, we should be able to say "N-1
zeroes, 1 one" in about the same size as we could say "position N".

EWAH seems pretty awful in that regard. Or at least its serialized
format is (or maybe it's our implementation that is bad).

The patch below generates a bitmap for each commit in a repository (it
doesn't output the total list of paths; I've left that as an exercise
for the reader). On linux.git, the result is 57MB. But when I look at
the individual bitmap sizes (via GIT_TRACE), they're quite silly.
Storing a single set bit takes 28 bytes in serialized form!

There are only around 120k unique paths (including prefix trees).
Naively using run-length encoding and varints, our worst case should be
something like 18-20 bits to say "120k zeroes, then a 1, then all
zeroes".  And the average case should be better (you don't even need to
say "120k", but some smaller number).

I wonder if Roaring does better here.

Gzipping the resulting bitmaps drops the total size to about 7.5MB.
That's not a particularly important number, but I think it shows that
the built-in ewah compression is far from ideal.

Just listing the positions with a series of varints would generally be
fine, since we expect sparse bitmaps. I just hoped that a good
RLE scheme would degrade to roughly that for the sparse case, but also
perform well for more dense cases.

So at any rate, I do think it would not be out of the question to store
bitmaps like this. I'm much more worried about the maintenance cost of
adding new entries incrementally. I think it's only feasible if we give
up sorting, and then I wonder what other problems that might cause.

-Peff

-- >8 --
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
