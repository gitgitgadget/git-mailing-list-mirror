Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A350DC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED4C2077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgDCTvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:51:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:32808 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728151AbgDCTvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 15:51:05 -0400
Received: (qmail 30402 invoked by uid 109); 3 Apr 2020 19:51:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 19:51:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22789 invoked by uid 111); 3 Apr 2020 20:01:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 16:01:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 15:51:03 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200403195103.GA663412@coredump.intra.peff.net>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
 <20200403183057.GA659224@coredump.intra.peff.net>
 <20200403184933.GA57202@syl.local>
 <20200403193842.GA7859@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200403193842.GA7859@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 03, 2020 at 09:38:42PM +0200, SZEDER Gábor wrote:

> > > Can you explain more why the old behavior is a problem?
> 
> Because when I do:
> 
>    # sometimes I forgot that refs are not good...
>    $ echo HEAD | git commit-graph write --stdin-commits
> 
> then I get _nothing_: neither an error, nor a commit-graph.

OK, that makes more sense: it's an input format error, because we only
take hex oids.

Do you care about complaining about:

  git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits

? That's the case that's much more interesting, I think.

> Or introduce 'git commit-graph write --stdin-refs'?  Or teach
> '--stdin-commits' to DWIM and accept and parse refs?  Though the
> question still remains what to do with refs that can't be peeled back
> to commits

Right. I think there are two orthogonal questions:

  - whether to resolve arbitrary names to objects and how to handle such
    input if we don't

  - what to do with an oid (whether given as hex or resolved from a
    name) that isn't a commit-ish

-Peff
