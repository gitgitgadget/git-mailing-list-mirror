Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380082036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdJCXtW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:49:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:59798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750865AbdJCXtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:49:22 -0400
Received: (qmail 27563 invoked by uid 109); 3 Oct 2017 23:49:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 23:49:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13133 invoked by uid 111); 3 Oct 2017 23:49:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 19:49:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 19:49:19 -0400
Date:   Tue, 3 Oct 2017 19:49:19 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: reset instead of release a strbuf
Message-ID: <20171003234919.qsr54ncmw6cihowi@sigill.intra.peff.net>
References: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
 <20171003221740.26325-1-sbeller@google.com>
 <20171003222414.GC19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003222414.GC19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 03:24:14PM -0700, Jonathan Nieder wrote:

> Here's a patch to address the surprising strbuf.h advice.
> 
> -- >8 --
> Subject: strbuf: do not encourage init-after-release
> 
> strbuf_release already leaves the strbuf in a valid, initialized
> state, so there is not need to call strbuf_init after it.
> 
> Moreover, this is not likely to change in the future: strbuf_release
> leaving the strbuf in a valid state has been easy to maintain and has
> been very helpful for Git's robustness and simplicity (e.g.,
> preventing use-after-free vulnerabilities).

Thanks for picking this up. Like you, I was quite surprised when I saw
Stefan's original patch.

> diff --git a/strbuf.h b/strbuf.h
> index 7496cb8ec5..6e175c3694 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -83,7 +83,7 @@ extern void strbuf_init(struct strbuf *, size_t);
>  
>  /**
>   * Release a string buffer and the memory it used. You should not use the
> - * string buffer after using this function, unless you initialize it again.
> + * string buffer after using this function.
>   */
>  extern void strbuf_release(struct strbuf *);

I think it's actually OK to use the string buffer after this function.
It's just an empty string.

Perhaps we should be more explicit: this releases any resources and
resets to a pristine, empty state. I suspect strbuf_detach() probably
should make the same claim.

Earlier you mentioned:

> It is still not advisable to call strbuf_release until done using a
> strbuf because it is wasteful, so keep that part of the advice.

Is this what you meant? If so, I think we should probably be more
explicit in giving people a hint to use strbuf_reset() for efficiency.

-Peff
