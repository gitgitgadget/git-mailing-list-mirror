Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB8C77B7D
	for <git@archiver.kernel.org>; Sat,  6 May 2023 02:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjEFCNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 22:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjEFCNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 22:13:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383515FF2
        for <git@vger.kernel.org>; Fri,  5 May 2023 19:12:57 -0700 (PDT)
Received: (qmail 6171 invoked by uid 109); 6 May 2023 02:12:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 May 2023 02:12:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6281 invoked by uid 111); 6 May 2023 02:12:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 May 2023 22:12:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 May 2023 22:12:55 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <20230506021255.GA3798242@coredump.intra.peff.net>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLSDS89y8P2+g/2@nand.local>
 <20230505212631.GB3321533@coredump.intra.peff.net>
 <20230505221357.GD3321533@coredump.intra.peff.net>
 <ZFWbuf34pVxJyRiM@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFWbuf34pVxJyRiM@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 08:13:45PM -0400, Taylor Blau wrote:

> > @@ -78,7 +144,7 @@ static void add_recent_object(const struct object_id *oid,
> >  	struct object *obj;
> >  	enum object_type type;
> >
> > -	if (mtime <= data->timestamp)
> > +	if (!obj_is_recent(oid, mtime, data))
> >  		return;
> >
> >  	/*
> 
> ...this hunk. That only kicks in if you have other recent object(s),
> since the hooks are consulted as a side-effect of calling your new
> `obj_is_recent()` function.

I think we'll evaluate each object in the repo for recent-ness, via
for_each_loose_object and for_each_packed_object. So if an object exists
in the repo it will be evaluated here, as long as we are checking for
recent objects at all. And if it doesn't exist, then having the hook
tell us about it won't help; there is nothing for us to save (nor even
to use as a source of reachability, since we don't know what's in it).

Modulo the want_recent_object() thing you mentioned, of course, which is
evaluated first. And I could see that yeah, that might need to let the
hook override it, which shouldn't be too hard to do.

I'm not super familiar with this aspect of the cruft pack code. That
function is trying to avoid looking at objects that are in in-core kept
packs, which implies repack feeding those via stdin. Looking at
repack.c, we are feeding the existing packs we just wrote (so all of the
reachable stuff). So I can see why we might skip those packs, but at the
same time, we know we are keeping them (they were just written!) so they
are not really cruft candidates anyway. If an extraCruftTips hook told
us about them, would it matter? They are already being kept as
non-cruft.

But that is just an analysis based on 5 minutes of poking at the code. I
won't be surprised if I'm misunderstanding it or missing subtle cases.

-Peff
