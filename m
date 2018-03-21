Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3CE1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeCUF7r (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:59:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:37034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751040AbeCUF7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:59:46 -0400
Received: (qmail 29615 invoked by uid 109); 21 Mar 2018 05:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:59:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7071 invoked by uid 111); 21 Mar 2018 06:00:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 02:00:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:59:44 -0400
Date:   Wed, 21 Mar 2018 01:59:44 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] read-cache: fix an -Wmaybe-uninitialized warning
Message-ID: <20180321055944.GA15719@sigill.intra.peff.net>
References: <6d434e76-cfa0-2a6e-f163-b54316a24cee@ramsayjones.plus.com>
 <20180320043652.GC13302@sigill.intra.peff.net>
 <e3894650-3639-c871-1291-f3efa7fbea0a@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3894650-3639-c871-1291-f3efa7fbea0a@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 10:52:16PM +0000, Ramsay Jones wrote:

> > Maybe too clever, but I think you could just do:
> > 
> >   unsigned int saved_namelen = 0;
> >   ...
> > 	saved_namelen = ce_namelen(ce);
> >   ...
> >   if (saved_namelen)
> > 	ce->ce_namelen = saved_namelen;
> >   ce->ce_flags &= ~CE_STRIP_NAME;
> > 
> > the zero-length name case (if that's even legal) would work out the
> > same.
> 
> Yeah, that was one option that I looked at. The first option
> was to initialise saved_namelen to -1 (it was still an int) then
> the test became if (saved_namelen >= 0). However, that started
> me thinking about the zero-length case - should I assert if
> ((ce->ce_flags & CE_STRIP_NAME) && (ce_namelen(ce) == 0))? etc.
> 
> In the end, I decided that I wanted it to be 'drop dead' obvious
> what was going on! Hopefully, the result was just that. :-D

Yeah, thinking on it more, simple and stupid is the right thing to do
here. Thanks for a dose of sanity. :)

-Peff
