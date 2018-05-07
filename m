Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6C71F42E
	for <e@80x24.org>; Mon,  7 May 2018 09:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEGJBN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 05:01:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:58556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751940AbeEGJBM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 05:01:12 -0400
Received: (qmail 759 invoked by uid 109); 7 May 2018 09:01:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 May 2018 09:01:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24815 invoked by uid 111); 7 May 2018 09:01:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 May 2018 05:01:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2018 05:01:10 -0400
Date:   Mon, 7 May 2018 05:01:10 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] Finish the conversion from die("BUG: ...") to
 BUG()
Message-ID: <20180507090109.GA367@sigill.intra.peff.net>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
 <cover.1525253892.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1525253892.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 02, 2018 at 11:38:13AM +0200, Johannes Schindelin wrote:

> The BUG() macro was introduced in this patch series:
> https://public-inbox.org/git/20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net
> 
> The second patch in that series converted one caller from die("BUG: ")
> to use the BUG() macro.
> 
> It seems that there was no concrete plan to address the same issue in
> the rest of the code base.

I had a plan; it was that people would convert these as they touched the
relevant areas. :)

I'm happy to see a mass-conversion, though.

> For that reason, the commit message contains the precise Unix shell
> invocation (GNU sed semantics, not BSD sed ones, because I know that the
> Git maintainer as well as the author of the patch introducing BUG() both
> use Linux and not macOS or any other platform that would offer a BSD
> sed). It should be straight-forward to handle merge
> conflicts/non-applying patches by simply re-running that command.

I suspect this could have been done with coccinelle, but it's definitely
not worth going back to re-do it now.

> Changes since v2:
> 
> - Avoided the entire discussion about the previous 2/6 (now dropped)
>   that prepared t1406 to handle SIGABRT by side-stepping the issue: the
>   ref-store test helper will no longer call abort() in BUG() calls but
>   exit with exit code 99 instead.

I actually think this should be a runtime flag in the environment, like
GIT_BUG_EXIT_CODE (and if not set, continue to abort). That can help if
you come across a BUG() in real Git code, but for some reason your
environment makes aborting a pain. For example, maybe you're debugging a
racy BUG() and don't want to generate a bunch of coredumps.

Or here's an interesting related case I came across a few months ago.
t6210 has a test that's known to segfault due to stack exhaustion. It's
marked test_expect_failure, so all is good, right?  Normally, yes, but
when I run the test suite inside our local Jenkins setup, it detects a
segfault in _any_ child process of the test runner and aborts the whole
thing. This is great as a belt-and-suspenders if we miss an unexpected
segfault, but is obviously annoying in this case.

Triggering BUG()s in the test suite, even inside an expect_failure,
would introduce the same headache. It would be nice if I could just do:

  GIT_BUG_EXIT_CODE=134 make test

to avoid it.  Possibly expect_failure should even set that
automatically.

I also suspect that nobody really needs to set a specific exit code.
Using 134 is enough to avoid all of the unpleasantness of SIGABRT, but
still enough to trigger test_must_fail to distinguish it from a non-BUG
death. The callers that intentionally trigger bugs probably ought to be
using test_expect_code to make sure they are hitting a BUG() and not
some other death, anyway.

So we could probably simplify it to something like this:

diff --git a/usage.c b/usage.c
index cdd534c9df..50651bed40 100644
--- a/usage.c
+++ b/usage.c
@@ -221,7 +221,11 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
 		snprintf(prefix, sizeof(prefix), "BUG: ");
 
 	vreportf(prefix, fmt, params);
-	abort();
+
+	if (git_env_bool("GIT_BUG_ABORT"), 1)
+		abort();
+	else
+		exit(134);
 }
 
 #ifdef HAVE_VARIADIC_MACROS

-Peff
