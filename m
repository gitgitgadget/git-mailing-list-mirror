Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F2931FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 06:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756163AbcK2Gvb (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 01:51:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:48258 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756010AbcK2Gv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 01:51:28 -0500
Received: (qmail 30208 invoked by uid 109); 29 Nov 2016 06:51:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 06:51:27 +0000
Received: (qmail 8102 invoked by uid 111); 29 Nov 2016 06:52:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 01:52:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 01:51:25 -0500
Date:   Tue, 29 Nov 2016 01:51:25 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 01:37:59AM -0500, Jeff King wrote:

>   2. Grep threads doing more complicated stuff that needs to take a
>      lock. You might try building with -fsanitize=thread to see if it
>      turns up anything.

I tried this and it didn't find anything useful. It complains about
multiple threads calling want_color() at the same time, which you can
silence with something like:

diff --git a/builtin/grep.c b/builtin/grep.c
index 2c727ef49..d48846f40 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -207,6 +207,12 @@ static void start_threads(struct grep_opt *opt)
 {
 	int i;
 
+	/*
+	 * trigger want_color() for its side effect of caching the result;
+	 * otherwise the threads will fight over setting the cache
+	 */
+	want_color(GIT_COLOR_AUTO);
+
 	pthread_mutex_init(&grep_mutex, NULL);
 	pthread_mutex_init(&grep_read_mutex, NULL);
 	pthread_mutex_init(&grep_attr_mutex, NULL);

But the problem persists even with that patch, so it is something else.
It may still be a threading problem; -fsanitize=thread isn't perfect. I
also couldn't get the stress-test to fail when compiled with it. But
that may simply mean that the timing of the resulting binary is changed
enough not to trigger the issue.

-Peff
