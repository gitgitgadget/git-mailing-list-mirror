Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8E4C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F92610C8
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJ1RIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:08:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:48888 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhJ1RIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:08:43 -0400
Received: (qmail 16907 invoked by uid 109); 28 Oct 2021 17:06:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Oct 2021 17:06:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6385 invoked by uid 111); 28 Oct 2021 17:06:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Oct 2021 13:06:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Oct 2021 13:06:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation/Makefile: fix lint-docs mkdir dependency
Message-ID: <YXrYh9aPA8csq+UQ@coredump.intra.peff.net>
References: <YXeu4Hl2cmIPqobd@coredump.intra.peff.net>
 <xmqqlf2et3r3.fsf@gitster.g>
 <211028.861r45y3pt.gmgdl@evledraar.gmail.com>
 <YXq1OE/p5VoPR3WZ@coredump.intra.peff.net>
 <xmqqzgqtrtd1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzgqtrtd1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 09:45:14AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's an in-between, I'd think, where the many "foo/bar/baz/$@"
> > targets have an order-dependency on "foo/bar/baz", and that single rule
> > uses "mkdir -p" to create all of the directories.
> >
> > It doesn't buy us much simplification in this case, though, because
> > various rules independently depend on .build/gitlink/lint-docs/howto,
> > .built/gitlink/lint-docs, and .build/gitlink, etc. So we still end up
> > with roughly the same number of rules, though the directory rules don't
> > have to depend on one another.
> >
> > It also means that these "mkdir -p" may race with each other, though in
> > general I'd hope that most "mkdir" implements could handle this.
> >
> > Something like this works, I think:
> 
> Hmph, what I actually meant was to make sure that the recipe to
> create the files to have "mkdir -p $(basename $@)" in front, instead
> of having "we need to prepare the containing directory in order to
> have a file there" in the makefile.

Yeah, I agree that's simpler, and is what Ævar showed. But it is slower,
because we run a bunch of redundant "mkdir -p" calls, one per file.

-Peff
