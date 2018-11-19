Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8AB91F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeKTGJl (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:09:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:44886 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725843AbeKTGJl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:09:41 -0500
Received: (qmail 21605 invoked by uid 109); 19 Nov 2018 19:44:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Nov 2018 19:44:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21569 invoked by uid 111); 19 Nov 2018 19:43:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Nov 2018 14:43:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2018 14:44:32 -0500
Date:   Mon, 19 Nov 2018 14:44:32 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tests: send "bug in the test script" errors to the
 script's stderr
Message-ID: <20181119194432.GA7330@sigill.intra.peff.net>
References: <20181119131326.2435-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119131326.2435-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 02:13:26PM +0100, SZEDER Gábor wrote:

> Send these "bug in the test script" error messages directly to the
> test scripts standard error and thus to the terminal, so those bugs
> will be much harder to overlook.  Instead of updating all ~20 such
> 'error' calls with a redirection, let's add a BUG() function to
> 'test-lib.sh', wrapping an 'error' call with the proper redirection
> and also including the common prefix of those error messages, and
> convert all those call sites [4] to use this new BUG() function
> instead.

Yes, I think this is an improvement.

> +BUG () {
> +	error >&7 "bug in the test script: $*"
> +}

I naively expected this to go to >&4, but of course that is the
conditional "stderr or /dev/null, depending on --verbose" descriptor. I
have a feeling that we could get rid of descriptors 5 and 7 in favor of
3 and 4, if we did the conditional redirection when running each test,
instead of ahead of time.

But unless we are running out of descriptors, it's not worth the effort
(it's debatable whether we are; 9be795fbce (t5615: avoid re-using
descriptor 4, 2017-12-08) made me nervous, but it's more about the
special-ness of BASHE_XTRACEFD than anything).

Anyway, that's all a tangent to your patch.

I do notice that many of the existing "FATAL:" errors use descriptor 5,
which goes to stdout. I'm not sure if those should actually be going to
stderr (or if there's some TAP significance to those lines).

-Peff
