Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69300C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4262B613B8
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbhDMHkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:40:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:50854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238266AbhDMHj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 03:39:58 -0400
Received: (qmail 28698 invoked by uid 109); 13 Apr 2021 07:39:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Apr 2021 07:39:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23245 invoked by uid 111); 13 Apr 2021 07:39:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Apr 2021 03:39:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Apr 2021 03:39:36 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: update "nr_seen" progress based on
 pack-reused count
Message-ID: <YHVKuFaR/AjYhf9b@coredump.intra.peff.net>
References: <YHPBXu9R/7i1jZhy@coredump.intra.peff.net>
 <06e42cf3-188c-d314-b3b9-bdb2f43a37e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06e42cf3-188c-d314-b3b9-bdb2f43a37e6@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 08:48:24PM -0400, Derrick Stolee wrote:

> On 4/11/2021 11:41 PM, Jeff King wrote:> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 525c2d8552..faee5a5c76 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -3527,7 +3527,8 @@ static int get_object_list_from_bitmap(struct rev_info *revs)
> >  			&reuse_packfile_bitmap)) {
> >  		assert(reuse_packfile_objects);
> >  		nr_result += reuse_packfile_objects;
> > -		display_progress(progress_state, nr_result);
> > +		nr_seen += reuse_packfile_objects;
> > +		display_progress(progress_state, nr_seen);
> 
> nr_seen and nr_result are defined in the same line with nr_written,
> as static globals. I can understand how this mistake happened.

I think it is even more subtle than that. Both topics (the one to
convert callers to use nr_seen as progress, and the one adding this call
to use nr_result for progress) were "in flight" at the same time, but in
a funny way. The latter was written much earlier in a fork of Git, but
not sent upstream immediately. So the nr_seen conversion didn't know
about it, and later the other topic was "merged" (actually,
cherry-picked) into upstream.

So it really is a semantic conflict when merging two branches that
happened simultaneously. It's a little odd in that the branches were
running simultaneously for years, but the same thing could happen even
with two topics much closer together.

Anyway, that's all just an interesting sidenote.

> There are no other places where nr_result is used for
> display_progress() while nr_seen _is_ used a couple more times.

Thanks for double-checking. That make sense, since we added only this
one call, and the others were all converted to nr_seen when it was
introduced.

-Peff
