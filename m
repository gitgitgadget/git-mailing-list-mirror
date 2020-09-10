Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13461C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C044521D40
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgIJSI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:08:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:53720 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgIJSIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 14:08:16 -0400
Received: (qmail 22724 invoked by uid 109); 10 Sep 2020 18:08:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 18:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21861 invoked by uid 111); 10 Sep 2020 18:08:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 14:08:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 14:08:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] quote_path: code clarification
Message-ID: <20200910180814.GA1917207@coredump.intra.peff.net>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
 <20200910170159.1278781-5-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910170159.1278781-5-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 10:01:56AM -0700, Junio C Hamano wrote:

> Instead we can scan the path upfront to see if the input has SP in
> it.  If so, we tell quote_c_style_counted() not to enclose its
> output in a dq-pair, and we add a dq-pair ourselves.  Whether the
> input had bytes that quote_c_style_counted() uses backslash quoting,
> this would give us a desired quoted string.  If the input does not
> have SP in it, we just let quote_c_style_counted() do its thing as
> usual, which would enclose the result in a dq-pair only when needed.

Nice. I think the result is easier to follow than the original, not to
mention more efficient. And the fact that we didn't need to touch
quote_c_style_counted() is the cherry on top.

> +	int force_dq = ((flags & QUOTE_PATH_QUOTE_SP) && strchr(rel, ' '));
> [...]
> +	quote_c_style_counted(rel, strlen(rel), out, NULL, !!force_dq);

I think force_dq is already normalized to 0/1 by the &&, so we wouldn't
need the "!!" here.

-Peff
