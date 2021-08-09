Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0BC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B73760FC2
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhHIWtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:49:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:42870 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhHIWtK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 18:49:10 -0400
Received: (qmail 3837 invoked by uid 109); 9 Aug 2021 22:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 22:48:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2992 invoked by uid 111); 9 Aug 2021 22:48:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 18:48:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 18:48:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/3] range-diff: use ssize_t for parsed "len" in
 read_patches()
Message-ID: <YRGw0FH3XciRGq5x@coredump.intra.peff.net>
References: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we iterate through the buffer containing git-log output, parsing
lines, we use an "int" to store the size of an individual line. This
should be a size_t, as we have no guarantee that there is not a
malicious 2GB+ commit-message line in the output.

Overflowing this integer probably doesn't do anything _too_ terrible. We
are not using the value to size a buffer, so the worst case is probably
an out-of-bounds read from before the array. But it's easy enough to
fix.

Note that we have to use ssize_t here, since we also store the length
result from parse_git_diff_header(), which may return a negative value
for error. That function actually returns an int itself, which has a
similar overflow problem, but I'll leave that for another day. Much
of the apply.c code uses ints and should be converted as a whole; in the
meantime, a negative return from parse_git_diff_header() will be
interpreted as an error, and we'll bail (so we can't handle such a case,
but given that it's likely to be malicious anyway, the important thing
is we don't have any memory errors).

Signed-off-by: Jeff King <peff@peff.net>
---
 range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 088db1b1ce..e731525e66 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -38,7 +38,7 @@ static int read_patches(const char *range, struct string_list *list,
 	struct patch_util *util = NULL;
 	int in_header = 1;
 	char *line, *current_filename = NULL;
-	int len;
+	ssize_t len;
 	size_t size;
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
-- 
2.33.0.rc1.475.g023efe0ae4
