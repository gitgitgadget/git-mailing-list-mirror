Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FF7C433FE
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B091E611F0
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhIKREe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:04:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:45076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhIKREc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:04:32 -0400
Received: (qmail 12770 invoked by uid 109); 11 Sep 2021 17:03:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 17:03:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22324 invoked by uid 111); 11 Sep 2021 17:03:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 13:03:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 13:03:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] packfile: use oidset for bad objects
Message-ID: <YTzhVfmObOf7DHqm@coredump.intra.peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <14d48124-d8bb-aa34-aad0-4203d699e17e@web.de>
 <YTy8o3qXvyVv8fNr@coredump.intra.peff.net>
 <3d637be1-f89f-414c-19ef-65c3943457e9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d637be1-f89f-414c-19ef-65c3943457e9@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 06:08:38PM +0200, René Scharfe wrote:

> >> +	nth_midxed_object_oid(&oid, m, pos);
> >> +	if (oidset_contains(&p->bad_objects, &oid))
> >> +		return 0;
> >
> > Calling nth_midxed_object_oid() implies a memcpy() under the hood. In
> > the old code, we'd skip that in the common case that we had no corrupt
> > objects, but now we'll pay the cost regardless. memcpy() isn't _that_
> > expensive, but I'd expect this to be a relatively hot code path.
> >
> > Is it worth sticking all of this inside:
> >
> >   if (oidset_size(&p->bad_objects))
> >
> > ?
> 
> Hard to say.  It would certainly match the old code more closely.  Is a
> function call cheaper than copying 32 bytes?  Depends on the CPU and
> whether the hash is cached, I guess.  And cached it probably is, because
> the caller did a binary search for it..

You already have a function call for nth_midxed_object_oid(), so
checking oidset_size() would be a strict improvement.

> We can pass on the original oid to avoid the nth_midxed_object_oid()
> call, but inlining the whole thing might even be nicer.

Yeah, it occurs to me that oidset_size() would be a good candidate for
inlining, if that's what you mean.

-Peff
