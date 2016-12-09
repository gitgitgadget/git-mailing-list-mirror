Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D22B1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 14:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbcLIODt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 09:03:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:54169 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932560AbcLIODt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 09:03:49 -0500
Received: (qmail 30815 invoked by uid 109); 9 Dec 2016 14:03:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 14:03:48 +0000
Received: (qmail 18394 invoked by uid 111); 9 Dec 2016 14:04:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 09:04:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2016 09:03:46 -0500
Date:   Fri, 9 Dec 2016 09:03:46 -0500
From:   Jeff King <peff@peff.net>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com, gitster@pobox.com,
        jnareb@gmail.com
Subject: Re: [PATCH v8 18/19] branch: use ref-filter printing APIs
Message-ID: <20161209140345.76ybodldmg2lxgbn@sigill.intra.peff.net>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
 <20161207153627.1468-19-Karthik.188@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161207153627.1468-19-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2016 at 09:06:26PM +0530, Karthik Nayak wrote:

> +const char *quote_literal_for_format(const char *s)
>  {
> +	struct strbuf buf = STRBUF_INIT;
>  
> +	strbuf_reset(&buf);
> +	while (*s) {
> +		const char *ep = strchrnul(s, '%');
> +		if (s < ep)
> +			strbuf_add(&buf, s, ep - s);
> +		if (*ep == '%') {
> +			strbuf_addstr(&buf, "%%");
> +			s = ep + 1;
> +		} else {
> +			s = ep;
> +		}
>  	}
> +	return buf.buf;
>  }

You should use strbuf_detach() to return the buffer from a strbuf.
Otherwise it is undefined whether the pointer is allocated or not (and
whether it needs to be freed).

In this case, if "s" is empty, buf.buf would point to a string literal,
but otherwise to allocated memory. strbuf_detach() normalizes that.

But...

> +			    branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),

This caller never stores the return value, and it ends up leaking. So I
wonder if you wanted "static struct strbuf" in the first place (and that
would explain the strbuf_reset() in your function).

-Peff
