Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355861F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbcHSCF3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:05:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57770 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753997AbcHSAwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:52:36 -0400
Received: (qmail 4455 invoked by uid 109); 18 Aug 2016 22:05:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 22:05:33 +0000
Received: (qmail 18571 invoked by uid 111); 18 Aug 2016 22:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Aug 2016 18:05:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2016 18:05:31 -0400
Date:   Thu, 18 Aug 2016 18:05:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] cat-file: support --textconv/--filters in batch mode
Message-ID: <20160818220530.2dcsag4qeitia4ao@sigill.intra.peff.net>
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
 <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2315ae5ab6918a7c1567f11a64093a860983bc20.1471524357.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 02:46:28PM +0200, Johannes Schindelin wrote:

> With this patch, --batch can be combined with --textconv or --filters.
> For this to work, the input needs to have the form
> 
> 	<object name><single white space><path>
> 
> so that the filters can be chosen appropriately.

The object name can have spaces in it, too. E.g.:

  HEAD:path with spaces

or even:

  :/grep for this

(as was pointed out to me when I tried to turn on %(rest) handling by
default, long ago). How do those work with your patch?

It looks like the extra split isn't enabled unless one of those options
is selected. Since --filters is new, that's OK for backwards
compatibility. But --textconv isn't. So I think:

  echo "HEAD:path with spaces" |
  git cat-file --textconv --batch

is regressed by this patch.

I wonder if we need an option specifically to say "the object name can
be split". Right now it kicks in automatically if you use "%(rest)" in
your format, but you might not care about passing along that output
(e.g., a lot of times I am piping "rev-list" straight to cat-file, and I
have to use a separate "cut" to throw away the pathnames).

-Peff
