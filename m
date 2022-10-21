Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF17C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJUFDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJUFDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:03:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B8C1DED67
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:03:41 -0700 (PDT)
Received: (qmail 10434 invoked by uid 109); 21 Oct 2022 05:03:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:03:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1131 invoked by uid 111); 21 Oct 2022 05:03:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:03:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:03:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y1IoLBvVfo+pIC+6@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
 <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
 <Y0TLf/J22ioQ5UCt@nand.local>
 <Y1H9xdDJS+xKW8mS@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1H9xdDJS+xKW8mS@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 10:02:45PM -0400, Taylor Blau wrote:

> > > > -	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
> > > > -		strbuf_reset(&ident);
> > > > -		format_commit_message(commit,
> > > > -				      log->email ? "%aN <%aE>" : "%aN",
> > > > -				      &ident, &ctx);
> > > > -		if (!HAS_MULTI_BITS(log->groups) ||
> > > > -		    strset_add(&dups, ident.buf))
> > > > -			insert_one_record(log, ident.buf, oneline_str);
> > > > -	}
> > >
> > > This loses the HAS_MULTI_BITS() optimization. The idea there is that if
> > > you have a single group-by that can't produce multiple outputs, then
> > > there's no need to do duplicate detection.
> > >
> > > The equivalent in an all-formats world is something like:
> > >
> > >   log.format.nr > 1 && !log.trailers.nr
> > >
> > > (because trailers are special in that one trailer key can produce
> > > multiple idents for a single commit).
> 
> Hmm. Shouldn't that "&& !log.trailers.nr" be an "|| log.trailers.nr"? It
> doesn't seem to make sense to say "there are things that could produce
> multiple outputs" if there's more than one format _and_ no trailers.

Yeah. I was thinking of it as "is it OK to not de-dup", but of course it
is the other way around because of the "!". And regardless of which way
you write the conditional, the two sides must agree. ;)

> The logic should read "there are things that could produce multiple
> outputs if there is more than one format *or* at least one trailer".
> 
> So I think the right change would be:
> 
> --- >8 ---
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 95ceab7649..7e1b56e2aa 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -216,7 +216,8 @@ static void insert_records_from_format(struct shortlog *log,
> 
>  		format_commit_message(commit, item->string, &buf, ctx);
> 
> -		if (strset_add(dups, buf.buf))
> +		if (!(log->format.nr > 1 || log->trailers.nr) ||
> +		    strset_add(dups, buf.buf))
>  			insert_one_record(log, buf.buf, oneline);
>  	}
> --- 8< ---
> 
> Yeah?

Right. I wondered if it might be a little clearer to drop the outer "!",
which yields:

  if ((log->format.nr <= 1 && !log->trailers.nr) ||
      strset_add(dups, buf.buf))

but it is not really any less confusing. If we gave that first part of
the conditional a name, like:

  if (!needs_dedup(log) || strset_add(dups, buf.buf))

maybe that is better. I dunno.

Regardless, what you wrote above is correct. Thanks for catching it.

-Peff
