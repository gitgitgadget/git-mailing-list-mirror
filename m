Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B76AC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038A722211
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgIYHCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:02:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:40424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgIYHCu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 03:02:50 -0400
Received: (qmail 13156 invoked by uid 109); 25 Sep 2020 07:02:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 07:02:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15967 invoked by uid 111); 25 Sep 2020 07:02:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 03:02:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 03:02:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/8] trailer: add interface for iterating over commit trailers
Message-ID: <20200925070249.GC62741@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
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
 trailer.h | 44 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 78 insertions(+), 2 deletions(-)

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
index 203acf4ee1..af9949363a 100644
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
@@ -103,4 +102,45 @@ void trailer_info_release(struct trailer_info *info);
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
+ * After initializing, we are not yet pointing
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
2.28.0.1085.g44a0350633

