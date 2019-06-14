Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C3F1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 15:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfFNP1N (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 11:27:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:55216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725991AbfFNP1M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 11:27:12 -0400
Received: (qmail 16973 invoked by uid 109); 14 Jun 2019 15:27:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jun 2019 15:27:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27823 invoked by uid 111); 14 Jun 2019 15:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Jun 2019 11:27:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jun 2019 11:27:10 -0400
Date:   Fri, 14 Jun 2019 11:27:10 -0400
From:   Jeff King <peff@peff.net>
To:     Karen Arutyunov <karen@codesynthesis.com>
Cc:     git@vger.kernel.org
Subject: Re: advertised commit fetch using commit id fails
Message-ID: <20190614152710.GB22984@sigill.intra.peff.net>
References: <38030a81-73bc-f877-362a-3fd8018b5977@codesynthesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38030a81-73bc-f877-362a-3fd8018b5977@codesynthesis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 01:54:15PM +0300, Karen Arutyunov wrote:

> git 2.22, in contrast to previous versions, fails to fetch advertised commit
> using commit id:
>
> Is it a bug or advertised object semantics change?

This is working as designed, but the behavior is a rather tricky
historical case. The change you're seeing is due to 34066f0661 (fetch:
do not consider peeled tags as advertised tips, 2019-04-13), and there's
further discussion in the thread at:

  https://public-inbox.org/git/20180610143231.7131-1-kirr@nexedi.com/

Basically, upload-pack has never considered the peeled value of a tag to
be "advertised" for the purposes of letting the client request it. But
by default, in git-over-http mode, the server does act as if
uploadpack.allowReachableSHA1InWant is set, which comes from 051e4005a3
(helping smart-http/stateless-rpc fetch race, 2011-08-05).

So even though the server does not advertise that it will accept non-tip
sha1s, it happened to do so only over this one protocol. If you retry
your fetch over git:// or ssh, it would fail with any version.

It would also fail even with http for versions prior to v2.14, because
the bug to consider peeled tips as advertised on the client side comes
from fdb69d33c4 (fetch-pack: always allow fetching of literal SHA1s,
2017-05-15).

So in short, it was never supposed to work, but between bugs and
protocol vagaries, there are a few version and protocol combinations
where it did.

-Peff
