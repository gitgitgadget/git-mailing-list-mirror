Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D3BC433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7113561585
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhC2LVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 07:21:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:35344 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhC2LU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 07:20:56 -0400
Received: (qmail 10290 invoked by uid 109); 29 Mar 2021 11:20:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Mar 2021 11:20:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12698 invoked by uid 111); 29 Mar 2021 11:20:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Mar 2021 07:20:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Mar 2021 07:20:55 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 01/16] builtin/multi-pack-index.c: inline 'flags' with
 options
Message-ID: <YGG4F+TmtBC/WZmb@coredump.intra.peff.net>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <43fc0ad276406ff77283613c45188e102a6dc515.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43fc0ad276406ff77283613c45188e102a6dc515.1615482270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:04:36PM -0500, Taylor Blau wrote:

> Subcommands of the 'git multi-pack-index' command (e.g., 'write',
> 'verify', etc.) will want to optionally change a set of shared flags
> that are eventually passed to the MIDX libraries.
> 
> Right now, options and flags are handled separately. Inline them into
> the same structure so that sub-commands can more easily share the
> 'flags' data.

This "opts" struct is kind of funny. It is used to collect the options
in cmd_multi_pack_index(), but nobody ever passes it anywhere! Instead,
we pass individual components of it around.

So I'm not sure I buy "...so that sub-commands can more easily share the
flags data", since either way they are all receiving the individual
flags field already. And your patch 2 could just as easily do the same
simplification by modifying the function-local "flags" variable.

But. I think things get more interesting when you later introduce
common_opts, because now those options have to refer back to actuals
storage for each item. Which means that "flags" would have to become a
global variable. And there it's nicer to have all of the options stuffed
into a struct, even if it is a single global struct.

So I think this is the right direction, but it took me a minute to
realize quite why.

-Peff
