Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CB11F462
	for <e@80x24.org>; Tue,  4 Jun 2019 18:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFDSvK (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 14:51:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:46242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726261AbfFDSvK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 14:51:10 -0400
Received: (qmail 24173 invoked by uid 109); 4 Jun 2019 18:51:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 18:51:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16534 invoked by uid 111); 4 Jun 2019 18:51:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 14:51:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 14:51:08 -0400
Date:   Tue, 4 Jun 2019 14:51:08 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190604185108.GA14738@sigill.intra.peff.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
 <20190603222247.GG4641@comcast.net>
 <20190604161332.GA29603@sigill.intra.peff.net>
 <20190604171952.GI4641@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604171952.GI4641@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 10:19:52AM -0700, Matthew DeVore wrote:

> On Tue, Jun 04, 2019 at 12:13:32PM -0400, Jeff King wrote:
> > > -	return has_reserved_character(subspec, errbuf) ||
> > > -		url_decode(subspec, errbuf) ||
> > > -		gently_parse_list_objects_filter(
> > > -			&filter_options->sub[new_index], subspec->buf, errbuf);
> > > +	decoded = url_percent_decode(subspec->buf);
> > 
> > I think you can get rid of has_reserved_character() now, too.
> 
> The purpose of has_reserved_character is to allow for future
> extensibility if someone decides to implement a more sophisticated DSL
> and give meaning to these characters. That may be a long-shot, but it
> seems worth it.

I think you'll find that -Wunused-function complains, though, if nobody
is calling it. I wasn't sure if what you showed in the interdiff was
meant to be final (I had to add a few other variable declarations to
make it compile, too).

> > The reserved character list is still used on the encoding side. But I
> > think you could switch to strbuf_add_urlencode() there?
> 
> strbuf_addstr_urlencode will either escape or not escape all rfc3986
> reserved characters, and that set includes both : and +. The former
> should not require escaping since it's a common character in filter
> specs, and I would like the hand-encoded combine specs to be relatively
> easy to type and read. The + must be escaped since it is used as part of
> the combine:... syntax to delimit sub filters. So
> strbuf_addstr_url_encode would have to be more customizable to make it
> work for this context. I'd like to add a parameterizable should_escape
> predicate (iow function pointer) which strbuf_addstr_urlencode accepts.
> I actually think this will be more readable than the current strbuf API.

That makes some sense, and I agree that readability is a good goal. Do
we not need to be escaping colons in other URLs? Or are the strings
you're generating not true by-the-book URLs? I'm just wondering if we
could take this opportunity to improve the URLs we output elsewhere,
too.

-Peff
