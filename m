Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381511F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbeBOFts (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:49:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:53402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752423AbeBOFtr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:49:47 -0500
Received: (qmail 2333 invoked by uid 109); 15 Feb 2018 05:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:49:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7330 invoked by uid 111); 15 Feb 2018 05:50:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:50:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:49:45 -0500
Date:   Thu, 15 Feb 2018 00:49:45 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 14/23] ref_filter: add is_atom_used function
Message-ID: <20180215054945.GL18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4357-05e636bc-8b44-425b-a252-ff2341f91cdd-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f4357-05e636bc-8b44-425b-a252-ff2341f91cdd-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Delete all items related to split_on_whitespace from ref-filter
> and add new function for handling the logic.
> Now cat-file could invoke that function to implementing its logic.

OK, this is a good direction. I think in a more compact series we'd
avoid moving the split-on-whitespace bits over to ref-filter in the
first place, and have two commits:

 - one early in the series adding is_atom_used()

 - one late in the series switching cat-file over to is_atom_used() as
   part of the conversion to ref-filter

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 6db57e3533806..3a49b55a1cc2e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -382,8 +382,7 @@ static int batch_objects(struct batch_options *opt)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	struct expand_data data;
> -	int save_warning;
> -	int retval = 0;
> +	int save_warning, is_rest, retval = 0;

Try to avoid reformatting existing code that you're not otherwise
touching, as it makes the diff noisier. Just adding "int is_rest" would
make this easier to review.

I also think the variable name should probably still be
"split_on_whitespace". It's set based on whether we saw a "%(rest)"
atom, but ultimately we'll use it to decide whether to split.

-Peff
