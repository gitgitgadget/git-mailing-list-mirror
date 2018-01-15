Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D821F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750750AbeAOVhF (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:37:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:44414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750733AbeAOVhF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 16:37:05 -0500
Received: (qmail 13680 invoked by uid 109); 15 Jan 2018 21:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jan 2018 21:37:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20040 invoked by uid 111); 15 Jan 2018 21:37:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jan 2018 16:37:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2018 16:37:03 -0500
Date:   Mon, 15 Jan 2018 16:37:03 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 02/18] cat-file: reuse struct ref_format
Message-ID: <20180115213702.GC4778@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc51d-7cd5fb1a-9798-49c1-bc82-480108e1a90b-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020160df6dc51d-7cd5fb1a-9798-49c1-bc82-480108e1a90b-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 09:36:41AM +0000, Olga Telezhnaya wrote:

> Start using ref_format struct instead of simple char*.
> Need that for further reusing of formatting logic from ref-filter.

OK, this makes sense (though again, at some point we want this to stop
being a "ref_format" and just be a "format").

>  struct batch_options {
> +	struct ref_format *format;

Does this need to be a pointer? We can just store the ref_format inside
the struct, right? And then...

> @@ -557,7 +558,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  {
>  	int opt = 0;
>  	const char *exp_type = NULL, *obj_name = NULL;
> -	struct batch_options batch = {0};
> +	struct ref_format format = REF_FORMAT_INIT;
> +	struct batch_options batch = {&format};
>  	int unknown_type = 0;

...here you would not need the extra local variable. You can initialize
it like:

  struct batch_options batch = { REF_FORMAT_INIT };

-Peff
