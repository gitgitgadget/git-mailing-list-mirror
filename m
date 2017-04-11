Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD9A20970
	for <e@80x24.org>; Tue, 11 Apr 2017 19:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbdDKTld (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:41:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:60271 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751900AbdDKTld (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:41:33 -0400
Received: (qmail 32229 invoked by uid 109); 11 Apr 2017 19:41:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 19:41:30 +0000
Received: (qmail 6358 invoked by uid 111); 11 Apr 2017 19:41:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 15:41:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 15:41:27 -0400
Date:   Tue, 11 Apr 2017 15:41:27 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH v6] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170411194127.cfy2omkdwhbtkn63@sigill.intra.peff.net>
References: <20170411181357.16580-1-dturner@twosigma.com>
 <20170411182740.GO8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411182740.GO8741@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 11:27:40AM -0700, Jonathan Nieder wrote:

> David Turner wrote:
> 
> > Unfortunately, in order to push some large repos where a server does
> > not support chunked encoding, the http postbuffer must sometimes
> > exceed two gigabytes.  On a 64-bit system, this is OK: we just malloc
> > a larger buffer.
> >
> > This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
> > buffer size.
> >
> > Signed-off-by: David Turner <dturner@twosigma.com>
> > ---
> >  cache.h       |  1 +
> >  config.c      | 17 +++++++++++++++++
> >  http.c        |  6 ++++--
> >  http.h        |  2 +-
> >  remote-curl.c | 12 +++++++++---
> >  5 files changed, 32 insertions(+), 6 deletions(-)
> 
> The only unresolved issue was whether we can count on curl being new
> enough for CURLOPT_POSTFIELDSIZE_LARGE to be present.  I say
> "unresolved" but it is resolved in my mind since git doesn't build and
> pass tests with such old versions of curl --- what's unresolved is
> formalizing what the oldest curl version is that we want to support.
> And that doesn't need to hold this patch hostage.

It could build on older curl with a minor fix; the regression is in
v2.12. So if we did want to continue to support the same versions of
curl we did in v2.11, we could apply that fix and then we _would_ care
about #ifdef-ing this.

That isn't my preferred route; just pointing out that if the "oldest
curl" question isn't settled, that could still be relevant to this
patch. It doesn't have to be held hostage to the fix, but we should be
aware we are digging the hole deeper.

-Peff
