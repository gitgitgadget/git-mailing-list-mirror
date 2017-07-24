Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93422203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 16:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755612AbdGXQJ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 12:09:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:46988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756196AbdGXQJm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 12:09:42 -0400
Received: (qmail 3591 invoked by uid 109); 24 Jul 2017 16:09:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 16:09:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9337 invoked by uid 111); 24 Jul 2017 16:09:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 12:09:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 12:09:39 -0400
Date:   Mon, 24 Jul 2017 12:09:39 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lukas Fleischer <lfleischer@lfos.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] refs: use skip_prefix() in ref_is_hidden()
Message-ID: <20170724160938.bpdqf64p2ja2vvbd@sigill.intra.peff.net>
References: <20170722043912.32118-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170722043912.32118-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 22, 2017 at 06:39:12AM +0200, Christian Couder wrote:

> @@ -1175,10 +1175,9 @@ int ref_is_hidden(const char *refname, const char *refname_full)
>  		}
>  
>  		/* refname can be NULL when namespaces are used. */
> -		if (!subject || !starts_with(subject, match))
> -			continue;
> -		len = strlen(match);
> -		if (!subject[len] || subject[len] == '/')
> +		if (subject &&
> +		    skip_prefix(subject, match, &p) &&
> +		    (!*p || *p == '/'))
>  			return !neg;

This looks good to me.

I seem to recall running across a similar pattern elsewhere, where a
caller wanted either an exact match, or a match ending with a particular
character. We could add one more helper like:

  if (subject && skip_prefix_with_sep(subject, match, '/', &p))
	return !neg;

But I don't offhand recall where that other place was, and it's not like
it's saving a huge amount of complexity in the caller. So I'll file it
away in the back of my mind and see if it comes up a third time. ;)

-Peff
