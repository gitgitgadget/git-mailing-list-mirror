Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1411F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405932AbeKWDA3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 22:00:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:48664 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730352AbeKWDA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 22:00:29 -0500
Received: (qmail 23501 invoked by uid 109); 22 Nov 2018 16:20:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Nov 2018 16:20:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23358 invoked by uid 111); 22 Nov 2018 16:19:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Nov 2018 11:19:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2018 11:20:24 -0500
Date:   Thu, 22 Nov 2018 11:20:24 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
Message-ID: <20181122162024.GD28192@sigill.intra.peff.net>
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
 <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 09:52:27PM +0100, Thomas Braun wrote:

> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 69fc55ea1e..8c2558b07d 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -144,6 +144,11 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
>  		textconv_two = get_textconv(o->repo->index, p->two);
>  	}
>  
> +	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
> +	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
> +	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
> +		return 0;

If the user passes "-a" to treat binary files as text, we should
probably skip the binary check. I think we'd need to check
"o->flags.text" here.

> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 844df760f7..42cc8afd8b 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -106,4 +106,26 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
> [...]
> +test_expect_success 'log -G ignores binary files' '
> [...]
> +test_expect_success 'log -G looks into binary files with textconv filter' '

And likewise add a test here similar to the textconv one.

-Peff
