Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF771F462
	for <e@80x24.org>; Thu, 30 May 2019 12:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfE3MEo (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 08:04:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:42196 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726806AbfE3MEn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 08:04:43 -0400
Received: (qmail 967 invoked by uid 109); 30 May 2019 12:04:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 May 2019 12:04:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4032 invoked by uid 111); 30 May 2019 12:05:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 May 2019 08:05:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 May 2019 08:04:41 -0400
Date:   Thu, 30 May 2019 08:04:41 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 00/52] fix some -Wmissing-field-initializer warnings
Message-ID: <20190530120441.GD31607@sigill.intra.peff.net>
References: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
 <0f1c5a49-f971-848d-700e-9c124ae8e617@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f1c5a49-f971-848d-700e-9c124ae8e617@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 30, 2019 at 10:47:37AM +0200, Johannes Sixt wrote:

> I had a brief look at the series. IMO, it is a mistake to appease
> -Wmissing-field-initializer.
> 
> We have two sorts of initializers:
> 
>  - zero initializers: they just want to null out every field,
>    like CHILD_PROCESS_INIT and ad-hoc initializers of structs
>    such as xpparam_t pp = { 0 }; in range-diff.c
> 
>  - value initializers are always macros, such as STRING_LIST_INIT_DUP
>    and the OPT_* family.
> 
> I am strongly against forcing zero initializers to write down a value
> for every field. It is much more preferable to depend on that the
> compiler does the right thing with them. -Wmissing-field-initializer
> would provide guidance in the wrong direction. A zero initializer looks
> like this: = { 0 }; and nothing else.

I had a similar impression while perusing the commits. I don't mind
forcing some extra work on programmers to appease a warning if
disregarding it is a common source of errors. But I didn't see any real
bug-fixes in the series, so it doesn't seem like that good a tradeoff to
me.

Contrast that with the -Wunused-parameters warning. I found a dozen or
so actual bugs by sifting through the results, and another couple dozen
spots where the code could be cleaned up or simplified. If we want to
shut up the warning completely (so we can pay attention to it), we'll
then have to annotate probably a couple hundred spots, and keep those
annotations up to date. But I feel better doing that knowing that it's
shown real-world value.

-Peff
