Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A4C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F57364E56
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhBIRBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:01:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:55100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233065AbhBIRBm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:01:42 -0500
Received: (qmail 27057 invoked by uid 109); 9 Feb 2021 17:00:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 17:00:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7778 invoked by uid 111); 9 Feb 2021 17:00:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 12:00:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 12:00:57 -0500
From:   Jeff King <peff@peff.net>
To:     Dominick Latreille <dominick.latreille@ubisoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: The argument "--recurse-submodules=no" when doing "fetch --all"
 is not passed to the following commands which can ends up fetching
 submodules
Message-ID: <YCK/yfrDQ3LXP3ec@coredump.intra.peff.net>
References: <DM5PR1701MB1724CCBB1AC5CF342BA9ADD5898E9@DM5PR1701MB1724.namprd17.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR1701MB1724CCBB1AC5CF342BA9ADD5898E9@DM5PR1701MB1724.namprd17.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 04:35:58PM +0000, Dominick Latreille wrote:

> Here is the command I ran to trigger this issue
> ```
> GIT_TRACE2=1 git fetch --all --recurse-submodules=no
> ```
> 
> I expected the submodules to not be fetched and to see this command with traces activated
> ```
> git fetch --append --no-auto-gc --recurse-submodules=no --no-write-commit-graph origin
> ```
> 
> But, here is the command line I got with traces activated and the submodules were fetched later on.
> ```
> git fetch --append --no-auto-gc --no-write-commit-graph origin
> ```

The issue is that "fetch --all" runs fetch sub-processes (one for each
remote), and tries to copy its arguments to them. But it does so by
looking at what it parsed and trying to recreate the relevant set of
original arguments.

And it looks like when this was added way back in 7dce19d374
(fetch/pull: Add the --recurse-submodules option, 2010-11-12), it was
not anticipated that somebody would need to turn recursion _off_. :) Of
course it makes perfect sense if somebody later switches the default to
on-demand. :)

So the solution is probably:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 91f3d20696..cb59f79157 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1660,6 +1660,8 @@ static void add_options_to_argv(struct strvec *argv)
 		strvec_push(argv, "--recurse-submodules");
 	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
 		strvec_push(argv, "--recurse-submodules=on-demand");
+	else if (recurse_submodules == RECURSE_SUBMODULES_OFF)
+		strvec_push(argv, "--recurse-submodules=no");
 	if (tags == TAGS_SET)
 		strvec_push(argv, "--tags");
 	else if (tags == TAGS_UNSET)

but there are a bunch of other RECURSE_SUBMODULES_* values. I have no
idea if any of those should be covered, too.

-Peff
