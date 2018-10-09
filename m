Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE3F1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 23:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJJGeA (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 02:34:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:34894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725750AbeJJGeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 02:34:00 -0400
Received: (qmail 14519 invoked by uid 109); 9 Oct 2018 23:14:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 23:14:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11351 invoked by uid 111); 9 Oct 2018 23:13:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 09 Oct 2018 19:13:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Oct 2018 19:14:41 -0400
Date:   Tue, 9 Oct 2018 19:14:41 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PoC -- do not apply 3/3] test-tree-bitmap: replace ewah with custom
 rle encoding
Message-ID: <20181009231441.GC23730@sigill.intra.peff.net>
References: <20181009231250.GA19342@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181009231250.GA19342@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rules are basically:

 - each bitmap is a series of counts of runs of 0/1

 - each count is one of our standard varints

 - each bitmap must have at least one initial count of
   zeroes (which may itself be a zero-length count, if the
   first bit is set)

 - a zero-length count anywhere else marks the end of
   the bitmap

For a sparse bitmap, these will tend to be quite short,
because long runs are encoded as fairly small counts. The
worst case is an alternate 0/1/0/1 bitmap, where we will
spend a full byte to specify each bit (thus bloating it by a
factor of 8 over an uncompressed bitmap).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-tree-bitmap.c | 105 +++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 14 deletions(-)

diff --git a/t/helper/test-tree-bitmap.c b/t/helper/test-tree-bitmap.c
index 6f8833344a..36f19ed464 100644
--- a/t/helper/test-tree-bitmap.c
+++ b/t/helper/test-tree-bitmap.c
@@ -3,6 +3,7 @@
 #include "diffcore.h"
 #include "argv-array.h"
 #include "ewah/ewok.h"
+#include "varint.h"
 
 /* map of pathnames to bit positions */
 struct pathmap_entry {
@@ -123,6 +124,49 @@ static void collect_paths(struct hashmap *paths)
 	free(sorted);
 }
 
+static void strbuf_add_varint(struct strbuf *out, uintmax_t val)
+{
+	size_t len;
+	strbuf_grow(out, 16); /* enough for any varint */
+	len = encode_varint(val, (unsigned char *)out->buf + out->len);
+	strbuf_setlen(out, out->len + len);
+}
+
+static void bitmap_to_rle(struct strbuf *out, struct bitmap *bitmap)
+{
+	int curval = 0; /* count zeroes, then ones, then zeroes, etc */
+	size_t run = 0;
+	size_t word;
+	size_t orig_len = out->len;
+
+	for (word = 0; word < bitmap->word_alloc; word++) {
+		int bit;
+
+		for (bit = 0; bit < BITS_IN_EWORD; bit++) {
+			int val = !!(bitmap->words[word] & (((eword_t)1) << bit));
+			if (val == curval)
+				run++;
+			else {
+				strbuf_add_varint(out, run);
+				curval = 1 - curval; /* flip 0/1 */
+				run = 1;
+			}
+		}
+	}
+
+	/*
+	 * complete the run, but do not bother with trailing zeroes, unless we
+	 * failed to write even an initial run of 0's.
+	 */
+	if (curval && run)
+		strbuf_add_varint(out, run);
+	else if (orig_len == out->len)
+		strbuf_add_varint(out, 0);
+
+	/* signal end-of-input with an empty run */
+	strbuf_add_varint(out, 0);
+}
+
 /* generate the bitmap for a single commit */
 static void generate_bitmap(struct diff_queue_struct *q,
 			    struct diff_options *opts,
@@ -130,7 +174,6 @@ static void generate_bitmap(struct diff_queue_struct *q,
 {
 	struct walk_paths_data *data = vdata;
 	struct bitmap *bitmap = bitmap_new();
-	struct ewah_bitmap *ewah;
 	struct strbuf out = STRBUF_INIT;
 	size_t i;
 
@@ -148,8 +191,7 @@ static void generate_bitmap(struct diff_queue_struct *q,
 		bitmap_set(bitmap, entry->pos);
 	}
 
-	ewah = bitmap_to_ewah(bitmap);
-	ewah_serialize_strbuf(ewah, &out);
+	bitmap_to_rle(&out, bitmap);
 
 	fwrite(data->commit->object.oid.hash, 1, GIT_SHA1_RAWSZ, stdout);
 	fwrite(out.buf, 1, out.len, stdout);
@@ -160,7 +202,6 @@ static void generate_bitmap(struct diff_queue_struct *q,
 		     (unsigned)out.len);
 
 	strbuf_release(&out);
-	ewah_free(ewah);
 	bitmap_free(bitmap);
 }
 
@@ -181,6 +222,51 @@ static void show_path(size_t pos, void *data)
 	printf("%s\n", paths[pos]);
 }
 
+static size_t rle_each_bit(const unsigned char *in, size_t len,
+			   void (*fn)(size_t, void *), void *data)
+{
+	int curval = 0; /* look for zeroes first, then ones, etc */
+	const unsigned char *cur = in;
+	const unsigned char *end = in + len;
+	size_t pos;
+
+	/* we always have a first run, even if it's 0 zeroes */
+	pos = decode_varint(&cur);
+
+	/*
+	 * ugh, varint does not seem to have a way to prevent reading past
+	 * the end of the buffer. We'll do a length check after each one,
+	 * so the worst case is bounded.
+	 */
+	if (cur > end) {
+		error("input underflow in rle");
+		return len;
+	}
+
+	while (1) {
+		size_t run = decode_varint(&cur);
+
+		if (cur > end) {
+			error("input underflow in rle");
+			return len;
+		}
+
+		if (!run)
+			break; /* empty run signals end */
+
+		curval = 1 - curval; /* flip 0/1 */
+		if (curval) {
+			/* we have a run of 1's; deliver them */
+			size_t i;
+			for (i = 0; i < run; i++)
+				fn(pos + i, data);
+		}
+		pos += run;
+	}
+
+	return cur - in;
+}
+
 static void do_dump(void)
 {
 	struct strbuf in = STRBUF_INIT;
@@ -219,7 +305,6 @@ static void do_dump(void)
 	/* read the bitmap for each commit */
 	while (remain) {
 		struct object_id oid;
-		struct ewah_bitmap *ewah;
 		ssize_t len;
 
 		if (remain < GIT_SHA1_RAWSZ) {
@@ -230,17 +315,9 @@ static void do_dump(void)
 		cur += GIT_SHA1_RAWSZ;
 		remain -= GIT_SHA1_RAWSZ;
 
-		ewah = ewah_new();
-		len = ewah_read_mmap(ewah, cur, remain);
-		if (len < 0) {
-			ewah_free(ewah);
-			goto out;
-		}
-
 		printf("%s\n", oid_to_hex(&oid));
-		ewah_each_bit(ewah, show_path, paths);
+		len = rle_each_bit((const unsigned char *)cur, remain, show_path, paths);
 
-		ewah_free(ewah);
 		cur += len;
 		remain -= len;
 	}
-- 
2.19.1.550.g7610f1eecb
