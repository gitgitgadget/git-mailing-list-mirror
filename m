Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE0C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E48E2070A
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfLCPeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:34:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:37436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725997AbfLCPeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 10:34:16 -0500
Received: (qmail 9710 invoked by uid 109); 3 Dec 2019 15:34:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Dec 2019 15:34:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14185 invoked by uid 111); 3 Dec 2019 15:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2019 10:38:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Dec 2019 10:34:15 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191203153415.GA5813@sigill.intra.peff.net>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191202174035.GJ23183@szeder.dev>
 <20191202194231.GA10707@sigill.intra.peff.net>
 <20191203061744.GA74594@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191203061744.GA74594@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 02, 2019 at 10:17:44PM -0800, Taylor Blau wrote:

> > Good catch. The issue is that we only add entries to the hashmap in
> > prepare_packed_git(), but they may be added to the pack list by other
> > callers of install_packed_git(). It probably makes sense to just push
> > the hashmap maintenance down into that function, like below. That
> > requires an extra strhash() when inserting a new pack, but I don't think
> > that's a big deal.
> 
> Ah, great catch, and thanks for pointing it out. We have been running
> this patch in production at GitHub for a few weeks now, but didn't
> notice this because we never run tests with
> 'GIT_TEST_MULTI_PACK_INDEX=1' in the environment.
> 
> Perhaps in the future that might change, but I think that for now that
> can explain why the failure wasn't noticed earlier.

It would trigger in other contexts, too: anywhere we call
install_packed_git() outside of prepare_packed_git(). I think the main
reason we didn't notice in the tests or in production is that:

  - it would generally require re-scanning the pack directory, which
    implies an unexpected missing object (or a racy repack), which is
    not likely to happen during the tests

  - in most cases duplicates don't impact the outcome of the command at
    all. A duplicate entry in the packed_git list would just mean an
    extra pack to check for lookups. Most objects would be found in
    other packs (including its doppelganger entry), so the duplicate
    would float to the bottom of the MRU order. It's only lookups for
    objects we don't have that would pay a penalty (and it would be
    relatively small).

But obviously it's still worth fixing.

-Peff
