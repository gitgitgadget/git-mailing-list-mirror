Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FF0C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLNUfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiLNUe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:34:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D3222
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:28:19 -0800 (PST)
Received: (qmail 28145 invoked by uid 109); 14 Dec 2022 20:28:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 20:28:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22544 invoked by uid 111); 14 Dec 2022 20:28:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 15:28:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 15:28:18 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] ref-filter: factor out "%(foo) does not take
 arguments" errors
Message-ID: <Y5ox4ib0KvslKlr/@coredump.intra.peff.net>
References: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>
 <Y5n3n7Gp2gKNMln3@coredump.intra.peff.net>
 <Y5opRTGtrpoLsSF6@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5opRTGtrpoLsSF6@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 02:51:33PM -0500, Taylor Blau wrote:

> > +static int err_no_arg(struct strbuf *sb, const char *name)
> > +{
> > +	strbuf_addf(sb, _("%%(%s) does not take arguments"), name);
> > +	return -1;
> > +}
> > +
> 
> Why introduce such a function? strbuf_addf_ret() already takes a format
> string with additional vargs, so it should suffice to replace existing
> calls with:
> 
>   return strbuf_addf_ret(err, -1, _("%%(%s) does not take arguments"), "objecttype");
> 
> Playing devil's advocate for a moment, I suppose arguments in favor of
> err_no_arg() might be:
> 
>   - It does not require callers to repeat the translation key each time.
>   - It requires fewer characters to call.

Yes. My primary motivation was avoiding repeated strings that are
supposed to be the same (but nothing is checking). You could also
accomplish that by pulling the format string into a variable, but I
think that readability suffers (since you don't see the format string in
the addf call that is passing in the varargs).

As you saw, I ended up also making the function more complicated in a
later patch, though that really did come later and wasn't part of my
motivation (for once my commit messages were actually written in
order!). I considered going back and mentioning it in this commit
message, but I though the "don't repeat yourself" motivation was
sufficient. Maybe that's not so, though.

> So I think either is fine, though it might be cleaner to implement
> err_no_arg() in terms of strbuf_addf_ret() like:
> 
>   static int err_no_arg(struct strbuf *sb, const char *name)
>   {
>     return strbuf_addf_ret(sb, -1, _("%%(%s) does not take arguments"), name);
>   }

That was actually what I wrote initially, but it seemed less readable to
me. In the middle of a parsing function which is conditionally reporting
an error, smooshing two lines to one has value. Here in a helper, it
seemed like a net negative. Maybe it's just me, though.

-Peff
