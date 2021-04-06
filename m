Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338D1C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D7F613AD
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhDFSJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:09:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:42850 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237456AbhDFSJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:09:01 -0400
Received: (qmail 8428 invoked by uid 109); 6 Apr 2021 18:08:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 18:08:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30846 invoked by uid 111); 6 Apr 2021 18:08:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 14:08:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 14:08:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/8] rev-parse: implement object type filter
Message-ID: <YGyjtCWqdeCj3S3U@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <xmqqblbdjzu6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblbdjzu6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 20, 2021 at 02:10:41PM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > this is the second version of my patch series which implements a new
> > `object:type` filter for git-rev-parse(1) and git-upload-pack(1) and
> > extends support for bitmap indices to work with combined filters.
> > ...
> > Please see the attached range-diff for more details.
> 
> Any comment from stakeholders?

Sorry, this languished on my to-review list for a while.

I took a careful look. I found a few small nits, but the code overall
looks pretty good.

I do still find the use of the filter code here a _little_ bit
off-putting. It makes perfect sense in some ways: we are asking rev-list
to filter the output, and it keeps our implementation nice and simple.
It took me a while to figure out what I think makes it weird, but I
think it's:

  - the partial-clone feature exposes the filter mechanism in a very
    transparent way. So while it's not _wrong_ to be able to ask for a
    partial clone of only trees, it's an odd thing that nobody would
    really use in practice. And so it's a bit funny that it gets
    documented alongside blob:limit, etc.

  - for the same reason, it's very rigid. We have no way to say "this
    filter OR that filter", and are unlikely to grow them (because this
    is all part of the network protocol). Whereas it's perfectly
    reasonable for somebody to ask for "trees and blobs" via rev-list.

I dunno. Those aren't objections exactly. Just trying to put my finger
on why my initial reaction was "huh, why --filter?".

-Peff
