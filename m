Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0B9C1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 14:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030539AbeBNOGA (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 09:06:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:52016 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1030448AbeBNOGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 09:06:00 -0500
Received: (qmail 17019 invoked by uid 109); 14 Feb 2018 14:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 14:05:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28780 invoked by uid 111); 14 Feb 2018 14:06:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 09:06:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 09:05:58 -0500
Date:   Wed, 14 Feb 2018 09:05:58 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, doron.behar@gmail.com
Subject: Re: [PATCH 1/2] parse-options: expand $HOME on filename options
Message-ID: <20180214140557.GA27850@sigill.intra.peff.net>
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain>
 <20180214105149.28896-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214105149.28896-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 05:51:48PM +0700, Nguyễn Thái Ngọc Duy wrote:

> When you specify "--path ~/foo", the shell will automatically expand
> ~/foo to $HOME/foo before it's passed to git. The expansion is not done
> on "--path=~/foo". An experienced user sees the difference but it could
> still be confusing for others (especially when tab-completion still
> works on --path=~/foo).
> 
> Support $HOME expansion for all filename options. There are about seven
> of them.

I think this probably makes sense.

>  parse-options.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Should this be mentioned in the comment documenting OPT_FILENAME()?

> diff --git a/parse-options.c b/parse-options.c
> index d265a756b5..c33f14c74e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -38,10 +38,13 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
>  
>  static void fix_filename(const char *prefix, const char **file)
>  {
> -	if (!file || !*file || !prefix || is_absolute_path(*file)
> -	    || !strcmp("-", *file))
> +	if (!file || !*file || is_absolute_path(*file) ||
> +	    !strcmp("-", *file))
>  		return;
> -	*file = prefix_filename(prefix, *file);
> +	if (**file == '~')
> +		*file = expand_user_path(*file, 0);
> +	else if (prefix)
> +		*file = prefix_filename(prefix, *file);
>  }

I thought at first this needed a final "else" clause, because we don't
assign to *file if we have neither a prefix nor a user-path. But that's
what the callers expect (and we are similarly a noop if we hit the first
conditional). So this looks right.

-Peff
