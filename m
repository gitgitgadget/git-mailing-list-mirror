Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F6C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6424C206E6
	for <git@archiver.kernel.org>; Tue,  5 May 2020 17:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgEERBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 13:01:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:37980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728804AbgEERBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 13:01:05 -0400
Received: (qmail 13493 invoked by uid 109); 5 May 2020 17:01:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 May 2020 17:01:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31595 invoked by uid 111); 5 May 2020 17:01:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 May 2020 13:01:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 May 2020 13:01:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Provide option to opt in/out GitHub Actions
Message-ID: <20200505170104.GD64077@coredump.intra.peff.net>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <cover.1588695295.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1588695295.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 11:26:38PM +0700, Đoàn Trần Công Danh wrote:

> It seems like there're 2 schools for GitHub Actions,
> - Opt-in by using some specific patterns
> - Opt-out by using some specific patterns
> 
> I tried to help everyone happy, but with my current knowledge, I couldn't.

Yeah, I agree it's not possible to make anyone happy.

I think the special handling of git/git and gitster/git in patch 3 is
not worth doing. That case is already easy to solve because it's two
repos: just turn off Actions in gitster/git if Junio isn't looking at
the results, and leave them on in git/git.

The real problem we're trying to solve is people with forks who might
want some branches with CI, but not others. Right now the only solution
is for them to make a separate repository, and push to both.

To do that we need some way of getting per-branch information into the
Actions workflow. The ideal solution would just pull extra data from
some other ref or config within the repository, but there doesn't seem
to be a way to do that.

So we're left with:

  - changing the tree of the branch; this is painful to manage, and the
    tree changes risk leaking out when we send out patches, etc. I think
    we all agree this is too horrible.

  - annotating the commit message with [skip ci] or similar. This is
    less painful, but still risks leaking out during patch mailing, etc.

  - sticking data in the branch name. This is the "for-ci" thing, which
    requires you to opt-in to CI. But it could be -wip or -no-ci or
    whatever, which would flip the default.

The third one seems like the only workable thing, so we have to pick a
direction. I prefer "for-ci" to "no-ci" because it's easier to add a
refspec to push to for-ci/* than it is to remember to put "no-ci" in
every branch name that you _don't_ want built.

-Peff
