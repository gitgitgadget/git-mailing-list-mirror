Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC85C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259BE61157
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhECOyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:54:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:43112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhECOx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:53:59 -0400
Received: (qmail 6025 invoked by uid 109); 3 May 2021 14:53:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 14:53:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4295 invoked by uid 111); 3 May 2021 14:53:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 10:53:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 10:53:05 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
Message-ID: <YJAOUZv0gTWrWd9L@coredump.intra.peff.net>
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
 <YIxRbOh4j9eFxBF3@coredump.intra.peff.net>
 <237482e4-8e21-5cd0-010e-09fb4ba8d27e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <237482e4-8e21-5cd0-010e-09fb4ba8d27e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 07:54:50AM -0400, Derrick Stolee wrote:

> > I'm not really opposed to disallowing this entirely (with an escape
> > hatch, as you have here), because it really is an awful practice for a
> > lot of reasons. But another option we discussed previously was to allow
> > the initial clone, but not store the password, which would result in the
> > user being prompted for subsequent fetches:
> > 
> >   https://lore.kernel.org/git/20190519050724.GA26179@sigill.intra.peff.net/
> > 
> > I think that third patch there is just too gross. But with the first
> > two, if you do have a credential helper configured, then:
> > 
> >   git clone https://user:pass@example.com/repo.git
> > 
> > would do what you want: clone with that user/pass, and then store the
> > result in the credential helper.
> 
> This seems like the best approach, as it presents the highest likelihood
> of working as expected in the automated scenarios. I will take a look to
> see how I could adapt those patches and maybe make the third one better.

IIRC, there was nothing too wrong with the patches. Reviewers had a few
small comments/fixups, but mostly I was on the fence on whether it was a
good idea at all, since it was not really my itch, and it was all
motivated by third-hand complaints about the behavior. Since nobody
brought it up more since then, I hadn't come back to it.

So I think it probably just needs a bit of polish, and to decide on
patch 3. If it helps, I've been rebasing it forward as:

  https://github.com/peff/git jk/clone-url-password-wip

but it's not part of my daily build, so caveat structor.

I don't think the third patch is wrong in _how_ it works. It's mostly
whether it's a good idea at all: we are not storing the file in
.git/config, but we are still storing it in ~/.git-credentials. That's
moderately better, but still not very secure.

If you do have a credential helper defined, then with just patch 2
everything would Just Work as you'd hope (and even with patch 3, we'll
skip using credential-store if you have something better defined).

> Is it possible that some Git installations have no credential helper? We
> can keep the "git clone" working in that scenario by storing the password
> in memory until the process completes, but later "git fetch" commands
> will fail.

I expect lots of installations have no helper configured. I don't think
any Linux distro packages ship with one configured. I think Apple Git
ships with osxkeychain configured, but I don't know whether the homebrew
recipe does, too. And of course anybody building from source is on their
own.

Hopefully some of those people install and configure a credential helper
on their own, but I expect it is wishful thinking to imagine that it's a
majority. :)

Even with just the first two patches, I believe the "in memory" thing
you suggest would already work. We feed the full URL to the transport
code, which can make us of it for the duration of the clone process.
It's only what we write into .git/config that is changed (so yes, future
fetches would fail).

-Peff
