Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96257C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DAC20786
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgKCSVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:21:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:46448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCSVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:21:04 -0500
Received: (qmail 6792 invoked by uid 109); 3 Nov 2020 18:21:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Nov 2020 18:21:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3221 invoked by uid 111); 3 Nov 2020 18:21:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Nov 2020 13:21:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Nov 2020 13:21:02 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Sathyajith Bhat <sathya@sathyasays.com>, git@vger.kernel.org
Subject: Re: Segfault in git when using git logs
Message-ID: <20201103182102.GA459792@coredump.intra.peff.net>
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <20201102144321.GA3962443@coredump.intra.peff.net>
 <20201103101553.GH24813@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103101553.GH24813@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 03, 2020 at 11:15:53AM +0100, SZEDER Gábor wrote:

> > > Now, use git log to show commit logs using command
> > > 
> > >         git log  --follow -L 1,1:hello.log -- hello.log
> 
> While Git should never segfault, no matter what, this is a bogus git
> invocation to begin with: the second sentence in the description of
> 'git log -L' clearly states that "You may not give any pathspec
> limiters", so this command should have errored out from early days,
> but, unfortunately, it was never enforced.  This also means that '-L'
> and '--follow' are incompatible, because while the former forbids any
> pathspecs, the latter requires exactly one; and line-level
> log does its own rename following anyway.

Thanks for confirming. My "I am not clear how these should interact" was
really "this does not make any sense to me" in my head, but I was afraid
that I was missing something. The fact that we document explicitly that
-L should not be combined with pathspecs makes that much more obvious.

> VS Code should be fixed to call 'git log -L 1,1:hello.log' instead,
> without '--follow' and without pathspec.

Agreed.

On our side, I don't think it would be _wrong_ to catch and disallow the
combination. But it may be nicer to them if we continue to quietly
ignore --follow and the pathspec in that case, for working with older
versions. (OTOH, if I understand correctly they're segfaulting every
time VS Code is used with v2.29 now, so they may have to accept it as an
urgent fix anyway).

-Peff
