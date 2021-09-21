Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DB5C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2F761245
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhIUDw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:52:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:51432 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhIUDw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:52:57 -0400
Received: (qmail 3426 invoked by uid 109); 21 Sep 2021 03:51:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:51:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27604 invoked by uid 111); 21 Sep 2021 03:51:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 23:51:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 23:51:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH 5/5] grep: store grep_source buffer as const
Message-ID: <YUlWwOY7MD3KUyWh@coredump.intra.peff.net>
References: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUlVZk1xXulAqdef@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our grep_buffer() function takes a non-const buffer, which is confusing:
we don't take ownership of nor write to the buffer.

This mostly comes from the fact that the underlying grep_source struct
in which we store the buffer uses non-const pointer. The memory pointed
to by the struct is sometimes owned by us (for FILE or OID sources), and
sometimes not (for BUF sources).

Let's store it as const, which lets us err on the side of caution (i.e.,
the compiler will warn us if any of our code writes to or tries to free
it).

As a result, we must annotate the one place where we do free it by
casting away the constness. But that's a small price to pay for the
extra safety and clarity elsewhere (and indeed, it already had a comment
explaining why GREP_SOURCE_BUF _didn't_ free it).

And then we can mark grep_buffer() as taking a const buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c | 9 ++++++---
 grep.h | 4 ++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 9603ac119d..14fe8a0fd2 100644
--- a/grep.c
+++ b/grep.c
@@ -1820,9 +1820,10 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs)
 
 	return grep_source_1(opt, gs, 0);
 }
 
-static void grep_source_init_buf(struct grep_source *gs, char *buf,
+static void grep_source_init_buf(struct grep_source *gs,
+				 const char *buf,
 				 unsigned long size)
 {
 	gs->type = GREP_SOURCE_BUF;
 	gs->name = NULL;
@@ -1832,9 +1833,9 @@ static void grep_source_init_buf(struct grep_source *gs, char *buf,
 	gs->driver = NULL;
 	gs->identifier = NULL;
 }
 
-int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
+int grep_buffer(struct grep_opt *opt, const char *buf, unsigned long size)
 {
 	struct grep_source gs;
 	int r;
 
@@ -1884,9 +1885,11 @@ void grep_source_clear_data(struct grep_source *gs)
 {
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_OID:
-		FREE_AND_NULL(gs->buf);
+		/* these types own the buffer */
+		free((char *)gs->buf);
+		gs->buf = NULL;
 		gs->size = 0;
 		break;
 	case GREP_SOURCE_BUF:
 		/* leave user-provided buf intact */
diff --git a/grep.h b/grep.h
index 128007db65..3cb8a83ae8 100644
--- a/grep.h
+++ b/grep.h
@@ -188,9 +188,9 @@ void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const
 void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
 void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
 void compile_grep_patterns(struct grep_opt *opt);
 void free_grep_patterns(struct grep_opt *opt);
-int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
+int grep_buffer(struct grep_opt *opt, const char *buf, unsigned long size);
 
 struct grep_source {
 	char *name;
 
@@ -201,9 +201,9 @@ struct grep_source {
 	} type;
 	void *identifier;
 	struct repository *repo; /* if GREP_SOURCE_OID */
 
-	char *buf;
+	const char *buf;
 	unsigned long size;
 
 	char *path; /* for attribute lookups */
 	struct userdiff_driver *driver;
-- 
2.33.0.1023.gc687d0d3c8
