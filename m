Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A29C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DFC2193E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgIVFAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:00:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:36466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgIVFAe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 01:00:34 -0400
Received: (qmail 13678 invoked by uid 109); 22 Sep 2020 05:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Sep 2020 05:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29192 invoked by uid 111); 22 Sep 2020 05:00:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Sep 2020 01:00:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Sep 2020 01:00:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] diff-highlight: correctly match blank lines for flush
Message-ID: <20200922050033.GA528837@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We try to flush the output from diff-highlight whenever we see a blank
line. That lets you see the output for each commit as soon as it is
generated, even if Git is still chugging away at a diff, or traversing
to find the next commit.

However, our "blank line" match checks length($_). That won't ever be
true, because we haven't chomped the line ending. As a result, we never
flush. Instead, let's use a simple regex which handles line endings in
with the end-of-line marker.

This has been broken since the initial version in 927a13fe87 (contrib:
add diff highlight script, 2011-10-18). Probably nobody noticed because:

  - most output is big enough, or comes fast enough, that it flushes
    anyway. And it can be difficult to notice the difference between
    "show a commit, then pause" and "pause, then show two commits". I
    only noticed because I was viewing "git log" output on a repo with a
    very slow textconv filter.

  - if stdout is going to the terminal (and not another pager like
    less), then the flush isn't necessary. So any manual testing would
    show it appearing to work.

You can easily see the difference with something like:

  echo '* diff=slow' >>.gitattributes
  git -c diff.slow.textconv='sleep 1; cat' \
      -c pager.log='diff-highlight | less' \
      log -p

That should generate one commit every second or so (more if it touches
multiple files), but without this patch it waits for many seconds before
generating several pages of output.

Signed-off-by: Jeff King <peff@peff.net>
---
I had this script for a few years before I sent the patch for contrib/.
This feature _did_ work at some point there, but I lost the "chomp" when
cleaning up the code for the list. :)

 contrib/diff-highlight/DiffHighlight.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index e2589922a6..376f577737 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -112,7 +112,7 @@ sub handle_line {
 	# Since we can receive arbitrary input, there's no optimal
 	# place to flush. Flushing on a blank line is a heuristic that
 	# happens to match git-log output.
-	if (!length) {
+	if (/^$/) {
 		$flush_cb->();
 	}
 }
-- 
2.28.0.1034.ge13a789063
