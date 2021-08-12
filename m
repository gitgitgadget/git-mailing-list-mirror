Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD80C4320A
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE3660FC0
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhHLUAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:00:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:45740 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhHLUAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:00:16 -0400
Received: (qmail 24633 invoked by uid 109); 12 Aug 2021 19:59:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 19:59:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25158 invoked by uid 111); 12 Aug 2021 19:59:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 15:59:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 15:59:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YRV9tXGTxziK3V7l@coredump.intra.peff.net>
References: <YP8F9ttlMXwNZBam@nand.local>
 <YP8zsR+W8JeCWc1Q@nand.local>
 <YQBCjSmdOPfrnNnK@coredump.intra.peff.net>
 <YQBEIrRfcq5dhpZn@nand.local>
 <YQBFi70c1wfXdKQf@coredump.intra.peff.net>
 <YQBGvEQoZpw49Z7L@nand.local>
 <YQBIqO5j0VHXL6V7@coredump.intra.peff.net>
 <YQBnE+ft/MR3zs1t@nand.local>
 <YQGX7SMu4UoTJ2VK@coredump.intra.peff.net>
 <YQMFIljXl7sAAA/L@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQMFIljXl7sAAA/L@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 03:44:34PM -0400, Taylor Blau wrote:

> >   Side note: IMHO the "check all packs to see if there are any other
> >   bitmaps to warn about" behavior is kind of pointless, and we should
> >   consider just returning as soon as we have one. This is already
> >   somewhat the case after your midx-bitmap patches, as we will not even
> >   bother to look for a pack bitmap after finding a midx bitmap. That is
> >   a good thing, because it means you can keep pack bitmaps around for
> >   flexibility. But let's leave any changes to the pack-only behavior out
> >   of this series for simplicity.
> 
> I agree. I'd be in favor of something like
> [...patch...]

Yep, that looks good. I'd be quite happy if you sent that once the dust
is settled.

> > But we do allow an "--object-dir" option to "multi-pack-index write",
> > and I don't see any other code explicitly requiring that it be part of
> > the current repository. What I'm wondering is whether this would be
> > breaking:
> >
> >   cd $REPO/..
> >   git multi-pack-index --object-dir $REPO/.git/objects write
> >
> > or:
> >
> >   cd /some/other/repo
> >   git multi-pack-index --object-dir $REPO/.git/objects write
> >
> > The latter does seem to work, but the former segfaults (usually -- if
> > there's already a midx it is OK).
> 
> The former should work, but doesn't, because (as you pointed out to me
> in our regular weekly discussion off-list) that the "multi-pack-index"
> entry in git.c's commands array has the RUN_SETUP_GENTLY option, and
> probably should have RUN_SETUP so that we complain with die() instead of
> BUG.
> 
> And the latter will continue to work, but only if in your scenario that
> $REPO is an alternate of /some/other/repo.
> 
> I wrote a little bit more in [1] about this behavior, but the upshot is
> that we used to technically support passing *any* directory to
> `--object-dir`, including directories that didn't belong to an
> alternated repository.
> 
> And that will cease to work after the patch that [1] is in response to
> is applied. But for the reasons that I explain there, I think that is a
> sufficient outcome, because the behavior is kind of bizarre to begin
> with.

Yeah, I think I am comfortable with the change at this point. The only
case that will be broken is one that is quite ridiculous, and I am
surprised worked in the first place. Thanks for talking it through.

-Peff
