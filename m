Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B08C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5309F223FB
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKBOnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 09:43:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:44544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKBOnf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 09:43:35 -0500
Received: (qmail 29983 invoked by uid 109); 2 Nov 2020 14:43:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Nov 2020 14:43:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18636 invoked by uid 111); 2 Nov 2020 14:43:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Nov 2020 09:43:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Nov 2020 09:43:21 -0500
From:   Jeff King <peff@peff.net>
To:     Sathyajith Bhat <sathya@sathyasays.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
Message-ID: <20201102144321.GA3962443@coredump.intra.peff.net>
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 03:59:59PM +0200, Sathyajith Bhat wrote:

> Simple repro steps
> 
>         mkdir git_segfault_test && cd git_segfault_test && echo
> "Hello" > hello.log
>         git init && git add hello.log && git commit -m "init commit"
> 
> Now, use git log to show commit logs using command
> 
>         git log  --follow -L 1,1:hello.log -- hello.log
> 
> What did you expect to happen? (Expected behavior)
> Git should not segfault

Thanks for making this reproduction recipe! I can easily see the problem
on my system. Looks like the segfault was introduced by a2bb801f6a
(line-log: avoid unnecessary full tree diffs, 2019-08-21). I've cc'd the
author.

That commit causes the line-log to clear the set of pathspecs, but the
--follow option requires exactly one pathspec (and it even makes sure
the user gives us one, but that happens before we clear it internally).
Something like this makes the segfault go away:

diff --git a/line-log.c b/line-log.c
index 42c5e41f68..f789863928 100644
--- a/line-log.c
+++ b/line-log.c
@@ -847,6 +847,7 @@ static void queue_diffs(struct line_log_data *range,
 		clear_pathspec(&opt->pathspec);
 		parse_pathspec_from_ranges(&opt->pathspec, range);
 	}
+	opt->flags.follow_renames = 0;
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
 	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
 	if (opt->detect_rename && diff_might_be_rename()) {

but I'm not clear on how "--follow" and "-L" are supposed to interact. I
wouldn't expect --follow to do anything at all with line-log (nor for it
to be useful to specify pathspecs outside of the -L option). So possibly
this is restoring the behavior prior to that commit, or possibly it's
just papering over a breakage. ;)

-Peff
