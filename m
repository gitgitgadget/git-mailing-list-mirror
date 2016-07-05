Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0272070A
	for <e@80x24.org>; Tue,  5 Jul 2016 20:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbcGEU21 (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 16:28:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:40646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751868AbcGEU20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 16:28:26 -0400
Received: (qmail 14453 invoked by uid 102); 5 Jul 2016 20:28:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jul 2016 16:28:26 -0400
Received: (qmail 18086 invoked by uid 107); 5 Jul 2016 20:28:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 Jul 2016 16:28:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jul 2016 16:28:20 -0400
Date:	Tue, 5 Jul 2016 16:28:20 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: clarify seemingly bogus OPT_END repetition
Message-ID: <20160705202820.GA14496@sigill.intra.peff.net>
References: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b424bad41ca027b39eea4b1fa9d87df0a489e0f.1467719888.git.johannes.schindelin@gmx.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 05, 2016 at 01:58:51PM +0200, Johannes Schindelin wrote:

> This developer stumbled over repeated OPT_END entries and was *so
> close* (almost touches his thumb with his index finger) to collapse
> them into a single one. Only inspecting the file's history with
> `git log -p -SOPT_END` clarified why they are there.

Wow, that's really ugly, and confused me, too.

I've been trying to move us away from this kind of manually-computed
array size, simply because it's error-prone and often not obviously
correct[1].

I wonder if parse_options_concat should simply allocate a new list
(after computing the total required size). I guess this is the only
caller, though, so perhaps it's not the end of the world. In the
meantime, your patch is certainly an improvement.

By the way, I notice that the error message when concat fails is just:

  if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
	die(_("program error"));

Should this become:

        die("BUG: not enough room to concatenate options");

as part of your BUG cleanups elsewhere?

-Peff

[1] At least the concat interface takes ARRAY_SIZE(), so that we will
    catch an error, rather than silently causing memory corruption. A
    much more likely error is to forget OPT_END(), which will cause
    parse_options to read past the end of the array.
