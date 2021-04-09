Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E986C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA6D86023C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDIQFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:05:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:46384 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhDIQFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 12:05:41 -0400
Received: (qmail 31974 invoked by uid 109); 9 Apr 2021 16:05:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 16:05:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12720 invoked by uid 111); 9 Apr 2021 16:05:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 12:05:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 12:05:27 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/8] rev-parse: implement object type filter
Message-ID: <YHB7R8hVRt+V+i2W@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <xmqqblbdjzu6.fsf@gitster.g>
 <YGyjtCWqdeCj3S3U@coredump.intra.peff.net>
 <YHA3EkH3HDe45EKA@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHA3EkH3HDe45EKA@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 01:14:26PM +0200, Patrick Steinhardt wrote:

> > I dunno. Those aren't objections exactly. Just trying to put my finger
> > on why my initial reaction was "huh, why --filter?".
> 
> Yeah, I do kind of share these concerns. Ideally, we'd provide a nicer
> only-user-facing interface to query the repository for various objects.
> git-cat-file(1) would be the obvious thing that first gets into my mind,
> where it would be nice to have it filter stuff. But then on the other
> hand, it's really rather a simple "Give me what I tell you to" binary,
> which is probably a good thing. Other than that I don't think there's
> any executable that'd be a good fit -- we could do this via a new
> git-list-objects(1), but then again git-rev-list(1) already does most of
> what git-list-objects(1) would do, so why bother.

I don't think cat-file does quite the same thing. An important part of
rev-list is that it is traversing. So it is determining both
reachability, but also eliminating excluded objects. For example, there
is no cat-file equivalent (and can never be) of:

  git rev-list --objects --filter=object:type=blob $old..$new

Likewise for list-objects (which cat-file really _does_ cover, with
--batch-all-objects). Obviously you can pair rev-list with cat-file to
traverse and then filter, but the whole point of this series is to do so
more efficiently.

So I think putting this into rev-list is the only sensible option. The
question is just whether to use --filter, or if it should be:

  git rev-list --show-blobs --show-trees $old..$new

with rules like:

  - if no --show-X is given, show only commits

  - if one or more --show-X is given, show all of them (but nothing else)

  - --objects is equivalent to providing each of --show-commits
    --show-blobs --show-trees --show-tags

-Peff
