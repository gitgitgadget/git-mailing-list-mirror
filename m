Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C02E201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 21:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755183AbdBVVf5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 16:35:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:60205 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755055AbdBVVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 16:35:46 -0500
Received: (qmail 25986 invoked by uid 109); 22 Feb 2017 21:35:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 21:35:45 +0000
Received: (qmail 4923 invoked by uid 111); 22 Feb 2017 21:35:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 16:35:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 16:35:43 -0500
Date:   Wed, 22 Feb 2017 16:35:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170222213542.opunuepfmj557zyr@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <20170222210636.k2ps3qhhpiyyv6cp@sigill.intra.peff.net>
 <xmqq4lzlc408.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lzlc408.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 01:25:11PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think it incurs an extra round-trip now, because of the way
> > libcurl works. Though I think it _does_ make it harder for curl to later
> > optimize out that extra round-trip.
> > ...
> > In the current trace, you can see that libcurl insists on making a
> > second auth-less request after we've fed it credentials. I'm not sure
> > how to get rid of this useless extra round-trip, but it would be nice to
> > do so (IIRC, it is a probe request to find out the list of auth types
> > that the server supports, which are not remembered from the previous
> > request).
> > ...
> > With http.emptyauth, the second round-trip _isn't_ useless. It's trying
> > to send the empty credential.
> > 
> > So while curl isn't currently optimizing out the second call, I think
> > http.emptyauth makes it harder to do the right thing.
> > ...
> > I think that would keep it to 2 round-trips for the normal "Basic" case,
> > as well as for the GSSNegotiate case. It would be 3 requests when the
> > server offers GSSNegotiate but you can't use it (but you could set
> > http.emptyauth=false to optimize that out).
> 
> Thanks for your thoughts.  I'd think that we should take this change
> and leave the optimization for later, then.  It's not like the
> change of the default is making the normal situation any worse, it
> seems.

I'm not excited that it will start making known bogus-username requests
by default to servers which do not even support Negotiate. I guess that
is really the server-operators problem, but it feels pretty hacky.

-Peff
