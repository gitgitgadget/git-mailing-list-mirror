Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7A3208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753201AbdHJVCt (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:02:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:35234 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753099AbdHJVCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:02:49 -0400
Received: (qmail 28286 invoked by uid 109); 10 Aug 2017 21:02:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 21:02:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9640 invoked by uid 111); 10 Aug 2017 21:03:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 17:03:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 17:02:46 -0400
Date:   Thu, 10 Aug 2017 17:02:46 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: [PATCH] strbuf: clear errno before calling getdelim(3)
Message-ID: <20170810210246.p4vp2ibahgsii7fc@sigill.intra.peff.net>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
 <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 10:56:40PM +0200, René Scharfe wrote:

> getdelim(3) returns -1 at the end of the file and if it encounters an
> error, but sets errno only in the latter case.  Set errno to zero before
> calling it to avoid misdiagnosing an out-of-memory condition due to a
> left-over value from some other function call.

Looks good to me.

> Do we need to save and restore the original value of errno?  I doubt it,
> but didn't think deeply about it, yet.

I'd say no. Anybody depending on strbuf_getwholeline() is clearly
already wrong in the error case. And in general I think we assume that
syscalls can clear errno on success if they choose to (this isn't a
syscall, but obviously it is calling some).

-Peff
