Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B71D1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfAVSuE (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:50:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:44716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725896AbfAVSuC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:50:02 -0500
Received: (qmail 3032 invoked by uid 109); 22 Jan 2019 18:50:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 22 Jan 2019 18:50:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9296 invoked by uid 111); 22 Jan 2019 18:50:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 22 Jan 2019 13:50:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jan 2019 13:49:59 -0500
Date:   Tue, 22 Jan 2019 13:49:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        asottile@umich.edu, benpeart@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com
Subject: Re: [PATCH v2 2/2] checkout: fix regression in checkout -b on
 intitial checkout
Message-ID: <20190122184959.GF4399@sigill.intra.peff.net>
References: <20190118185558.17688-1-peartben@gmail.com>
 <20190121195008.8700-1-peartben@gmail.com>
 <20190121195008.8700-3-peartben@gmail.com>
 <nycvar.QRO.7.76.6.1901221529210.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1901221529210.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 03:35:21PM +0100, Johannes Schindelin wrote:

> I also looked at the implementation of `file_exists()` and found that it
> uses `lstat()`. Peff, you introduced this (using `stat()`) in c91f0d92efb3
> (git-commit.sh: convert run_status to a C builtin, 2006-09-08), could you
> enlighten me why you chose `stat()` over `access()` (the latter seems more
> light-weight to me)?

That's quite a while ago, but I'm pretty sure I was just following
existing practice. It would be fine to switch from stat() to access().
But...

> Also, Junio, you changed it to use `lstat()` in
> a50f9fc5feb0 (file_exists(): dangling symlinks do exist, 2007-11-18), do
> you think we can/should use `access()` instead?

I think access() will always dereference. So it would not detect a
dangling symlink. Whether that matters or not is going to depend on each
caller.

I doubt it would matter much either way in this case. And I don't think
this is performance critical (it should be once per checkout, not once
per file).

If there are callers that care (and I assume there are due to the
existence of a50f9fcfeb0), and if we do care about performance on
platforms where stat() is slower, it might be reasonable to have a
platform-specific implementation of file_exists().

Likewise, anybody converting from access() should consider whether each
site cares about dangling symlinks (though in general, I'd expect most
of them to simply not have thought of it, and be happy to start
considering that as "exists").

-Peff
