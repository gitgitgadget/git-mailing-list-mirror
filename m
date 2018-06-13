Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1BF41F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935777AbeFMVFO (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:05:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:43680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S935448AbeFMVFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:05:12 -0400
Received: (qmail 4484 invoked by uid 109); 13 Jun 2018 21:05:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Jun 2018 21:05:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6356 invoked by uid 111); 13 Jun 2018 21:05:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Jun 2018 17:05:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jun 2018 17:05:10 -0400
Date:   Wed, 13 Jun 2018 17:05:10 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Takuto Ikuta <tikuta@chromium.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: test explicitly that --all can fetch tag
 references pointing to non-commits
Message-ID: <20180613210509.GA15574@sigill.intra.peff.net>
References: <20180612185413.GA21856@deco.navytux.spb.ru>
 <20180613111840.1427-1-kirr@nexedi.com>
 <xmqqbmce7fcm.fsf@gitster-ct.c.googlers.com>
 <20180613184301.GB22854@deco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613184301.GB22854@deco.navytux.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 06:43:04PM +0000, Kirill Smelkov wrote:

> From: Kirill Smelkov <kirr@nexedi.com>
> Date: Wed, 13 Jun 2018 12:28:21 +0300
> Subject: [PATCH v2] fetch-pack: test explicitly that --all can fetch tag
>  references pointing to non-commits
> 
> Fetch-pack --all became broken with respect to unusual tags in
> 5f0fc64513 (fetch-pack: eliminate spurious error messages, 2012-09-09),
> and was fixed only recently in e9502c0a7f (fetch-pack: don't try to fetch
> peel values with --all, 2018-06-11). However the test added in
> e9502c0a7f does not explicitly cover all funky cases.
> 
> In order to be sure fetching funky tags will never break, let's
> explicitly test all relevant cases with 4 tag objects pointing to 1) a
> blob, 2) a tree, 3) a commit, and 4) another tag objects. The referenced
> tag objects themselves are referenced from under regular refs/tags/*
> namespace. Before e9502c0a7f `fetch-pack --all` was failing e.g. this way:
> 
>         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git ls-remote ..
>         44085874...        HEAD
>         ...
>         bc4e9e1f...        refs/tags/tag-to-blob
>         038f48ad...        refs/tags/tag-to-blob^{}	# peeled
>         520db1f5...        refs/tags/tag-to-tree
>         7395c100...        refs/tags/tag-to-tree^{}	# peeled
> 
>         .../git/t/trash directory.t5500-fetch-pack/fetchall$ git fetch-pack --all ..
>         fatal: A git upload-pack: not our ref 038f48ad...
>         fatal: The remote end hung up unexpectedly

TBH, I do not find this snippet all that compelling. We know that
e9502c0a7f already fixed the bug, and that it had nothing to do with
non-commits at all.

The primary reason to add these tests is that in general we do not cover
fetch-pack over tags to non-commits. And I think the reason to use
otherwise unreferenced objects is that it they are more likely to have
detectable symptoms if they tickle a bug.

So why don't we say that, instead of re-hashing output from the earlier
fix?

-Peff
