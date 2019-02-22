Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5232720248
	for <e@80x24.org>; Fri, 22 Feb 2019 14:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfBVOxq (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 09:53:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:54360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726090AbfBVOxq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 09:53:46 -0500
Received: (qmail 1390 invoked by uid 109); 22 Feb 2019 14:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 14:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28525 invoked by uid 111); 22 Feb 2019 14:53:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 09:53:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 09:53:44 -0500
Date:   Fri, 22 Feb 2019 09:53:44 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        John Keeping <john@keeping.me.uk>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH 1/2] rebase tests: test linear branch topology
Message-ID: <20190222145344.GA5090@sigill.intra.peff.net>
References: <20190221151009.GA24309@sigill.intra.peff.net>
 <20190221214059.9195-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221214059.9195-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 10:40:58PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Add tests rebasing a linear branch topology to linear rebase tests
> added in 2aad7cace2 ("add simple tests of consistency across rebase
> types", 2013-06-06).

I had trouble parsing this. Did you mean s/topology to/topology, similar
to/?

> These tests are duplicates of two surrounding tests that do the same
> with tags pointing to the same objects. Right now there's no change in
> behavior being introduced, but as we'll see in a subsequent change
> rebase can have different behaviors when working implicitly with
> remote tracking branches.

It took me a while to figure out what was new in these tests. Maybe:

  These tests are duplicates of two surrounding tests, but with one
  change: the existing tests refer to objects by their tag names, but
  here we'll use branches (pointing at the same objects).

But then I'm left wondering why that's important.

> While I'm at it add a --fork-point test, strictly speaking this is
> redundant to the existing '' test, as no argument to rebase implies
> --fork-point. But now it's easier to grep for tests that explicitly
> stress --fork-point.

That makes sense.

> +test_expect_success 'setup branches and remote tracking' '
> +	git tag -l >tags &&
> +	for tag in $(cat tags)
> +	do
> +		git branch branch-$tag $tag || return 1
> +	done &&

I don't think we need this extra tmpfile and cat, do we? I.e.,

  for tag in $(git tag -l)

would work. We should probably avoid depending on the exact output of
the porcelain "tag", though. Maybe:

  git for-each-ref \
    --format='create refs/heads/branch-%(refname:strip=2) %(objectname)' \
    refs/tags |
  git update-ref --stdin

which has the added bonus of using a constant number of processes.

-Peff
