Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22371F97E
	for <e@80x24.org>; Mon, 29 Jul 2019 10:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfG2KHr (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 06:07:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:53896 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726358AbfG2KHq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 06:07:46 -0400
Received: (qmail 21682 invoked by uid 109); 29 Jul 2019 10:07:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 10:07:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26984 invoked by uid 111); 29 Jul 2019 10:09:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 06:09:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 06:07:45 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: Warnings in gc.log can prevent gc --auto from running
Message-ID: <20190729100745.GA2755@sigill.intra.peff.net>
References: <qhdnuh$5m5r$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qhdnuh$5m5r$1@blaine.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 07:18:57PM -0700, Gregory Szorc wrote:

> I think I've found some undesirable behavior with regards to the
> behavior of `git gc --auto`. The tl;dr is that a warning message written
> to gc.log can result in `git gc --auto` effectively disabling itself for
> gc.logExpiry. The problem is easier to trigger in 2.22 as a result of
> enabling bitmap indices for bare repositories by default and the
> behavior can easily result in performance degradation, especially on
> servers.

Yuck, thanks for reporting this.

As you note, this is a special case of a much larger problem. The other
common case is the "oops, you still have a lot of loose objects after
repacking" warning. There's more discussion and some patches here:

  https://public-inbox.org/git/20180716172717.237373-1-jonathantanmy@google.com/

though I don't think any of the work that came out of that fundamentally
solves the issue.

> I don't prescribe to know the best way to solve this problem. I just
> know it is a footgun sitting in the default Git configuration. And the
> footgun became a lot easier to fire with the introduction of warning
> messages related to bitmap indices and again when bitmap indices were
> enabled by default for bare repositories in Git 2.22.

IMHO one way to mitigate this is to simply warn less. In particular, if
we are auto-enabling bitmaps, then it doesn't necessarily make sense for
us to warn about them being disabled.

In the case of .keep files, we've already got 7328482253 (repack:
disable bitmaps-by-default if .keep files exist, 2019-06-29), which
should be in the next released version of Git. But I suspect that's
racy with respect to somebody creating .keep files, and as you note
there are other config options that might prevent us from generating
bitmaps.

Instead, it may make sense to turn the --write-bitmap-index option of
pack-objects into a tri-state: true/false/auto. Then pack-objects would
know that we are in best-effort mode, and would avoid warning in that
case. That would also let git-repack express its intentions better to
git-pack-objects, so we could replace 7328482253, and keep more of the
logic in pack-objects, which is ultimately what has to make the decision
about whether it can generate bitmaps.

-Peff
