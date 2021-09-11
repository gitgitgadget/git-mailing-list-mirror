Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E78AC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDA8611AD
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 21:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhIKVVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 17:21:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:45230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhIKVVS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 17:21:18 -0400
Received: (qmail 13416 invoked by uid 109); 11 Sep 2021 21:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 21:20:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24886 invoked by uid 111); 11 Sep 2021 21:20:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 17:20:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 17:20:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] midx: inline nth_midxed_pack_entry()
Message-ID: <YT0dgTgLVrtS9md6@coredump.intra.peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
 <YTziaNywmCMn07IS@coredump.intra.peff.net>
 <120ffa79-d3cb-2e81-1da6-358e7407ec69@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <120ffa79-d3cb-2e81-1da6-358e7407ec69@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 10:31:34PM +0200, René Scharfe wrote:

> Am 11.09.21 um 19:07 schrieb Jeff King:
> > On Sat, Sep 11, 2021 at 06:08:42PM +0200, René Scharfe wrote:
> >
> >> @@ -304,8 +307,7 @@ static int nth_midxed_pack_entry(struct repository *r,
> >>  	if (!is_pack_valid(p))
> >>  		return 0;
> >>
> >> -	nth_midxed_object_oid(&oid, m, pos);
> >> -	if (oidset_contains(&p->bad_objects, &oid))
> >> +	if (oidset_contains(&p->bad_objects, oid))
> >>  		return 0;
> >
> > So we get to avoid the nth_midxed_object_oid() copy entirely. Very nice.
> >
> > Compared to the code before your series, we still have an extra function
> > call to oidset_contains(), which will (in the common case) notice we
> > have no entries and immediately return. But I think that's getting into
> > pointless micro-optimization.
> 
> Right.  I measure a 0.5% slowdown for git multi-pack-index verify.  An
> inline oidset_size call avoids it.  That's easy enough to add, so let's
> have it!

I don't mind that, but I wonder if we can have our cake and eat it, too.

oidset_contains() is short, too, and could be inlined. Or if we're
worried about the size of the embedded kh_get_oid_set() getting inlined,
we could do something like:

  static inline int oidset_contains(const struct oidset *set, const
				    struct object_id *oid)
  {
	if (!oidset_size(set))
		return 0;
	return oidset_contains_func(set, oid);
  }

That saves callers from having to deal with it, at the expense of a
slightly complicated oidset implementation.

I guess it's an extra integer comparison for callers that _do_ expect to
have a non-empty set. So maybe it is better left to the caller to
decide whether to optimize in this way.

(A totally inline oidset_contains() avoids the extra check, but possibly
at the cost of larger code size).

-Peff
