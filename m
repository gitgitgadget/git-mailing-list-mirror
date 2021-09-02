Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A62BC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5368F6108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 23:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbhIBXFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 19:05:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:38406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244682AbhIBXFg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 19:05:36 -0400
Received: (qmail 25277 invoked by uid 109); 2 Sep 2021 23:04:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 23:04:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1863 invoked by uid 111); 2 Sep 2021 23:04:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 19:04:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 19:04:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] builtin/pack-objects.c: simplify
 add_objects_in_unpacked_packs()
Message-ID: <YTFYhG+nK49/jR/v@coredump.intra.peff.net>
References: <cover.1630291682.git.me@ttaylorr.com>
 <c857e12a032f197626cd6a5eb0eafc66afbb5bed.1630291682.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c857e12a032f197626cd6a5eb0eafc66afbb5bed.1630291682.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 10:48:54PM -0400, Taylor Blau wrote:

> +static int add_object_in_unpacked_pack(const struct object_id *oid,
> +				       struct packed_git *pack,
> +				       uint32_t pos,
> +				       void *_data)
>  {
> [...]
> +	struct object *obj = lookup_unknown_object(the_repository, oid);
> +	if (obj->flags & OBJECT_ADDED)
> +		return 0;
> +	add_object_entry(oid, obj->type, "", 0);
> +	obj->flags |= OBJECT_ADDED;
> +	return 0;
>  }

This is not new in your patch series, but while merging this with
another topic I had, I noticed another opportunity for optimization
here. We already know the pack/pos in which we found the object. But
when we call add_object_entry(), it will do another lookup, via
want_object_in_pack().

We could shortcut that by providing it with the extra information, the
way add_object_entry_from_bitmap() does. The original code before your
series could have done the same optimization, but it became much more
obvious after your series, since -Wunused-parameters notices that we do
not look at the "pack" or "pos" parameters at all. :)

It may not be that exciting an optimization, though. Pack lookups aren't
_that_ expensive, and the pack-mru code would mean we always find it in
the first pack (since by definition we're iterating through the objects
in whole packs, our locality is perfect).

It would also probably involve some slight refactoring of
add_object_entry() to avoid duplication (though possibly the result
could reduce similar duplication with the bitmap variant). Hmm, actually
looking further, we already have add_object_entry_from_pack() for
--stdin-packs.

So I offer it mainly as an observation, in case somebody wants to look
into it further (both for the optimization and the possibility of
simplifying the code).

-Peff
