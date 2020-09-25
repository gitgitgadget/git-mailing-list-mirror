Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2110AC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76032371F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgIYHFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:05:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:40436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbgIYHFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 03:05:10 -0400
Received: (qmail 13169 invoked by uid 109); 25 Sep 2020 07:05:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 07:05:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16004 invoked by uid 111); 25 Sep 2020 07:05:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 03:05:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 03:05:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/8] shortlog: de-duplicate trailer values
Message-ID: <20200925070509.GE62741@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current documentation is vague about what happens with
--group=trailer:signed-off-by when we see a commit with:

  Signed-off-by: One
  Signed-off-by: Two
  Signed-off-by: One

We clearly should credit both "One" and "Two", but should "One" get
credited twice? The current code does so, but mostly because that was
the easiest thing to do. It's probably more useful to count each commit
at most once. This will become especially important when we allow
values from multiple sources in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  3 +-
 builtin/shortlog.c             | 58 ++++++++++++++++++++++++++++++++++
 t/t4201-shortlog.sh            | 28 ++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 40752bc573..29a9b22d3b 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -62,7 +62,8 @@ OPTIONS
 +
 Note that commits that do not include the trailer will not be counted.
 Likewise, commits with multiple trailers (e.g., multiple signoffs) may
-be counted more than once.
+be counted more than once (but only once per unique trailer value in
+that commit).
 +
 The contents of each trailer value are taken literally and completely.
 No mailmap is applied, and the `-e` option has no effect (if the trailer
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index e1d9ee909f..d2d8103dd3 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -166,13 +166,68 @@ static void read_from_stdin(struct shortlog *log)
 	strbuf_release(&oneline);
 }
 
+struct strset_item {
+	struct hashmap_entry ent;
+	char value[FLEX_ARRAY];
+};
+
+struct strset {
+	struct hashmap map;
+};
+
+#define STRSET_INIT { { NULL } }
+
+static int strset_item_hashcmp(const void *hash_data,
+			       const struct hashmap_entry *entry,
+			       const struct hashmap_entry *entry_or_key,
+			       const void *keydata)
+{
+	const struct strset_item *a, *b;
+
+	a = container_of(entry, const struct strset_item, ent);
+	if (keydata)
+		return strcmp(a->value, keydata);
+
+	b = container_of(entry_or_key, const struct strset_item, ent);
+	return strcmp(a->value, b->value);
+}
+
+/*
+ * Adds "str" to the set if it was not already present; returns true if it was
+ * already there.
+ */
+static int strset_check_and_add(struct strset *ss, const char *str)
+{
+	unsigned int hash = strhash(str);
+	struct strset_item *item;
+
+	if (!ss->map.table)
+		hashmap_init(&ss->map, strset_item_hashcmp, NULL, 0);
+
+	if (hashmap_get_from_hash(&ss->map, hash, str))
+		return 1;
+
+	FLEX_ALLOC_STR(item, value, str);
+	hashmap_entry_init(&item->ent, hash);
+	hashmap_add(&ss->map, &item->ent);
+	return 0;
+}
+
+static void strset_clear(struct strset *ss)
+{
+	if (!ss->map.table)
+		return;
+	hashmap_free_entries(&ss->map, struct strset_item, ent);
+}
+
 static void insert_records_from_trailers(struct shortlog *log,
 					 struct commit *commit,
 					 struct pretty_print_context *ctx,
 					 const char *oneline)
 {
 	struct trailer_iterator iter;
 	const char *commit_buffer, *body;
+	struct strset dups = STRSET_INIT;
 
 	/*
 	 * Using format_commit_message("%B") would be simpler here, but
@@ -190,10 +245,13 @@ static void insert_records_from_trailers(struct shortlog *log,
 		if (strcasecmp(iter.key.buf, log->trailer))
 			continue;
 
+		if (strset_check_and_add(&dups, value))
+			continue;
 		insert_one_record(log, value, oneline);
 	}
 	trailer_iterator_release(&iter);
 
+	strset_clear(&dups);
 	unuse_commit_buffer(commit, commit_buffer);
 }
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index e97d891a71..83dbbc44e8 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -234,4 +234,32 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog de-duplicates trailers in a single commit' '
+	git commit --allow-empty -F - <<-\EOF &&
+	subject one
+
+	this message has two distinct values, plus a repeat
+
+	Repeated-trailer: Foo
+	Repeated-trailer: Bar
+	Repeated-trailer: Foo
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	subject two
+
+	similar to the previous, but without the second distinct value
+
+	Repeated-trailer: Foo
+	Repeated-trailer: Foo
+	EOF
+
+	cat >expect <<-\EOF &&
+	     2	Foo
+	     1	Bar
+	EOF
+	git shortlog -ns --group=trailer:repeated-trailer -2 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.28.0.1085.g44a0350633

