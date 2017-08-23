Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD09120899
	for <e@80x24.org>; Wed, 23 Aug 2017 15:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbdHWPlR (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 11:41:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754136AbdHWPlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 11:41:16 -0400
Received: (qmail 11250 invoked by uid 109); 23 Aug 2017 15:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 15:41:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 948 invoked by uid 111); 23 Aug 2017 15:41:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 11:41:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Aug 2017 11:41:14 -0400
Date:   Wed, 23 Aug 2017 11:41:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] http: handle curl with vendor backports
Message-ID: <20170823154114.zanr26hg2silquez@sigill.intra.peff.net>
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
 <cover.1502462884.git.tgc@jupiterrise.com>
 <xmqq1sohzr85.fsf@gitster.mtv.corp.google.com>
 <20170820084725.ce5inn5jzkyor4zk@sigill.intra.peff.net>
 <xmqqziau6w63.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqziau6w63.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2017 at 09:28:20AM -0700, Junio C Hamano wrote:

> > Yes, I agree that these are an improvement regardless. If we follow
> > through on the cut-off to 7.19.4, then the CURLPROTO ones all go away.
> > But I don't mind rebasing any cut-off proposal on top of this work.
> 
> Yeah I came to a similar conclusion and was about asking if you feel
> the same way that your series should be made on top of Tom's fixes.
> 
> The aspect of that series I do like the most is to base our
> decisions on features, not versions, and I also wonder if we can do
> similar in your "abandon too old ones" series, too.

Yeah, I don't mind moving to feature flags where we can (though some
features do not have a useful flag; e.g., the only way to know whether
we must be strdup curl_easy_setopt() arguments is by checking the curl
version).

One annoying thing about "feature" flags instead of version flags is
that it takes a lot of legwork to figure out how old those features are
(whereas with the versions I was able to look that up in the curl
history pretty easily).  Since people adding the feature flag generally
do that legwork, it's probably worth having a comment for each
mentioning the general vintage (or maybe the commit message is an OK
place for that).

I actually wonder if it is worth defining our own readable flags in a
big table at the beginning of the file, like:

  /*
   * introduced in curl 7.19.4, but backported by some distros like
   * RHEL. We can identify it by the presence of the PROTO flags.
   */
  #ifdef CURLPROTO_HTTP
  #define CURL_SUPPORTS_PROTOCOL_REDIRECTION
  #endif

That keeps the logic in one place (where it can be changed if we later
find that the define we picked for our feature isn't quite accurate).
And then the #ifdefs sprinkled through the code itself become
self-documenting.

-Peff
