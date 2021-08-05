Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3FCC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B276160231
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 20:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbhHEU3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:29:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:40742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236102AbhHEU3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 16:29:24 -0400
Received: (qmail 12727 invoked by uid 109); 5 Aug 2021 20:29:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Aug 2021 20:29:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7246 invoked by uid 111); 5 Aug 2021 20:29:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Aug 2021 16:29:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Aug 2021 16:29:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
Message-ID: <YQxKEyHXm2W2Y3M5@coredump.intra.peff.net>
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
 <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
 <87y29fzp5f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y29fzp5f.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 09:05:59PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Wed, Aug 04 2021, Jeff King wrote:
> 
> > [...]
> > If we don't go that route, there's another possible speedup: after
> > parsing a tag, the type of tag->tagged (if it is not NULL) will be known
> > from the tag's contents, and we can avoid the oid_object_info_extended()
> > type lookup. It might need some extra surgery to convince the tag-parse
> > not to fetch promisor objects, though.
> >
> > I'm not sure it would make that big a difference, though. If we save one
> > type-lookup per parsed tag, then the tag parsing is likely to dwarf it.
> 
> Except that the tag type can be a lie, as our tests and some recent
> object/fsck serieses (not yet integrated) from me show. It can be relied
> upon for >99.99% of cases, but code like that needs to make sure it's
> not segfaulting or whatever if that relationship doesn't hold.

Yes, but we'd discover that when we called repo_parse_commit(), and
Patrick's patch already handles failure there.

-Peff
