Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A41C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BD2208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGaVgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:36:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:44470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgGaVgF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 17:36:05 -0400
Received: (qmail 26827 invoked by uid 109); 31 Jul 2020 21:36:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 21:36:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1507 invoked by uid 111); 31 Jul 2020 21:36:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 17:36:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 17:36:04 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <20200731213604.GA1457058@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
 <20200731210114.GC1440890@coredump.intra.peff.net>
 <20200731212905.GE3409@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731212905.GE3409@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 05:29:05PM -0400, Taylor Blau wrote:

> > > @@ -1029,6 +1040,11 @@ static void die_if_using_banned_filter(struct upload_pack_data *data)
> > >
> > >  	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
> > >  		    list_object_filter_config_name(banned->choice));
> > > +	if (banned->choice == LOFC_TREE_DEPTH &&
> > > +	    data->tree_filter_max_depth != ULONG_MAX)
> > > +		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
> > > +			    data->tree_filter_max_depth,
> > > +			    banned->tree_exclude_depth);
> >
> > Hmm. So I see now why you wanted to go with the strbuf in the earlier
> > patch. This does still feel awkward, though. You check "is it allowed"
> > in an earlier function, we get "nope, it's not allowed", and now we have
> > to reimplement the check here. That seems like a maintenance burden.
> 
> I'm not sure that I follow. Is the earlier function that you're
> referring to 'banned_filter'? If so, the only use of that function is
> within 'die_if_using_banned_filter'. 'banned_filter' exists only insofar
> as to answer the question "return me the first banned filter, if one
> exists, or NULL otherwise".
> 
> Then, dying here is as simple as (1) lookup the banned filter, and (2)
> check if it's NULL or not.
> 
> If you're referring to 'allows_filter_choice', I guess I see what you're
> getting it, but to be honest I'm not sure if I'm buying it.

Yeah, it's allows_filter_choice() that knows "if it's a tree we must
check the depth". And now die_if_using_banned_filter() needs to know
that, too. The policy is implemented twice.

I do appreciate that the way you've written it means that if somebody
forgets to update die_if_using_banned_filter() to match the logic in
allows_filter_choice(), we'd at least still die, just with a less good
error message. But it seems better still not to require the two to match
in the first place.

> If we were
> to combine 'allows_filter_choice', 'banned_filter', and
> 'die_if_using_banned_filter' into one function that traversed the filter
> tree and 'die()'d as soon as it got to a banned one, that function would
> have to know how to:
> 
>   1. Recurse through the tree when it hits a LOFC_COMBINE node.
> 
>   2. At each node, translate the filter->choice into the appropriate key
>   name, look it up, and then figure out how to interpret its allowed
>   status (including falling back to the default if unspecified).
> 
>   3. And, it would have to figure out how to format the message at each
>   step.
> 
> (3) I think is made easier, since we know what message to format based
> on whether or not we're in the 'opts->choice == LOFC_TREE_DEPTH' arm or
> not. But, there are two more things that we now have to cram into that
> same function.

You can still split those things into functions; see the patch I posted.

> Maybe I'm being too strict an adherent to having simpler functions, but
> I'm failing to see how to combine these in a way that's cleaner than
> what's written here.

To me this is less about "clean" and more about "don't ever duplicate
policy code". I don't mind duplicating boilerplate, but introducing a
place where somebody touching function X must remember to also touch Y
(and gets no compiler support to remind them) is a bad thing. I guess
you can call that "clean", but I'd take longer or more functions as a
tradeoff to avoid that.

My suggested patch does introduce more side effects. I think that's OK
because there really is only a single caller here. But if you wanted it
cleaner, then I think having allows_filter_choice() fill out an error
strbuf would eliminate my concern without drastically altering the flow
of your code.

-Peff
