Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15EB1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 11:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933263AbeFULxE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 07:53:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:50506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933130AbeFULxE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 07:53:04 -0400
Received: (qmail 17429 invoked by uid 109); 21 Jun 2018 11:53:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Jun 2018 11:53:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4554 invoked by uid 111); 21 Jun 2018 11:53:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Jun 2018 07:53:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2018 07:53:02 -0400
Date:   Thu, 21 Jun 2018 07:53:02 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180621115302.GB15293@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1529524852.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 03:05:30PM -0500, Taylor Blau wrote:

> Hi,
> 
> Here is a re-roll of my series to add --column to 'git-grep(1)'. Since
> last time, not much has changed other than the following:
> 
>   - Fix a typo where 'col', 'icol' were spelled as 'match', 'imatch'
>     [1].
> 
>   - Disable short-circuiting OR when --column is given [2].

If we're going to do this, should we be short-circuiting AND, too?

Handling just OR makes this work:

  $ ./git grep --column -e scalable --or -e fast -- README.md
  README.md:7:Git - fast, scalable, distributed revision control system
  README.md:10:Git is a fast, scalable, distributed revision control system with an

but not this:

  $ ./git grep --column -v --not -e scalable --and --not -e fast -- README.md
  README.md:13:Git - fast, scalable, distributed revision control system
  README.md:16:Git is a fast, scalable, distributed revision control system with an

I wasn't sure where we landed in the discussion on "how much crazy stuff
to support". But AFAIK, the code in this iteration handles every crazy
case already except this one. If we're going to care about OR, maybe we
should just cover all cases.

> @@ -1429,7 +1447,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
>  	 */
>  	if (opt->columnnum && cno) {
>  		char buf[32];
> -		xsnprintf(buf, sizeof(buf), "%d", cno);
> +		xsnprintf(buf, sizeof(buf), "%zu", cno);

Unfortunately %z isn't portable. You have to use:

  xsnprintf(buf, sizeof(buf), "%"PRIuMAX, (uintmax_t)cno);

-Peff
