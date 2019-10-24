Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D8A1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 23:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfJXXWJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 19:22:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:57700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726395AbfJXXWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 19:22:09 -0400
Received: (qmail 26530 invoked by uid 109); 24 Oct 2019 23:22:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Oct 2019 23:22:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6376 invoked by uid 111); 24 Oct 2019 23:25:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Oct 2019 19:25:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Oct 2019 19:22:07 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 02/23] parse_commit_buffer(): treat lookup_tree() failure
 as parse error
Message-ID: <20191024232207.GA32602@sigill.intra.peff.net>
References: <20191018044328.GB17879@sigill.intra.peff.net>
 <20191024231220.96547-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191024231220.96547-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 04:12:20PM -0700, Jonathan Tan wrote:

> > And
> > certainly we _have_ seen real-world cases, such as the one fixed by
> > 806278dead (commit-graph.c: handle corrupt/missing trees, 2019-09-05).
> > 
> > Note that we can't quite drop the check in the caller added by that
> > commit yet, as there's some subtlety with repeated parsings (which will
> > be addressed in a future commit).
> 
> I tried figuring out what the subtlety is by undoing the check you
> describe, and did get a segfault in one of the tests, but couldn't
> figure out exactly what is going on. Looking at the code, is it because
> load_tree_for_commit() in commit-graph.c uses the return value of
> lookup_tree() indiscriminately (which is the issue that this patch
> fixes)?
> 
> This patch itself and patch 1 looks good (with the reasoning in the
> commit message), of course.

It's the issue addressed in patch 4. The issue is that some _other_ code
already called parse_commit(), got an error, but then for whatever
reason ignored it. Now when we call parse_commit(), the "parsed" flag is
set, so it returns success even though the tree is still NULL.

That commit fixes the problem and does drop the extra tree check.

-Peff
