Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D125B20282
	for <e@80x24.org>; Fri, 23 Jun 2017 14:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbdFWOvF (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 10:51:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:50458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750932AbdFWOvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 10:51:05 -0400
Received: (qmail 26005 invoked by uid 109); 23 Jun 2017 14:51:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 14:51:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14115 invoked by uid 111); 23 Jun 2017 14:51:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 10:51:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 10:51:03 -0400
Date:   Fri, 23 Jun 2017 10:51:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param
 to bool
Message-ID: <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net>
References: <20170623144603.11774-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170623144603.11774-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 02:46:03PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the code for deciding what's to be done about %Z to stop
> passing always either a NULL or "" char * to
> strbuf_addftime(). Instead pass a boolean int to indicate whether the
> strftime() %Z format should be omitted, which is what this code is
> actually doing.
> 
> This code grew organically between the changes in 9eafe86d58 ("Merge
> branch 'rs/strbuf-addftime-zZ'", 2017-06-22) yielding an end result
> that wasn't very readable. Out of context it looked as though the call
> to strbuf_addstr() might be adding a custom tz_name to the string, but
> actually tz_name would always be "", so the call to strbuf_addstr()
> just to add an empty string to the format was pointless.

The idea was that eventually the caller might be able to come up with a
TZ that is not blank, but is also not what strftime("%Z") would produce.
Conceivably that could be done if Git commits carried the "%Z"
information (not likely), or if we used a reverse-lookup table (also not
likely).

This closes the door on that.  Since we don't have immediate plans to go
that route, I'm OK with this patch. It would be easy enough to re-open
the door if we change our minds later.

>  /**
>   * Add the time specified by `tm`, as formatted by `strftime`.
> - * `tz_name` is used to expand %Z internally unless it's NULL.
>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>   * of Greenwich, and it's used to expand %z internally.  However, tokens
>   * with modifiers (e.g. %Ez) are passed to `strftime`.
> + * `omit_strftime_tz_name` when set, means don't let `strftime` format
> + * %Z, instead do our own formatting.

Since we now always turn it into a blank string, perhaps "do our own
formatting" could be more descriptive: we convert it into the empty
string.

-Peff
