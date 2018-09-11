Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63941F404
	for <e@80x24.org>; Tue, 11 Sep 2018 02:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeIKH1Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 03:27:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:45600 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726353AbeIKH1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 03:27:24 -0400
Received: (qmail 4814 invoked by uid 109); 11 Sep 2018 02:30:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Sep 2018 02:30:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14848 invoked by uid 111); 11 Sep 2018 02:30:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 22:30:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 22:30:25 -0400
Date:   Mon, 10 Sep 2018 22:30:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: Treat empty CONTENT_LENGTH as zero
Message-ID: <20180911023025.GA7739@sigill.intra.peff.net>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
 <20180910212221.GG26356@aiede.svl.corp.google.com>
 <20180911015553.GA5838@sigill.intra.peff.net>
 <20180911022028.GA20518@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180911022028.GA20518@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 07:20:28PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Mon, Sep 10, 2018 at 02:22:21PM -0700, Jonathan Nieder wrote:
> 
> >> Thanks.  I am wondering if we should go all the way and do
> >>
> >> 	ssize_t val;
> >> 	const char *str = getenv("CONTENT_LENGTH");
> >>
> >> 	if (!str || !*str)
> >> 		return 0;
> >> 	if (!git_parse_ssize_t(str, &val))
> >> 		die(...);
> >> 	return val;
> >>
> >> That would match the RFC, but it seems to make t5510-fetch.sh hang,
> [...]
> >> Do you know why?
> >
> > Yes. :)
> >
> > It's due to this comment in the patch you are replying to:
> >
> > +       if (!str) {
> > +               /*
> > +                * RFC3875 says this must mean "no body", but in practice we
> > +                * receive chunked encodings with no CONTENT_LENGTH. Tell the
> > +                * caller to read until EOF.
> > +                */
> > +               val = -1;
> 
> Ah!  So "in practice" includes "in Apache".  An old discussion[1] on
> Apache's httpd-users list agrees.
> 
> The question then becomes: what does IIS do for zero-length requests?
> Does any other web server fail to support "read until EOF" in general?
> 
> The CGI standard does not cover chunked encoding so we can't lean on
> the standard for advice.  It's not clear to me yet whether this patch
> improves on what's in "master".

I'd note that the case in question (no CONTENT_LENGTH at all) is not
changed between this patch and master. It's only the case of
CONTENT_LENGTH set to an empty string. But I agree that it is not clear
to me whether it is actually improving anything in practice.

-Peff
