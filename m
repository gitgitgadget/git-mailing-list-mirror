Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9132C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1BB23A02
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgLIQNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:13:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:55586 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgLIQNN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 11:13:13 -0500
Received: (qmail 18172 invoked by uid 109); 9 Dec 2020 16:12:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 16:12:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16372 invoked by uid 111); 9 Dec 2020 16:12:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 11:12:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 11:12:32 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 1/3] quote: make sq_dequote_step() a public function
Message-ID: <X9D3cO+l2cYA9cB0@coredump.intra.peff.net>
References: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We provide a function for dequoting an entire string, as well as one for
handling a space-separated list of quoted strings. But there's no way
for a caller to parse a string like 'foo'='bar', even though it is easy
to generate one using sq_quote_buf() or similar.

Let's make the single-step function available to callers outside of
quote.c. Note that we do need to adjust its implementation slightly: it
insists on seeing whitespace between items, and we'd like to be more
flexible than that. Since it only has a single caller, we can move that
check (and slurping up any extra whitespace) into that caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c | 15 ++++++++++-----
 quote.h | 18 ++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/quote.c b/quote.c
index 69f4ca45da..8a3a5e39eb 100644
--- a/quote.c
+++ b/quote.c
@@ -116,7 +116,7 @@ void sq_append_quote_argv_pretty(struct strbuf *dst, const char **argv)
 	}
 }
 
-static char *sq_dequote_step(char *arg, char **next)
+char *sq_dequote_step(char *arg, char **next)
 {
 	char *dst = arg;
 	char *src = arg;
@@ -153,11 +153,8 @@ static char *sq_dequote_step(char *arg, char **next)
 			}
 		/* Fallthrough */
 		default:
-			if (!next || !isspace(*src))
+			if (!next)
 				return NULL;
-			do {
-				c = *++src;
-			} while (isspace(c));
 			*dst = 0;
 			*next = src;
 			return arg;
@@ -182,6 +179,14 @@ static int sq_dequote_to_argv_internal(char *arg,
 		char *dequoted = sq_dequote_step(next, &next);
 		if (!dequoted)
 			return -1;
+		if (next) {
+			char c;
+			if (!isspace(*next))
+				return -1;
+			do {
+				c = *++next;
+			} while (isspace(c));
+		}
 		if (argv) {
 			ALLOC_GROW(*argv, *nr + 1, *alloc);
 			(*argv)[(*nr)++] = dequoted;
diff --git a/quote.h b/quote.h
index 4b72a583cf..768cc6338e 100644
--- a/quote.h
+++ b/quote.h
@@ -42,12 +42,26 @@ void sq_quote_buf_pretty(struct strbuf *, const char *src);
 void sq_quote_argv_pretty(struct strbuf *, const char **argv);
 void sq_append_quote_argv_pretty(struct strbuf *dst, const char **argv);
 
-/* This unwraps what sq_quote() produces in place, but returns
+/*
+ * This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
- * produced.
+ * produced (the full string must be a single quoted item).
  */
 char *sq_dequote(char *);
 
+/*
+ * Like sq_dequote(), but dequote a single item, and leave "next" pointing to
+ * the next character. E.g., in the string:
+ *
+ *   'one' 'two' 'three'
+ *
+ * after the first call, the return value would be the unquoted string "one",
+ * with "next" pointing to the space between "one" and "two"). The caller is
+ * responsible for advancing the pointer to the start of the next item before
+ * calling sq_dequote_step() again.
+ */
+char *sq_dequote_step(char *src, char **next);
+
 /*
  * Same as the above, but can be used to unwrap many arguments in the
  * same string separated by space. Like sq_quote, it works in place,
-- 
2.29.2.1019.g5c4255ecd5

