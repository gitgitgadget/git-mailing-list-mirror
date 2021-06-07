Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D03C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E6D61139
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 19:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFGTp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 15:45:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:48164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhFGTp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 15:45:56 -0400
Received: (qmail 25817 invoked by uid 109); 7 Jun 2021 19:44:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Jun 2021 19:44:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2485 invoked by uid 111); 7 Jun 2021 19:44:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Jun 2021 15:44:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Jun 2021 15:44:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] xdiff: use BUG(...), not xdl_bug(...)
Message-ID: <YL53AylIeN+YdOTA@coredump.intra.peff.net>
References: <patch-1.1-68bf1ba4d3-20210607T164305Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-68bf1ba4d3-20210607T164305Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 06:43:49PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The xdl_bug() function was introduced in
> e8adf23d1e (xdl_change_compact(): introduce the concept of a change
> group, 2016-08-22), let's use our usual BUG() function instead.
> 
> We'll now have meaningful line numbers if we encounter bugs in xdiff,
> and less code duplication.

Thanks, I think this is a good direction.

Back when that commit was originally done, we didn't include
git-compat-util.h in xdiff at all, so we couldn't rely on Git-specific
code (though I think BUG() did not even exist back then anyway!).

These days I think we're comfortable with the notion that there is no
active upstream for xdiff, so we'd not be likely to send our changes
anywhere (and thus dependencies on our helpers are not a problem). But
there is one complication: libgit2 uses xdiff, too, and has pulled in
our changes including xdl_bug().

I wondered if we could make it easier on them by keeping the change in
one spot. But doing:

  static void xdl_bug(const char *msg)
  {
	BUG("%s", msg);
  }

is not really helpful, as it loses the line numbers. I guess we could
do:

  #ifdef BUG
  #define xdl_bug(msg) BUG(msg)
  #else
  ...the current implementation
  #endif

But really, libgit2 could just as easily define their own BUG() as they
see fit. Whether it is called xdl_bug() or BUG() in the call-sites is
not really that important.

So I think this patch is fine in its current form.

-Peff
