Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20148C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DE820781
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHMPy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:54:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:57878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMPy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:54:27 -0400
Received: (qmail 20308 invoked by uid 109); 13 Aug 2020 15:54:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 15:54:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15065 invoked by uid 111); 13 Aug 2020 15:54:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 11:54:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 11:54:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] UNLEAK style fixes
Message-ID: <20200813155426.GA896769@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although we introduced UNLEAK() long ago, I don't know that anybody has
really made a concerted effort to annotate enough variables to make
running a leak-checker useful. So I haven't paid too much attention to
its use.

But a few people have added some annotations, and I think some of them
aren't great examples. So I decided to clean them up. This by definition
has no impact on regular builds (since UNLEAK is a noop there), but even
in leak-checking builds should give no behavior change.

Another category that I was tempted to change is when variables _could_
be freed, but we just don't bother to do so. E.g., at the end of
bugreport.c, we have:

  UNLEAK(buffer);
  UNLEAK(report_path);
  return !!launch_editor(report_path.buf, NULL, NULL);

Using UNLEAK(report_path) makes sense; we can't free it because we're
passing it to a function that runs until program end. But we _could_
free "buffer" here, which isn't otherwise used again (i.e., that could
be strbuf_release() instead of UNLEAK).

But that does have a run-time cost (we'd actually free the memory, even
though we could just exit and let the OS handle it). My guess is that
it's not a measurable cost, and the code might be cleaner to actually
clean up instead of sprinkling more UNLEAKs around. But until we're
actually pushing forward with a real effort to get a leak-checker
running clean, I don't see much point in doing one or the other.

(As a side note, if we want to declare UNLEAK() a failure because nobody
cares enough to really use it, I'm OK with that, too).

  [1/2]: stop calling UNLEAK() before die()
  [2/2]: ls-remote: simplify UNLEAK() usage

 bugreport.c         | 4 +---
 builtin/ls-remote.c | 8 +++-----
 midx.c              | 8 ++------
 3 files changed, 6 insertions(+), 14 deletions(-)

-Peff
