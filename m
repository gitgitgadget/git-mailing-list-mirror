Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2DA1FAE5
	for <e@80x24.org>; Wed,  7 Jun 2017 08:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbdFGIRg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 04:17:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:35763 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbdFGIRc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 04:17:32 -0400
Received: (qmail 8727 invoked by uid 109); 7 Jun 2017 08:17:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 08:17:31 +0000
Received: (qmail 31302 invoked by uid 111); 7 Jun 2017 08:17:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Jun 2017 04:17:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jun 2017 04:17:29 -0400
Date:   Wed, 7 Jun 2017 04:17:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
Message-ID: <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
References: <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 03, 2017 at 12:40:34PM +0200, René Scharfe wrote:

> There is no portable way to pass timezone information to strftime.  Add
> parameters for timezone offset and name to strbuf_addftime and let it
> handle the timezone-related format specifiers %z and %Z internally.
> Callers can opt out by passing NULL as timezone name.
> 
> Use an empty string as timezone name in show_date (the only current
> caller) for now because we only have the timezone offset in non-local
> mode.  POSIX allows %Z to resolve to nothing in case of missing info.

This direction looks good to me overall. It's not pretty, but I think
it's the least-bad option.

> ---
> Duplicates strbuf_expand to a certain extent, but not too badly, I
> think.  Leaves the door open for letting strftime handle the local
> case.

I guess you'd plan to do that like this in the caller:

  if (date->local)
	tz_name = NULL;
  else
	tz_name = "";

and then your strftime() doesn't do any %z expansion when tz_name is
NULL.

I was thinking that we would need to have it take the actual time_t, and
then it would be able to do the tzset/localtime dance itself. But since
I don't think we're planning to do that (if anything we'd just handle
the normal localtime() case), the complication it would add to the
interface isn't worth it.

> -void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
> +void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
> +		     int tz_offset, const char *tz_name)
>  {
> +	struct strbuf munged_fmt = STRBUF_INIT;

Now we're doing two types of munging: sometimes handling %z, and
sometimes the extra-space hack. I had to read through it carefully to
make sure we handle all cases correctly, but I think it works.

In particular, I worried about us setting "fmt" to munged_fmt.buf for
the %z case, and then later adding the extra space to it for the
zero-length hack, which might reallocate, leaving "fmt" pointing to
unallocated memory. But it's OK because at that point we never touch the
original "fmt" again.

>  /**
> - * Add the time specified by `tm`, as formatted by `strftime`.
> - */
> -extern void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm);
> + * Add the time specified by `tm`, as formatted by `strftime`.  `tz_offset`
> + * and `tz_name` are used to expand %z and %Z internally, unless `tz_name`
> + * is NULL.  `tz_offset` is in decimal hhmm format, e.g. -600 means six
> + * hours west of Greenwich.
> + */
> +extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
> +			    const struct tm *tm, int tz_offset,
> +			    const char *tz_name);

Good, documentation (the diff order put the implementation first so I
scratched my head for a moment before realizing you had already
described it).

-Peff
