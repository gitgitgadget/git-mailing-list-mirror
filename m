Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AE2C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B5221531
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgI2AaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:30:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:43860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgI2AaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:30:01 -0400
Received: (qmail 6865 invoked by uid 109); 29 Sep 2020 00:30:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2020 00:30:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13450 invoked by uid 111); 29 Sep 2020 00:30:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2020 20:30:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Sep 2020 20:30:00 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
Message-ID: <20200929003000.GA898702@coredump.intra.peff.net>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
 <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
 <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
 <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 04:26:38PM -0700, Carlo Arenas wrote:

> > -test_expect_success 'get: credentials with DOS line endings are invalid if path is relevant' '
> > +test_expect_success 'get: credentials with DOS line endings are valid if path is relevant' '
> 
> note that this test was put in place to protect users from regressions
> like the one we got after the release of 2.26.1 where users that had
> '\r' as part of their credentials were getting an error[1]
> 
> while I am sympathetic to the change (indeed I proposed something
> similar, but was reminded by Peff that while it looks like a text file
> it was designed to be considered opaque and therefore should use UNIX
> LF as record terminator by specification), I am concerned this could
> result in a similar regression since we know they are still users out
> there that had modified this file manually (something that was not
> recommended) and are currently relying on the fact that these lines
> are invalid and therefore silently ignored.

Going over that old thread, I'm not sure that anybody raised a real use
case where somebody expected a CR at the end of a line. The discussion
was mostly about whether proposed changes would or would not be
compatible with existing behavior.

I think that:

  - we'd never write a raw CR ourselves, as we'd urlencode the character

  - if somebody did put in a raw CR manually like:

      https://example.com\r\n

    then we'd currently fail to match "example.com". Which is probably
    not what they wanted. I suspect that \r in a hostname is bogus
    anyway (certainly curl will complain about it).

  - you could do the same in a path:

      https://example.com/foo\r\n

    which _is_ legal, but I think we'd generally ignore it completely
    unless credential.usehttppath is set (for network-accessible
    requests, that is; you could probably point your local cert file at
    something bogus, but I think the main areas of interest here are
    people manipulating the credential protocol via malicious urls).

So I'm OK loosening the format in the name of convenience, as long as
we're confident that it's not opening up any security problems. I can't
think of any such problems, though.

It sounds from your email like you may have found me arguing the
opposite. That's entirely possible. ;) But I couldn't find it in the
thread Junio linked.

-Peff
