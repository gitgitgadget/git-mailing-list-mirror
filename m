Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C077215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbcJLXyh (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:54:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:56785 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932872AbcJLXyg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:54:36 -0400
Received: (qmail 4834 invoked by uid 109); 12 Oct 2016 23:47:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 23:47:55 +0000
Received: (qmail 25466 invoked by uid 111); 12 Oct 2016 23:48:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 19:48:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2016 19:47:53 -0400
Date:   Wed, 12 Oct 2016 19:47:53 -0400
From:   Jeff King <peff@peff.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Shawn Pearce <spearce@spearce.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Huge performance bottleneck reading packs
Message-ID: <20161012234753.tbqhuc7qdyklpfzv@sigill.intra.peff.net>
References: <ea8db41f-2ea4-b37b-e6f8-1f1d428aea5d@oracle.com>
 <20161012230143.5kxcmtityaasra5j@sigill.intra.peff.net>
 <20161012231807.syockv2emrsjf55r@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161012231807.syockv2emrsjf55r@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 07:18:07PM -0400, Jeff King wrote:

> Also, is it possible to make the repository in question available? I
> might be able to reproduce based on your description, but it would save
> time if I could directly run gdb on your example.

I tried this by making a bunch of packs in linux.git (my standard "this
is pretty big" repo), like so:

  for i in $(seq 1000); do
    git rev-list --objects HEAD~$((i+1))..HEAD~$i |
    git pack-objects --delta-base-offset .git/objects/pack/pack
  done

and then doing a 25,000-object fetch from upstream (no significance to
the number; that's just how far behind upstream I happened to be).

However, I didn't notice any regression. In fact, it was much _slower_
than v1.9.0, because that older version didn't have threaded index-pack.

If you can't share the repo directly, can you tell us more about your
fetch? How many objects are in your repository? How many objects are
fetched? How many refs are there on the remote side?

-Peff
