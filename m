Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCCBF20248
	for <e@80x24.org>; Thu,  7 Mar 2019 19:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCGT47 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 14:56:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:43056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726200AbfCGT47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 14:56:59 -0500
Received: (qmail 6791 invoked by uid 109); 7 Mar 2019 19:56:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 19:56:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27170 invoked by uid 111); 7 Mar 2019 19:57:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 14:57:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 14:56:57 -0500
Date:   Thu, 7 Mar 2019 14:56:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Joey Hess <id@joeyh.name>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] convert: avoid malloc of original file size
Message-ID: <20190307195657.GA29776@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joey Hess <id@joeyh.name>

We write the output of a "clean" filter into a strbuf. Rather than
growing the strbuf dynamically as we read its output, we make the
initial allocation as large as the original input file. This is a good
guess when the filter is just tweaking a few bytes, but it's disastrous
when the point of the filter is to condense a very large file into a
short identifier (e.g., the way git-lfs and git-annex do). We may ask to
allocate many gigabytes, causing the allocation to fail and Git to
die().

Instead, let's just let strbuf do its usual growth.

When the clean filter does output something around the same size as the
worktree file, the buffer will need to be reallocated until it fits,
starting at 8192 and doubling in size. Benchmarking indicates that
reallocation is not a significant overhead for outputs up to a
few MB in size.

Signed-off-by: Joey Hess <id@joeyh.name>
Signed-off-by: Jeff King <peff@peff.net>
---
This is a resurrection of the patch from:

  https://public-inbox.org/git/20190122220714.GA6176@kitenet.net/

It got stalled on discussion of the commit message, which I've rewritten
here to match the suggestions in the thread.

As discussed there, I do think this only solves half the problem, as the
smudge filter has the same issue in reverse. That's more complicated to
fix, and AFAIK nobody is working on it. But I don't think there's any
reason not to pick up this part in the meantime.

 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 5d0307fc10..94ff837649 100644
--- a/convert.c
+++ b/convert.c
@@ -731,7 +731,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 	if (start_async(&async))
 		return 0;	/* error was already reported */
 
-	if (strbuf_read(&nbuf, async.out, len) < 0) {
+	if (strbuf_read(&nbuf, async.out, 0) < 0) {
 		err = error(_("read from external filter '%s' failed"), cmd);
 	}
 	if (close(async.out)) {
-- 
2.21.0.787.g929e938557
