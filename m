Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 629DF1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfFSViH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:38:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:44800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725908AbfFSViH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:38:07 -0400
Received: (qmail 12919 invoked by uid 109); 19 Jun 2019 21:34:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 21:34:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10115 invoked by uid 111); 19 Jun 2019 21:38:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 17:38:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 17:38:05 -0400
Date:   Wed, 19 Jun 2019 17:38:05 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5] rev-list: teach --no-object-names to enable piping
Message-ID: <20190619213804.GD6571@sigill.intra.peff.net>
References: <20190618222917.261701-1-emilyshaffer@google.com>
 <20190619205656.117272-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619205656.117272-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 01:56:56PM -0700, Emily Shaffer wrote:

> Allow easier parsing by cat-file by giving rev-list an option to print
> only the OID of a non-commit object without any additional information.
> This is a short-term shim; later on, rev-list should be taught how to
> print the types of objects it finds in a format similar to cat-file's.
> [...]

I missed some of the intermediate rounds, but fortunately Junio already
said everything I was going to. :) This version looks good to me, though
with one minor nit:

> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 88609ff435..9392760b25 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -48,6 +48,7 @@ SYNOPSIS
>  	     [ --date=<format>]
>  	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
>  	       [ --unpacked ]
> +	       [ --object-names | --no-object-names ]
>  	       [ --filter=<filter-spec> [ --filter-print-omitted ] ] ]
>  	     [ --missing=<missing-action> ]
>  	     [ --pretty | --header ]

Here you put --object-names along with the --objects. Which kind of
makes sense, but everything else in that block is about choosing _which_
commits to show. In the short help, you put it near --pretty:

> @@ -49,6 +49,7 @@ static const char rev_list_usage[] =
>  "    --objects | --objects-edge\n"
>  "    --unpacked\n"
>  "    --header | --pretty\n"
> +"    --[no-]object-names\n"
>  "    --abbrev=<n> | --no-abbrev\n"
>  "    --abbrev-commit\n"
>  "    --left-right\n"

which I think makes more sense. I think maybe you were trying to imply
that "--object-names" is not useful unless you're also using
"--objects". Which is true, but I'm not sure it's obvious from that mass
of brackets (and I think is sufficiently covered in the actual option
descriptions you give later).

> +test_expect_success '--no-object-names and --object-names are last-one-wins' '
> +	git rev-list --objects --no-object-names --object-names --all >output &&
> +	grep wanted_file output &&
> +	git rev-list --objects --object-names --no-object-names --all >output &&
> +	! grep wanted_file output
> +'

We don't generally test this behavior for each option, since it would
lead to a ton of uninteresting tests (and parse-options generally just
handles it).  But after our discussion about --no-abbrev, I can see how
you might be more interested in the topic. :) So I'm OK with it either
way.

-Peff
