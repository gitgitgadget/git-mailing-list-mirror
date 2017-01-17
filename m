Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA7020756
	for <e@80x24.org>; Tue, 17 Jan 2017 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdAQPeI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 10:34:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:40197 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbdAQPeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 10:34:07 -0500
Received: (qmail 5394 invoked by uid 109); 17 Jan 2017 15:34:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:34:07 +0000
Received: (qmail 18165 invoked by uid 111); 17 Jan 2017 15:35:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 10:35:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 10:34:04 -0500
Date:   Tue, 17 Jan 2017 10:34:04 -0500
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 5/7] builtin/tag: add --format argument for tag -v
Message-ID: <20170117153404.jp3ftdlzeyut6e7a@sigill.intra.peff.net>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-6-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170115184705.10376-6-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 01:47:03PM -0500, santiago@nyu.edu wrote:

> -static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
> +static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
> +		void *cb_data)
>  {
>  	const char **p;
>  	char ref[PATH_MAX];
>  	int had_error = 0;
>  	unsigned char sha1[20];
>  
> +
>  	for (p = argv; *p; p++) {
>  		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
>  					>= sizeof(ref)) {

Funny extra line?

>  {
> -	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
> +	int flags;
> +	char *fmt_pretty = cb_data;
> +	flags = GPG_VERIFY_VERBOSE;
> +
> +	if (fmt_pretty)
> +		flags = GPG_VERIFY_QUIET;
> +
> +	return verify_and_format_tag(sha1, ref, fmt_pretty, flags);

It seems funny that VERBOSE and QUIET are bit-flags. What happens when
you ask for GPG_VERIFY_VERBOSE|GPG_VERIFY_QUIET?

I suppose this is actually not a problem in _this_ patch, but in the
very first one that adds the QUIET flag. I'm not sure if the problem is
that the options should be more orthogonal, or that they are just badly
named to appear as opposites when they aren't.

-Peff
