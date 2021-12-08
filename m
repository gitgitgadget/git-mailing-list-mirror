Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3CC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbhLHVzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:55:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhLHVzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:55:53 -0500
Received: (qmail 11426 invoked by uid 109); 8 Dec 2021 21:52:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 21:52:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8226 invoked by uid 111); 8 Dec 2021 21:52:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Dec 2021 16:52:20 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Dec 2021 16:52:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Message-ID: <YbEpE7UI+ovnNQyj@coredump.intra.peff.net>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
 <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g>
 <xmqq8rwu278d.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rwu278d.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 08, 2021 at 12:04:50PM -0800, Junio C Hamano wrote:

> > That is an interesting way to demonstrate how orthogonal the issues
> > are, which in turn means that it is not such a big deal to add back
> > the coverage to the part that goes to contrib/scalar/.  As the actual
> > implementation, it is a bit too icky, though.
> 
> So, how about doing it this way?  This is based on 'master' and does
> not cover contrib/scalar, but if we want to go this route, it should
> be trivial to do it on top of a merge of ab/ci-updates and js/scalar
> into 'master'.  Good idea?  Terrible idea?  Not good enough?

I don't mind the general direction, but...

> +# Additional tests from places in contrib/ that are prepared to take
> +# "make -C $there test", but expects that the primary build is done
> +# already.
> +test-extra: all
> +	$(MAKE) -C contrib/diff-highlight test
> +	$(MAKE) -C contrib/mw-to-git test
> +	$(MAKE) -C contrib/subtree test

I'm not sure of the quality of tests in some of the contrib stuff. The
tests in diff-highlight worked for me when I added them, but it's not
like I ever run them regularly, or that they've been tested on a wide
variety of platforms.

So I think this is as likely to cause somebody a headache due to a dumb
portability problem or random bitrot as it is to actually find a bug. I
guess test-extra wouldn't be run by default, but only via CI, so maybe
that limits the blast radius sufficiently.

For diff-highlight in particular, you need to have a working perl, so
you'd probably want to at least wrap it with a NO_PERL ifndef. For
mw-to-git, you need to have MediaWiki::API installed, though I think the
tests at least notice this and skip everything if you don't.

-Peff
