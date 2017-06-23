Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D19C20282
	for <e@80x24.org>; Fri, 23 Jun 2017 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbdFWQoG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 12:44:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50638 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754011AbdFWQoG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 12:44:06 -0400
Received: (qmail 765 invoked by uid 109); 23 Jun 2017 16:44:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 16:44:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15942 invoked by uid 111); 23 Jun 2017 16:44:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 12:44:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 12:44:04 -0400
Date:   Fri, 23 Jun 2017 12:44:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH -v2] strbuf: change an always NULL/"" strbuf_addftime()
 param to bool
Message-ID: <20170623164403.bxilz7k5ny7hs466@sigill.intra.peff.net>
References: <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net>
 <20170623163606.27571-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170623163606.27571-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 04:36:06PM +0000, Ævar Arnfjörð Bjarmason wrote:

> I believe this addresses the comments in the thread so far. Also Re:
> René's "why const?" in a2673ce4-5cf8-6b40-d4db-8e2a49518138@web.de:
> Because tzname_from_tz isn't changed in the body of the function, only
> read.

Sure, it's not wrong. But that property is also held by 99% of the
parameters that are passed by value. It's the normal style in our code
base (and in most C code bases I know of) to never declare pass-by-value
as const. It pollutes the interface and isn't something the caller cares
about.

Without passing judgement on whether that style is good or not (though
IMHO it is), making this one case different than all the others is a bad
idea. It makes the reader wonder why it's different.

> diff --git a/date.c b/date.c
> index 1fd6d66375..17db07d905 100644
> --- a/date.c
> +++ b/date.c
> @@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>  			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
>  	else if (mode->type == DATE_STRFTIME)
>  		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
> -				mode->local ? NULL : "");
> +				mode->local);

You flipped the boolean here. That's OK by me. But in the definition...

>  void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
> -		     int tz_offset, const char *tz_name)
> +		     int tz_offset, const int tzname_from_tz)

Wouldn't tzname_from_tz only happen when we're _not_ in local mode? I
suggested that name anticipating your second patch to actually compute
it based on "tz". In local-mode it's not coming from tz, it's coming
from secret unportable magic (the combination of localtime() and
strftime()).

> @@ -815,8 +815,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>  			fmt++;
>  			break;
>  		case 'Z':
> -			if (tz_name) {
> -				strbuf_addstr(&munged_fmt, tz_name);
> +			if (!tzname_from_tz) {
>  				fmt++;
>  				break;
>  			}

This logic matches your inversion in the caller, so it does the right
thing. But I think the name is wrong, as above.

> index 4559035c47..eba5d59a77 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -340,14 +340,15 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
>  
>  /**
>   * Add the time specified by `tm`, as formatted by `strftime`.
> - * `tz_name` is used to expand %Z internally unless it's NULL.
>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>   * of Greenwich, and it's used to expand %z internally.  However, tokens
>   * with modifiers (e.g. %Ez) are passed to `strftime`.
> + * `tzname_from_tz` when set, means let `strftime` format %Z, instead
> + * of intercepting it and doing our own formatting.
>   */
>  extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
>  			    const struct tm *tm, int tz_offset,
> -			    const char *tz_name);
> +			    const int omit_strftime_tz_name);

This would need the new name, too (whatever it is).

-Peff
