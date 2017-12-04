Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C8C520954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbdLDVdx (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:33:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752073AbdLDVdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:33:52 -0500
Received: (qmail 9850 invoked by uid 109); 4 Dec 2017 21:33:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 21:33:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26957 invoked by uid 111); 4 Dec 2017 21:34:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 16:34:12 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 16:33:50 -0500
Date:   Mon, 4 Dec 2017 16:33:50 -0500
From:   Jeff King <peff@peff.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, nico@cam.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] progress: print progress output for all operations
 taking longer than 2s
Message-ID: <20171204213350.GA21552@sigill.intra.peff.net>
References: <20171204203647.30546-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171204203647.30546-1-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 04, 2017 at 09:36:47PM +0100, lars.schneider@autodesk.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> In 180a9f2 we implemented a progress API which suppresses the progress
> output if the progress has reached a specified percentage threshold
> within a given time frame. In 8aade10 we simplified the API and set the
> threshold to 0% and the time frame to 2 seconds for all delayed progress
> operations. That means we would only see a progress output if we still
> have 0% progress after 2 seconds. Consequently, only operations that
> have a very slow start would show the progress output at all.
> 
> Remove the threshold entirely and print the progress output for all
> operations that take longer than 2 seconds.

Good catch.

I was surprised at first to see 8aade10 as the culprit here, because it
was supposed to be a mechanical conversion. I.e.:

  start_progress_delay("foo", 0, 0, 2);
  start_progress_delay("bar", nr, 50, 1);

would both call the wrapper with a 0-percent delay threshold.

And now call sites like the first one still works, but the second one is
broken.

The problem is that commit got the meaning of the threshold parameter
totally backwards. It is "only show progress if we have not gotten past
this percent". Which means that passing "0" is nonsense, as you
discovered.

But wait, why did we have all those calls using "0" in the first place,
and why did they work? The answer is that we can only look at the
threshold at all when we know the total, since otherwise we can't
compute a percentage. So that first call should logically have been:

  start_progress_delay("foo", 0, 100, 2);

I.e., 100% to indicate that we always show the progress after 2 seconds
regardless. But since our total was "0", we never looked at the
threshold at all. But they misled us into thinking that "0" was the way
to say "always show this progress after 2 seconds".

So the minimal fix is actually:

diff --git a/progress.c b/progress.c
index 289678d43d..b774cb1cd1 100644
--- a/progress.c
+++ b/progress.c
@@ -229,7 +229,7 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
 
 struct progress *start_delayed_progress(const char *title, unsigned total)
 {
-	return start_progress_delay(title, total, 0, 2);
+	return start_progress_delay(title, total, 100, 2);
 }
 
 struct progress *start_progress(const char *title, unsigned total)

That keeps "start_progress_delay" functioning properly, but makes
callers of the wrapper use a sane threshold.

That said, after 8aade10 there are literally no callers that use a
threshold other than what is set here. So we could just rip out the
"threshold" feature entirely, which is what your patch is doing.

I'm OK with that route, but I think we would want to explain that
decision in the commit message a bit better.

> a few weeks ago I was puzzled why the progress output is not shown in
> certain situations [1]. I debugged the issue a bit today and came up
> with this patch as solution. It is entirely possible that I misunderstood
> the intentions of the progress API and therefore my patch is bogus.
> In this case, please treat this email as RFC.

No, I think 8aade10 misunderstood the progress API. ;)

-Peff
