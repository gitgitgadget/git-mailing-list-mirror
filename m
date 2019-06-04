Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217CC1F609
	for <e@80x24.org>; Tue,  4 Jun 2019 16:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfFDQNs (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 12:13:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:46058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728166AbfFDQNs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 12:13:48 -0400
Received: (qmail 23279 invoked by uid 109); 4 Jun 2019 16:13:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 16:13:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15425 invoked by uid 111); 4 Jun 2019 16:14:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 12:14:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 12:13:32 -0400
Date:   Tue, 4 Jun 2019 12:13:32 -0400
From:   Jeff King <peff@peff.net>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190604161332.GA29603@sigill.intra.peff.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
 <20190603222247.GG4641@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190603222247.GG4641@comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 03:22:47PM -0700, Matthew DeVore wrote:

> On Mon, Jun 03, 2019 at 08:34:35AM -0400, Jeff King wrote:
> > Great. We might want to stop there, but it's possible could reuse even
> > more code. I didn't look closely before, but it seems this code is
> > decoding a URL. We already have a url_decode() routine in url.c. Could
> > it be reused?
> 
> Very nice. Here is an interdiff and the changes will be included in v3 of my
> patchset:

Nice to see a reduction in duplication (and I see you found some
problems in the existing code elsewhere; thanks for cleaning that up).

> -	return has_reserved_character(subspec, errbuf) ||
> -		url_decode(subspec, errbuf) ||
> -		gently_parse_list_objects_filter(
> -			&filter_options->sub[new_index], subspec->buf, errbuf);
> +	decoded = url_percent_decode(subspec->buf);

I think you can get rid of has_reserved_character() now, too.

The reserved character list is still used on the encoding side. But I
think you could switch to strbuf_add_urlencode() there?

-Peff
