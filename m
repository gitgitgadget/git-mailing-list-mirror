Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B85320401
	for <e@80x24.org>; Sat, 17 Jun 2017 11:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdFQLWc (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 07:22:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:41966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752773AbdFQLWb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 07:22:31 -0400
Received: (qmail 15219 invoked by uid 109); 17 Jun 2017 11:22:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 11:22:30 +0000
Received: (qmail 13430 invoked by uid 111); 17 Jun 2017 11:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 07:22:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jun 2017 07:22:28 -0400
Date:   Sat, 17 Jun 2017 07:22:28 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCHv5 1/2] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170617112228.vugswym4o4owf6wj@sigill.intra.peff.net>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
 <20170616173849.8071-1-szeder.dev@gmail.com>
 <20170616173849.8071-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170616173849.8071-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 07:38:48PM +0200, SZEDER Gábor wrote:

> +void add_and_parse_fetch_refspec(struct remote *remote, const char *refspec)
> +{
> +	struct refspec *rs;
> +
> +	add_fetch_refspec(remote, refspec);
> +	rs = parse_fetch_refspec(1, &refspec);
> +	REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
> +	remote->fetch[remote->fetch_refspec_nr - 1] = *rs;
> +
> +	/* Not free_refspecs(), as we copied its pointers above */
> +	free(rs);
> +}

I'd still prefer this to have:

  if (!remote->fetch && remote->fetch_refspec_nr)
	BUG("attempt to add refspec to uninitialized list");

at the top, as otherwise this case writes garbage into remote->fetch[0].

I see you have another series dealing with the lazy parsing, but I
haven't looked at it yet (hopefully this danger would just go away after
that).

Other than that, the patch looks fine to me.

-Peff
