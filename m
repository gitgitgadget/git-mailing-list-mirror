Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1EF11F461
	for <e@80x24.org>; Tue, 14 May 2019 14:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfENOnI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 10:43:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:57094 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726025AbfENOnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 10:43:08 -0400
Received: (qmail 5777 invoked by uid 109); 14 May 2019 14:43:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 14:43:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13607 invoked by uid 111); 14 May 2019 14:43:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 10:43:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 10:43:06 -0400
Date:   Tue, 14 May 2019 10:43:06 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
Message-ID: <20190514144305.GA28530@sigill.intra.peff.net>
References: <pull.192.git.gitgitgadget@gmail.com>
 <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com>
 <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 02:57:01PM +0200, Johannes Schindelin wrote:

> > But the parameter treated as a constant without getting modified
> > during the invocation of the function is an implementation detail of
> > the function; there is no point exposing that implementation detail
> > to its callers.  It does not even help the compilers handling the
> > caller's compilation unit---the parameter is passed by value, so the
> > caller knows that the callee would not modify it without "const"
> > there.
> >
> > Does the language even allow flagging "const int in the definition,
> > int in the declaration" as a warning-worthy discrepancy?
> 
> Apparently it does, as MS Visual C does issue a warning (and with `/Wall`,
> it fails).
> 
> In any case, I don't think that it makes sense to have a function
> declaration whose signature differs from the definition's.

I actually agree with Junio's point that in an ideal world the
declaration should omit details that are not relevant to the caller. But
clearly we do not live in that world, and this is a small enough point
that we should fix it in one direction or the other.

I do have a slight preference for going the _other_ way. There is no
need to mark the parameter as const in the definition. It is passed by
value, so nobody except the function body cares either way. And we have
many function bodies where value-passed parameters (or local variables!)
are not marked as const, even though they are only assigned to once.

I don't think that annotation is telling much to any reader of the code,
nor to a decent optimizing compiler.

-Peff
