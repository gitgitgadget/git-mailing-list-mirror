Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719FFC48BE5
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5071461107
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 18:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhFVS7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 14:59:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:36268 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhFVS7w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 14:59:52 -0400
Received: (qmail 6519 invoked by uid 109); 22 Jun 2021 18:57:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 18:57:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29578 invoked by uid 111); 22 Jun 2021 18:57:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 14:57:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 14:57:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Message-ID: <YNIyn7dksqMtkuk/@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
 <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
 <875yy53juu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yy53juu.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 07:06:43PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > @@ -155,9 +156,10 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
> >  		return 0;
> >  	}
> >  
> > -	obj = parse_object(the_repository, oid);
> > -	if (!obj)
> > +	objtype = oid_object_info(the_repository, oid, NULL);
> > +	if (type < 0)
> >  		return 0;
> > +	obj = lookup_object_by_type(the_repository, oid, objtype);
> 
> This series looks good. I just wonder if between this and my own
> lookup_{blob,tree,tag,commit}_type() in [1] whether exposing some
> function between what we have now in parse_object() and
> parse_object_buffer() wouldn't also do this for you.
> 
> I.e. in my patch if you pass a type into parse_object_buffer() I think
> you'll get the same behavior.

Maybe, but I'm having trouble seeing what would be a helpful
abstraction. I don't think I'd want to use parse_object_buffer() here;
we don't have a buffer at all (and obviously it could learn to handle
NULL, but that's extra code there).

parse_object_buffer() could call this lookup_object_by_type() to get the
struct, which would save it a few lines. But it still has to do the
if-else chain for each type, because it does other type-specific
things.

So I dunno. I would be happy if you came up with something, just because
it's nice to minimize the number of places that do this if-else/switch
on type. But I have a feeling it's diminishing returns in terms of
complexity. If we can at least contain it all to object.c, that's
something.

-Peff
