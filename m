Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A572020966
	for <e@80x24.org>; Wed,  5 Apr 2017 20:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755533AbdDEUKB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 16:10:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:57157 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755400AbdDEUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 16:09:59 -0400
Received: (qmail 16003 invoked by uid 109); 5 Apr 2017 20:09:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Apr 2017 20:09:57 +0000
Received: (qmail 18945 invoked by uid 111); 5 Apr 2017 20:10:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Apr 2017 16:10:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Apr 2017 16:09:55 -0400
Date:   Wed, 5 Apr 2017 16:09:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 1/2] string-list: use ALLOC_GROW macro when reallocing
 string_list
Message-ID: <20170405200954.jmjvuzwjploenbho@sigill.intra.peff.net>
References: <20170405195600.54801-1-git@jeffhostetler.com>
 <20170405195600.54801-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170405195600.54801-2-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2017 at 07:55:59PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Use ALLOC_GROW() macro when reallocing a string_list array
> rather than simply increasing it by 32.  This is a performance
> optimization.
> 
> During status on a very large repo and there are many changes,
> a significant percentage of the total run time was spent
> reallocing the wt_status.changes array.
> 
> This change decreased the time in wt_status_collect_changes_worktree()
> from 125 seconds to 45 seconds on my very large repository.

Oof. Looks like the original was quadratic. I'm surprised this didn't
bite us more often. I guess we don't usually use string-lists for big
lists.

Aside from the redundant size-check that Stefan pointed out, the patch
looks obviously correct. I grepped for "alloc +=" and "alloc =.*+' to
see if there were any other cases, but didn't find any. Obviously that
is dependent on calling the variable "alloc", but that is normal for us
(and it does turn up a number of cases that do allocate correctly).

-Peff
