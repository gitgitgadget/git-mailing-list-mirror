Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ACB71F404
	for <e@80x24.org>; Sat,  3 Mar 2018 04:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeCCEYI (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 23:24:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:45202 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751608AbeCCEYH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 23:24:07 -0500
Received: (qmail 2984 invoked by uid 109); 3 Mar 2018 04:24:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 04:24:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2874 invoked by uid 111); 3 Mar 2018 04:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Mar 2018 23:24:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2018 23:24:05 -0500
Date:   Fri, 2 Mar 2018 23:24:05 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180303042405.GA27689@sigill.intra.peff.net>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222202150.GA23985@sigill.intra.peff.net>
 <20180223210904.GB234838@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223210904.GB234838@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 01:09:04PM -0800, Brandon Williams wrote:

> > By the way, any decision here would presumably need to be extended to
> > git-serve, etc. The current property is that it's safe to fetch from an
> > untrusted repository, even over ssh. If we're keeping that for protocol
> > v1, we'd want it to apply to protocol v2, as well.
> 
> This may be more complicated.  Right now (for backward compatibility)
> all fetches for v2 are issued to the upload-pack endpoint. So even
> though I've introduced git-serve it doesn't have requests issued to it
> and no requests can be issued to it currently (support isn't added to
> http-backend or git-daemon).  This just means that the command already
> exists to make it easy for testing specific v2 stuff and if we want to
> expose it as an endpoint (like when we have a brand new server command
> that is completely incompatible with v1) its already there and support
> just needs to be plumbed in.
> 
> This whole notion of treating upload-pack differently from receive-pack
> has bad consequences for v2 though.  The idea for v2 is to be able to
> run any number of commands via the same endpoint, so at the end of the
> day the endpoint you used is irrelevant.  So you could issue both fetch
> and push commands via the same endpoint in v2 whether its git-serve,
> receive-pack, or upload-pack.  So really, like Jonathan has said
> elsewhere, we need to figure out how to be ok with having receive-pack
> and upload-pack builtins, or having neither of them builtins, because it
> doesn't make much sense for v2 to straddle that line.

It seems like it would be OK if the whole code path of git-serve
invoking upload-pack happened without being a builtin, even if it would
be possible to run a builtin receive-pack from that same (non-builtin)
git-serve.

Remember that the client is driving the whole operation here, and we can
assume that git-serve is operating on the client's behalf. So a client
who chooses not to trigger receive-pack would be fine.

-Peff
