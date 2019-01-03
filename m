Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34E241F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfACHhh (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:37:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:53620 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730063AbfACHhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:37:37 -0500
Received: (qmail 25857 invoked by uid 109); 3 Jan 2019 07:37:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 07:37:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8639 invoked by uid 111); 3 Jan 2019 07:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 02:37:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 02:37:35 -0500
Date:   Thu, 3 Jan 2019 02:37:35 -0500
From:   Jeff King <peff@peff.net>
To:     "Stephen P . Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] Add 'human' date format
Message-ID: <20190103073735.GB24925@sigill.intra.peff.net>
References: <20181231003150.8031-1-ischis2@cox.net>
 <20181231003150.8031-2-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181231003150.8031-2-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 30, 2018 at 05:31:48PM -0700, Stephen P. Smith wrote:

> Also add 'auto' date mode, which defaults to human if we're using the
> pager.  So you can do
> 
> 	git config --add log.date auto
> 
> and your "git log" commands will show the human-legible format unless
> you're scripting things.

I like the idea of "human", and I like the idea of "auto", but it seems
to me that these are really two orthogonal things. E.g., might some
people not want to do something like:

  git config log.date auto:relative

?

I don't personally care about using this myself, but we already had to
deal with retrofitting "local" as a modifier. I'd prefer to avoid making
the same mistake again.

(I'd actually argue that "log.date" should basically _always_ have the
"auto" behavior, since it tends to get treated as plumbing anyway, and I
suspect that anybody who sets log.date now would see subtle breakage
from scripts. But maybe it's too late at this point?).

> diff --git a/builtin/blame.c b/builtin/blame.c
> index 6d798f9939..f684e31d82 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -925,6 +925,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  		 */
>  		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
>  		break;
> +	case DATE_HUMAN:
> +		/* If the year is shown, no time is shown */
> +		blame_date_width = sizeof("Thu Oct 19 16:00");
> +		break;

OK, and we expect the year to be less than 5 characters. I briefly
wondered what would happen at Y100K (or somebody maliciously using a
bogus year), but it is not a buffer overflow. It is simply a mis-aligned
blame line (and actually, the same goes for the existing entries, which
use a 4-digit year).

-Peff
