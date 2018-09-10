Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436731F404
	for <e@80x24.org>; Mon, 10 Sep 2018 13:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeIJSLa (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 14:11:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:44688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728159AbeIJSLa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 14:11:30 -0400
Received: (qmail 5005 invoked by uid 109); 10 Sep 2018 13:17:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Sep 2018 13:17:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7038 invoked by uid 111); 10 Sep 2018 13:17:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 09:17:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 09:17:25 -0400
Date:   Mon, 10 Sep 2018 09:17:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH v4] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180910131724.GA5233@sigill.intra.peff.net>
References: <20180907033607.24604-1-max@max630.net>
 <20180909041016.23980-1-max@max630.net>
 <20180910052558.GB55941@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180910052558.GB55941@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 09, 2018 at 10:25:58PM -0700, Jonathan Nieder wrote:

> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -353,8 +353,28 @@ static ssize_t get_content_length(void)
> >  	ssize_t val = -1;
> >  	const char *str = getenv("CONTENT_LENGTH");
> >  
> > -	if (str && !git_parse_ssize_t(str, &val))
> > -		die("failed to parse CONTENT_LENGTH: %s", str);
> > +	if (!str) {
> > +		/*
> > +		 * RFC3875 says this must mean "no body", but in practice we
> > +		 * receive chunked encodings with no CONTENT_LENGTH. Tell the
> > +		 * caller to read until EOF.
> > +		 */
> > +		val = -1;
> > +	} else if (!*str) {
> > +		/*
> > +		 * An empty length should be treated as "no body" according to
> > +		 * RFC3875, and this seems to hold in practice.
> > +		 */
> > +		val = 0;
> 
> Are there example callers that this version fixes?  Where can I read
> more, or what can I run to experience it?
> 
> For example, v2.19.0-rc0~45^2~2 (http-backend: respect CONTENT_LENGTH
> as specified by rfc3875, 2018-06-10) mentions IIS/Windows; does IIS
> make use of this distinction?

So this code is what I recommended based on my reading of the RFC, and
based on my understanding of the Debian bug. But I admit I'm confused.

I thought the complaint was that this:

  CONTENT_LENGTH= git http-backend

was reading a body, when it shouldn't be. And so setting it to 0 here
made sense.

But that couldn't have been what older versions were doing, since they
never looked at CONTENT_LENGTH at all, and instead always read to EOF.
So presumably the original problem wasn't that we tried to read a body,
but that the empty string caused git_parse_ssize_t to report failure,
and we called die(). Which probably should be explained by 574c513e8d
(http-backend: allow empty CONTENT_LENGTH, 2018-09-07), but it's too
late for that.

So after that patch, we really do have the original behavior, and that's
enough for v2.19.

But the remaining question then is: what should clients expect on an
empty variable? We know what the RFC says, and we know what dulwich
expected, but I'm not sure we have real world cases beyond that. So it
might actually make sense to punt until we see one, though I don't mind
doing what the rfc says in the meantime. And then the explanation in the
commit message would be "do what the rfc says", and any test probably
ought to be feeding a non-empty empty and confirming that we don't read
it.

-Peff
