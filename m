Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C68C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F25B207BC
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgI0IkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:40:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:42390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgI0IkD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:40:03 -0400
Received: (qmail 29157 invoked by uid 109); 27 Sep 2020 08:40:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:40:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4070 invoked by uid 111); 27 Sep 2020 08:40:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:40:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:40:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: [PATCH v2 3/8] trailer: add interface for iterating over commit
 trailers
Message-ID: <20200927084001.GC2465761@coredump.intra.peff.net>
References: <20200927083933.GA2222823@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200927083933.GA2222823@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The trailer code knows how to parse out the trailers and re-format them,
but there's no easy way to iterate over the trailers (you can use
trailer_info, but you have to then do a bunch of extra parsing).

Let's add an iteration interface that makes this easy to do.

Signed-off-by: Jeff King <peff@peff.net>
---
 trailer.c | 36 ++++++++++++++++++++++++++++++++++++
 trailer.h | 45 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 68dabc2556..3f7391d793 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1183,3 +1183,39 @@ void format_trailers_from_commit(struct strbuf *out, const char *msg,
 	format_trailer_info(out, &info, opts);
 	trailer_info_release(&info);
 }
+
+void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
+{
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	strbuf_init(&iter->key, 0);
+	strbuf_init(&iter->val, 0);
+	opts.no_divider = 1;
+	trailer_info_get(&iter->info, msg, &opts);
+	iter->cur = 0;
+}
+
+int trailer_iterator_advance(struct trailer_iterator *iter)
+{
+	while (iter->cur < iter->info.trailer_nr) {
+		char *trailer = iter->info.trailers[iter->cur++];
+		int separator_pos = find_separator(trailer, separators);
+
+		if (separator_pos < 1)
+			continue; /* not a real trailer */
+
+		strbuf_reset(&iter->key);
+		strbuf_reset(&iter->val);
+		parse_trailer(&iter->key, &iter->val, NULL,
+			      trailer, separator_pos);
+		unfold_value(&iter->val);
+		return 1;
+	}
+	return 0;
+}
+
+void trailer_iterator_release(struct trailer_iterator *iter)
+{
+	trailer_info_release(&iter->info);
+	strbuf_release(&iter->val);
+	strbuf_release(&iter->key);
+}
diff --git a/trailer.h b/trailer.h
index 203acf4ee1..cd93e7ddea 100644
--- a/trailer.h
+++ b/trailer.h
@@ -2,8 +2,7 @@
 #define TRAILER_H
 
 #include "list.h"
-
-struct strbuf;
+#include "strbuf.h"
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -103,4 +102,46 @@ void trailer_info_release(struct trailer_info *info);
 void format_trailers_from_commit(struct strbuf *out, const char *msg,
 				 const struct process_trailer_options *opts);
 
+/*
+ * An interface for iterating over the trailers found in a particular commit
+ * message. Use like:
+ *
+ *   struct trailer_iterator iter;
+ *   trailer_iterator_init(&iter, msg);
+ *   while (trailer_iterator_advance(&iter))
+ *      ... do something with iter.key and iter.val ...
+ *   trailer_iterator_release(&iter);
+ */
+struct trailer_iterator {
+	struct strbuf key;
+	struct strbuf val;
+
+	/* private */
+	struct trailer_info info;
+	size_t cur;
+};
+
+/*
+ * Initialize "iter" in preparation for walking over the trailers in the commit
+ * message "msg". The "msg" pointer must remain valid until the iterator is
+ * released.
+ *
+ * After initializing, note that key/val will not yet point to any trailer.
+ * Call advance() to parse the first one (if any).
+ */
+void trailer_iterator_init(struct trailer_iterator *iter, const char *msg);
+
+/*
+ * Advance to the next trailer of the iterator. Returns 0 if there is no such
+ * trailer, and 1 otherwise. The key and value of the trailer can be
+ * fetched from the iter->key and iter->value fields (which are valid
+ * only until the next advance).
+ */
+int trailer_iterator_advance(struct trailer_iterator *iter);
+
+/*
+ * Release all resources associated with the trailer iteration.
+ */
+void trailer_iterator_release(struct trailer_iterator *iter);
+
 #endif /* TRAILER_H */
-- 
2.28.0.1127.ga65787d918

