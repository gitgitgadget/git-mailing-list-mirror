Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887931FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 12:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbdDLMwV (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 08:52:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:60602 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752697AbdDLMwU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 08:52:20 -0400
Received: (qmail 18426 invoked by uid 109); 12 Apr 2017 12:52:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 12:52:17 +0000
Received: (qmail 12078 invoked by uid 111); 12 Apr 2017 12:52:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 08:52:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Apr 2017 08:52:14 -0400
Date:   Wed, 12 Apr 2017 08:52:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH v6] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170412125214.uiex4ludmgahsvme@sigill.intra.peff.net>
References: <20170411181357.16580-1-dturner@twosigma.com>
 <20170411182740.GO8741@aiede.mtv.corp.google.com>
 <20170411194127.cfy2omkdwhbtkn63@sigill.intra.peff.net>
 <xmqqa87mqrhc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa87mqrhc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 07:39:27PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> The only unresolved issue was whether we can count on curl being new
> >> enough for CURLOPT_POSTFIELDSIZE_LARGE to be present.  I say
> >> "unresolved" but it is resolved in my mind since git doesn't build and
> >> pass tests with such old versions of curl --- what's unresolved is
> >> formalizing what the oldest curl version is that we want to support.
> >> And that doesn't need to hold this patch hostage.
> >
> > It could build on older curl with a minor fix; the regression is in
> > v2.12. So if we did want to continue to support the same versions of
> > curl we did in v2.11, we could apply that fix and then we _would_ care
> > about #ifdef-ing this.
> 
> What would the fix be?  Have a code that notices that the value set
> to http.postbuffer is too large and ignore the request on the other
> side of #ifdef, i.e. when Git is built with older curl that lack
> CURLOPT_POSTFIELDSIZE_LARGE?

The fix I meant there is for a different spot. During the course of the
discussion, somebody noticed that v2.12 does not compile using older
curls:

  http://public-inbox.org/git/20170404133241.GA15588@gevaerts.be/

So _if_ we care about those older curls, then we should consider that a
regression and fix it on the v2.12-maint track.

And likewise, we should not accept this patch into master without a
similar fix. Which is probably, yes, an ifdef for older curl that uses
the non-LARGE version of POSTFIELDSIZE and defines xcurl_off_t() to
check against "long" and complain when it overflows.

-Peff
