Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20E4C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9488660FC2
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbhHIWsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:48:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:42854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhHIWsE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 18:48:04 -0400
Received: (qmail 3817 invoked by uid 109); 9 Aug 2021 22:47:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 22:47:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2951 invoked by uid 111); 9 Aug 2021 22:47:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 18:47:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 18:47:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 1/3] range-diff: drop useless "offset" variable from
 read_patches()
Message-ID: <YRGwjgAIyLPb7g50@coredump.intra.peff.net>
References: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "offset" variable was was introduced in 44b67cb62b (range-diff:
split lines manually, 2019-07-11), but it has never done anything
useful. We use it to count up the number of bytes we've consumed, but we
never look at the result. It was probably copied accidentally from an
almost-identical loop in apply.c:find_header() (and the point of that
commit was to make use of the parse_git_diff_header() function which
underlies both).

Because the variable was set but not used, most compilers didn't seem to
notice, but the upcoming clang-14 does complain about it, via its
-Wunused-but-set-variable warning.

Signed-off-by: Jeff King <peff@peff.net>
---
The for-loop with an empty initializer and a doubled post-loop operation
is a little funny to see. I didn't see an easy way to make it less ugly
(pushing the line/size initialization into the for() would work, but the
resulting line is awfully long).

 range-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index e9479794b4..551600c774 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -49,7 +49,7 @@ static int read_patches(const char *range, struct string_list *list,
 	struct patch_util *util = NULL;
 	int in_header = 1;
 	char *line, *current_filename = NULL;
-	int offset, len;
+	int len;
 	size_t size;
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
@@ -86,7 +86,7 @@ static int read_patches(const char *range, struct string_list *list,
 
 	line = contents.buf;
 	size = contents.len;
-	for (offset = 0; size > 0; offset += len, size -= len, line += len) {
+	for (; size > 0; size -= len, line += len) {
 		const char *p;
 
 		len = find_end_of_line(line, size);
-- 
2.33.0.rc1.475.g023efe0ae4

