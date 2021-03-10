Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4417C433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAC864FC8
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhCJRGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 12:06:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:58688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233224AbhCJRGe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 12:06:34 -0500
Received: (qmail 6399 invoked by uid 109); 10 Mar 2021 17:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Mar 2021 17:06:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23330 invoked by uid 111); 10 Mar 2021 17:06:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Mar 2021 12:06:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Mar 2021 12:06:33 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/3] sha256 fixes for filter-branch
Message-ID: <YEj8meoPn/g6tCe3@coredump.intra.peff.net>
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net>
 <20200729231428.3658647-1-sandals@crustytoothpaste.net>
 <8735x3i59m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735x3i59m.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 01:04:37PM +0100, Ævar Arnfjörð Bjarmason wrote:

> I found a missing spot that wasn't trivial to fix, so sending an E-Mail:
> 
> In git-filter-branch.sh we have:
> 
> _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> 
> Then later we have a case condition based on matching a SHA-1:
> 
>         $_x40)
>                 echo "Ref '$ref' was rewritten"
>                 if ! git update-ref -m "filter-branch: rewrite" \
> 
> Just deleting that case arm has filter-branch tests passing, so whatever
> it's meant to do it has zero coverage, which explains why it hasn't
> broken with our tests.

It actually does get covered. Dropping that case-arm means we'll fall
through to the one below, which does _roughly_ the same thing with a
bunch of extra warnings. But none of the tests actually check the error
messages, so they don't notice.

Here's a series which fixes it, plus extra tests to notice the
distinction.

  [1/3]: t7003: test ref rewriting explicitly
  [2/3]: filter-branch: drop multiple-ancestor warning
  [3/3]: filter-branch: drop $_x40 glob

 git-filter-branch.sh     | 16 ++--------------
 t/t7003-filter-branch.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 14 deletions(-)

-Peff
