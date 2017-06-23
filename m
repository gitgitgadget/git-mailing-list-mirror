Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFF620282
	for <e@80x24.org>; Fri, 23 Jun 2017 15:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754435AbdFWPXr (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 11:23:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:50512 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753447AbdFWPXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 11:23:47 -0400
Received: (qmail 28257 invoked by uid 109); 23 Jun 2017 15:23:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 15:23:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14908 invoked by uid 111); 23 Jun 2017 15:23:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 11:23:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 11:23:45 -0400
Date:   Fri, 23 Jun 2017 11:23:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param
 to bool
Message-ID: <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net>
References: <20170623144603.11774-1-avarab@gmail.com>
 <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net>
 <8760fmka8t.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8760fmka8t.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 05:13:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > The idea was that eventually the caller might be able to come up with a
> > TZ that is not blank, but is also not what strftime("%Z") would produce.
> > Conceivably that could be done if Git commits carried the "%Z"
> > information (not likely), or if we used a reverse-lookup table (also not
> > likely).
> >
> > This closes the door on that.  Since we don't have immediate plans to go
> > that route, I'm OK with this patch. It would be easy enough to re-open
> > the door if we change our minds later.
> 
> Closes the door on doing that via passing the char * of the prepared
> custom tz_name to strbuf_addftime().
> 
> I have a WIP patch (which may not make it on-list, depending) playing
> with the idea I proposed in
> CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com which
> just inserts the custom TZ name based on the offset inside that `if
> (omit_strftime_tz_name)` branch.

OK. I'd assumed that would all happen outside of strbuf_addftime(). But
if it happens inside, then I agree a flag is better.

> >>   * Add the time specified by `tm`, as formatted by `strftime`.
> >> - * `tz_name` is used to expand %Z internally unless it's NULL.
> >>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
> >>   * of Greenwich, and it's used to expand %z internally.  However, tokens
> >>   * with modifiers (e.g. %Ez) are passed to `strftime`.
> >> + * `omit_strftime_tz_name` when set, means don't let `strftime` format
> >> + * %Z, instead do our own formatting.
> >
> > Since we now always turn it into a blank string, perhaps "do our own
> > formatting" could be more descriptive: we convert it into the empty
> > string.
> 
> Then we'd need to change this comment again if we had some patch like
> the one I mentioned above, I thought it was better to just leave this
> vague enough that we didn't need to do that.

Right, if you're going to do your own formatting inside the function,
then I agree the wording should be kept. But then "omit" is not really
the right word. Isn't it "tzname_from_tz" or something?

-Peff
