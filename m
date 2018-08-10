Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6078C1F405
	for <e@80x24.org>; Fri, 10 Aug 2018 23:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeHKB47 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:56:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:50732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726774AbeHKB47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:56:59 -0400
Received: (qmail 28571 invoked by uid 109); 10 Aug 2018 23:24:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Aug 2018 23:24:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24886 invoked by uid 111); 10 Aug 2018 23:25:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 10 Aug 2018 19:25:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2018 19:24:57 -0400
Date:   Fri, 10 Aug 2018 19:24:57 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 7/7] cat-file: support "unordered" output for
 --batch-all-objects
Message-ID: <20180810232457.GG19875@sigill.intra.peff.net>
References: <20180810230729.GA19090@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810230729.GA19090@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you're going to access the contents of every object in a
packfile, it's generally much more efficient to do so in
pack order, rather than in hash order. That increases the
locality of access within the packfile, which in turn is
friendlier to the delta base cache, since the packfile puts
related deltas next to each other. By contrast, hash order
is effectively random, since the sha1 has no discernible
relationship to the content.

This patch introduces an "--unordered" option to cat-file
which iterates over packs in pack-order under the hood. You
can see the results when dumping all of the file content:

  $ time ./git cat-file --batch-all-objects --buffer --batch | wc -c
  6883195596

  real	0m44.491s
  user	0m42.902s
  sys	0m5.230s

  $ time ./git cat-file --unordered \
                        --batch-all-objects --buffer --batch | wc -c
  6883195596

  real	0m6.075s
  user	0m4.774s
  sys	0m3.548s

Same output, different order, way faster. The same speed-up
applies even if you end up accessing the object content in a
different process, like:

  git cat-file --batch-all-objects --buffer --batch-check |
  grep blob |
  git cat-file --batch='%(objectname) %(rest)' |
  wc -c

Adding "--unordered" to the first command drops the runtime
in git.git from 24s to 3.5s.

  Side note: there are actually further speedups available
  for doing it all in-process now. Since we are outputting
  the object content during the actual pack iteration, we
  know where to find the object and could skip the extra
  lookup done by oid_object_info(). This patch stops short
  of that optimization since the underlying API isn't ready
  for us to make those sorts of direct requests.

So if --unordered is so much better, why not make it the
default? Two reasons:

  1. We've promised in the documentation that --batch-all-objects
     outputs in hash order. Since cat-file is plumbing,
     people may be relying on that default, and we can't
     change it.

  2. It's actually _slower_ for some cases. We have to
     compute the pack revindex to walk in pack order. And
     our de-duplication step uses an oidset, rather than a
     sort-and-dedup, which can end up being more expensive.
     If we're just accessing the type and size of each
     object, for example, like:

       git cat-file --batch-all-objects --buffer --batch-check

     my best-of-five warm cache timings go from 900ms to
     1100ms using --unordered. Though it's possible in a
     cold-cache or under memory pressure that we could do
     better, since we'd have better locality within the
     packfile.

And one final question: why is it "--unordered" and not
"--pack-order"? The answer is again two-fold:

  1. "pack order" isn't a well-defined thing across the
     whole set of objects. We're hitting loose objects, as
     well as objects in multiple packs, and the only
     ordering we're promising is _within_ a single pack. The
     rest is apparently random.

  2. The point here is optimization. So we don't want to
     promise any particular ordering, but only to say that
     we will choose an ordering which is likely to be
     efficient for accessing the object content. That leaves
     the door open for further changes in the future without
     having to add another compatibility option.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt | 10 ++++++
 builtin/cat-file.c             | 56 +++++++++++++++++++++++++++++++---
 t/t1006-cat-file.sh            | 11 +++++++
 3 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f90f09b03f..74013335a1 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -104,6 +104,16 @@ OPTIONS
 	buffering; this is much more efficient when invoking
 	`--batch-check` on a large number of objects.
 
+--unordered::
+	When `--batch-all-objects` is in use, visit objects in an
+	order which may be more efficient for accessing the object
+	contents than hash order. The exact details of the order are
+	unspecified, but if you do not require a specific order, this
+	should generally result in faster output, especially with
+	`--batch`.  Note that `cat-file` will still show each object
+	only once, even if it is stored multiple times in the
+	repository.
+
 --allow-unknown-type::
 	Allow -s or -t to query broken/corrupt objects of unknown type.
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2d34f3b867..45992c9be9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -21,6 +21,7 @@ struct batch_options {
 	int print_contents;
 	int buffer_output;
 	int all_objects;
+	int unordered;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
 };
@@ -410,6 +411,7 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 struct object_cb_data {
 	struct batch_options *opt;
 	struct expand_data *expand;
+	struct oidset *seen;
 };
 
 static int batch_object_cb(const struct object_id *oid, void *vdata)
@@ -437,6 +439,32 @@ static int collect_packed_object(const struct object_id *oid,
 	return 0;
 }
 
+static int batch_unordered_object(const struct object_id *oid, void *vdata)
+{
+	struct object_cb_data *data = vdata;
+
+	if (oidset_contains(data->seen, oid))
+		return 0;
+	oidset_insert(data->seen, oid);
+
+	return batch_object_cb(oid, data);
+}
+
+static int batch_unordered_loose(const struct object_id *oid,
+				 const char *path,
+				 void *data)
+{
+	return batch_unordered_object(oid, data);
+}
+
+static int batch_unordered_packed(const struct object_id *oid,
+				  struct packed_git *pack,
+				  uint32_t pos,
+				  void *data)
+{
+	return batch_unordered_object(oid, data);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -473,19 +501,35 @@ static int batch_objects(struct batch_options *opt)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
-		struct oid_array sa = OID_ARRAY_INIT;
 		struct object_cb_data cb;
 
-		for_each_loose_object(collect_loose_object, &sa, 0);
-		for_each_packed_object(collect_packed_object, &sa, 0);
 		if (repository_format_partial_clone)
 			warning("This repository has extensions.partialClone set. Some objects may not be loaded.");
 
 		cb.opt = opt;
 		cb.expand = &data;
-		oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
-		oid_array_clear(&sa);
+		if (opt->unordered) {
+			struct oidset seen = OIDSET_INIT;
+
+			cb.seen = &seen;
+
+			for_each_loose_object(batch_unordered_loose, &cb, 0);
+			for_each_packed_object(batch_unordered_packed, &cb,
+					       FOR_EACH_OBJECT_PACK_ORDER);
+
+			oidset_clear(&seen);
+		} else {
+			struct oid_array sa = OID_ARRAY_INIT;
+
+			for_each_loose_object(collect_loose_object, &sa, 0);
+			for_each_packed_object(collect_packed_object, &sa, 0);
+
+			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
+
+			oid_array_clear(&sa);
+		}
+
 		return 0;
 	}
 
@@ -586,6 +630,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
 		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
 			 N_("show all objects with --batch or --batch-check")),
+		OPT_BOOL(0, "unordered", &batch.unordered,
+			 N_("do not order --batch-all-objects output")),
 		OPT_END()
 	};
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 4fb5e098f2..7f19d591f2 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -575,4 +575,15 @@ test_expect_success 'cat-file --batch-all-objects shows all objects' '
 	test_cmp expect actual
 '
 
+# The only user-visible difference is that the objects are no longer sorted,
+# and the resulting sort order is undefined. So we can only check that it
+# produces the same objects as the ordered case, but that at least exercises
+# the code.
+test_expect_success 'cat-file --unordered works' '
+	git -C all-two cat-file --batch-all-objects --unordered \
+				--batch-check="%(objectname)" >actual.unsorted &&
+	sort <actual.unsorted >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.1058.g7433f71063

