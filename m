Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582462036B
	for <e@80x24.org>; Fri,  6 Oct 2017 07:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdJFHjR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 03:39:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:34866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750815AbdJFHjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 03:39:16 -0400
Received: (qmail 15264 invoked by uid 109); 6 Oct 2017 07:39:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 07:39:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3487 invoked by uid 111); 6 Oct 2017 07:39:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 03:39:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 03:39:14 -0400
Date:   Fri, 6 Oct 2017 03:39:14 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Git Users <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Regression in 'git branch -m'?
Message-ID: <20171006073913.yavdbdd3p3y5vjhd@sigill.intra.peff.net>
References: <20171005172552.GA11497@inner.h.apk.li>
 <20171005183303.f77dpkhs5ztxlmyv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005183303.f77dpkhs5ztxlmyv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 02:33:03PM -0400, Jeff King wrote:

> Looks like 31824d180d (branch: fix branch renaming not updating HEADs
> correctly, 2017-08-24). This is in v2.15.0-rc0, so we should figure it
> out before the upcoming release.
> 
> I didn't dig very far, but it looks like the branch name is important
> "foo" doesn't trigger the problem but "master/master" does. "master/foo"
> also does, but "foo/master" does not. So I suspect it's something about
> how resolve_ref handles the failure when it would not be able to create
> the ref because of the d/f conflict. So it's probably related to losing
> the RESOLVE_REF_READING in the final hunk of that patch. That's just a
> guess for now, though.

I got a chance to look at this again. I think the root of the problem is
that resolve_ref() as it is implemented now is just totally unsuitable
for asking the question "what does this symbolic link point to?".

Because you end up with either:

  1. If we pass RESOLVE_REF_READING, then we do not return the target
     refname for orphaned commits (which is why 31824d180d dropped it).

  2. If not, then we do not return the target refname for commits with
     names that are not available for writing. The d/f conflict here is
     one example, but there may be others.

So I think we need to teach resolve_ref() a new mode that's like
"reading", but just follows the symref chain.

In the meantime, here's a test which shows off the regression.

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3ac7ebf85f..503a88d029 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -117,6 +117,16 @@ test_expect_success 'git branch -m bbb should rename checked out branch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'renaming checked out branch works with d/f conflict' '
+	test_when_finished "git branch -D foo/bar || git branch -D foo" &&
+	test_when_finished git checkout master &&
+	git checkout -b foo &&
+	git branch -m foo/bar &&
+	git symbolic-ref HEAD >actual &&
+	echo refs/heads/foo/bar >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
 	git branch o/o &&
 	git branch o/p &&

-Peff
