Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF8F1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeHBSq5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 14:46:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:40500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726636AbeHBSq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 14:46:57 -0400
Received: (qmail 17401 invoked by uid 109); 2 Aug 2018 16:55:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 16:55:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25501 invoked by uid 111); 2 Aug 2018 16:54:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 12:54:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 12:54:58 -0400
Date:   Thu, 2 Aug 2018 12:54:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
Message-ID: <20180802165457.GC15984@sigill.intra.peff.net>
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 08:31:57AM -0700, Junio C Hamano wrote:

> > diff --git a/parse-options.c b/parse-options.c
> > index 7db84227ab..fadfc6a833 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
> >  static int usage_argh(const struct option *opts, FILE *outfile)
> >  {
> >  	const char *s;
> > -	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
> > +	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh ||
> > +		(opts->argh[0] == '<' && strchr(opts->argh, '>'));
> 
> You are greedier than what I thought ;-) I would have limited this
> magic to the case where argh is surrounded by "<>", but you allow
> one closing ">" anywhere, which allows us to grab more complex cases.
> 
> The lack of escape hatch to decline this auto-literal magic makes me
> somewhat nervous, but I do not offhand think of a reason why I do
> want an arg-help string that _begins_ with '<' to be enclosed by
> another set of "<>", so perhaps this is a good kind of magic.

I think that case is actually easy; once the caller provides a "<>",
they are in "literal" mode, so they are free to add extra brackets if
you want. I.e., any "<foo>bar" that you do want enclosed could be
spelled "<<foo>bar>". It's the opposite that becomes impossible: you do
not have an opening bracket and nor do you want one.  But as long as we
retain LITERAL_ARGHELP for that case, we have an escape hatch.

I was going to suggest that this conversion has the downside of being
somewhat one-way. That is, it is easy for us to find affected sites now
since they contain the string LITERAL_ARGHELP. Whereas if we wanted to
back it out in the future, it is hard to know which sites are depending
on this new behavior.

But I am having trouble thinking of a reason we would want to back it
out. This makes most cases easier, and has a good escape hatch.

-Peff

PS I actually would have made the rule simply "does it begin with a
   '<'", which seems simpler still. If people accidentally write "<foo",
   forgetting to close their brackets, that is a bug under both the
   old and new behavior (just with slightly different outcomes).
