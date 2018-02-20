Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6161F576
	for <e@80x24.org>; Tue, 20 Feb 2018 07:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeBTHmE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 02:42:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:57850 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750985AbeBTHmD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 02:42:03 -0500
Received: (qmail 3614 invoked by uid 109); 20 Feb 2018 07:42:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Feb 2018 07:42:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12115 invoked by uid 111); 20 Feb 2018 07:42:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Feb 2018 02:42:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Feb 2018 02:42:01 -0500
Date:   Tue, 20 Feb 2018 02:42:01 -0500
From:   Jeff King <peff@peff.net>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch-hooks
Message-ID: <20180220074201.GA2154@sigill.intra.peff.net>
References: <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
 <20180214013520.GA25188@sigill.intra.peff.net>
 <96dd7fb3-849b-8de6-7c3a-cd6bde9da432@gaspard.io>
 <20180219212347.GA9748@sigill.intra.peff.net>
 <cdef8e46-92ee-2062-385a-999b5b49ae9a@gaspard.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdef8e46-92ee-2062-385a-999b5b49ae9a@gaspard.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 19, 2018 at 11:50:37PM +0100, Leo Gaspard wrote:

> On 02/19/2018 10:23 PM, Jeff King wrote:
> > [...]
> > If you do go this route, please model it after "pre-receive" rather than
> > "update". We had "update" originally but found it was too limiting for
> > hooks to see only one ref at a time. So we introduced pre-receive. The
> > "update" hook remains for historical reasons, but I don't think we'd
> > want to reproduce the mistake. :)
> 
> Hmm, what bothered me with “pre-receive” was that it was an
> all-or-nothing decision, without the ability to allow some references
> through and not others.
> 
> Is there a way for “pre-receive” to individually filter hooks? I was
> under the impression that the only way to do that was to use the
> “update” hook, which was the reason I wanted to model it after “update”
> rather than “pre-receive” (my use case being a check independent for
> each pushed ref)

No, pre-receive is always atomic. However, that may actually be what you
want, if the point is to keep untrusted data out of the repository. By
rejecting the whole thing, we could in theory keep the objects from
entering the repository at all. This is how the push side works via the
"quarantine" system (which is explained in git-receive-pack(1)).
Fetching doesn't currently quarantine objects, but it probably wouldn't
be very hard to make it do so.

-Peff
