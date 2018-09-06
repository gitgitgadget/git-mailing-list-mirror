Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670001F404
	for <e@80x24.org>; Thu,  6 Sep 2018 14:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeIFTfl (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 15:35:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:41150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730019AbeIFTfk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 15:35:40 -0400
Received: (qmail 10844 invoked by uid 109); 6 Sep 2018 14:59:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 14:59:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30525 invoked by uid 111); 6 Sep 2018 14:59:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 10:59:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 10:59:42 -0400
Date:   Thu, 6 Sep 2018 10:59:42 -0400
From:   Jeff King <peff@peff.net>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
Message-ID: <20180906145942.GB1209@sigill.intra.peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180906101658.1865-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180906101658.1865-1-timschumi@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 12:16:58PM +0200, Tim Schumacher wrote:

> @@ -691,17 +692,23 @@ static int run_argv(int *argcp, const char ***argv)
>  		/* .. then try the external ones */
>  		execv_dashed_external(*argv);
>  
> -		/* It could be an alias -- this works around the insanity
> +		if (string_list_has_string(&cmd_list, *argv[0]))
> +			die(_("loop alias: %s is called twice"), *argv[0]);

I pointed this out in my response to Ævar, but I want to make sure it
gets seen. This call assumes the list is sorted, but...

> +		string_list_append(&cmd_list, *argv[0]);

This will create an unsorted list. You'd have to use
string_list_insert() here for a sorted list, or
unsorted_string_list_has_string() in the earlier call.

It's unfortunate that string_list makes this so easy to get wrong.

> +
> +		/*
> +		 * It could be an alias -- this works around the insanity
>  		 * of overriding "git log" with "git show" by having
>  		 * alias.log = show
>  		 */
> -		if (done_alias)
> -			break;
>  		if (!handle_alias(argcp, argv))
>  			break;
> -		done_alias = 1;
> +		done_alias++;

I don't think anybody cares about done_alias being an accurate count.
Should we just leave this as-is?

-Peff
