Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC58AC433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB4522201
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgJNPRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 11:17:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:59752 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgJNPRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 11:17:16 -0400
Received: (qmail 17477 invoked by uid 109); 14 Oct 2020 15:17:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Oct 2020 15:17:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17753 invoked by uid 111); 14 Oct 2020 15:17:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Oct 2020 11:17:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Oct 2020 11:17:14 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        gitster@pobox.com, masayasuzuki@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
Message-ID: <20201014151714.GB12589@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net>
 <20201013234502.GB490427@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201013234502.GB490427@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 11:45:02PM +0000, brian m. carlson wrote:

> Yeah, I was about to mention the same thing.  It looks like we cover
> only a subset of requests.  Moreover, I think this feature is going to
> practically fail in some cases and we need to either document that
> clearly or abandon this effort.
> 
> In remote-curl.c, we have post_rpc, which does a POST request to upload
> data for a push.  However, if the data is larger than the buffer, we
> stream it using chunked transfer-encoding.  Because we're reading from a
> pipe, that data cannot be retried: the pack-objects stream will have
> ended.

Right, this is the large_request code path there. We use the same
function for fetches, too, though perhaps it's less likely that a
negotiation request will exceed the post buffer size.

We do send a probe rpc in this case, which lets us handle an HTTP 401
auth request. We _could_ retry on errors to the probe rpc, but I'm not
sure if it really accomplishes that much. The interesting thing is
whether the actual request with content goes through. If retrying
magically fixes things, there's no reason to think that the actual
request is any less likely to intermittently fail than the probe request
(in fact I'd expect it to fail more).

It would be possible to restart even these large requests. Obviously we
could spool the contents to disk in order to replay it. But that carries
a cost for the common case that we either succeed or definitely fail on
the first case, and never use the spooled copy.

Another option is to simply restart the Git process that is generating
the data that we're piping. But that has to happen outside of
post_rpc(); only the caller knows the right way to invoke that again.
And we kind of already have that: just run the Git command again.
I know that sounds a little dismissive, but it has really been our
recommended retry strategy for ages[1].

So I'd wonder in Sean's use case why just restarting the whole Git
process isn't a workable solution. It wouldn't respect Retry-After, but
it might be reasonable to surface that header's value to the caller so
it can act appropriately (and I guess likewise whether we saw an error
that implies retrying might work).

All of this is written from the perspective of v1. In v2, we do a lot
more blind packet-shuffling (see remote-curl.c:stateless_connect()). I
suspect it makes any kind of retry at the level of the http code much
harder. Whereas just restarting the Git command would probably work just
fine.

-Peff

[1] I think git-submodule will retry failed clones, for example. TBH, I
    have never once seen this retry accomplish anything, and it only
    wastes time and makes the output more confusing (since we see the
    failure twice). I have to admit I'm not thrilled to see more blind
    retrying for that reason.
