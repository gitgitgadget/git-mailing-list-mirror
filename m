Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F861F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfKGGk7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:40:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41726 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726094AbfKGGk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:40:59 -0500
Received: (qmail 29180 invoked by uid 109); 7 Nov 2019 06:40:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 06:40:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32375 invoked by uid 111); 7 Nov 2019 06:44:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:44:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 01:40:58 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, rynus@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
Message-ID: <20191107064058.GG6431@sigill.intra.peff.net>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
 <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
 <20191106040955.GD4307@sigill.intra.peff.net>
 <832b3b8b-63e6-1d32-0013-158b3c6725c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <832b3b8b-63e6-1d32-0013-158b3c6725c8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 08:21:48AM -0500, Derrick Stolee wrote:

> >> Now that we changed this method, very fast commands show no progess at
> >> all. This means we need to stop testing for seeing these progress lines
> >> in the test suite.
> > 
> > I think this is OK for now, though it does make me wonder if
> > "--progress" ought to perhaps override "delayed" in some instances,
> > since it's a positive signal from the caller that they're interested in
> > seeing progress.
> 
> I was thinking that we could start with a GIT_TEST_PROGRESS environment
> variable to force all delayed progress to act like non-delayed progress.
> That would at least give us confirmation on these kinds of tests.

I think this could actually be a non-test variable. E.g., something like
this:

diff --git a/progress.c b/progress.c
index 0063559aab..74b90e8898 100644
--- a/progress.c
+++ b/progress.c
@@ -14,6 +14,7 @@
 #include "strbuf.h"
 #include "trace.h"
 #include "utf8.h"
+#include "config.h"
 
 #define TP_IDX_MAX      8
 
@@ -269,7 +270,8 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 
 struct progress *start_delayed_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 2, 0);
+	int delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
+	return start_progress_delay(title, total, delay_in_secs, 0);
 }
 
 struct progress *start_progress(const char *title, uint64_t total)


which lets you ask for more verbose progress. There are times when I'd
use something like this for general debugging. Though these days I might
suggest that something like GIT_TRACE2_PERF hook the progress code to
output. That's a bit more complicated to implement, though.

-Peff
