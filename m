Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25441F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfIIR2e (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:28:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:44388 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfIIR2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:28:34 -0400
Received: (qmail 20707 invoked by uid 109); 9 Sep 2019 17:28:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Sep 2019 17:28:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10957 invoked by uid 111); 9 Sep 2019 17:30:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2019 13:30:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Sep 2019 13:28:33 -0400
From:   Jeff King <peff@peff.net>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] Quit passing 'now' to date code
Message-ID: <20190909172832.GB30470@sigill.intra.peff.net>
References: <20190909014711.3894-1-ischis2@cox.net>
 <20190909014711.3894-2-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190909014711.3894-2-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 08, 2019 at 06:47:10PM -0700, Stephen P. Smith wrote:

> As part of a previous patch set, the get_time() function was added to
> date.c eliminating the need to pass a `now` parameter from the test
> code.

I'm glad to see this cleanup. I think it is worth explaining a bit more,
though, why this hunk in particular:

> @@ -103,22 +103,14 @@ static void getnanos(const char **argv)
>  
>  int cmd__date(int argc, const char **argv)
>  {
> -	struct timeval now;
>  	const char *x;
> -
>  	x = getenv("GIT_TEST_DATE_NOW");
> -	if (x) {
> -		now.tv_sec = atoi(x);
> -		now.tv_usec = 0;
> -	}
> -	else
> -		gettimeofday(&now, NULL);

...is doing the right thing, since it was the site that actually used
the parameters that are being deleted. Maybe something like:

  Commit b841d4ff43 (Add `human` format to test-tool, 2019-01-28) added
  a get_time() function which allows $GIT_TEST_DATE_NOW in the
  environment to override the current time. So we no longer need to
  interpret that variable in cmd__date().

  Likewise, we can stop passing the "now" parameter down through the
  date functions, since nobody uses them. Note that we do need to make
  sure all of the previous callers that took a "now" parameter are
  correctly using get_time().

which I think explains all of the hunks.

-Peff
