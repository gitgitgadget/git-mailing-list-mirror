Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F68C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A739613CC
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 17:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhDFRbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:31:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:42762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhDFRbH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 13:31:07 -0400
Received: (qmail 8212 invoked by uid 109); 6 Apr 2021 17:30:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 17:30:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30562 invoked by uid 111); 6 Apr 2021 17:30:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 13:30:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 13:30:57 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/8] revision: mark commit parents as NOT_USER_GIVEN
Message-ID: <YGya0XY969HlyPWl@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <ddbec7598664bceee50213a41fefa248d249435e.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddbec7598664bceee50213a41fefa248d249435e.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 02:14:36PM +0100, Patrick Steinhardt wrote:

> The NOT_USER_GIVEN flag of an object marks whether a flag was explicitly
> provided by the user or not. The most important use case for this is
> when filtering objects: only objects that were not explicitly requested
> will get filtered.
> 
> The flag is currently only set for blobs and trees, which has been fine
> given that there are no filters for tags or commits currently. We're
> about to extend filtering capabilities to add object type filter though,
> which requires us to set up the NOT_USER_GIVEN flag correctly -- if it's
> not set, the object wouldn't get filtered at all.
> 
> Mark unseen commit parents as NOT_USER_GIVEN when processing parents.
> Like this, explicitly provided parents stay user-given and thus
> unfiltered, while parents which get loaded as part of the graph walk
> can be filtered.
> 
> This commit shouldn't have any user-visible impact yet as there is no
> logic to filter commits yet.

I'm still scratching my head a bit to understand how NOT_USER_GIVEN can
possibly be correct (as opposed to USER_GIVEN). If we visit the commit
in a not-user-given context and add the flag, how do we know it wasn't
_also_ visited in a user-given context?

Just guessing, but perhaps the SEEN flag is saving us here? If we visit
the user-given commit itself first, then we give it the SEEN flag. Then
if we try to visit it again via parent traversal, we've already
processed it and don't add the NOT_USER_GIVEN flag here.

That seems the opposite of the order we'd usually traverse, but I think
we set SEEN on each commit in prepare_revision_walk(), before we do any
traversing.

So I _think_ it all works even with your changes here, but I have to say
this NOT_USER_GIVEN thing seems really fragile to me. Not new in your
series, of course, but something we may want to look at.

Just grepping around, "rev-list -g" will happily remove SEEN flags, so I
suspect it interacts badly with --filter. Just trying "rev-list -g
--objects --filter=object:type=blob HEAD" shows that it produces quite a
lot of commits (which I think is a more fundamental problem: it is not
walking the parent chain at all to assign these NOT_USER_GIVEN flags).

-Peff
