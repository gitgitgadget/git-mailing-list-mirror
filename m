Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8784A1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 06:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJDNkU (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 09:40:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:41046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726899AbeJDNkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 09:40:20 -0400
Received: (qmail 2970 invoked by uid 109); 4 Oct 2018 06:48:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 06:48:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22790 invoked by uid 111); 4 Oct 2018 06:47:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Oct 2018 02:47:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2018 02:48:34 -0400
Date:   Thu, 4 Oct 2018 02:48:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] oidset: use khash
Message-ID: <20181004064833.GA9051@sigill.intra.peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <5efe6695-2e82-786c-1170-7874978cb534@web.de>
 <20181003194051.GB20709@sigill.intra.peff.net>
 <d17f104e-7cc2-5e73-78c9-6c268f9ec5b2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d17f104e-7cc2-5e73-78c9-6c268f9ec5b2@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 07:56:44AM +0200, René Scharfe wrote:

> > As the comment above notes, I think we're really looking at the case
> > where this gets populated on the first call, but not subsequent ones. It
> > might be less hacky to use a "static int initialized" here. Or if we
> > want to avoid hidden globals, put the logic into filter_refs() to decide
> > when to populate.
> 
> Right.  I'd prefer the latter, but was unable to find a nice way that
> still populates the oidset lazily.  It's certainly worth another look,
> and a separate series.

It's a little awkward because the lazy load happens in a conditional.
You can fully encapsulate it like the patch below, but I actually don't
think it's really helping readability.

> >> +KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
> > 
> > This will declare these "static inline". Our other major "macros become
> > inline functions" code is commit-slab.h, and there we found it necessary
> > to add MAYBE_UNUSED. I wonder if we ought to be doing the same here (I
> > don't get any warnings, but I suspect sparse might complain).
> 
> I doubt it (but didn't check) because khash.h defines kh_clear_##name(),
> which we don't use it anywhere and there have been no complaints so far.
> And if we wanted to add MAYBE_UNUSED then the right place for that would
> be in KHASH_INIT, no?

Right, that would be the correct spot. I'm OK to leave it until somebody
complains. Looking at commit-slab again, its functions are straight
statics, not static inline. That's probably the important difference.

> > It might be nice if these functions could hide inside oidset.c (and just
> > declare the struct here). It looks like we might be able to do that with
> > __KHASH_TYPE(), but the double-underscore implies that we're not
> > supposed to. ;)
> > 
> > I guess we also use a few of them in our inlines here. I'm not 100% sure
> > that oidset_* needs to be inlined either, but this is at least a pretty
> > faithful conversion of the original.
> 
> We could inline all of the oidset functions, following the spirit of
> klib/khash.h.
> 
> Or we could uninline all of them and then may be able to clean up
> oidset.h by using KHASH_DECLARE.  Perhaps we'd need to guard with an
> "#ifndef THIS_IS_OIDSET_C" or similar to avoid a clash with KHASH_INIT.
> 
> Not sure if any of that would be a worthwhile improvement..

Unless we know something is a performance win to inline, I'd generally
prefer not to.

For a case like this with auto-generated functions, I'm mostly worried
about bloating the compiled code. Either with a bunch of inlined
non-trivial functions, or cases where the compiler says "this is too big
to inline" and generates an anonymous file-scope function, but we end up
with a bunch of duplicates, because we're generating the same functions
in a bunch of C files.

I may be worried about nothing, though. I don't know how clever the
compiler and linker can be there.

-Peff
