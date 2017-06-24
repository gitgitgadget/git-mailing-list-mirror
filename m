Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D2120401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdFXMDD (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:03:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:51688 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751272AbdFXMDB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:03:01 -0400
Received: (qmail 314 invoked by uid 109); 24 Jun 2017 12:03:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:03:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23027 invoked by uid 111); 24 Jun 2017 12:03:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:03:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:02:59 -0400
Date:   Sat, 24 Jun 2017 08:02:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 2/2] strbuf: change an always NULL/""
 strbuf_addftime() param to bool
Message-ID: <20170624120259.5kbmkww66tymxb5i@sigill.intra.peff.net>
References: <20170623164403.bxilz7k5ny7hs466@sigill.intra.peff.net>
 <20170624113635.16360-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170624113635.16360-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2017 at 11:36:35AM +0000, Ævar Arnfjörð Bjarmason wrote:

> >>  extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
> >>  			    const struct tm *tm, int tz_offset,
> >> -			    const char *tz_name);
> >> +			    const int omit_strftime_tz_name);
> >
> > This would need the new name, too (whatever it is).
> 
> *Nod*. Now the parameter is called suppress_tz_name.

Thanks. That sounds good (and your initial re-ordering patch looks fine,
too). One minor typo:

> diff --git a/strbuf.h b/strbuf.h
> index 6708cef0f9..d3e6e65123 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -343,11 +343,12 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>   * of Greenwich, and it's used to expand %z internally.  However, tokens
>   * with modifiers (e.g. %Ez) are passed to `strftime`.
> - * `tz_name` is used to expand %Z internally unless it's NULL.
> + * `suppress_tz_name` when set, means let suppress the `strftime` %Z
> + * format and replace it with an empty string.

I couldn't quite parse "let suppress". I'm not sure if it was supposed
to be "let's". Probably "means to suppress the strftime..." would be
more clear. I'd probably have written it more like:

  `suppress_tz_name`, when set, expands %Z internally to the empty
  string rather than passing it to `strftime`.

-Peff
