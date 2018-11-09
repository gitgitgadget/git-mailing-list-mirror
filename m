Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DDCE1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 19:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeKJFll (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 00:41:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:46518 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725788AbeKJFll (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 00:41:41 -0500
Received: (qmail 28413 invoked by uid 109); 9 Nov 2018 19:59:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Nov 2018 19:59:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22015 invoked by uid 111); 9 Nov 2018 19:58:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Nov 2018 14:58:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2018 14:59:34 -0500
Date:   Fri, 9 Nov 2018 14:59:34 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] built-in rebase: reinstate `checkout -q` behavior
 where appropriate
Message-ID: <20181109195934.GC4938@sigill.intra.peff.net>
References: <pull.72.git.gitgitgadget@gmail.com>
 <070092b4309e5e74e3a1b3be54613cccf26e97da.1541756054.git.gitgitgadget@gmail.com>
 <20181109101148.GB7410@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1811091813140.39@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 06:21:41PM +0100, Johannes Schindelin wrote:

> Actually, you got me thinking about the desc.buffer. And I think there is
> one corner case where it could cause a problem: `struct tree_desc desc[2]`
> does not initialize the buffers to NULL. And what if
> fill_tree_descriptor() function returns NULL? Then the buffer is still
> uninitialized.
> 
> In practice, our *current* version of fill_tree_descriptor() never returns
> NULL if the oid parameter is non-NULL. It would die() in the error case
> instead (bad!). So to prepare for a less bad version, I'd rather
> initialize the `desc` array and be on the safe (and easier to reason
> about) side.

Yeah, I agree with all of that.

One solution would just be to increment only after success:

  if (fill_tree_descriptor(&desc[nr], ..) < 0)
	goto error;
  nr++; /* now we know it's valid! */

But there are lots of alternatives.  :)

-Peff
