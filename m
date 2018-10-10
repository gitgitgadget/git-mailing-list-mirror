Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C181F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 14:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJJWNu (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 18:13:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:35562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726515AbeJJWNu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 18:13:50 -0400
Received: (qmail 24945 invoked by uid 109); 10 Oct 2018 14:51:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 10 Oct 2018 14:51:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17958 invoked by uid 111); 10 Oct 2018 14:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 10:50:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 10:51:17 -0400
Date:   Wed, 10 Oct 2018 10:51:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: Re: [PATCH v5 17/23] userdiff.c: remove implicit dependency on
 the_index
Message-ID: <20181010145116.GA11772@sigill.intra.peff.net>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
 <20180921155739.14407-18-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180921155739.14407-18-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 05:57:33PM +0200, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/diff.c b/diff.c
> index 140d0e86df..5256b9eabc 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2093,23 +2093,25 @@ static void diff_words_flush(struct emit_callback *ecbdata)
>  	}
>  }
>  
> -static void diff_filespec_load_driver(struct diff_filespec *one)
> +static void diff_filespec_load_driver(struct diff_filespec *one,
> +				      struct index_state *istate)

I hadn't looked at this topic until today, when I tried merging next
with some of my other local bits and ran into conflicts. I found the
idea of passing index_state here, rather than the whole "struct
repository", a bit curious.

I get why you're doing it: your topic here only cares about removing
index dependencies, so you did the minimal thing to move that forward.

But if you think about what this function is doing, it is quite clearly
dependent on the whole repository, since the userdiff config we're
looking up may come from repo config.

So I think in the long run this probably should take a repository
argument, and use r->index instead of a separate istate argument. That
said, I'm not totally opposed to taking this incremental step and
letting somebody later sort out the config portions. I wonder if it
would be worth calling that out in the commit message to help that later
person. But I guess it is a bit late if this is already in next.

Maybe this email will serve the same purpose. :)

-Peff
