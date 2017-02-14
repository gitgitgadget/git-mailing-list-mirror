Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01991FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755029AbdBNRZg (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 12:25:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:55117 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754956AbdBNRZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 12:25:34 -0500
Received: (qmail 6296 invoked by uid 109); 14 Feb 2017 17:25:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 17:25:28 +0000
Received: (qmail 4445 invoked by uid 111); 14 Feb 2017 17:25:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 12:25:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 12:25:26 -0500
Date:   Tue, 14 Feb 2017 12:25:26 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
Message-ID: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214154816.12625-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 04:48:16PM +0100, Christian Couder wrote:

> @@ -791,11 +791,11 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>  				    head_oid.hash, NULL);
>  	if (head_p) {
>  		head_len = strlen(head_p);
> -		memcpy(head, head_p, head_len + 1);
> +		head_cpy = xstrdup(head_p);
>  	}
>  	else {
>  		head_len = 0;
> -		head[0] = 0;
> +		head_cpy = xstrdup("");
>  	}

This fixes the problem, but I think we can simplify it quite a bit by
using resolve_refdup(). Here's the patch series I ended up with:

  [1/3]: show-branch: drop head_len variable
  [2/3]: show-branch: store resolved head in heap buffer
  [3/3]: show-branch: use skip_prefix to drop magic numbers

 builtin/show-branch.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

-Peff
